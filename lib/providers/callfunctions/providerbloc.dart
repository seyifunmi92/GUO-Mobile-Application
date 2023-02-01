import 'dart:io';
import 'dart:async';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/main.dart';
import 'package:guomobile/navigators/navigation.dart';
import '../../hooks/dialog/loader.dart';
import '../../screens/onboarding/onboarding.dart';

class ProviderBloc extends ChangeNotifier {
  final myController = CarouselController();

  nextSlide() {
    myController.nextPage();
  }

  setDarkTheme(BuildContext context) {
    GuoLaunch2.of(context)!.changeTheme(ThemeMode.dark);
  }

  setLightTheme(BuildContext context) {
    GuoLaunch2.of(context)!.changeTheme(ThemeMode.light);
  }

  closeApp() {
    Platform.isAndroid ? SystemNavigator.pop() : exit(0);
  }

  timeFunction(int seconds, void Function()? call) {
    Timer(Duration(seconds: seconds), call!);
  }

  showTCDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        return Transform.scale(
          scale: Curves.bounceOut.transform(a1.value),
          child: Drawer(
            child: Container(
              height: 1000,
              width: 300,
              color: guocolor.offWhite,
            ),
          ),
        );
      },
      transitionDuration: const Duration(seconds: 1),
    );
  }

  showAnimatedLoader(BuildContext context, String image) {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        return Transform.scale(
            scale: Curves.bounceOut.transform(a1.value), child: Loader(image));
      },
      transitionDuration: const Duration(seconds: 1),
    );
  }

  showLoader(BuildContext context, String image) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loader(image);
        });
  }

  onChangeNext(BuildContext context) {
    timeFunction(5, () {
      mynextTransition(
          context, true, const Duration(seconds: 2), const Onboarding());
    });
  }
}
