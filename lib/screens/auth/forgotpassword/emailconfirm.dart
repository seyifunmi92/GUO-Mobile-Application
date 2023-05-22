import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/auth/forgotpassword/resetpass.dart';
import 'package:provider/provider.dart';
import '../../../hooks/buttons/buttons.dart';
import '../../../hooks/dialog/showmessage.dart';
import '../../../hooks/text/text.dart';
import '../../../providers/callfunctions/providerbloc.dart';
import '../../../services/accountbloc.dart';

class OpenEmail extends StatefulWidget {
  String email;
  String token;
  OpenEmail(this.email, this.token);

  @override
  State<OpenEmail> createState() => _OpenEmailState();
}

class _OpenEmailState extends State<OpenEmail> {
  @override
  Widget build(BuildContext context) {
    print(widget.email);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sbHeight(mqHeight(context, .23)),
            dText("Open Your Email", mqHeight(context, .025),
                fontweight: FontWeight.w700),
            spacex1(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageClass.email,
                  height: mqHeight(context, .15),
                ),
              ],
            ),
            sbHeight(mqHeight(context, .04)),
            dText(GuoText.fP2, mqHeight(context, .019),
                fontweight: FontWeight.w100),
            sbHeight(mqHeight(context, .05)),
            straightButton(
              "Open Email",
              mqHeight(context, .059),
              mqWidth(context, .915),
              guocolor.primaryColor,
              8,
              fontSize: mqHeight(context, .022),
              fontColor: guocolor.white,
              onT: () {
                _runFunction2();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: textbottomNav(
          context, guocolor.white, "Didnt receive the email?", "Resend Link",
          () {
        runFunction();
      }),
    );
  }

  _validateToken() {
    Provider.of<AccountBloc>(context, listen: false)
        .validteToken(widget.token)
        .then((value) => x(value));
  }

  x(String _x) {
    print(_x);
    _x.contains("success") ? success(_x) : fail(_x);
  }

  success(String _x) {
    var x = jsonDecode(_x);
    print(x);
    setState(() {
      Provider.of<AccountBloc>(context, listen: false).isLoading = false;
    });
    closeAction(context);
    gToast("Verification successful.Please proceed to create a new password");
    mynextScreen(context, rPass(x["data"]["email"]));
  }

  fail(String _x) {
    setState(() {
      Provider.of<AccountBloc>(context, listen: false).isLoading = false;
    });
    closeAction(context);
    gToast("An error occured, please try again");
  }

  _runFunction2() {
    setState(() {
      Provider.of<AccountBloc>(context, listen: false).isLoading = true;
    });
    _loader();
    _validateToken();
  }

  runFunction() {
    setState(() {
      Provider.of<AccountBloc>(context, listen: false).isLoading = true;
    });
    _loader();
    resend();
  }

  _loader() {
    if (Provider.of<AccountBloc>(context, listen: false).isLoading) {
      Provider.of<ProviderBloc>(context, listen: false)
          .showAnimatedLoader(context, ImageClass.loader);
    }
  }

  resend() {
    Provider.of<AccountBloc>(context, listen: false)
        .resetPassword(widget.email)
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
    mynextScreen(context, OpenEmail(email, token));
    gToast("Successful, Please check your email for confirmation");
  }

  failed(dynamic x) {
    setState(() {
      Provider.of<AccountBloc>(context, listen: false).isLoading = false;
    });
    closeAction(context);
    gToast(x["message"]);
  }
}
