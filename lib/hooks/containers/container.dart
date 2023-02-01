import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/text/text.dart';


import '../layout/mediaqueries.dart';

Widget uploadImageContainer(BuildContext context, String body) {
  return DottedBorder(
    color: const Color(0xff1A5B93),
    strokeWidth: 0,
    child: Container(
      height: mqHeight(context, .15),
      width: mqWidth(context, .2),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .04)),
        child: Column(
          children: [
            sbHeight(mqHeight(context, .03)),
            Image.asset(
             " ImageClass.uploadIcon",
              height: mqHeight(context, .035),
            ),
            sbHeight(mqHeight(context, .01)),
            dText(body, mqHeight(context, .013),
                fontweight: FontWeight.w400,
                color: const Color(0xff000F16).withOpacity(.9)),
          ],
        ),
      ),
    ),
  );
}

Widget dContain(BuildContext context, String content) {
  return Container(
    height: mqHeight(context, .06),
    width: mqWidth(context, .17),
    decoration: BoxDecoration(
      color: guocolor.primaryColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
        child:
            dText4(content, mqHeight(context, .017), color: guocolor.white)),
  );
}

Widget dContain2(
    BuildContext context, String content, Color color, String image) {
  return Container(
    height: mqHeight(context, .06),
    width: mqWidth(context, .17),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .015)),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Color(0xffE4ECF2),
            child: Image.asset(
              image,
              height: mqHeight(context, .017),
            ),
          ),
          sbWidth(mqWidth(context, .00)),
          dText4(content, mqHeight(context, .017), color: guocolor.black),
        ],
      )),
    ),
  );
}

Widget dContain3(BuildContext context, String product, String image) {
  return Container(
    height: mqHeight(context, .2),
    width: mqWidth(context, .2),
    decoration: BoxDecoration(
      color: guocolor.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sbHeight(mqHeight(context, .028)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xffE4ECF2),
                child: Image.asset(
                  image,
                  height: mqHeight(context, .04),
                ),
              ),
              Column(
                children: [
                  dText4("YTD%", mqHeight(context, .019),
                      color: Color(0xff67BFB0)),
                  dText4("Annual Returns", mqHeight(context, .013),
                      color: guocolor.black),
                ],
              ),
            ],
          ),
          sbHeight(mqHeight(context, .058)),
          dText(product, mqHeight(context, .017),
              color: guocolor.black, fontweight: FontWeight.w600),
        ],
      ),
    ),
  );
}

Widget circle(BuildContext context, IconData icon) {
  return CircleAvatar(
    radius: 20,
    backgroundColor: Color(0xffE4ECF2),
    child: Icon(
      icon,
      color: guocolor.primaryColor,
      size: mqHeight(context, .025),
    ),
  );
}
