import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/providers/sharedstorage/localstorage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../hooks/buttons/buttons.dart';
import '../../hooks/containers/container.dart';
import '../../hooks/layout/mediaqueries.dart';
import '../../hooks/text/text.dart';

class Typemodal extends StatefulWidget {
  const Typemodal({super.key});

  @override
  State<Typemodal> createState() => _TypemodalState();
}

class _TypemodalState extends State<Typemodal> {
  bool isPerishable = false;
  bool isBulky = false;
  bool isFragile = false;
  bool isHeavy = false;

  @override
  void initState() {
    getBoolP();
    getBoolBulky();
    getBoolFragile();
    getBoolHeavy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: guocolor.transparent,
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Container(
          height: mqHeight(context, .4),
          width: mqWidth(context, 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: guocolor.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
            child: Column(
              children: [
                sbHeight(mqHeight(context, .02)),
                dText("Item Type", mqHeight(context, .02),
                    color: guocolor.black, fontweight: FontWeight.w700),
                sbHeight(mqHeight(context, .05)),
                Row(
                  children: [
                    boxTick(isPerishable ? true : false, onT: () {
                      if (!isPerishable) {
                        setState(() {
                          isPerishable = true;
                          Provider.of<LocalStorageBloc>(context, listen: false)
                              .setBool("isPerishable", true);
                        });
                      } else {
                        setState(() {
                          isPerishable = false;
                          Provider.of<LocalStorageBloc>(context, listen: false)
                              .removeBool("isPerishable");
                        });
                      }
                    }),
                    sbWidth(mqWidth(context, .01)),
                    dText("Perishable", mqHeight(context, .02)),
                  ],
                ),
                sbHeight(mqHeight(context, .02)),
                Row(
                  children: [
                    boxTick(isFragile ? true : false, onT: () {
                      if (!isFragile) {
                        setState(() {
                          isFragile = true;
                          Provider.of<LocalStorageBloc>(context, listen: false)
                              .setBool("isFragile", true);
                        });
                      } else {
                        setState(() {
                          isFragile = false;
                          Provider.of<LocalStorageBloc>(context, listen: false)
                              .removeBool("isFragile");
                        });
                      }
                    }),
                    sbWidth(mqWidth(context, .01)),
                    dText("Fragile", mqHeight(context, .02)),
                  ],
                ),
                sbHeight(mqHeight(context, .02)),
                Row(
                  children: [
                    boxTick(isBulky ? true : false, onT: () {
                      if (!isBulky) {
                        setState(() {
                          isBulky = true;
                          Provider.of<LocalStorageBloc>(context, listen: false)
                              .setBool("isBulky", true);
                        });
                      } else {
                        setState(() {
                          isBulky = false;
                          Provider.of<LocalStorageBloc>(context, listen: false)
                              .removeBool("isBulky");
                        });
                      }
                    }),
                    sbWidth(mqWidth(context, .01)),
                    dText("Bulky", mqHeight(context, .02)),
                  ],
                ),
                sbHeight(mqHeight(context, .02)),
                Row(
                  children: [
                    boxTick(isHeavy ? true : false, onT: () {
                      if (!isHeavy) {
                        setState(() {
                          isHeavy = true;
                          Provider.of<LocalStorageBloc>(context, listen: false)
                              .setBool("isHeavy", true);
                        });
                      } else {
                        setState(() {
                          isHeavy = false;
                          Provider.of<LocalStorageBloc>(context, listen: false)
                              .removeBool("isHeavy");
                        });
                      }
                    }),
                    sbWidth(mqWidth(context, .01)),
                    dText("Heavy", mqHeight(context, .02)),
                  ],
                ),
                sbHeight(mqHeight(context, .04)),
                straightButton("Close", mqHeight(context, .05),
                    mqWidth(context, .1), guocolor.primaryColor, 10,
                    fontColor: guocolor.white, onT: () {
                  closeAction(context);
                }),
              ],
            ),
          ),
        ),
      )),
    );
  }

  _functionType(bool x) {
    if (!x) {
      setState(() {
        x = true;
        print(x);
      });
    } else {
      setState(() {
        x = !x;
        print("skskss");
        print(x);
      });
    }
  }

  getBoolP() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var p = _shared.getBool("isPerishable");
    setState(() {
      isPerishable = p!;
    });
  }

  getBoolBulky() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var p = _shared.getBool("isBulky");
    setState(() {
      isBulky = p!;
    });
  }

  getBoolHeavy() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var p = _shared.getBool("isHeavy");
    setState(() {
      isHeavy = p!;
    });
  }

  getBoolFragile() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var p = _shared.getBool("isFragile");
    setState(() {
      isFragile = p!;
    });
  }
}
