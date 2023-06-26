import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
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
import 'package:guomobile/screens/privacy/privacy.dart';
import 'package:guomobile/screens/refferals/loyalty.dart';
import 'package:guomobile/screens/reviews/successreview.dart';

import 'package:guomobile/services/logisticsbloc.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../hooks/buttons/buttons.dart';
import '../../hooks/servicehooks/hookservice.dart';

class PrivacyDetails extends StatefulWidget {
  bool? islogistics;
  PrivacyDetails({this.islogistics});

  @override
  State<PrivacyDetails> createState() => _PrivacyDetailsState();
}

class _PrivacyDetailsState extends State<PrivacyDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: guocolor.white,
      appBar: guoAppBar(
          context,
          widget.islogistics == true
              ? "Logistics Privacy Policy"
              : "Transport Privacy Policy",
          color: guocolor.primaryColor,
          showElevation: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              sbHeight(mqHeight(context, .02)),
              dText(GuoText.privacyLogistics, mqHeight(context, .016),
                  color: Color(0xff8C8C95)),
              sbHeight(mqHeight(context, .02)),
              straightButton(
                "Back",
                mqHeight(context, .054),
                mqWidth(context, .915),
                Color(0xff50AEF0),
                8,
                fontSize: mqHeight(context, .022),
                fontColor: guocolor.white,
                onT: () {
                  mynextScreen(context, PrivacyPolicy());
                },
              ),
              sbHeight(mqHeight(context, .02)),
            ],
          ),
        ),
      ),
    );
  }
}
