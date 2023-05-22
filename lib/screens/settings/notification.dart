import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/providers/sharedstorage/localstorage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../hooks/appbars/appbar.dart';
import '../../hooks/text/text.dart';

class Not extends StatefulWidget {
  const Not({super.key});

  @override
  State<Not> createState() => _NotState();
}

class _NotState extends State<Not> {
  int toggleIndex = 0;
  int toggleIndex2 = 0;
  bool pushnotificationStatus = false;
  bool emailnotificationStatus = false;
  bool toggletrue = false;
  @override
  void initState() {
    getemailStatus();
    getpushStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    emailnotificationStatus == true ? toggleIndex = 1 : 0;
    pushnotificationStatus == true ? toggleIndex2 = 1 : 0;
    return Scaffold(
      backgroundColor: guocolor.offWhite,
      appBar: guoAppBar(context, "Notifications", showElevation: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Column(
          children: [
            sbHeight(mqHeight(context, .04)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dText("Email Notifications", mqHeight(context, .021),
                    color: guocolor.black.withOpacity(.7)),
                ToggleSwitch(
                  minHeight: mqHeight(context, .0153),
                  minWidth: mqWidth(context, .0154),
                  cornerRadius: 15.0,
                  activeBgColors: [
                    [Colors.white],
                    [guocolor.primaryColor]
                  ],
                  inactiveBgColor: toggleIndex == 1
                      ? guocolor.grey.withOpacity(.2)
                      : guocolor.grey.withOpacity(.2),
                  initialLabelIndex: emailnotificationStatus == true ? 1 : 0,
                  totalSwitches: 2,
                  radiusStyle: true,
                  onToggle: (index) {
                    toggleIndex = index!;
                    if (toggleIndex != 0) {
                      toggletrue = true;
                    } else {
                      toggletrue = false;
                    }
                    print(toggletrue);

                    toggleIndex != 0
                        ? toast("Email Notifications Activated")
                        : toast("Email Notifications Deactivated");
                    Provider.of<LocalStorageBloc>(context, listen: false)
                        .emailNotificationSettings(
                            toggleIndex != 0 ? true : false);
                  },
                  changeOnTap: true,
                ),
              ],
            ),
            sbHeight(mqHeight(context, .04)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dText("Push Notifications", mqHeight(context, .021),
                    color: guocolor.black.withOpacity(.7)),
                ToggleSwitch(
                  minHeight: mqHeight(context, .0153),
                  minWidth: mqWidth(context, .0154),
                  cornerRadius: 15.0,
                  activeBgColors: [
                    [Colors.white],
                    [guocolor.primaryColor]
                  ],
                  activeFgColor: guocolor.primaryColor,
                  inactiveBgColor: toggleIndex2 != 0
                      ? guocolor.grey.withOpacity(.2)
                      : guocolor.grey.withOpacity(.2),
                  inactiveFgColor: guocolor.primaryColor,
                  initialLabelIndex: pushnotificationStatus == true ? 1 : 0,
                  totalSwitches: 2,
                  radiusStyle: true,
                  onToggle: (index) {
                    toggleIndex2 = index!;
                    toggleIndex2 != 0
                        ? toast("Push Notifications Activated")
                        : toast("Push Notifications Deactivated");
                    print('switched to: $index');

                    Provider.of<LocalStorageBloc>(context, listen: false)
                        .pushNotificationSettings(
                            toggleIndex2 != 0 ? true : false);
                  },
                  changeOnTap: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  getpushStatus() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var x = _shared.getBool("pushNotifications");
    setState(() {
      pushnotificationStatus = x!;
    });
    print(pushnotificationStatus);
  }

  getemailStatus() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var x = _shared.getBool("emailNotifications");
    setState(() {
      emailnotificationStatus = x!;
    });
    print(emailnotificationStatus);
  }
}
