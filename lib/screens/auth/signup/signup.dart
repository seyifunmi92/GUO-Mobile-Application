import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/dialog/showmessage.dart';
import 'package:guomobile/hooks/formfields/formfields.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/hooks/text/text.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/providers/callfunctions/providerbloc.dart';
import 'package:guomobile/providers/validations/validation.dart';
import 'package:guomobile/screens/auth/login/login.dart';
import 'package:guomobile/screens/auth/signup/verificationsuccess.dart';
import 'package:guomobile/services/accountbloc.dart';
import 'package:provider/provider.dart';
import '../../../asset/imageclass.dart';
import '../../../hooks/buttons/buttons.dart';

class CreateAcc extends StatefulWidget {
  const CreateAcc({super.key});

  @override
  State<CreateAcc> createState() => _CreateAccState();
}

class _CreateAccState extends State<CreateAcc> {
  TextEditingController xFirstName = TextEditingController();
  TextEditingController xLastName = TextEditingController();
  TextEditingController xEmail = TextEditingController();
  TextEditingController xPhone = TextEditingController();
  TextEditingController xPass = TextEditingController();
  String emailValidation = "";
  String phoneValidation = "";
  String passValidation = "";
  String _encryptedNumber = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: guocolor.offWhite,
      appBar: guoAppBar(context, "Create An Account",
          showBack: false, isCenter: true, showElevation: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            spacex1(context),
            dText("First Name", mqHeight(context, .018)),
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
                      .validFirstname = true;
                });
              },
              controller: xFirstName,
              isnext: true,
            ),
            sbHeight(mqHeight(context, .005)),
            !Provider.of<ValidationBloc>(context, listen: false).validFirstname
                ? dText("First name cant be empty", mqHeight(context, .012),
                    color: guocolor.red.withOpacity(.7))
                : dText("", 0),
            spacex1(context),
            dText("Last Name", mqHeight(context, .018)),
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
                      .validLastName = true;
                });
              },
              controller: xLastName,
              isnext: true,
            ),
            sbHeight(mqHeight(context, .005)),
            !Provider.of<ValidationBloc>(context, listen: false).validLastName
                ? dText("Last name cant be empty", mqHeight(context, .012),
                    color: guocolor.red.withOpacity(.7))
                : dText("", 0),
            spacex1(context),
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
                  Provider.of<ValidationBloc>(context, listen: false)
                      .validEmail = true;
                });
              },
              controller: xEmail,
              isnext: true,
            ),
            sbHeight(mqHeight(context, .005)),
            !Provider.of<ValidationBloc>(context, listen: false).validEmail
                ? dText(emailValidation, mqHeight(context, .012),
                    color: guocolor.red.withOpacity(.7))
                : dText("", 0),
            spacex1(context),
            dText("Phone Number", mqHeight(context, .018)),
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
                      .validPhone = true;
                });
              },
              onchanged: (x) {
                x.length == 11
                    ? Provider.of<ValidationBloc>(context, listen: false)
                        .hideKey(context)
                    : null;
              },
              controller: xPhone,
              maxlength: 11,
              isInt: true,
              isnext: true,
            ),
            sbHeight(mqHeight(context, .005)),
            !Provider.of<ValidationBloc>(context, listen: false).validPhone
                ? dText(phoneValidation, mqHeight(context, .012),
                    color: guocolor.red.withOpacity(.7))
                : dText("", 0),
            spacex1(context),
            dText("Password", mqHeight(context, .018)),
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
              controller: xPass,
              isnext: false,
            ),
            sbHeight(mqHeight(context, .005)),
            !Provider.of<ValidationBloc>(context, listen: false).validPassword
                ? dText(passValidation, mqHeight(context, .012),
                    color: guocolor.red.withOpacity(.7))
                : dText("", 0),
            sbHeight(mqHeight(context, .035)),
            straightButton(
              "Create Account",
              mqHeight(context, .059),
              mqWidth(context, .915),
              guocolor.primaryColor,
              8,
              fontSize: mqHeight(context, .022),
              fontColor: guocolor.white,
              onT: () {
                call();
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
                mynextScreen(context, Login());
              },
            ),
          ]),
        ),
      ),
      bottomNavigationBar: textbottomNav(
          context, guocolor.white, "Already have an account?", "Login", () {
        mynextScreenPop(context, Login());
      }),
    );
  }

  call() {
    Provider.of<ValidationBloc>(context, listen: false).hideKey(context);
    _validation();
    _validationLastname();
    _validationEmail();
    _validatePhone();
    _validatePassword();
    Provider.of<ValidationBloc>(context, listen: false).validFirstname &&
            Provider.of<ValidationBloc>(context, listen: false).validLastName &&
            Provider.of<ValidationBloc>(context, listen: false).validEmail &&
            Provider.of<ValidationBloc>(context, listen: false).validPhone &&
            Provider.of<ValidationBloc>(context, listen: false).validPassword
        ? _runFunction()
        : null;
  }

  _runFunction() {
    setState(() {
      Provider.of<AccountBloc>(context, listen: false).isLoading = true;
      _encryptedNumber = xPhone.text.substring(1);
    });
    _loader();
    createCst();
  }

  _loader() {
    if (Provider.of<AccountBloc>(context, listen: false).isLoading) {
      Provider.of<ProviderBloc>(context, listen: false)
          .showAnimatedLoader(context, ImageClass.loader);
    }
  }

  createCst() {
    print(xPhone.text.substring(1));
    print("234" + _encryptedNumber);
    Provider.of<AccountBloc>(context, listen: false)
        .createCustomer(xFirstName.text, xLastName.text,
            "234" + _encryptedNumber, xEmail.text, xPass.text)
        .then((x) => xOutput(x));
  }

  xOutput(String x) {
    print(x);
    var bodyT = jsonDecode(x);
    bodyT["status"] == 200 ? xSuccess(bodyT) : xFailed(bodyT);
  }

  xSuccess(dynamic x) {
    setState(() {
      Provider.of<AccountBloc>(context, listen: false).isLoading = false;
    });
    closeAction(context);
    mynextScreen(context, Vsuccess());
    gToast(x["message"], isLong: true);
  }

  xFailed(dynamic x) {
    setState(() {
      Provider.of<AccountBloc>(context, listen: false).isLoading = false;
    });
    closeAction(context);
    gToast(x["message"], isLong: true);
  }

  _validation() {
    if (xFirstName.text.isEmpty) {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).validFirstname =
            false;
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).hideKey(context);
        Provider.of<ValidationBloc>(context, listen: false).validFirstname =
            true;
      });
    }
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

  _validationLastname() {
    if (xLastName.text.isEmpty) {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).validLastName =
            false;
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).hideKey(context);
        Provider.of<ValidationBloc>(context, listen: false).validLastName =
            true;
      });
    }
  }

  _validatePhone() {
    RegExp xRegexPhone = RegExp(
        Provider.of<ValidationBloc>(context, listen: false).phoneValidation);
    if (!xRegexPhone.hasMatch(xPhone.text) && !xPhone.text.isEmpty) {
      setState(() {
        phoneValidation = "Please enter a valid phone number";
        Provider.of<ValidationBloc>(context, listen: false).validPhone = false;
      });
    } else if (xPhone.text.length != 11 && !xPhone.text.isEmpty) {
      setState(() {
        phoneValidation = "Please enter a valid phone number";
        Provider.of<ValidationBloc>(context, listen: false).validPhone = false;
      });
    } else if (xPhone.text.isEmpty) {
      setState(() {
        phoneValidation = "Phone number cant be empty";
        Provider.of<ValidationBloc>(context, listen: false).validPhone = false;
      });
    } else {
      setState(() {
        Provider.of<ValidationBloc>(context, listen: false).hideKey(context);
        Provider.of<ValidationBloc>(context, listen: false).validPhone = true;
      });
    }
  }

  _validatePassword() {
    RegExp xRegexPass = RegExp(
        Provider.of<ValidationBloc>(context, listen: false).regexPassword);
    if (xRegexPass.hasMatch(xPass.text) &&
        !xPass.text.isEmpty &&
        xPass.text.length >= 8) {
      setState(() {
        passValidation = "Password must contain alphanumeric characters";
        Provider.of<ValidationBloc>(context, listen: false).validPassword =
            false;
      });
    } else if (xPass.text.length < 8 && !xPass.text.isEmpty) {
      setState(() {
        passValidation = "Password must be at least 8 characters";
        Provider.of<ValidationBloc>(context, listen: false).validPassword =
            false;
      });
    } else if (xPass.text.isEmpty) {
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
}
