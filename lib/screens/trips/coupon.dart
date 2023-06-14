import 'dart:convert';
import 'dart:math';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/containers/container.dart';
import 'package:guomobile/hooks/dialog/loader.dart';
import 'package:guomobile/hooks/servicehooks/hookservice.dart';
import 'package:guomobile/models/states.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/providers/callfunctions/providerbloc.dart';
import 'package:guomobile/screens/trips/guardian.dart';
import 'package:guomobile/screens/trips/seatdetails.dart';
import 'package:guomobile/screens/trips/summary.dart';
import 'package:guomobile/services/accountbloc.dart';
import 'package:guomobile/services/terminalbloc.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../hooks/appbars/appbar.dart';
import '../../hooks/buttons/buttons.dart';
import '../../hooks/formfields/formfields.dart';
import '../../hooks/layout/mediaqueries.dart';
import '../../hooks/text/text.dart';
import '../../models/cars.dart';
import '../../models/terminals.dart';

class Coupon extends StatefulWidget {
  String? price;
  int? id;
  String? depatureState;
  String? depatureT;
  String? destination;
  DateTime? depatureDate;
  int? passengers;
  bool? isLocalTrip;
  bool? isWestCoast;
  int? seatNumber;
  Coupon(
      {this.price,
      this.id,
      this.depatureState,
      this.depatureT,
      this.destination,
      this.depatureDate,
      this.passengers,
      this.isLocalTrip,
      this.isWestCoast,
      this.seatNumber});

  @override
  State<Coupon> createState() => _CouponState();
}

class _CouponState extends State<Coupon> {
  final _format = NumberFormat("#,###,000.00");

  @override
  void initState() {
    print(widget.price);
    print(widget.id);
    print(widget.depatureState);
    print(widget.destination);
    print(widget.depatureDate);
    print(widget.passengers);
    print(widget.isLocalTrip);
    print(widget.isWestCoast);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: guocolor.offWhite,
      appBar: guoAppBar(context, "Coupon Code", showElevation: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqHeight(context, .02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sbHeight(mqHeight(context, .02)),
            dText("Price", mqHeight(context, .018), color: Color(0xff8C8C95)),
            sbHeight(mqHeight(context, .01)),
            dText("N${_format.format(widget.price.toDouble())}",
                mqHeight(context, .02),
                fontweight: FontWeight.w700),
            sbHeight(mqHeight(context, .02)),
            dText("Discount X: 5%", mqHeight(context, .018),
                color: Color(0xff8C8C95)),
            sbHeight(mqHeight(context, .02)),
            dText("To Pay", mqHeight(context, .018), color: Color(0xff8C8C95)),
            sbHeight(mqHeight(context, .01)),
            dText("N${_format.format(widget.price.toDouble())}",
                mqHeight(context, .02),
                fontweight: FontWeight.w700),
            sbHeight(mqHeight(context, .04)),
            dText("Coupon Code", mqHeight(context, .018),
                color: Color(0xff8C8C95)),
            sbHeight(mqHeight(context, .02)),
            guoFormField(
              context,
              mqHeight(context, .05),
              mqWidth(context, .5),
              containercolor: guocolor.white,
              showBorder: false,
              showRadius: true,
              radiusborder: true,
              onT: () {},
              isnext: true,
              title: "Enter Coupon",
              // controller: gemailc,
            ),
            sbHeight(mqHeight(context, .05)),
            straightButton(
              "Apply",
              mqHeight(context, .059),
              mqWidth(context, .915),
              guocolor.primaryColor,
              8,
              fontSize: mqHeight(context, .022),
              fontColor: guocolor.white,
              onT: () {
                mynextScreen(
                    context,
                    TripSummary(
                      price: widget.price,
                      id: widget.id,
                      busType: widget.depatureT,
                      depatureState: widget.depatureState,
                      destination: widget.destination,
                      depatureDate: widget.depatureDate,
                      passengers: widget.passengers,
                      isLocalTrip: widget.isLocalTrip,
                      isWestCoast: widget.isWestCoast,
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
