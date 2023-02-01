import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guomobile/constant/colors.dart';
import '../../asset/imageclass.dart';
import '../../navigators/navigation.dart';
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

AppBar guoLogoAppBarDash(BuildContext context, String title, String subTitle,
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
                child: Image.asset(ImageClass.anayo),
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

Widget textbottomNav(
    BuildContext context, Color color, String title1, String title2) {
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
          onTap: () {},
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
    BuildContext context,
    void Function()? onT,
    String title1,
    String title2,
    String title3,
    String title4,
    String title5,
    String icon1,
    String icon2,
    String icon3,
    String icon4,
    String icon5,
    {bool showIcon = true}) {
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
                  ? Image.asset(
                      icon1,
                      height: mqHeight(context, .022),
                      color: guocolor.primaryColor,
                    )
                  : Text(""),
              sbHeight(mqHeight(context, .012)),
              dText(title1, mqHeight(context, .011),
                  color: guocolor.primaryColor)
            ],
          ),
          Column(
            children: [
              showIcon
                  ? Image.asset(
                      icon2,
                      height: mqHeight(context, .025),
                    )
                  : Text(""),
              sbHeight(mqHeight(context, .01)),
              dText(title2, mqHeight(context, .011), color: Color(0xffA0B8CC)),
            ],
          ),
          Column(
            children: [
              showIcon
                  ? Image.asset(
                      icon3,
                      height: mqHeight(context, .025),
                    )
                  : Text(""),
              sbHeight(mqHeight(context, .01)),
              dText(title3, mqHeight(context, .011), color: Color(0xffA0B8CC))
            ],
          ),
          Column(
            children: [
              showIcon
                  ? Image.asset(
                      icon4,
                      height: mqHeight(context, .025),
                    )
                  : Text(""),
              sbHeight(mqHeight(context, .01)),
              dText(title4, mqHeight(context, .011), color: Color(0xffA0B8CC))
            ],
          ),
          Column(
            children: [
              showIcon
                  ? Image.asset(
                      icon5,
                      height: mqHeight(context, .025),
                    )
                  : Text(""),
              sbHeight(mqHeight(context, .01)),
              dText(title5, mqHeight(context, .012), color: Color(0xffA0B8CC))
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
