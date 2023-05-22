import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/dialog/showmessage.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/auth/forgotpassword/emailconfirm.dart';
import 'package:guomobile/services/accountbloc.dart';
import 'package:provider/provider.dart';
import '../../../hooks/buttons/buttons.dart';
import '../../../hooks/formfields/formfields.dart';
import '../../../hooks/text/text.dart';
import '../../../providers/callfunctions/providerbloc.dart';
import '../../../providers/validations/validation.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  TextEditingController xEmail = TextEditingController();
  String emailValidation = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: guocolor.offWhite,
      appBar: guoAppBar(context, "Forgot Password",
          showBack: true, isCenter: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          spacex1(context),
          dText(GuoText.fP, mqHeight(context, .017)),
          sbHeight(mqHeight(context, .15)),
          dText("Email", mqHeight(context, .018)),
          space(context),
          guoFormField(
            context,
            mqHeight(context, .05),
            mqWidth(context, .5),
            containercolor: guocolor.white,
            showBorder: false,
            showRadius: true,
            radiusborder: true,
            onT: () {
              setState(() {
                Provider.of<ValidationBloc>(context, listen: false).validEmail =
                    true;
              });
            },
            controller: xEmail,
          ),
          sbHeight(mqHeight(context, .005)),
          !Provider.of<ValidationBloc>(context, listen: false).validEmail
              ? dText(emailValidation, mqHeight(context, .012),
                  color: guocolor.red.withOpacity(.7))
              : dText("", 0),
          sbHeight(mqHeight(context, .05)),
          straightButton(
            "Verify",
            mqHeight(context, .059),
            mqWidth(context, .915),
            guocolor.primaryColor,
            8,
            fontSize: mqHeight(context, .022),
            fontColor: guocolor.white,
            onT: () {
              _callwithvalidation();
            },
          ),
        ]),
      ),
    );
  }

  _callwithvalidation() {
    _validationEmail();
    Provider.of<ValidationBloc>(context, listen: false).validEmail
        ? _runFunction()
        : null;
  }

  _runFunction() {
    setState(() {
      Provider.of<AccountBloc>(context, listen: false).isLoading = true;
    });
    _loader();
    _reset();
  }

  _loader() {
    if (Provider.of<AccountBloc>(context, listen: false).isLoading) {
      Provider.of<ProviderBloc>(context, listen: false)
          .showAnimatedLoader(context, ImageClass.loader);
    }
  }

  _reset() {
    Provider.of<AccountBloc>(context, listen: false)
        .resetPassword(xEmail.text)
        .then((value) => xOutput(value));
  }

  xOutput(String x) {
    print("seyi oo");
    print(x);
    print("seyi $x");
    var _x = jsonDecode(x.toString());
    _x["status"] != 200 ? failed(_x) : passed(_x);
  }

  passed(dynamic x) {
    setState(() {
      Provider.of<AccountBloc>(context, listen: false).isLoading = false;
    });
    closeAction(context);
    var email = x["data"]["user"];
    var token = x["data"]["token"];
    mynextScreen(context, OpenEmail(email,token));
    gToast(x["message"]);
  }

  failed(dynamic x) {
    setState(() {
      Provider.of<AccountBloc>(context, listen: false).isLoading = false;
    });
    closeAction(context);
    gToast(x["message"]);
  }

  _validationEmail() {
    RegExp xRegex = RegExp(
        Provider.of<ValidationBloc>(context, listen: false).emailValidation);
    if (!xRegex.hasMatch(xEmail.text) && !xEmail.text.isEmpty) {
      setState(() {
        emailValidation = "Please enter a valid email";
        Provider.of<ValidationBloc>(context, listen: false).validEmail = false;
      });
    } else if (xEmail.text.length <= 11 && !xEmail.text.isEmpty) {
      setState(() {
        emailValidation = "Please enter a valid email";
        Provider.of<ValidationBloc>(context, listen: false).validEmail = false;
      });
    } else if (xEmail.text.isEmpty) {
      setState(() {
        emailValidation = "Email cant be empty";
        Provider.of<ValidationBloc>(context, listen: false).validEmail = false;
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).hideKey(context);
        Provider.of<ValidationBloc>(context, listen: false).validEmail = true;
      });
    }
  }
}
