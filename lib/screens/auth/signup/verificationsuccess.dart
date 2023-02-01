import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/auth/login/login.dart';
import '../../../hooks/buttons/buttons.dart';
import '../../../hooks/text/text.dart';

class Vsuccess extends StatefulWidget {
  const Vsuccess({super.key});

  @override
  State<Vsuccess> createState() => _VsuccessState();
}

class _VsuccessState extends State<Vsuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sbHeight(mqHeight(context, .3)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageClass.vsuccess,
                  height: mqHeight(context, .15),
                ),
              ],
            ),
            sbHeight(mqHeight(context, .04)),
            dText("Registration Successful", mqHeight(context, .024),
                fontweight: FontWeight.w700),
            sbHeight(mqHeight(context, .02)),
            dText(GuoText.welcome, mqHeight(context, .019),
                fontweight: FontWeight.w100),
            sbHeight(mqHeight(context, .01)),
            dText(GuoText.verify, mqHeight(context, .019),
                fontweight: FontWeight.w100),
            sbHeight(mqHeight(context, .28)),
            straightButton(
              "Login",
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
          ],
        ),
      ),
    );
  }
}
