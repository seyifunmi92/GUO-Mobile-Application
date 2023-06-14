import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/models/onboarding.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/providers/sharedstorage/localstorage.dart';
import 'package:guomobile/screens/auth/signup/signup.dart';
import 'package:guomobile/screens/home/home.dart';
import 'package:guomobile/services/accountbloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../asset/imageclass.dart';
import '../../../hooks/buttons/buttons.dart';
import '../../../hooks/dialog/showmessage.dart';
import '../../../hooks/formfields/formfields.dart';
import '../../../hooks/text/text.dart';
import '../../../providers/callfunctions/providerbloc.dart';
import '../forgotpassword/forgotpass.dart';

class Login extends StatefulWidget {
  bool? islogout;
  Login({this.islogout});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController xEmail = TextEditingController();
  TextEditingController xPassword = TextEditingController();
  bool phoneSelected = true;
  bool emailSelected = false;
  Loginmodel? xLogin;
  bool isname = false;
  String name = "";
  @override
  void initState() {
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _checkLog();
    return Scaffold(
      backgroundColor: guocolor.offWhite,
      appBar: guoAppBar(context, "Login",
          showBack: false, isCenter: false, showElevation: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          spacex1(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => setState(() {
                  phoneSelected = true;
                  emailSelected = false;
                  xEmail.clear();
                }),
                child: dText("Phone", mqHeight(context, .02),
                    color: phoneSelected
                        ? guocolor.primaryColor
                        : const Color(0xff8C8C95)),
              ),
              InkWell(
                onTap: () => setState(() {
                  emailSelected = true;
                  phoneSelected = false;
                  xEmail.clear();
                }),
                child: dText("Email", mqHeight(context, .02),
                    color: phoneSelected
                        ? const Color(0xff8C8C95)
                        : guocolor.primaryColor),
              ),
            ],
          ),
          sbHeight(mqHeight(context, .008)),
          Stack(children: [
            const Divider(
              color: Color(0xff8C8C95),
            ),
            Positioned(
              top: 4,
              left: phoneSelected ? 0 : MediaQuery.of(context).size.width / 2.3,
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 7,
                color: guocolor.primaryColor,
              ),
            )
          ]),
          sbHeight(mqHeight(context, .05)),
          isname
              ? Center(
                  child: dText("welcome back, ${name}", mqHeight(context, .022),
                      color: guocolor.primaryColor.withOpacity(.7),
                      fontweight: FontWeight.w700),
                )
              : dText("", 0),
          spacex1(context),
          dText(
              phoneSelected ? "Phone Number" : "Email", mqHeight(context, .018),
              color: guocolor.primaryColor.withOpacity(.7)),
          space(context),
          guoFormField(context, mqHeight(context, .05), mqWidth(context, .5),
              containercolor: guocolor.white,
              showBorder: false,
              showRadius: true,
              controller: xEmail,
              radiusborder: true, onT: () {
            setState(() {});
          }),
          spacex1(context),
          dText("Password", mqHeight(context, .018),
              color: guocolor.primaryColor.withOpacity(.7)),
          space(context),
          guoFormField(context, mqHeight(context, .05), mqWidth(context, .5),
              containercolor: guocolor.white,
              showBorder: false,
              showRadius: true,
              controller: xPassword,
              radiusborder: true, onT: () {
            setState(() {});
          }),
          space(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  mynextScreen(context, const Forgot());
                },
                child: dText("Forgot Password?", mqHeight(context, .015),
                    fontweight: FontWeight.w200,
                    color: const Color(0xff053984)),
              ),
            ],
          ),
          spacex1(context),
          straightButton(
            "Login",
            mqHeight(context, .059),
            mqWidth(context, .915),
            guocolor.primaryColor,
            8,
            fontSize: mqHeight(context, .022),
            fontColor: guocolor.white,
            onT: () {
              xEmail.text.isNotEmpty && xPassword.text.isNotEmpty
                  ? _runFunction()
                  : gToast("Please enter your details to login");
            },
          ),
          sbHeight(mqHeight(context, .01)),
          straightButton(
            "Use as guest",
            mqHeight(context, .059),
            mqWidth(context, .915),
            guocolor.primaryColor,
            8,
            fontSize: mqHeight(context, .022),
            fontColor: guocolor.white,
            onT: () {
              mynextScreen(context, Home("guest", "", ""));
            },
          ),
        ]),
      ),
      bottomNavigationBar: textbottomNav(
          context, guocolor.white, "Dont have an account?", "Sign Up", () {
        mynextScreenPop(context, CreateAcc());
      }),
    );
  }

  getUserName() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var nameT = _shared.getString("firstname");
    if (nameT == null) {
      setState(() {
        isname = false;
      });
    } else {
      setState(() {
        isname = true;
        name = nameT;
      });
    }
  }

  _checkLog() {
    if (widget.islogout == true) {
      setState(() {
        toast("Log Out Successful");
        widget.islogout = false;
      });

      // Provider.of<ProviderBloc>(context, listen: false).logoutnotice(context);
    }
  }

  _runFunction() {
    setState(() {
      Provider.of<AccountBloc>(context, listen: false).isLoading = true;
    });
    _loader();
    logCst();
  }

  _loader() {
    if (Provider.of<AccountBloc>(context, listen: false).isLoading) {
      Provider.of<ProviderBloc>(context, listen: false)
          .showAnimatedLoader(context, ImageClass.loader);
    }
  }

  logCst() {
    print(phoneSelected);
    Provider.of<AccountBloc>(context, listen: false)
        .Logincst(phoneSelected ? "" : xEmail.text,
            phoneSelected ? xEmail.text : "", xPassword.text)
        .then((x) => xLog(x));
  }

  xLog(String x) {
    var bodyT = jsonDecode(x);
    bodyT["status"] == 200 ? xSuccess(bodyT) : xFailed(bodyT);
  }

  xSuccess(dynamic bodyT) {
    setState(() {
      print(bodyT.runtimeType);
      xLogin = Loginmodel.fromJson(bodyT);
      Provider.of<AccountBloc>(context, listen: false).isLoading = false;
    });
    closeAction(context);
    Provider.of<LocalStorageBloc>(context, listen: false)
        .setToken(xLogin!.data.accessToken);
    Provider.of<LocalStorageBloc>(context, listen: false)
        .setFirstname(xLogin!.data.user.firstName!);
    Provider.of<LocalStorageBloc>(context, listen: false)
        .getLastname(xLogin!.data.user.lastName!);
    Provider.of<LocalStorageBloc>(context, listen: false)
        .setCustomerId(xLogin!.data.user.id!);
    Provider.of<LocalStorageBloc>(context, listen: false)
        .getEmail(xLogin!.data.user.email!);
    Provider.of<LocalStorageBloc>(context, listen: false)
        .getPhone(xLogin!.data.user.phoneNumber);
    mynextScreen(
        context,
        Home(xLogin!.data.user.firstName!, xLogin!.data.user.lastName!,
            !isname ? "firstinstall" : ""));
    gToast("Login Successful", isLong: true);
  }

  xFailed(dynamic x) {
    setState(() {
      Provider.of<AccountBloc>(context, listen: false).isLoading = false;
    });
    closeAction(context);
    gToast(x["message"], isLong: true);
  }
}
