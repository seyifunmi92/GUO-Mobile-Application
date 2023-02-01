import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/hooks/servicehooks/hookservice.dart';
import 'package:guomobile/hooks/text/text.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/profile/profilesuccess.dart';

import '../../hooks/formfields/formfields.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "Anayo Obiajulu";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: guoAppBar(context, "Profile"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: SingleChildScrollView(
          child: Column(children: [
            sbHeight(mqHeight(context, .1)),
            Center(child: profileCard(context, false, ImageClass.download)),
            sbHeight(mqHeight(context, .015)),
            dText(name, mqHeight(context, .024),
                fontweight: FontWeight.w700, letterSpacing: .04),
            sbHeight(mqHeight(context, .005)),
            dText("@anayor", mqHeight(context, .017),
                color: guocolor.primaryColor, letterSpacing: .15),
            sbHeight(mqHeight(context, .05)),
            Row(
              children: [
                dText("First Name", mqHeight(context, .018),
                    color: guocolor.black, letterSpacing: .15),
              ],
            ),
            sbHeight(mqHeight(context, .01)),
            guoFormField(context, mqHeight(context, .05), mqWidth(context, .5),
                containercolor: guocolor.white,
                showBorder: false,
                showRadius: true,
                radiusborder: true, onT: () {
              setState(() {});
            }, title: "Anayo"),
            sbHeight(mqHeight(context, .025)),
            Row(
              children: [
                dText("Last Name", mqHeight(context, .018),
                    color: guocolor.black, letterSpacing: .15),
              ],
            ),
            sbHeight(mqHeight(context, .01)),
            guoFormField(context, mqHeight(context, .05), mqWidth(context, .5),
                containercolor: guocolor.white,
                showBorder: false,
                showRadius: true,
                radiusborder: true, onT: () {
              setState(() {});
            }, title: "Anayo"),
            sbHeight(mqHeight(context, .025)),
            Row(
              children: [
                dText("Email", mqHeight(context, .018),
                    color: guocolor.black, letterSpacing: .15),
              ],
            ),
            sbHeight(mqHeight(context, .01)),
            guoFormField(context, mqHeight(context, .05), mqWidth(context, .5),
                containercolor: guocolor.white,
                showBorder: false,
                showRadius: true,
                radiusborder: true, onT: () {
              setState(() {});
            }, title: "obianayo@gmail.com"),
            sbHeight(mqHeight(context, .025)),
            Row(
              children: [
                dText("Phone Number", mqHeight(context, .018),
                    color: guocolor.black, letterSpacing: .15),
              ],
            ),
            sbHeight(mqHeight(context, .01)),
            guoFormField(context, mqHeight(context, .05), mqWidth(context, .5),
                containercolor: guocolor.white,
                showBorder: false,
                showRadius: true,
                radiusborder: true, onT: () {
              setState(() {});
            }, title: ""),
          ]),
        ),
      ),
      bottomNavigationBar: bottomNavwithbutton(context, () {
        mynextScreen(context, PSuccess());
      }, "Update"),
    );
  }
}
