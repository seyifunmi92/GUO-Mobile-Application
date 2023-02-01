import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';



void newpushHardReplacementWidgetWithAnimation(
    String pageName,
    {required BuildContext context,
      required Duration duration,
      required Widget child,
      required PageTransitionType transitionType}) {
  Navigator.pushAndRemoveUntil(
      context,
      PageTransition(duration: duration, type: transitionType, child: child),
      ModalRoute.withName(pageName));
}

void newpushwithAnimation(
    String pageName,
    {required BuildContext context,
      required Duration duration,
      required Widget child,
      required PageTransitionType transitionType}
    ){
  Navigator.push(context,
      PageTransition(duration: duration, type: transitionType, child: child));


}