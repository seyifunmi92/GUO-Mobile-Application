import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/dialog/loader.dart';

import 'package:guomobile/hooks/formfields/formfields.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/hooks/text/text.dart';
import 'package:guomobile/models/od.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/reviews/successreview.dart';

import 'package:guomobile/services/logisticsbloc.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../hooks/buttons/buttons.dart';
import '../../hooks/servicehooks/hookservice.dart';

class Review extends StatefulWidget {
  Od xod;
  Review(this.xod);

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  bool noneClicked = true;
  bool firstClick = false;
  bool secondClick = false;
  bool thirdTap = false;
  bool fourthClick = false;
  bool fifthClick = false;
  bool lastClick = false;
  bool sixthClick = false;
  int _index = 0;
  TextEditingController reviewController = TextEditingController();
  @override
  void initState() {
    print(widget.xod.data.additionalFee);
    print(widget.xod.data.order.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Provider.of<LogisticsBloc>(context, listen: false).isloading,
      progressIndicator: Loaderx(ImageClass.loader),
      child: Scaffold(
        backgroundColor: guocolor.offWhite,
        appBar: guoAppBar(context, "Review Rider"),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
          child: Column(
            children: [
              sbHeight(mqHeight(context, .05)),
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage(ImageClass.anayo),
                  radius: 40,
                ),
              ),
              sbHeight(mqHeight(context, .04)),
              dText(
                  widget.xod.data.rider!.firstName +
                      " " +
                      widget.xod.data.rider!.lastName,
                  mqHeight(context, .02)),
              sbHeight(mqHeight(context, .02)),
              dText("Dispatch Rider", mqHeight(context, .017),
                  color: guocolor.black.withOpacity(.6)),
              sbHeight(mqHeight(context, .05)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  starRating(
                      context,
                      firstClick
                          ? Color(0xffFFC000)
                          : guocolor.grey.withOpacity(.5), onT: () {
                    _firstTap();
                  }),
                  starRating(
                      context,
                      secondClick
                          ? Color(0xffFFC000)
                          : guocolor.grey.withOpacity(.5), onT: () {
                    _secondTap();
                  }),
                  starRating(
                      context,
                      thirdTap
                          ? Color(0xffFFC000)
                          : guocolor.grey.withOpacity(.5), onT: () {
                    _thirdTap();
                  }),
                  starRating(
                      context,
                      fourthClick
                          ? Color(0xffFFC000)
                          : guocolor.grey.withOpacity(.5), onT: () {
                    _fourthTap();
                  }),
                  starRating(
                      context,
                      lastClick
                          ? Color(0xffFFC000)
                          : guocolor.grey.withOpacity(.5), onT: () {
                    _lastTap();
                  })
                ],
              ),
              sbHeight(mqHeight(context, .05)),
              formField1(context, "Say something about your experience",
                  mqHeight(context, .1), mqWidth(context, 1),
                  showBorder: true,
                  radius: BorderRadius.circular(10),
                  controller: reviewController),
              sbHeight(mqHeight(context, .24)),
              straightButton(
                "Submit",
                mqHeight(context, .059),
                mqWidth(context, .915),
                guocolor.primaryColor,
                8,
                fontSize: mqHeight(context, .022),
                fontColor: guocolor.white,
                onT: () {
                  setState(() {
                    Provider.of<LogisticsBloc>(context, listen: false)
                        .isloading = true;
                  });
                  _rateTrip();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _rateTrip() {
    Provider.of<LogisticsBloc>(context, listen: false)
        .rateTrip(_index, reviewController.text, widget.xod.data.order.id)
        .then((value) => xRate(value));
  }

  xRate(String xx) {
    var x = jsonDecode(xx);
    if (x["status"] == 200) {
      setState(() {
        Provider.of<LogisticsBloc>(context, listen: false).isloading = false;
        mynextScreen(context, SuccessReview());
      });
    } else {
      setState(() {
        Provider.of<LogisticsBloc>(context, listen: false).isloading = false;
        toast(x["message"]);
      });
    }
  }

  _firstTap() {
    if (noneClicked) {
      setState(() {
        noneClicked = false;
        firstClick = true;
        _index++;
        print(_index);
      });
    } else if (firstClick && !secondClick) {
      setState(() {
        firstClick = !firstClick;
        noneClicked = true;
        _index--;
        print(_index);
      });
    }
  }

  _secondTap() {
    if (firstClick && !secondClick) {
      setState(() {
        secondClick = true;
        _index++;
        print(_index);
      });
    } else if (secondClick && firstClick && !thirdTap) {
      setState(() {
        secondClick = !secondClick;
        _index--;
        print(_index);
      });
    }
  }

  _thirdTap() {
    if (secondClick && !thirdTap) {
      setState(() {
        thirdTap = true;
        _index++;
        print(_index);
      });
    } else if (secondClick && thirdTap && !fourthClick) {
      setState(() {
        thirdTap = !thirdTap;
        _index--;
        print(_index);
      });
    }
  }

  _fourthTap() {
    if (thirdTap && !fourthClick) {
      setState(() {
        fourthClick = true;
        _index++;
        print(_index);
      });
    } else if (thirdTap && fourthClick && !lastClick) {
      setState(() {
        fourthClick = !fourthClick;
        _index--;
        print(_index);
      });
    }
  }

  _lastTap() {
    if (fourthClick && !lastClick) {
      setState(() {
        lastClick = true;
        _index++;
        print(_index);
      });
    } else if (fourthClick && lastClick && !sixthClick) {
      setState(() {
        lastClick = !lastClick;
        _index--;
        print(_index);
      });
    }
  }
}
