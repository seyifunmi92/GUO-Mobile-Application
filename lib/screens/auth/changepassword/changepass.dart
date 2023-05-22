import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/auth/changepassword/changesuccess.dart';
import 'package:guomobile/services/accountbloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../../asset/imageclass.dart';
import '../../../hooks/buttons/buttons.dart';
import '../../../hooks/formfields/formfields.dart';
import '../../../hooks/text/text.dart';
import '../../../providers/callfunctions/providerbloc.dart';
import '../../../providers/validations/validation.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({super.key});

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  String passValidation = "";

  TextEditingController emailC = TextEditingController();
  TextEditingController oldPasswordC = TextEditingController();
  TextEditingController newPasswordC = TextEditingController();
  @override
  void initState() {
    Provider.of<ValidationBloc>(context, listen: false).validLastName = true;
    Provider.of<ValidationBloc>(context, listen: false).validFirstname = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: guocolor.offWhite,
        appBar: guoAppBar(context, "Change Password", showElevation: false),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sbHeight(mqHeight(context, .03)),
              dText("Email", mqHeight(context, .018)),
              sbHeight(mqHeight(context, .013)),
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
                controller: emailC,
              ),
              sbHeight(mqHeight(context, .005)),
              !Provider.of<ValidationBloc>(context, listen: false).validLastName
                  ? dText("Email cant be empty", mqHeight(context, .012),
                      color: guocolor.red.withOpacity(.7))
                  : dText("", 0),
              sbHeight(mqHeight(context, .03)),
              dText("Old Password", mqHeight(context, .018)),
              sbHeight(mqHeight(context, .013)),
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
                controller: oldPasswordC,
              ),
              sbHeight(mqHeight(context, .005)),
              !Provider.of<ValidationBloc>(context, listen: false)
                      .validFirstname
                  ? dText("Old Password cant be empty", mqHeight(context, .012),
                      color: guocolor.red.withOpacity(.7))
                  : dText("", 0),
              sbHeight(mqHeight(context, .03)),
              dText("New Password", mqHeight(context, .018)),
              sbHeight(mqHeight(context, .013)),
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
                controller: newPasswordC,
              ),
              sbHeight(mqHeight(context, .005)),
              !Provider.of<ValidationBloc>(context, listen: false).validPassword
                  ? dText(passValidation, mqHeight(context, .012),
                      color: guocolor.red.withOpacity(.7))
                  : dText("", 0),
              sbHeight(mqHeight(context, .05)),
              straightButton(
                "Update Password",
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
            ],
          ),
        ));
  }

  call() {
    _validateEmail();
    _validateoldpass();
    _validatePassword();
    Provider.of<ValidationBloc>(context, listen: false).validFirstname &&
            Provider.of<ValidationBloc>(context, listen: false).validLastName &&
            Provider.of<ValidationBloc>(context, listen: false).validPassword
        ? _runFunction()
        : null;
  }

  _runFunction() {
    setState(() {
      Provider.of<AccountBloc>(context, listen: false).isLoading = true;
    });
    _loader();
    userPassword();
  }

  _loader() {
    if (Provider.of<AccountBloc>(context, listen: false).isLoading) {
      Provider.of<ProviderBloc>(context, listen: false)
          .showAnimatedLoader(context, ImageClass.loader);
    }
  }



  userPassword() {
    print(emailC.text);
    print(newPasswordC.text);
    print(oldPasswordC.text);
    Provider.of<AccountBloc>(context, listen: false)
        .changeuserPassword(emailC.text, oldPasswordC.text, newPasswordC.text)
        .then((value) => xOutput(value));
  }

  xOutput(String x) {
  
    print(x);
    var bodyT = jsonDecode(x);
    if (bodyT["status"] == 200) {
      setState(() {
        Provider.of<AccountBloc>(context, listen: false).isLoading = false;
      });
      closeAction(context);
      mynextScreen(context, ChangeSuccess());
      toast(bodyT);
    } else {
      setState(() {
        Provider.of<AccountBloc>(context, listen: false).isLoading = false;
        closeAction(context);
        toast(bodyT["message"]);
      });
    }
  }

  _validateEmail() {
    if (emailC.text.isEmpty) {
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

  _validateoldpass() {
    if (oldPasswordC.text.isEmpty) {
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

  _validatePassword() {
    RegExp xRegexPass = RegExp(
        Provider.of<ValidationBloc>(context, listen: false).regexPassword);
    if (xRegexPass.hasMatch(newPasswordC.text) &&
        !newPasswordC.text.isEmpty &&
        newPasswordC.text.length >= 8) {
      setState(() {
        passValidation = "Password must contain alphanumeric characters";
        Provider.of<ValidationBloc>(context, listen: false).validPassword =
            false;
      });
    } else if (newPasswordC.text.length < 8 && !newPasswordC.text.isEmpty) {
      setState(() {
        passValidation = "Password must be at least 8 characters";
        Provider.of<ValidationBloc>(context, listen: false).validPassword =
            false;
      });
    } else if (newPasswordC.text.isEmpty) {
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
