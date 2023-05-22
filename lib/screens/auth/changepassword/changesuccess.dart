import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/auth/login/login.dart';
import 'package:guomobile/screens/settings/settings.dart';
import '../../../hooks/buttons/buttons.dart';
import '../../../hooks/formfields/formfields.dart';
import '../../../hooks/text/text.dart';
import '../../home/home.dart';

class ChangeSuccess extends StatefulWidget {
  const ChangeSuccess({super.key});

  @override
  State<ChangeSuccess> createState() => _ChangeSuccessState();
}

class _ChangeSuccessState extends State<ChangeSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: guocolor.white,
      body: Column(children: [
        sbHeight(mqHeight(context, .25)),
        Center(
          child: Image.asset(
            ImageClass.success,
            height: mqHeight(context, .25),
          ),
        ),
        sbHeight(mqHeight(context, .005)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            dText("Password Changed\n     Succesfully", mqHeight(context, .04),
                fontweight: FontWeight.w700),
          ],
        ),
        sbHeight(mqHeight(context, .27)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
          child: straightButton(
            "Go Home",
            mqHeight(context, .059),
            mqWidth(context, .915),
            guocolor.primaryColor,
            8,
            fontSize: mqHeight(context, .022),
            fontColor: guocolor.white,
            onT: () {
              mynextScreen(context, Home("x","",""));
            },
          ),
        ),
      ]),
    );
  }
}
