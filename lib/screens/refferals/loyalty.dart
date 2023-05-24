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
import 'package:guomobile/screens/reviews/successreview.dart';

import 'package:guomobile/services/logisticsbloc.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../hooks/buttons/buttons.dart';
import '../../hooks/servicehooks/hookservice.dart';

class Loyalty extends StatefulWidget {
  const Loyalty({super.key});

  @override
  State<Loyalty> createState() => _LoyaltyState();
}

class _LoyaltyState extends State<Loyalty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: guocolor.offWhite,
      appBar: guoAppBar(context, "Loyalty Performance"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sbHeight(mqHeight(context, .048)),
            loyaltyContainer(context, "tripDestination", "dateTime", "25,000"),
            sbHeight(mqHeight(context, .04)),
            dText("Your Progress", mqHeight(context, .02)),
            sbHeight(mqHeight(context, .04)),
            containSet(context, "All Expense Paid Trip to Maldives   ",
                "400pts", Icons.reviews_sharp),
            sbHeight(mqHeight(context, .02)),
            containSet(context, "All Expense Paid Trip to Maldives   ",
                "400pts", Icons.reviews_sharp),
            sbHeight(mqHeight(context, .2)),
            straightButton(
              "Redeem Offer",
              mqHeight(context, .059),
              mqWidth(context, .915),
              guocolor.primaryColor,
              8,
              fontSize: mqHeight(context, .022),
              fontColor: guocolor.white,
              onT: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}
