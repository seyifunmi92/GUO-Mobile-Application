import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../asset/imageclass.dart';
import '../../models/onboarding.dart';
import '../../navigators/navigation.dart';
import '../../screens/auth/login/login.dart';
import '../../screens/profile/profile.dart';
import '../formfields/formfields.dart';
import '../text/text.dart';

Widget sliderCustom(BuildContext context, ObSlider _slide) {
  return Stack(
    children: [
      Container(
        width: totalWidth(context),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(_slide.image2), fit: BoxFit.fill),
        ),
      ),
      Scaffold(
        backgroundColor: guocolor.transparent,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              sbHeight(mqHeight(context, .04)),
              Center(
                  child: Image.asset(
                _slide.image1,
                height: mqHeight(context, .5),
              )),
            ],
          ),
        ),
      )
    ],
  );
}

Widget otpContainer(BuildContext context) {
  return Container(
    height: mqHeight(context, .07),
    width: mqWidth(context, .07),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(.4)),
        borderRadius: BorderRadius.circular(10)),
    child: Center(
      child:
          formField1(context, "", mqHeight(context, .1), mqWidth(context, .1)),
    ),
  );
}

Widget dashContainer(BuildContext context, double height, double width) {
  return formField1(context, "Search Booking Code or Order ID", height, width,
      showBorder: true,
      radius: BorderRadius.circular(10),
      hintcolor: guocolor.black.withOpacity(.5));
}

Widget dashContainerTrip(BuildContext context, String tripDestination,
    String dateTime, int seatNumber) {
  return Container(
    height: mqHeight(context, .15),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
    child: Stack(children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
            image: AssetImage(ImageClass.ob2),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      Scaffold(
        backgroundColor: guocolor.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            sbHeight(mqHeight(context, .027)),
            dText(tripDestination, mqHeight(context, .017),
                fontweight: FontWeight.w700, color: guocolor.white),
            sbHeight(mqHeight(context, .012)),
            Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: guocolor.white,
                ),
                sbWidth(mqWidth(context, .005)),
                dText(dateTime, mqHeight(context, .0165),
                    fontweight: FontWeight.w600, color: guocolor.white),
              ],
            ),
            sbHeight(mqHeight(context, .012)),
            Row(
              children: [
                const Icon(
                  Icons.chair,
                  color: guocolor.white,
                ),
                sbWidth(mqWidth(context, .005)),
                dText("Seat $seatNumber", mqHeight(context, .0165),
                    fontweight: FontWeight.w600, color: guocolor.white),
              ],
            ),
          ]),
        ),
      )
    ]),
  );
}

Widget dashContainer2(BuildContext context, String image) {
  return Container(
    height: mqHeight(context, .23),
    width: mqWidth(context, .205),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
    child: Stack(children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      Scaffold(
        backgroundColor: guocolor.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .025)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            sbHeight(mqHeight(context, .13)),
          ]),
        ),
      )
    ]),
  );
}

Widget dashSearch(BuildContext context, void Function()? call) {
  return InkWell(
    onTap: call,
    child: Container(
      height: mqHeight(context, .05),
      width: mqWidth(context, .06),
      decoration: BoxDecoration(
          color: guocolor.primaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: Icon(
        Icons.search,
        size: mqHeight(context, .035),
        color: guocolor.white,
      ),
    ),
  );
}

Widget guoDrawer(BuildContext context, String image, String name) {
  return Container(
    height: MediaQuery.of(context).size.height,
    width: mqWidth(context, .3),
    color: guocolor.offWhite,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .04)),
      child: Column(children: [
        sbHeight(mqHeight(context, .07)),
        Row(
          children: [
            CircleAvatar(
              child: Image.asset(image),
            ),
            sbWidth(mqWidth(context, .01)),
            dText("Hello $name", mqHeight(context, .018),
                color: guocolor.black.withOpacity(.8)),
          ],
        ),
        sbHeight(mqHeight(context, .011)),
        Divider(
          color: guocolor.primaryColor.withOpacity(.7),
        ),
        sbHeight(mqHeight(context, .071)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              ImageClass.icon1,
              height: mqHeight(context, .018),
            ),
            sbWidth(mqWidth(context, .025)),
            InkWell(
              onTap: () {
                mynextScreen(context, Profile());
              },
              child: dText("Profile", mqHeight(context, .019),
                  color: guocolor.black.withOpacity(.7)),
            ),
          ],
        ),
        sbHeight(mqHeight(context, .071)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              ImageClass.icon2,
              height: mqHeight(context, .02),
            ),
            sbWidth(mqWidth(context, .025)),
            dText("My Trips", mqHeight(context, .019),
                color: guocolor.black.withOpacity(.7)),
          ],
        ),
        sbHeight(mqHeight(context, .071)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              ImageClass.icon3,
              height: mqHeight(context, .018),
            ),
            sbWidth(mqWidth(context, .025)),
            dText("Orders", mqHeight(context, .019),
                color: guocolor.black.withOpacity(.7)),
          ],
        ),
        sbHeight(mqHeight(context, .071)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              ImageClass.icon4,
              height: mqHeight(context, .018),
            ),
            sbWidth(mqWidth(context, .025)),
            dText("Rewards", mqHeight(context, .019),
                color: guocolor.black.withOpacity(.7)),
          ],
        ),
        sbHeight(mqHeight(context, .071)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              ImageClass.icon5,
              height: mqHeight(context, .018),
            ),
            sbWidth(mqWidth(context, .025)),
            dText("Help", mqHeight(context, .019),
                color: guocolor.black.withOpacity(.7)),
          ],
        ),
        sbHeight(mqHeight(context, .071)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              ImageClass.icon6,
              height: mqHeight(context, .018),
            ),
            sbWidth(mqWidth(context, .025)),
            dText("Settings", mqHeight(context, .019),
                color: guocolor.black.withOpacity(.7)),
          ],
        ),
        sbHeight(mqHeight(context, .21)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              ImageClass.icon7,
              height: mqHeight(context, .018),
            ),
            sbWidth(mqWidth(context, .025)),
            InkWell(
              onTap: (){
                mynextScreen(context, Login());
              },
              child: dText("Log Out", mqHeight(context, .019),
                  color: guocolor.black.withOpacity(.7)),
            ),
          ],
        ),
      ]),
    ),
  );
}

Widget pageIndicator(BuildContext context, int currentIndex,
    {Color? color, Color? color2}) {
  return AnimatedSmoothIndicator(
    effect: ExpandingDotsEffect(
      dotColor: color2!,
      activeDotColor: color!,
      spacing: 7,
      radius: 50,
      dotHeight: 9,
      dotWidth: 10,
    ),
    activeIndex: currentIndex,
    count: slider.length,
  );
}

Widget profileCard(BuildContext context, bool? isImage, String image) {
  return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isImage! ? guocolor.primaryColor : guocolor.transparent),
      child: isImage
          ? SingleChildScrollView(
              child: Column(
                children: [
                  sbHeight(mqHeight(context, .02)),
                  Image.asset(
                    image,
                    height: 60,
                  ),
                ],
              ),
            )
          : Image.asset(ImageClass.profile));
}

Widget sampleText(BuildContext context, ObText x) {
  return Center(
      child: dText(x.title, mqHeight(context, .0296),
          fontweight: FontWeight.w800, letterSpacing: 1.0));
}

Widget sampleText2(BuildContext context, ObText x) {
  return Center(
      child: dText(x.subTitle, mqHeight(context, .017),
          fontweight: FontWeight.w400,
          letterSpacing: .5,
          color: guocolor.black.withOpacity(.7)));
}
