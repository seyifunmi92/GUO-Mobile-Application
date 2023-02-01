import 'package:flutter/material.dart';

mqHeight(BuildContext context, double height) {
  return MediaQuery.of(context).size.height * height;
}

mqWidth(BuildContext context, double width) {
  return MediaQuery.of(context).size.height * width;
}

sbHeight(double height) {
  return SizedBox(
    height: height,
  );
}

totalWidth(BuildContext context) {
  MediaQuery.of(context).size.width;
}

sbWidth(double width) {
  return SizedBox(
    width: width,
  );
}

Widget space(BuildContext context) {
  return sbHeight(mqHeight(context, .02));
}
Widget spacex1(BuildContext context) {
  return sbHeight(mqHeight(context, .03));
}
Widget spacex2(BuildContext context) {
  return sbHeight(mqHeight(context, .07));
}
