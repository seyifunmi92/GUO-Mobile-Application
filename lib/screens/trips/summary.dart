import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/buttons/buttons.dart';
import 'package:guomobile/hooks/text/text.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/payment/payment.dart';
import 'package:intl/intl.dart';
import '../../hooks/appbars/appbar.dart';
import '../../hooks/layout/mediaqueries.dart';

class TripSummary extends StatefulWidget {
  String? price;
  int? id;
  String? depatureState;
  String? busType;
  String? destination;
  DateTime? depatureDate;
  int? passengers;
  bool? isLocalTrip;
  bool? isWestCoast;
  int? seatNumber;
  TripSummary(
      {this.price,
      this.id,
      this.depatureState,
      this.busType,
      this.destination,
      this.depatureDate,
      this.passengers,
      this.isLocalTrip,
      this.isWestCoast,
      this.seatNumber});

  @override
  State<TripSummary> createState() => _TripSummaryState();
}

class _TripSummaryState extends State<TripSummary> {
  final _format = NumberFormat("#,###,000.00");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: guocolor.offWhite,
      appBar: guoAppBar(context, "Summary", showElevation: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqHeight(context, .02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sbHeight(mqHeight(context, .04)),
            dText("Trip Type", mqHeight(context, .018),
                color: guocolor.black.withOpacity(.7)),
            sbHeight(mqHeight(context, .01)),
            dText(
                widget.isLocalTrip == true
                    ? "Local Trip"
                    : "West Coast Booking",
                mqHeight(context, .018),
                color: guocolor.black),
            sbHeight(mqHeight(context, .04)),
            dText("Seat Number", mqHeight(context, .018),
                color: guocolor.black.withOpacity(.7)),
            sbHeight(mqHeight(context, .01)),
            dText(widget.seatNumber.toString(), mqHeight(context, .018),
                color: guocolor.black),
            sbHeight(mqHeight(context, .04)),
            dText("Date", mqHeight(context, .018),
                color: guocolor.black.withOpacity(.7)),
            sbHeight(mqHeight(context, .01)),
            dText(
                DateFormat("dd MMMM yyyy hh:mm aaa")
                    .format(widget.depatureDate!),
                mqHeight(context, .018),
                color: guocolor.black),
            sbHeight(mqHeight(context, .04)),
            dText("Destination Terminal", mqHeight(context, .018),
                color: guocolor.black.withOpacity(.7)),
            sbHeight(mqHeight(context, .01)),
            dText(widget.destination!, mqHeight(context, .018),
                color: guocolor.black),
            sbHeight(mqHeight(context, .04)),
            dText("Bus Type", mqHeight(context, .018),
                color: guocolor.black.withOpacity(.7)),
            sbHeight(mqHeight(context, .01)),
            dText(widget.busType!, mqHeight(context, .018),
                color: guocolor.black),
            sbHeight(mqHeight(context, .04)),
            dText("Amount", mqHeight(context, .018),
                color: guocolor.black.withOpacity(.7)),
            sbHeight(mqHeight(context, .01)),
            dText("N ${_format.format(double.parse(widget.price!))}",
                mqHeight(context, .018),
                color: guocolor.black),
            sbHeight(mqHeight(context, .15)),
            straightButton(
                "Proceed",
                mqHeight(context, .059),
                mqWidth(context, .915),
                guocolor.primaryColor,
                fontColor: guocolor.white,
                8, onT: () {
              mynextScreen(
                  context,
                  Payment(
                    amount: double.parse(widget.price!).toInt(),
                  ));
            })
          ],
        ),
      ),
    );
  }
}
