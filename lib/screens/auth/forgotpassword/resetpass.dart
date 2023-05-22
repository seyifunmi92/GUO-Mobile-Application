import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/dialog/showmessage.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/auth/forgotpassword/resetsuccess.dart';
import 'package:guomobile/services/accountbloc.dart';
import 'package:provider/provider.dart';
import '../../../asset/imageclass.dart';
import '../../../hooks/buttons/buttons.dart';
import '../../../hooks/formfields/formfields.dart';
import '../../../hooks/text/text.dart';
import '../../../providers/callfunctions/providerbloc.dart';
import '../../../providers/validations/validation.dart';

class rPass extends StatefulWidget {
  String email;

  rPass(this.email);

  @override
  State<rPass> createState() => _rPassState();
}

class _rPassState extends State<rPass> {
  TextEditingController xPassword = TextEditingController();
  TextEditingController xConfirm = TextEditingController();
  String passValidation = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: guoAppBar(context, "Reset Password",
          showBack: true, isCenter: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spacex1(context),
            dText("Please enter new password", mqHeight(context, .018)),
            sbHeight(mqHeight(context, .09)),
            space(context),
            dText("New Password", mqHeight(context, .019)),
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
                  Provider.of<ValidationBloc>(context, listen: false)
                      .validPassword = true;
                });
              },
              controller: xPassword,
            ),
            sbHeight(mqHeight(context, .005)),
            !Provider.of<ValidationBloc>(context, listen: false).validPassword
                ? dText(passValidation, mqHeight(context, .012),
                    color: guocolor.red.withOpacity(.7))
                : dText("", 0),
            spacex1(context),
            dText("Confirm Password", mqHeight(context, .019)),
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
                  Provider.of<ValidationBloc>(context, listen: false)
                      .validPassword = true;
                });
              },
              controller: xConfirm,
            ),
            sbHeight(mqHeight(context, .005)),
            !Provider.of<ValidationBloc>(context, listen: false).validPassword
                ? dText(passValidation, mqHeight(context, .012),
                    color: guocolor.red.withOpacity(.7))
                : dText("", 0),
            sbHeight(mqHeight(context, .08)),
            straightButton(
              "Reset Password",
              mqHeight(context, .059),
              mqWidth(context, .915),
              guocolor.primaryColor,
              8,
              fontSize: mqHeight(context, .022),
              fontColor: guocolor.white,
              onT: () {
                _call();
              },
            ),
          ],
        ),
      ),
    );
  }

  _call() {
    _validateSame();
    Provider.of<ValidationBloc>(context, listen: false).validPassword
        ? _runFunction()
        : null;
  }

  _runFunction() {
    setState(() {
      Provider.of<AccountBloc>(context, listen: false).isLoading = true;
    });
    _loader();
    x();
  }

  _loader() {
    if (Provider.of<AccountBloc>(context, listen: false).isLoading) {
      Provider.of<ProviderBloc>(context, listen: false)
          .showAnimatedLoader(context, ImageClass.loader);
    }
  }

  _validateSame() {
    if (xPassword.text != xConfirm.text) {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).validPassword =
            false;
        passValidation = "Both password must be match";
      });
    } else {
      _validatePassword();
    }
  }

  _validatePassword() {
    RegExp xRegexPass = RegExp(
        Provider.of<ValidationBloc>(context, listen: false).regexPassword);
    if (xRegexPass.hasMatch(xPassword.text) &&
        !xPassword.text.isEmpty &&
        xPassword.text.length >= 8) {
      setState(() {
        passValidation = "Password must contain alphanumeric characters";
        Provider.of<ValidationBloc>(context, listen: false).validPassword =
            false;
      });
    } else if (xPassword.text.length < 8 && !xPassword.text.isEmpty) {
      setState(() {
        passValidation = "Password must be at least 8 characters";
        Provider.of<ValidationBloc>(context, listen: false).validPassword =
            false;
      });
    } else if (xPassword.text.isEmpty) {
      setState(() {
        passValidation = "Password cant be empty";
        Provider.of<ValidationBloc>(context, listen: false).validPassword =
            false;
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).hideKey(context);
        Provider.of<ValidationBloc>(context, listen: false).validPassword =
            true;
      });
    }
  }

  x() {
    Provider.of<AccountBloc>(context, listen: false)
        .changePassword(widget.email, xPassword.text)
        .then((value) => xData(value));
  }

  xData(String _x) {
    print(_x);
    print("method called");
    _x.contains("success") ? success(_x) : fail(_x);
  }

  success(String x) {
    var bodyT = jsonDecode(x);
    setState(() {
      Provider.of<AccountBloc>(context, listen: false).isLoading = false;
    });
    closeAction(context);
    mynextScreen(context, rSuccess());
    gToast(bodyT["message"]);
  }

  fail(String x) {
    setState(() {
      Provider.of<AccountBloc>(context, listen: false).isLoading = false;
    });
    closeAction(context);
    gToast(x);
  }
}
