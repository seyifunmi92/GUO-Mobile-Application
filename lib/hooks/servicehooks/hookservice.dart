import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/providers/callfunctions/providerbloc.dart';
import 'package:guomobile/screens/help/help.dart';
import 'package:guomobile/screens/nearme/terminalbyid.dart';
import 'package:guomobile/screens/orders/orderhistory.dart';
import 'package:guomobile/screens/refferals/refferal.dart';
import 'package:guomobile/screens/reviews/riderreview.dart';
import 'package:guomobile/screens/settings/settings.dart';
import 'package:guomobile/screens/trips/selectseats.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../asset/imageclass.dart';
import '../../models/onboarding.dart';
import '../../models/terminals.dart';
import '../../navigators/navigation.dart';
import '../../providers/sharedstorage/localstorage.dart';
import '../../screens/auth/login/login.dart';
import '../../screens/profile/profile.dart';
import '../buttons/buttons.dart';
import '../containers/container.dart';
import '../dialog/loader.dart';
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

Widget terminalCustom(BuildContext context, Datum x) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbHeight(mqHeight(context, .02)),
        InkWell(
            onTap: () {
              mynextScreen(context, TerminalDetails(x.id));
            },
            child: dContain(context, x.imageLink)),
        sbHeight(mqHeight(context, .025)),
        dText(x.terminal, mqHeight(context, .023)),
        sbHeight(mqHeight(context, .01)),
        dText(x.address, mqHeight(context, .02),
            color: guocolor.black.withOpacity(.5)),
        sbHeight(mqHeight(context, .01)),
        dText(x.phoneNumber, mqHeight(context, .016),
            color: guocolor.black.withOpacity(.5)),
        sbHeight(mqHeight(context, .01)),
        Divider(color: guocolor.black.withOpacity(.2)),
      ],
    ),
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

Widget dashContainer(BuildContext context, double height, double width,
    {TextEditingController? myController}) {
  return formField1(context, "Search Booking Code or Order ID", height, width,
      controller: myController,
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

Widget loyaltyContainer(BuildContext context, String tripDestination,
    String dateTime, String seatNumber) {
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
            dText("Loyalty points", mqHeight(context, .017),
                fontweight: FontWeight.w700, color: guocolor.white),
            sbHeight(mqHeight(context, .012)),
            sbHeight(mqHeight(context, .012)),
            Row(
              children: [
                dText("$seatNumber", mqHeight(context, .028),
                    fontweight: FontWeight.w700, color: guocolor.white),
              ],
            ),
          ]),
        ),
      )
    ]),
  );
}

Widget starRating(BuildContext context, Color color, {void Function()? onT}) {
  return InkWell(
      onTap: onT,
      child: Icon(
        Icons.star,
        color: color,
        size: mqHeight(context, .045),
      ));
}

seatContainer(BuildContext context, {int? seatNumber}) {
  return Container(
    height: mqHeight(context, .05),
    width: mqWidth(context, .05),
    decoration: BoxDecoration(
        border: Border.all(color: guocolor.black.withOpacity(.4)),
        borderRadius: BorderRadius.circular(10)),
    child: Center(
        child: dText(seatNumber.toString(), mqHeight(context, .02),
            color: guocolor.black.withOpacity(.5))),
  );
}

Widget guoLoader() {
  return Scaffold(body: Center(child: Loaderx(ImageClass.loader)));
}

Widget dashContainerWallet(BuildContext context, String tripDestination,
    String dateTime, String balance) {
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
            sbHeight(mqHeight(context, .04)),
            dText(tripDestination, mqHeight(context, .017),
                fontweight: FontWeight.w600, color: guocolor.white),
            sbHeight(mqHeight(context, .012)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dText(balance, mqHeight(context, .023),
                    fontweight: FontWeight.w700, color: guocolor.white),
                Container(
                  height: mqHeight(context, .03),
                  width: mqWidth(context, .1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: guocolor.white),
                  child: Center(
                    child: dText("Fund Wallet", mqHeight(context, .013),
                        color: guocolor.primaryColor),
                  ),
                ),
              ],
            ),
          ]),
        ),
      )
    ]),
  );
}

