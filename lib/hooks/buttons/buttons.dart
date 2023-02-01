import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guomobile/constant/colors.dart';

Widget straightButton(
    String text, double height, double width, Color color, double radius,
    {double? fontSize, Color? fontColor, void Function()? onT}) {
  return InkWell(
    onTap: onT,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Center(
          child: Text(
        text,
        style: TextStyle(
          fontFamily: "Futura",
          fontSize: fontSize,
          color: fontColor,
          fontWeight: FontWeight.w500,
          letterSpacing: .3,
        ),
      )),
    ),
  );
}

Widget floatButton(IconData icon) {
  return FloatingActionButton(
    onPressed: () {},
    child: Icon(
      icon,
      color: guocolor.white,
    ),
    backgroundColor: guocolor.primaryColor,
  );
}

Widget straightButtonwithGradient(String text, double height, double width,
    Color color1, Color color2, Function() onpressed) {
  return InkWell(
    onTap: () {
      onpressed;
    },
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color1, color2]),
      ),
      child: Center(child: Text(text)),
    ),
  );
}

Widget curvedButton(BuildContext context, String text, double height,
    double width, Color color, double radius, void Function()? onpressed) {
  return InkWell(
    onTap: onpressed,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      child: Center(
          child: Text(
        text,
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * .015,
            color: guocolor.white.withOpacity(.7)),
      )),
    ),
  );
}

Widget curvedButtonwithGradient(String text, double height, double width,
    double radius, Color color1, Color color2, Function() onpressed) {
  return InkWell(
    onTap: () {
      onpressed;
    },
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color1, color2]),
      ),
      child: Center(child: Text(text)),
    ),
  );
}
