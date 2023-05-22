import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/screens/orders/orderhistory.dart';
import 'package:guomobile/screens/nearme/nearme.dart';
import 'package:guomobile/screens/trips/trips.dart';
import 'package:guomobile/screens/wallet/wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../asset/imageclass.dart';
import '../../navigators/navigation.dart';
import '../../screens/home/home.dart';
import '../layout/mediaqueries.dart';
import '../text/text.dart';

AppBar guoAppBar(BuildContext context, String title,
    {bool showBack = true,
    bool isCenter = true,
    bool showElevation = true,
    bool showLogo = false,
    List<Widget>? actions,
    Color? color}) {
  return AppBar(
    backgroundColor: guocolor.white,
    toolbarHeight: mqHeight(context, .075),
    automaticallyImplyLeading: false,
    centerTitle: isCenter ? true : false,
    elevation: showElevation ? .2 : 0,
    title: Text(
      title,
      style: TextStyle(
        fontFamily: "Futura",
        color: Colors.black,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        fontSize: mqHeight(context, .022),
      ),
    ),
    leading: !showBack
        ? null
        : InkWell(
            onTap: () {
              finishContext(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: mqHeight(context, .025),
              color: guocolor.primaryColor,
            ),
          ),
    actions: actions,
  );
}

AppBar guoLogoAppBar(BuildContext context, String title,
    {bool showBack = true,
    bool isCenter = true,
    bool showElevation = true,
    List<Widget>? actions,
    Color? color}) {
  return AppBar(
    backgroundColor: guocolor.greyWhite,
    toolbarHeight: mqHeight(context, .07),
    automaticallyImplyLeading: false,
    centerTitle: isCenter ? true : false,
    elevation: showElevation ? .2 : 0,
    title: Text(
      title,
      style: TextStyle(
        fontFamily: "Futura",
        color: Colors.black,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        fontSize: mqHeight(context, .022),
      ),
    ),
    leading: !showBack
        ? null
        : InkWell(
            onTap: () {
              finishContext(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: mqHeight(context, .025),
              color: guocolor.primaryColor,
            ),
          ),
    actions: [
      Padding(
        padding: EdgeInsets.only(
            bottom: mqHeight(context, .01), right: mqWidth(context, .025)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              ImageClass.guo,
              height: mqHeight(context, .03),
            )
          ],
        ),
      )
    ],
  );
}

AppBar guoLogoAppBarDash(
    BuildContext context, String image, String title, String subTitle,
    {bool showBack = false,
    bool isCenter = false,
    bool showElevation = true,
    List<Widget>? actions,
    void Function()? onT,
    String? pix,
    Image? pix2,
    bool isApi = false,
    Color? color}) {
  return AppBar(
    backgroundColor: guocolor.white,
    toolbarHeight: mqHeight(context, .08),
    automaticallyImplyLeading: false,
    centerTitle: isCenter ? true : false,
    elevation: showElevation ? .2 : 0,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: "Futura",
            color: Colors.black.withOpacity(.8),
            fontWeight: FontWeight.w400,
            letterSpacing: 0,
            fontSize: mqHeight(context, .018),
          ),
        ),
        Text(
          subTitle,
          style: TextStyle(
            fontFamily: "Futura",
            color: Colors.black.withOpacity(.3),
            fontWeight: FontWeight.w500,
            letterSpacing: .45,
            fontSize: mqHeight(context, .015),
          ),
        ),
      ],
    ),
    leading: !showBack
        ? Padding(
            padding: EdgeInsets.only(left: mqWidth(context, .02)),
            child: InkWell(
              onTap: onT,
              child: CircleAvatar(
                backgroundImage: NetworkImage(image),
              ),
            ),
          )
        : InkWell(
            onTap: () {
              finishContext(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: mqHeight(context, .025),
              color: guocolor.primaryColor,
            ),
          ),
    actions: [
      Padding(
        padding: EdgeInsets.only(
            bottom: mqHeight(context, .01), right: mqWidth(context, .025)),
        child: const Icon(
          Icons.notifications,
        ),
      )
    ],
  );
}

AppBar fsdhAppBaTrans(BuildContext context, String title,
    {bool showBack = true,
    bool isCenter = true,
    bool showElevation = true,
    List<Widget>? actions,
    Color? color}) {
  return AppBar(
    backgroundColor: guocolor.primaryColor,
    toolbarHeight: mqHeight(context, .07),
    automaticallyImplyLeading: false,
    centerTitle: isCenter ? true : false,
    elevation: showElevation ? .2 : 0,
    title: Text(
      title,
      style: TextStyle(
        fontFamily: "Poppins",
        color: Colors.white,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        fontSize: mqHeight(context, .022),
      ),
    ),
    leading: !showBack
        ? null
        : InkWell(
            onTap: () {
              finishContext(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: mqHeight(context, .025),
              color: guocolor.white,
            ),
          ),
    actions: actions,
  );
}

Widget FSDHLogoAppBar(BuildContext context, String title,
    {bool showBack = true,
    bool? showNotificationIcon,
    bool isCenter = true,
    Color? color}) {
  return AppBar(
    toolbarHeight: MediaQuery.of(context).size.height * .01,
    automaticallyImplyLeading: showBack ? true : false,
    centerTitle: isCenter ? true : false,
    title: Text(
      title,
      style: GoogleFonts.lato(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        fontSize: MediaQuery.of(context).size.height * .001,
      ),
    ),
    leading: !showBack
        ? null
        : InkWell(
            onTap: () {
              void finish(BuildContext context, [Object? result]) {
                if (Navigator.canPop(context)) Navigator.pop(context, result);
              }
            },
            child: Icon(Icons.arrow_back_ios),
          ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [],
      )
    ],
  );
}