Widget dashContainer2(BuildContext context, String image,
    {void Function()? onT}) {
  return InkWell(
    onTap: onT,
    child: Container(
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
      ]),
    ),
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

Widget guoDrawer(BuildContext context, String image, String name,
    {bool asset = false, bool isguest = false}) {
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
            !asset
                ? CircleAvatar(backgroundImage: NetworkImage(image))
                : CircleAvatar(
                    backgroundImage: AssetImage(image),
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
                isguest
                    ? toast("You can not view this as a guest")
                    : mynextScreen(context, Profile());
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
            InkWell(
              onTap: () {
                isguest
                    ? toast("You can not view this as a guest")
                    : mynextScreen(context, OrderHistory());
              },
              child: dText("Orders", mqHeight(context, .019),
                  color: guocolor.black.withOpacity(.7)),
            ),
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
            InkWell(
              onTap: () {
                mynextScreen(context, Refferals());
              },
              child: dText("Referral", mqHeight(context, .019),
                  color: guocolor.black.withOpacity(.7)),
            ),
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
            InkWell(
              onTap: () {
                // mynextScreen(context, Review());
              },
              child: dText("Reviews", mqHeight(context, .019),
                  color: guocolor.black.withOpacity(.7)),
            ),
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
            InkWell(
              onTap: () {
                mynextScreen(context, Help());
              },
              child: dText("Help", mqHeight(context, .019),
                  color: guocolor.black.withOpacity(.7)),
            ),
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
            InkWell(
              onTap: () {
                mynextScreen(context, Settings());
              },
              child: dText("Settings", mqHeight(context, .019),
                  color: guocolor.black.withOpacity(.7)),
            ),
          ],
        ),
        sbHeight(mqHeight(context, .12)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              ImageClass.icon7,
              height: mqHeight(context, .018),
            ),
            sbWidth(mqWidth(context, .025)),
            InkWell(
              onTap: () {
                Provider.of<ProviderBloc>(context, listen: false)
                    .showLogout(context);
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

Widget guoTripDrawer(BuildContext context, {void Function()? onT}) {
  return Container(
    height: mqHeight(context, 1),
    width: mqWidth(context, .3),
    color: guocolor.white,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .035)),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          sbHeight(mqHeight(context, .055)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dText("Filter by", mqHeight(context, .02)),
              InkWell(
                onTap: () {
                  closeAction(context);
                },
                child: Icon(Icons.cancel),
              )
            ],
          ),
          sbHeight(mqHeight(context, .015)),
          dText("Purpose", mqHeight(context, .017)),
          sbHeight(mqHeight(context, .03)),
          Row(
            children: [
              tickCircle(true),
              sbWidth(mqWidth(context, .018)),
              InkWell(
                  onTap: () {
                    mynextScreen(context, SelectSeats());
                  },
                  child: dText("Transport", mqHeight(context, .017))),
            ],
          ),
          sbHeight(mqHeight(context, .02)),
          Row(
            children: [
              tickCircle(false),
              sbWidth(mqWidth(context, .018)),
              dText("Logistics", mqHeight(context, .017)),
            ],
          ),
          sbHeight(mqHeight(context, .03)),
          dText("Time", mqHeight(context, .017)),
          sbHeight(mqHeight(context, .02)),
          Row(
            children: [
              tickCircle(true),
              sbWidth(mqWidth(context, .018)),
              dText("Morning", mqHeight(context, .017)),
            ],
          ),
          sbHeight(mqHeight(context, .02)),
          Row(
            children: [
              tickCircle(false),
              sbWidth(mqWidth(context, .018)),
              dText("Afternoon", mqHeight(context, .017)),
            ],
          ),
          sbHeight(mqHeight(context, .02)),
          Row(
            children: [
              tickCircle(false),
              sbWidth(mqWidth(context, .018)),
              dText("Night", mqHeight(context, .017)),
            ],
          ),
          sbHeight(mqHeight(context, .03)),
          dText("Vehicle Type", mqHeight(context, .017)),
          sbHeight(mqHeight(context, .03)),
          Row(
            children: [
              tickCircle(true),
              sbWidth(mqWidth(context, .018)),
              dText("Morning", mqHeight(context, .017)),
            ],
          ),
          sbHeight(mqHeight(context, .02)),
          Row(
            children: [
              tickCircle(false),
              sbWidth(mqWidth(context, .018)),
              dText("Afternoon", mqHeight(context, .017)),
            ],
          ),
          sbHeight(mqHeight(context, .02)),
          Row(
            children: [
              tickCircle(false),
              sbWidth(mqWidth(context, .018)),
              dText("Night", mqHeight(context, .017)),
            ],
          ),
          sbHeight(mqHeight(context, .03)),
          dText("Capacity", mqHeight(context, .017)),
          sbHeight(mqHeight(context, .03)),
          Row(
            children: [
              tickCircle(true),
              sbWidth(mqWidth(context, .018)),
              dText("Custom (19 seats)", mqHeight(context, .017)),
            ],
          ),
          sbHeight(mqHeight(context, .02)),
          Row(
            children: [
              tickCircle(false),
              sbWidth(mqWidth(context, .018)),
              dText("Large (98 seats)", mqHeight(context, .017)),
            ],
          ),
          sbHeight(mqHeight(context, .02)),
          Row(
            children: [
              tickCircle(false),
              sbWidth(mqWidth(context, .018)),
              dText("Innoson", mqHeight(context, .017)),
            ],
          ),
          sbHeight(mqHeight(context, .03)),
          dText("Price Range", mqHeight(context, .017)),
          sbHeight(mqHeight(context, .03)),
          Row(
            children: [
              tickCircle(true),
              sbWidth(mqWidth(context, .018)),
              dText("₦8,000 - ₦10,000", mqHeight(context, .017)),
            ],
          ),
          sbHeight(mqHeight(context, .02)),
          Row(
            children: [
              tickCircle(false),
              sbWidth(mqWidth(context, .018)),
              dText("₦11,000 - ₦14,000", mqHeight(context, .017)),
            ],
          ),
          sbHeight(mqHeight(context, .02)),
          Row(
            children: [
              tickCircle(false),
              sbWidth(mqWidth(context, .018)),
              dText("₦15,000 - ₦20,000", mqHeight(context, .017)),
            ],
          ),
          sbHeight(mqHeight(context, .02)),
          straightButton(
            "Filter",
            mqHeight(context, .05),
            mqWidth(context, .5),
            guocolor.primaryColor,
            8,
            fontSize: mqHeight(context, .021),
            fontColor: guocolor.white,
            onT: onT,
          ),
        ]),
      ),
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

Widget uploadimage(BuildContext context, void Function()? galleryClick,
    void Function()? cameraClick) {
  return Scaffold(
    backgroundColor: guocolor.transparent,
    bottomNavigationBar: Container(
      height: mqHeight(context, .3),
      width: totalWidth(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: guocolor.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sbHeight(mqHeight(context, .03)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    closeAction(context);
                  },
                  child: Icon(Icons.cancel),
                ),
              ],
            ),
            sbHeight(mqHeight(context, .032)),
            InkWell(
              onTap: galleryClick,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dText("Upload Image From Gallery", mqHeight(context, .02),
                      color: guocolor.black.withOpacity(.8),
                      fontweight: FontWeight.w400),
                  Icon(Icons.upload),
                ],
              ),
            ),
            sbHeight(mqHeight(context, .055)),
            InkWell(
              onTap: cameraClick,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dText("Upload Image From Camera", mqHeight(context, .02),
                      color: guocolor.black.withOpacity(.8),
                      fontweight: FontWeight.w400),
                  Icon(Icons.upload)
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget profileCard(
    BuildContext context, bool? isImage, String image, void Function()? onT) {
  return InkWell(
    onTap: onT,
    child: Container(
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
            : Image.asset(ImageClass.profile)),
  );
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
