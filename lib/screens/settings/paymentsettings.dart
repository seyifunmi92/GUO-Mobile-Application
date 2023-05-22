import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../hooks/text/text.dart';


class Psettings extends StatefulWidget {
  const Psettings({super.key});

  @override
  State<Psettings> createState() => _PsettingsState();
}

class _PsettingsState extends State<Psettings> {
  bool otpClicked = false;
  bool touchclicked = false;
  bool alwayask = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: guocolor.transparent,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Column(
          children: [],
        ),
      ),
      bottomNavigationBar: Container(
        height: mqHeight(context, .4),
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
              sbHeight(mqHeight(context, .025)),
              dText("Payment Validation Mode", mqHeight(context, .02),
                  color: guocolor.black.withOpacity(1),
                  fontweight: FontWeight.w700),
              sbHeight(mqHeight(context, .05)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dText("OTP Verification", mqHeight(context, .02),
                      color: guocolor.black.withOpacity(.8),
                      fontweight: FontWeight.w400),
                  InkWell(
                    onTap: () {
                      clickFunction1();
                    },
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: guocolor.black),
                        color: otpClicked ? guocolor.primaryColor : null,
                      ),
                    ),
                  ),
                ],
              ),
              sbHeight(mqHeight(context, .025)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dText("Touch ID", mqHeight(context, .02),
                      color: guocolor.black.withOpacity(.8),
                      fontweight: FontWeight.w400),
                  InkWell(
                    onTap: () {
                      clickFunction2();
                    },
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: guocolor.black),
                        color: touchclicked ? guocolor.primaryColor : null,
                      ),
                    ),
                  )
                ],
              ),
              sbHeight(mqHeight(context, .025)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dText("Always ask", mqHeight(context, .02),
                      color: guocolor.black.withOpacity(.8),
                      fontweight: FontWeight.w400),
                  InkWell(
                    onTap: () {
                      clickFunction3();
                    },
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: guocolor.black),
                        color: alwayask ? guocolor.primaryColor : null,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  clickFunction1() {
    if (!otpClicked) {
      setState(() {
        alwayask = false;
        otpClicked = true;
        toast("OTP Verification activated");
      });
    } else {
      setState(() {
        toast("OTP Verification deactivated");
        otpClicked = false;
      });
    }
  }

  clickFunction2() {
    if (!touchclicked) {
      setState(() {
        alwayask = false;
        touchclicked = true;
        toast("Touch ID Activated");
      });
    } else {
      setState(() {
        toast("Touch ID deactivated");
        touchclicked = false;
      });
    }
  }

  clickFunction3() {
    if (!alwayask) {
      setState(() {
        alwayask = true;
        touchclicked = false;
        otpClicked = false;
        toast("Always Ask Activated");
      });
    } else {
      setState(() {
        toast("Always Ask deactivated");
        alwayask = false;
      });
    }
  }
}
