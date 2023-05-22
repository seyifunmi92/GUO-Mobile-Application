import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/navigators/navigation.dart';
import '../../../hooks/text/text.dart';
import 'home.dart';

class Walk extends StatefulWidget {
  const Walk({super.key});

  @override
  State<Walk> createState() => _WalkState();
}

class _WalkState extends State<Walk> {
  bool showfirstCard = true;
  bool showsecondcard = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: guocolor.transparent,
      body: Column(
        children: [
          sbHeight(mqHeight(context, .1)),
          showfirstCard
              ? Row(
                  children: [
                    sbWidth(mqWidth(context, .04)),
                    Container(
                      height: mqHeight(context, .13),
                      width: mqWidth(context, .25),
                      decoration: BoxDecoration(
                        color: guocolor.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: mqWidth(context, .02)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sbHeight(mqHeight(context, .017)),
                            dText("Nav Menu", mqHeight(context, .016)),
                            sbHeight(mqHeight(context, .017)),
                            dText("View more details on the nav menu",
                                mqHeight(context, .014),
                                color: guocolor.black.withOpacity(.7)),
                            sbHeight(mqHeight(context, .017)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      showfirstCard = false;
                                      showsecondcard = true;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xffF3F8FF),
                                    ),
                                    height: mqHeight(context, .022),
                                    width: mqWidth(context, .052),
                                    child: Center(
                                        child: dText(
                                            "Next", mqHeight(context, .012))),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    mynextScreen(context, Home("x", "y", ""));
                                  },
                                  child: Center(
                                      child: dText(
                                          "Skip", mqHeight(context, .012))),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    //   sbHeight(mqHeight(context, .7)),
                  ],
                )
              : dText("", 0),
          sbHeight(mqHeight(context, .68)),
          showsecondcard
              ? Row(
                  children: [
                    sbWidth(mqWidth(context, .18)),
                    Container(
                      height: mqHeight(context, .13),
                      width: mqWidth(context, .27),
                      decoration: BoxDecoration(
                        color: guocolor.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: mqWidth(context, .02)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sbHeight(mqHeight(context, .012)),
                            dText("My Trips", mqHeight(context, .016)),
                            sbHeight(mqHeight(context, .017)),
                            dText("Check out your upcoming and past trips here",
                                mqHeight(context, .014),
                                color: guocolor.black.withOpacity(.7)),
                            sbHeight(mqHeight(context, .013)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    mynextScreen(context, Home("x", "y", ""));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xffF3F8FF),
                                    ),
                                    height: mqHeight(context, .022),
                                    width: mqWidth(context, .052),
                                    child: Center(
                                        child: dText(
                                            "Finish", mqHeight(context, .012))),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    //   sbHeight(mqHeight(context, .7)),
                  ],
                )
              : dText("", 0),
        ],
      ),
    );
  }
}
