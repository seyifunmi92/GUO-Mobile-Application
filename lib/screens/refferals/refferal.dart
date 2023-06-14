import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/containers/container.dart';
import 'package:guomobile/hooks/dialog/loader.dart';

import 'package:guomobile/hooks/formfields/formfields.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/hooks/text/text.dart';
import 'package:guomobile/models/od.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/refferals/loyalty.dart';
import 'package:guomobile/screens/reviews/successreview.dart';

import 'package:guomobile/services/logisticsbloc.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../hooks/buttons/buttons.dart';
import '../../hooks/servicehooks/hookservice.dart';

class Refferals extends StatefulWidget {
  const Refferals({super.key});

  @override
  State<Refferals> createState() => _RefferalsState();
}

class _RefferalsState extends State<Refferals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: guocolor.offWhite,
      appBar: guoAppBar(context, "Referrals"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Column(
          children: [
            sbHeight(mqHeight(context, .05)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                dText("Get 0.25% per referral on booked trip",
                    mqHeight(context, .022),
                    fontweight: FontWeight.w700),
              ],
            ),
            sbHeight(mqHeight(context, .05)),
            Image.asset(
              ImageClass.reward,
              height: mqHeight(context, .15),
            ),
            sbHeight(mqHeight(context, .05)),
            contain(),
            sbHeight(mqHeight(context, .28)),
            straightButton(
              "View Referall Performance",
              mqHeight(context, .059),
              mqWidth(context, .915),
              guocolor.primaryColor,
              8,
              fontSize: mqHeight(context, .022),
              fontColor: guocolor.white,
              onT: () {
                setState(() {
                  Provider.of<LogisticsBloc>(context, listen: false).isloading =
                      true;
                });
              },
            ),
            sbHeight(mqHeight(context, .02)),
            straightButton(
              "View Loyalty Benefits",
              mqHeight(context, .059),
              mqWidth(context, .915),
              Color(0xffD1E2FB),
              8,
              fontSize: mqHeight(context, .022),
              fontColor: guocolor.primaryColor,
              onT: () {
                mynextScreen(context, Loyalty());
              },
            ),
          ],
        ),
      ),
    );
  }

  contain() {
    return Container(
      width: mqWidth(context, 1),
      height: mqHeight(context, .06),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: guocolor.black.withOpacity(.3))),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dText("https://guo.com/transport", mqHeight(context, .017),
                  color: Color(0xff4C5D77)),
              Icon(
                Icons.copy,
                size: mqHeight(context, .019),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
