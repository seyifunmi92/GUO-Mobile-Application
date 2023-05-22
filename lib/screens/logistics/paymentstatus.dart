import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/orders/orderhistory.dart';

import '../../asset/imageclass.dart';
import '../../hooks/appbars/appbar.dart';
import '../../hooks/buttons/buttons.dart';
import '../../hooks/text/text.dart';
import '../home/home.dart';

class PaymentStatus extends StatefulWidget {
  bool? lowBalance;
  PaymentStatus({this.lowBalance});

  @override
  State<PaymentStatus> createState() => _PaymentStatusState();
}

class _PaymentStatusState extends State<PaymentStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: guoAppBar(context, "title",showBack: true),

      backgroundColor: guocolor.white,
      body: Column(children: [
        sbHeight(mqHeight(context, .25)),
        Center(
          child: Image.asset(
            widget.lowBalance == true ? ImageClass.error : ImageClass.success,
            height: mqHeight(context, .25),
          ),
        ),
        sbHeight(mqHeight(context, .005)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            dText(
                widget.lowBalance == true
                    ? "Insufficient Balance"
                    : "Order Placed\n Successfully",
                mqHeight(context, .04),
                fontweight: FontWeight.w700),
          ],
        ),
        widget.lowBalance == true
            ? sbHeight(mqHeight(context, .32))
            : sbHeight(mqHeight(context, .28)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
          child: straightButton(
            "See History",
            mqHeight(context, .059),
            mqWidth(context, .915),
            guocolor.primaryColor,
            8,
            fontSize: mqHeight(context, .022),
            fontColor: guocolor.white,
            onT: () {
              mynextScreen(context, OrderHistory());
            },
          ),
        ),
      ]),
    );
  }
}
