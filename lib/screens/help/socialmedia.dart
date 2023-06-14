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
import 'package:guomobile/screens/refferals/loyalty.dart';
import 'package:guomobile/screens/reviews/successreview.dart';

import 'package:guomobile/services/logisticsbloc.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../hooks/buttons/buttons.dart';
import '../../hooks/servicehooks/hookservice.dart';

class Social extends StatefulWidget {
  const Social({super.key});

  @override
  State<Social> createState() => _SocialState();
}

class _SocialState extends State<Social> {
  var whatsappUrl = "whatsapp://send?phone=${2348144988273}";
  var facebookUrl = "facebook.com/guotransport";
  var twitterUrl = "twitter.com/guotransport";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: guoAppBar(context, "Social Media"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqHeight(context, .02)),
        child: Column(
          children: [
            sbHeight(mqHeight(context, .02)),
            containSet(context, "Facebook", "@guotransport", Icons.facebook,
                onT: () async {
              _facebook();
            }),
            sbHeight(mqHeight(context, .02)),
            containSet2(context, "Twitter", "@guotransport", ImageClass.twitter,
                onT: () async {
              _twitter();
            }),
            sbHeight(mqHeight(context, .02)),
            containSet2(
                context, "Whatsapp", "+2348144988273", ImageClass.whatsapp,
                onT: () async {
              _whatsapp();
            }),
            sbHeight(mqHeight(context, .02)),
            containSet(context, "Phone", "+2347000121000", Icons.phone,
                onT: () {
              _callRider();
            }),
          ],
        ),
      ),
    );
  }

  _callRider() {
    FlutterPhoneDirectCaller.callNumber("07000121000");
  }

  _whatsapp() async {
    if (await launchUrl(Uri.parse(whatsappUrl))) {
      print("whatsapp opened");
    } else {
      print("an error occured");
    }
  }

  _facebook() async {
    if (await launchUrl(Uri.parse(facebookUrl))) {
      print("whatsapp opened");
    } else {
      print("an error occured");
    }
  }

  _twitter() async {
    if (await launchUrl(Uri.parse(twitterUrl))) {
      print("whatsapp opened");
    } else {
      print("an error occured");
    }
  }
}
