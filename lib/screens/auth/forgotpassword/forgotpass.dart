import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/auth/forgotpassword/emailconfirm.dart';
import '../../../hooks/buttons/buttons.dart';
import '../../../hooks/formfields/formfields.dart';
import '../../../hooks/text/text.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: guoAppBar(context, "Forgot Password",
          showBack: false, isCenter: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          spacex1(context),
          dText(GuoText.fP, mqHeight(context, .017)),
          sbHeight(mqHeight(context, .15)),
          dText("Email", mqHeight(context, .018)),
          space(context),
          guoFormField(context, mqHeight(context, .05), mqWidth(context, .5),
              containercolor: guocolor.white,
              showBorder: false,
              showRadius: true,
              radiusborder: true, onT: () {
            setState(() {});
          }),
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
              mynextScreen(context, const OpenEmail());
            },
          ),
        ]),
      ),
    );
  }
}
