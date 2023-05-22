import 'dart:io';
import 'dart:async';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/containers/container.dart';
import 'package:guomobile/hooks/dialog/typemodal.dart';
import 'package:guomobile/hooks/servicehooks/hookservice.dart';
import 'package:guomobile/main.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/providers/sharedstorage/localstorage.dart';
import 'package:guomobile/screens/logistics/selectpay.dart';
import 'package:guomobile/screens/settings/paymentsettings.dart';
import 'package:provider/provider.dart';
import '../../hooks/dialog/loader.dart';
import '../../screens/home/walkthrough.dart';
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

  showPaymentDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        return Transform.scale(
          scale: Curves.bounceOut.transform(a1.value),
          child: Psettings(),
        );
      },
      transitionDuration: const Duration(seconds: 1),
    );
  }

  showTrips(BuildContext context, {Widget? list, String? header}) {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        return Transform.scale(
          scale: Curves.bounceOut.transform(a1.value),
          child: TripContainer(context, xArray: list, header: header!),
        );
      },
      transitionDuration: const Duration(seconds: 1),
    );
  }

  showType(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        return Transform.scale(
          scale: Curves.bounceOut.transform(a1.value),
          child: Typemodal(),
        );
      },
      transitionDuration: const Duration(seconds: 1),
    );
  }

  showPicker(
      BuildContext context, void Function()? gClick, void Function()? cClick) {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        return Transform.scale(
          scale: Curves.bounceIn.transform(a1.value),
          child: uploadimage(context, gClick, cClick),
        );
      },
      transitionDuration: const Duration(seconds: 0),
    );
  }

  showTimer(BuildContext context) {
    timeFunction(3, () {
      showWalk(context);
    });
  }

  showWalk(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        return Transform.scale(
          scale: Curves.bounceOut.transform(a1.value),
          child: Walk(),
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
            scale: Curves.fastOutSlowIn.transform(a1.value),
            child: Loaderx(image));
      },
      transitionDuration: const Duration(seconds: 1),
    );
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return Loaderx(image);
    //     });
  }

  showPaymentDialog2(BuildContext context, int amount) {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        return Transform.scale(
            scale: Curves.fastOutSlowIn.transform(a1.value),
            child: SelectPay(amount));
      },
      transitionDuration: const Duration(seconds: 1),
    );
  }

  showLoader(BuildContext context, String image) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loaderx(image);
        });
  }

  onChangeNext(BuildContext context) {
    timeFunction(0, () {
      mynextTransition(
          context, true, const Duration(seconds: 2), const Onboarding());
    });
  }

  getUserStatus(BuildContext context) {
    timeFunction(5, () {
      Provider.of<LocalStorageBloc>(context, listen: false).getStatus(context);
    });
  }
}
