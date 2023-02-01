import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/auth/signup/verificationsuccess.dart';
import '../../../hooks/buttons/buttons.dart';
import '../../../hooks/servicehooks/hookservice.dart';
import '../../../hooks/text/text.dart';

class Verifyotp extends StatefulWidget {
  const Verifyotp({super.key});

  @override
  State<Verifyotp> createState() => _VerifyotpState();
}

class _VerifyotpState extends State<Verifyotp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: guocolor.offWhite,
      appBar: guoAppBar(context, "Verify Email", showBack: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Column(children: [
          spacex1(context),
          dText(GuoText.verify, mqHeight(context, .017)),
          sbHeight(mqHeight(context, .1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              otpContainer(context),
              otpContainer(context),
              otpContainer(context),
              otpContainer(context),
              otpContainer(context),
            ],
          ),
          sbHeight(mqHeight(context, .5)),
          straightButton(
            "Verify",
            mqHeight(context, .059),
            mqWidth(context, .915),
            guocolor.primaryColor,
            8,
            fontSize: mqHeight(context, .022),
            fontColor: guocolor.white,
            onT: () {
              mynextScreen(context, Vsuccess());
            },
          ),
        ]),
      ),
    );
  }
}
