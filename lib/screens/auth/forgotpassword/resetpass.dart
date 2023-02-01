import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/auth/forgotpassword/resetsuccess.dart';
import '../../../hooks/buttons/buttons.dart';
import '../../../hooks/formfields/formfields.dart';
import '../../../hooks/text/text.dart';

class rPass extends StatefulWidget {
  const rPass({super.key});

  @override
  State<rPass> createState() => _rPassState();
}

class _rPassState extends State<rPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: guoAppBar(context, "Reset Password",
          showBack: false, isCenter: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spacex1(context),
            dText("Please enter new password", mqHeight(context, .018)),
            sbHeight(mqHeight(context, .09)),
            space(context),
            dText("New Password", mqHeight(context, .019)),
            space(context),
            guoFormField(context, mqHeight(context, .05), mqWidth(context, .5),
                containercolor: guocolor.white,
                showBorder: false,
                showRadius: true,
                radiusborder: true, onT: () {
              setState(() {});
            }),
            spacex1(context),
            dText("Confirm Password", mqHeight(context, .019)),
            space(context),
            guoFormField(context, mqHeight(context, .05), mqWidth(context, .5),
                containercolor: guocolor.white,
                showBorder: false,
                showRadius: true,
                radiusborder: true, onT: () {
              setState(() {});
            }),
            sbHeight(mqHeight(context, .08)),
            straightButton(
              "Reset Password",
              mqHeight(context, .059),
              mqWidth(context, .915),
              guocolor.primaryColor,
              8,
              fontSize: mqHeight(context, .022),
              fontColor: guocolor.white,
              onT: () {
                mynextScreen(context, rSuccess());
              },
            ),
          ],
        ),
      ),
    );
  }
}
