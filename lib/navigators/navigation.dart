import 'package:flutter/material.dart';
import 'package:guomobile/animations/animation.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:page_transition/page_transition.dart';

finishContext(BuildContext context) {
  if (Navigator.of(context).canPop()) {
    finish(context);
  }
}

closeContext(BuildContext context) {
  Navigator.pop(context);
}

void mynextScreenHardwithAnimation(
  BuildContext context,
  String pageName,
  PageTransitionType transition,
  Duration duration, {
  Widget? child,
}) {
  Navigator.pushAndRemoveUntil(
      context,
      PageTransition(duration: duration, type: transition, child: child!),
      ModalRoute.withName(pageName));
}

void mynextScreenwithAnimation(
  BuildContext context,
  String pageName,
  PageTransitionType transition,
  Duration duration, {
  Widget? child,
}) {
  newpushwithAnimation(
    pageName,
    context: context,
    duration: duration,
    child: child!,
    transitionType: transition,
  );
}

void mynextScreen(context, pageName) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => pageName));
}

void closeAction(BuildContext context) {
  Navigator.pop(context);
}

void mynextScreenPop(context, pageName) {
  Navigator.push(
      context,
      MaterialPageRoute(
          fullscreenDialog: true, builder: (context) => pageName));
}

void mynextTransition(context, bool? maintainState, Duration sec, pageName) {
  Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        maintainState: maintainState! ? true : false,
        opaque: true,
        pageBuilder: (context, context2, context3) => pageName,
        transitionDuration: sec,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ));
}

void mynextScreenOtherClose(context, pageName) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => pageName), (route) => false);
}

void nextScreenReplace(context, pageName) {
  finishContext(context);
  mynextScreen(context, pageName);
}