Widget textbottomNav(BuildContext context, Color color, String title1,
    String title2, void Function()? onT) {
  return Container(
    height: mqHeight(context, .1),
    color: color,
    child: Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title1,
          style: GoogleFonts.openSans(
            fontSize: mqHeight(context, .013),
            fontWeight: FontWeight.w400,
          ),
        ),
        sbWidth(mqWidth(context, .002)),
        InkWell(
          onTap: onT,
          child: Text(
            title2,
            style: GoogleFonts.openSans(
              color: Color(0xff009ADE),
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              fontSize: mqHeight(context, .018),
            ),
          ),
        ),
      ],
    )),
  );
}

Widget bottomNavDash(
  BuildContext context, {
  bool showIcon = true,
  bool isHome = false,
  bool isWallet = false,
  bool isNearme = false,
  bool isTrips = false,
  bool isOrders = false,
}) {
  return Container(
    height: mqHeight(context, .1),
    decoration: BoxDecoration(
        color: guocolor.white, borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: EdgeInsets.only(top: mqHeight(context, .025)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              showIcon
                  ? InkWell(
                      onTap: !isHome
                          ? () {
                              mynextScreen(context, Home("x", "y", ""));
                            }
                          : null,
                      child: Image.asset(
                        ImageClass.icons1,
                        height: mqHeight(context, .022),
                        color:
                            isHome ? guocolor.primaryColor : Color(0xffA0B8CC),
                      ),
                    )
                  : Text(""),
              sbHeight(mqHeight(context, .012)),
              dText("Home", mqHeight(context, .011),
                  color: isHome ? guocolor.primaryColor : Color(0xffA0B8CC))
            ],
          ),
          Column(
            children: [
              showIcon
                  ? InkWell(
                      onTap: () {
                        mynextScreen(context, Wallet());
                      },
                      child: Image.asset(
                        ImageClass.icons2,
                        height: mqHeight(context, .025),
                        color: isWallet
                            ? guocolor.primaryColor
                            : Color(0xffA0B8CC),
                      ),
                    )
                  : Text(""),
              sbHeight(mqHeight(context, .01)),
              dText("Wallet", mqHeight(context, .011),
                  color: isWallet ? guocolor.primaryColor : Color(0xffA0B8CC)),
            ],
          ),
          Column(
            children: [
              showIcon
                  ? InkWell(
                      onTap: () {
                        mynextScreen(context, Nearme());
                      },
                      child: Image.asset(
                        ImageClass.icons4,
                        height: mqHeight(context, .025),
                        color: isNearme
                            ? guocolor.primaryColor
                            : Color(0xffA0B8CC),
                      ),
                    )
                  : Text(""),
              sbHeight(mqHeight(context, .01)),
              dText("Near Me", mqHeight(context, .011),
                  color: isNearme ? guocolor.primaryColor : Color(0xffA0B8CC))
            ],
          ),
          Column(
            children: [
              showIcon
                  ? InkWell(
                      onTap: () {
                        mynextScreen(context, Trips());
                      },
                      child: Image.asset(
                        ImageClass.icons2,
                        height: mqHeight(context, .025),
                        color:
                            isTrips ? guocolor.primaryColor : Color(0xffA0B8CC),
                      ),
                    )
                  : Text(""),
              sbHeight(mqHeight(context, .01)),
              dText("My Trips", mqHeight(context, .011),
                  color: isTrips ? guocolor.primaryColor : Color(0xffA0B8CC))
            ],
          ),
          Column(
            children: [
              showIcon
                  ? InkWell(
                      onTap: () {
                        mynextScreen(context, OrderHistory());
                      },
                      child: Image.asset(
                        ImageClass.icons3,
                        height: mqHeight(context, .025),
                        color: isOrders
                            ? guocolor.primaryColor
                            : Color(0xffA0B8CC),
                      ),
                    )
                  : Text(""),
              sbHeight(mqHeight(context, .01)),
              dText("Orders", mqHeight(context, .012),
                  color: isOrders ? guocolor.primaryColor : Color(0xffA0B8CC))
            ],
          ),
        ],
      ),
    ),
  );
}

Widget bottomNavwithbutton(
  BuildContext context,
  void Function()? onT,
  String title,
) {
  return Container(
    height: mqHeight(context, .13),
    color: guocolor.bg3.withOpacity(.1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            onT!();
          },
          child: Container(
            height: MediaQuery.of(context).size.height * .059,
            width: MediaQuery.of(context).size.width * .91,
            decoration: BoxDecoration(
              color: guocolor.primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
                child: Text(
              title,
              style: TextStyle(
                fontFamily: "Futura",
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.height * .022,
                fontWeight: FontWeight.w500,
              ),
            )),
          ),
        ),
      ],
    ),
  );
}
