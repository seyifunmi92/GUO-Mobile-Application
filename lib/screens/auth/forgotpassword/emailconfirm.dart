import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/auth/forgotpassword/resetpass.dart';
import '../../../hooks/buttons/buttons.dart';
import '../../../hooks/formfields/formfields.dart';
import '../../../hooks/text/text.dart';

class OpenEmail extends StatefulWidget {
  const OpenEmail({super.key});

  @override
  State<OpenEmail> createState() => _OpenEmailState();
}

class _OpenEmailState extends State<OpenEmail> {
  @override
  Widget build(BuildContext context) {
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
                mynextScreen(context, rPass());
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: textbottomNav(
          context, guocolor.white, "Didnt receive the email?", "Resend Link"),
    );
  }
}
