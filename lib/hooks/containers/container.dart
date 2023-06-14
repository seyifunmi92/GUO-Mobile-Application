import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/buttons/buttons.dart';
import 'package:guomobile/hooks/text/text.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:provider/provider.dart';
import '../../providers/sharedstorage/localstorage.dart';
import '../../screens/auth/login/login.dart';
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
              "ImageClass.uploadIcon",
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

Widget container1(BuildContext context, String number,
    {void Function()? onT, Color? xColor}) {
  return GestureDetector(
    onTap: onT,
    child: Container(
      height: mqHeight(context, .15),
      width: mqWidth(context, .18),
      child: Center(
        child: dText(number, mqHeight(context, .02)),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: xColor,
      ),
    ),
  );
}

dispatchCircle(String content, bool isCompleted) {
  return Container(
    height: 60,
    width: 60,
    decoration: BoxDecoration(
      color: isCompleted ? guocolor.primaryColor : Color(0xff8C8C95),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Center(
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: guocolor.offWhite,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
            child: dText(content, 10,
                color:
                    isCompleted ? guocolor.primaryColor : Color(0xff8C8C95))),
      ),
    ),
  );
}

TripContainer(BuildContext context,
    {Widget? xArray, String header = "Select Trip Type"}) {
  return Scaffold(
    backgroundColor: guocolor.transparent,
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            sbHeight(mqHeight(context, .15)),
            Container(
              width: mqWidth(context, 1),
              decoration: BoxDecoration(
                color: guocolor.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: mqHeight(context, .02)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    sbHeight(mqHeight(context, .02)),
                    dText(header, mqHeight(context, .015),
                        fontweight: FontWeight.w700),
                    sbHeight(mqHeight(context, .01)),
                    xArray!,
                    sbHeight(mqHeight(context, .02)),
                    straightButton("Close", mqHeight(context, .04),
                        mqHeight(context, .1), guocolor.primaryColor, 10,
                        fontColor: guocolor.white,
                        fontSize: mqHeight(context, .015), onT: () {
                      closeAction(context);
                    })

                    //xArray,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget shadowContainer(BuildContext context, double height, double width,
    String title, void Function()? onT, bool isIcon,
    {IconData? icon, String? photopath}) {
  return InkWell(
    onTap: onT,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurStyle: BlurStyle.outer,
            blurRadius: 20,
            spreadRadius: 0,
            offset: Offset.zero,
          ),
        ],
      ),
      width: width,
      height: height,
      child: isIcon
          ? Center(
              child: Icon(icon),
            )
          : Center(
              child: Image.file(
                File(photopath!),
                fit: BoxFit.fill,
              ),
            ),
    ),
  );
}

logoutcontainer(BuildContext context) {
  return Scaffold(
    backgroundColor: guocolor.transparent,
    bottomNavigationBar: Container(
      height: mqHeight(context, .4),
      width: mqWidth(context, 1),
      color: guocolor.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Column(
          children: [
            sbHeight(mqHeight(context, .1)),
            dText("Are you sure you want to log out?", mqHeight(context, .03)),
            sbHeight(mqHeight(context, .1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .05)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  straightButton("No", mqHeight(context, .05),
                      mqWidth(context, .1), guocolor.primaryColor, 20,
                      fontColor: guocolor.white, onT: () {
                    closeAction(context);
                  }),
                  straightButton("Yes", mqHeight(context, .05),
                      mqWidth(context, .1), guocolor.whiteGrey, 20, onT: () {
                    Provider.of<LocalStorageBloc>(context, listen: false)
                        .refreshapp();
                    mynextScreen(
                        context,
                        Login(
                          islogout: true,
                        ));
                  })
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

logoutnotice() {
  return Scaffold(
    backgroundColor: guocolor.transparent,
    body: Center(
        child: Container(
      color: guocolor.white,
    )),
  );
}

paymentCard(BuildContext context, String title,
    {String? image, void Function()? onT}) {
  return InkWell(
    onTap: onT,
    child: Container(
      height: mqHeight(context, .18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: guocolor.white),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dText(title, mqHeight(context, .03)),
              Image.asset(
                image!,
                height: mqHeight(context, .05),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget shadowContainer2(
    BuildContext context,
    double height,
    double width,
    String title,
    String title2,
    String amount,
    String status,
    void Function()? onT,
    {IconData? icon,
    String? photopath}) {
  return InkWell(
    onTap: onT,
    child: Padding(
      padding: EdgeInsets.only(bottom: mqHeight(context, .01)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurStyle: BlurStyle.outer,
              blurRadius: 10,
              spreadRadius: 0,
              offset: Offset.zero,
            ),
          ],
        ),
        width: width,
        height: height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .012)),
          child: Row(
            children: [
              circle(context, Icons.pedal_bike),
              sbWidth(mqWidth(context, .02)),
              Container(
                width: mqWidth(context, .325),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sbHeight(mqHeight(context, .038)),
                        dText("${title} - ${title2}", mqHeight(context, .016)),
                        sbHeight(mqHeight(context, .003)),
                        dText(status, mqHeight(context, .011),
                            color: guocolor.red),
                      ],
                    ),
                    dText(
                      amount,
                      mqHeight(context, .016),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

dispatchCircleHome(Color outerColor, IconData icon,
    {Color? iconcolor, void Function()? onT}) {
  return InkWell(
    onTap: onT,
    child: Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        color: outerColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Container(
          height: 88,
          width: 88,
          decoration: BoxDecoration(
            color: guocolor.offWhite,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Icon(
              icon,
              size: 50,
              color: iconcolor,
            ),
          ),
        ),
      ),
    ),
  );
}

boxTick(bool showTick, {void Function()? onT}) {
  return InkWell(
    onTap: onT,
    child: Container(
      height: 13,
      width: 13,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: guocolor.black.withOpacity(.5)),
          color: showTick ? guocolor.primaryColor : null),
      child: showTick
          ? Center(
              child: Container(
                height: 5,
                width: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: guocolor.white,
                ),
              ),
            )
          : null,
    ),
  );
}

boxTickSeat(bool showTick, {void Function()? onT, Color? tickColor}) {
  return InkWell(
    onTap: onT,
    child: Container(
      height: 15,
      width: 15,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: guocolor.black.withOpacity(.5)),
          color: showTick ? tickColor : null),
    ),
  );
}

boxTickradius(bool showTick, BorderRadius radius, {void Function()? onT}) {
  return InkWell(
    onTap: onT,
    child: Container(
      height: 13,
      width: 13,
      decoration: BoxDecoration(
          borderRadius: radius,
          border: Border.all(color: guocolor.black.withOpacity(.5)),
          color: showTick ? guocolor.primaryColor : null),
      child: showTick
          ? Center(
              child: Container(
                height: 5,
                width: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: guocolor.white,
                ),
              ),
            )
          : null,
    ),
  );
}

tickCircle(bool showTick, {void Function()? onT}) {
  return InkWell(
    onTap: onT,
    child: Container(
      height: 13,
      width: 13,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: guocolor.black.withOpacity(.5)),
          color: showTick ? guocolor.primaryColor : null),
      child: showTick
          ? Center(
              child: Container(
                height: 5,
                width: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: guocolor.white,
                ),
              ),
            )
          : null,
    ),
  );
}

