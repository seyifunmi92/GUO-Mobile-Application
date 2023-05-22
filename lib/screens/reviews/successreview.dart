import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';

import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/hooks/text/text.dart';

import '../../hooks/buttons/buttons.dart';
import '../../navigators/navigation.dart';
import '../home/home.dart';

class SuccessReview extends StatefulWidget {
  const SuccessReview({super.key});

  @override
  State<SuccessReview> createState() => _SuccessReviewState();
}

class _SuccessReviewState extends State<SuccessReview> {
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
            dText("Rider Review Received", mqHeight(context, .04),
                fontweight: FontWeight.w700),
          ],
        ),
        sbHeight(mqHeight(context, .3)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
          child: straightButton(
            "Home",
            mqHeight(context, .059),
            mqWidth(context, .915),
            guocolor.primaryColor,
            8,
            fontSize: mqHeight(context, .022),
            fontColor: guocolor.white,
            onT: () {
              mynextScreen(context, Home("x", "", ""));
            },
          ),
        ),
      ]),
    );
  }
}
