import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guomobile/constant/colors.dart';

import '../layout/mediaqueries.dart';

Widget listState(BuildContext context, String title) {
  return dText(title, mqHeight(context, .017),
      color: const Color(0xff525F66).withOpacity(.8),
      fontweight: FontWeight.w400);
}

Widget listQ(BuildContext context, String title) {
  return dText(title, mqHeight(context, .017),
      color: const Color(0xff525F66).withOpacity(.8),
      fontweight: FontWeight.w400);
}

Text dText(String text, double fontSize,
    {Color? color, FontWeight? fontweight, double? letterSpacing}) {
  return Text(text,
      style: TextStyle(
        fontFamily: "Futura",
        fontSize: fontSize,
        color: color,
        fontWeight: fontweight,
        letterSpacing: letterSpacing,
      ));
}

Text dTex2t(String text, double fontSize,
    {Color? color, FontWeight? fontweight, double? letterSpacing}) {
  return Text(text,
      style: TextStyle(
        fontFamily: "OpenSans",
        fontSize: fontSize,
        color: color,
        fontWeight: fontweight,
        letterSpacing: letterSpacing,
      ));
}

Text dText4(String text, double fontSize,
    {Color? color, FontWeight? fontweight}) {
  return Text(text,
      style: GoogleFonts.openSans(
          fontSize: fontSize, color: color, fontWeight: fontweight));
}

pageTitle(BuildContext context, String title) {
  return dText(title, mqHeight(context, .023),
      color: guocolor.black, fontweight: FontWeight.w400);
}

termsText(BuildContext context, String title, String body) {
  return Column(
    children: [
      Row(
        children: [
          dText(title, mqHeight(context, .012), color: guocolor.red),
        ],
      ),
      sbHeight(mqHeight(context, .02)),
      dText(body, mqHeight(context, .0129), color: const Color(0xff65727B))
    ],
  );
}

emptyString() {
  return Text("");
}

class GuoText {
  static const ob1 = "Your safety and comfort\n        is our priority";
  static const ob2 = "Enjoy the best travel\n       experience";
  static const ob3 = "Seamless logistics\n   without stress";
  static const fP2 = "We’ve sent you a reset password link to your email.";
  static const fP =
      "Enter the email associated with your account, So we can send you a reset password link";
  static const welcome =
      "Welcome to GUO. Enjoy seamless\n            experiences with us";
  static const verify =
      "A verification link has been sent to your email";
  static const ob4 =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eros integer non justo euismod pretium pharetra\n                      tempor etiam augue. ";
  static const ob5 =
      "Lorems ipsum dolor sit amet, consectetur adipiscing elit. Eros integer non justo euismod pretium pharetra\n                      tempor etiam augue. ";
  static const ob6 =
      "Loremz ipsum dolor sit amet, consectetur adipiscing elit. Eros integer non justo euismod pretium pharetra\n                      tempor etiam augue. ";
}