imageContainer(BuildContext context, String imageLink) {
  return Container(
      height: mqHeight(context, .25),
      width: mqWidth(context, 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: guocolor.black,
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(
                      imageLink,
                    ),
                    fit: BoxFit.cover)),
          ),
        ],
      ));
}

selectorCircle() {
  return Center(
    child: Container(
      height: 5,
      width: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: guocolor.white,
      ),
    ),
  );
}

Widget dContain(BuildContext context, String content) {
  return Container(
      height: mqHeight(context, .3),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: guocolor.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Image.network(
        content,
        fit: BoxFit.fitWidth,
      ));
}

Widget containSet(
    BuildContext context, String title, String subTitle, IconData icon,
    {void Function()? onT}) {
  return InkWell(
    onTap: onT,
    child: Container(
      height: mqHeight(context, .1),
      width: totalWidth(context),
      decoration: BoxDecoration(
        color: guocolor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            circle2(context, icon),
            sbWidth(mqWidth(context, .02)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sbHeight(mqHeight(context, .031)),
                dText(title, mqHeight(context, .019)),
                sbHeight(mqHeight(context, .001)),
                dText(subTitle, mqHeight(context, .013),
                    color: guocolor.black.withOpacity(.5)),
              ],
            )
          ],
        )),
      ),
    ),
  );
}
Widget containSet2(
    BuildContext context, String title, String subTitle, String icon,
    {void Function()? onT}) {
  return InkWell(
    onTap: onT,
    child: Container(
      height: mqHeight(context, .1),
      width: totalWidth(context),
      decoration: BoxDecoration(
        color: guocolor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            circle3(context, icon),
            sbWidth(mqWidth(context, .02)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sbHeight(mqHeight(context, .031)),
                dText(title, mqHeight(context, .019)),
                sbHeight(mqHeight(context, .001)),
                dText(subTitle, mqHeight(context, .013),
                    color: guocolor.black.withOpacity(.5)),
              ],
            )
          ],
        )),
      ),
    ),
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

Widget circleTick(BuildContext context, IconData icon) {
  return CircleAvatar(
    radius: 12,
    backgroundColor: Color(0xff0AA06E),
    child: Icon(
      icon,
      color: guocolor.white,
      size: mqHeight(context, .018),
    ),
  );
}

Widget bigcircle(BuildContext context, IconData icon, {double? radius}) {
  return CircleAvatar(
    radius: radius,
    backgroundColor: guocolor.white,
    child: Icon(
      icon,
      color: guocolor.primaryColor,
      size: mqHeight(context, .05),
    ),
  );
}

Widget oDetails(BuildContext context) {
  return Container(
    height: mqHeight(context, .15),
    width: mqWidth(context, 1),
    decoration: BoxDecoration(
        color: guocolor.grey.withOpacity(.4),
        borderRadius: BorderRadius.circular(10)),
    child: Image.asset(
      ImageClass.map,
      fit: BoxFit.fill,
    ),
  );
}

Widget circle2(BuildContext context, IconData icon) {
  return CircleAvatar(
    radius: 20,
    backgroundColor: Color(0xffE4ECF2).withOpacity(.5),
    child: Icon(
      icon,
      color: guocolor.primaryColor,
      size: mqHeight(context, .02),
    ),
  );
}
Widget circle3(BuildContext context, String icon) {
  return CircleAvatar(
    radius: 20,
    backgroundColor: Color(0xffE4ECF2).withOpacity(.5),
    child: Image.asset(
      icon,
     //color: guocolor.primaryColor,
      height: mqHeight(context, .03),
    ),
  );
}
