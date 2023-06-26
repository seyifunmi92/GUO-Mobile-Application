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
import 'package:guomobile/screens/help/socialmedia.dart';
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

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  String email = Uri.encodeComponent("feedback@guologistics.com");
  String subject = Uri.encodeComponent("Hello GUO");
  String body = Uri.encodeComponent("Hi my name is ");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: guocolor.offWhite,
      appBar: guoAppBar(context, "Help"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqHeight(context, .02)),
        child: Column(
          children: [
            sbHeight(mqHeight(context, .02)),
            containSet(context, "Email", "Send us an email", Icons.email,
                onT: () async {
              _openMain();
            }),
            sbHeight(mqHeight(context, .02)),
            containSet(
                context,
                "FAQs",
                "See all our frequently asked questions",
                Icons.question_mark_outlined),
            sbHeight(mqHeight(context, .02)),
            containSet(context, "Socials", "See all our social media handles",
                Icons.speaker_rounded, onT: () {
              mynextScreen(context, Social());
            }),
            sbHeight(mqHeight(context, .02)),
            containSet(context, "Privacy Policy",
                "View our privacy policy here", Icons.privacy_tip, onT: () {
              mynextScreen(context, PrivacyPolicy());
            }),
          ],
        ),
      ),
    );
  }

  _openMain() async {
    Uri xmail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    if (await launchUrl(xmail)) {
      print("email opened");
    } else {
      print("an error occured");
    }
  }
}
