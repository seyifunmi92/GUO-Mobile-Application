import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/hooks/text/text.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/home/home.dart';

import '../../hooks/buttons/buttons.dart';

class PSuccess extends StatefulWidget {
  const PSuccess({super.key});

  @override
  State<PSuccess> createState() => _PSuccessState();
}

class _PSuccessState extends State<PSuccess> {
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
            dText("Photo Updated\n    Succesfully", mqHeight(context, .04),
                fontweight: FontWeight.w700),
          ],
        ),
        sbHeight(mqHeight(context, .27)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
          child: straightButton(
            "Close",
            mqHeight(context, .059),
            mqWidth(context, .915),
            guocolor.primaryColor,
            8,
            fontSize: mqHeight(context, .022),
            fontColor: guocolor.white,
            onT: () {
              mynextScreen(context, Home("", ""));
            },
          ),
        ),
      ]),
    );
  }
}
