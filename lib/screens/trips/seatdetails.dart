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
import 'package:guomobile/screens/trips/coupon.dart';
import 'package:guomobile/screens/trips/guardian.dart';
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
import '../../models/fleetdetail.dart';
import '../../models/terminals.dart';

class SeatDetails extends StatefulWidget {
  int id;
  String price;
  String? depatureState;
  String? destination;
  DateTime? depatureDate;
  int? passengers;
  bool? isLocalTrip;
  bool? isWestCoast;
  SeatDetails(this.id, this.price,
      {this.depatureState,
      this.destination,
      this.depatureDate,
      this.passengers,
      this.isLocalTrip,
      this.isWestCoast});

  @override
  State<SeatDetails> createState() => _SeatDetailsState();
}

class _SeatDetailsState extends State<SeatDetails> {
  FleetDetails? xFleet;

  @override
  void initState() {
    Provider.of<TerminalBloc>(context, listen: false).isloading = true;

    _getCharterDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<TerminalBloc>(context, listen: false).isloading
        ? guoLoader()
        : Scaffold(
            backgroundColor: guocolor.offWhite,
            appBar: guoAppBar(context, "View Seats", showElevation: false),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: mqHeight(context, .03)),
                child: Column(children: [
                  sbHeight(mqHeight(context, .03)),
                  Center(
                      child: imageContainer(context, xFleet!.data!.imageLink!)),
                  sbHeight(mqHeight(context, .02)),
                  Container(
                    height: mqHeight(context, .6),
                    width: mqWidth(context, 1),
                    decoration: BoxDecoration(
                        color: guocolor.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(100),
                            topRight: Radius.circular(100)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurStyle: BlurStyle.outer,
                            blurRadius: 30,
                            spreadRadius: 0,
                            offset: Offset.zero,
                          ),
                        ]),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: mqHeight(context, .1),
                          left: mqWidth(context, .02),
                          right: mqWidth(context, .02),
                          bottom: mqHeight(context, .02)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                ImageClass.steering,
                                height: mqHeight(context, .04),
                              ),
                              Container(
                                width: mqWidth(context, .15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    seatContainer(context, seatNumber: 1),
                                    seatContainer(context, seatNumber: 2),
                                  ],
                                ),
                              )
                            ],
                          ),
                          sbHeight(mqHeight(context, .05)),
                          Row(
                            children: [
                              seatContainer(context, seatNumber: 3),
                              sbWidth(mqWidth(context, .02)),
                              seatContainer(context, seatNumber: 4),
                              sbWidth(mqWidth(context, .02)),
                              seatContainer(context, seatNumber: 5),
                            ],
                          ),
                          sbHeight(mqHeight(context, .05)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: mqWidth(context, .191),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    seatContainer(context, seatNumber: 6),
                                    seatContainer(context, seatNumber: 7),
                                  ],
                                ),
                              ),
                              seatContainer(context, seatNumber: 8),
                            ],
                          ),
                          sbHeight(mqHeight(context, .05)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: mqWidth(context, .191),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    seatContainer(context, seatNumber: 9),
                                    seatContainer(context, seatNumber: 10),
                                  ],
                                ),
                              ),
                              seatContainer(context, seatNumber: 11),
                            ],
                          ),
                          sbHeight(mqHeight(context, .05)),
                          Row(
                            children: [
                              seatContainer(context, seatNumber: 12),
                              sbWidth(mqWidth(context, .053)),
                              seatContainer(context, seatNumber: 13),
                              sbWidth(mqWidth(context, .053)),
                              seatContainer(context, seatNumber: 14),
                              sbWidth(mqWidth(context, .053)),
                              seatContainer(context, seatNumber: 15),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  sbHeight(mqHeight(context, .05)),
                  Row(
                    children: [
                      boxTickSeat(
                        true,
                      ),
                      sbWidth(mqWidth(context, .01)),
                      dText("Available seats", mqHeight(context, .017)),
                    ],
                  ),
                  sbHeight(mqHeight(context, .01)),
                  Row(
                    children: [
                      boxTickSeat(
                        true,
                      ),
                      sbWidth(mqWidth(context, .01)),
                      dText("Blocked seats", mqHeight(context, .017)),
                    ],
                  ),
                  sbHeight(mqHeight(context, .01)),
                  Row(
                    children: [
                      boxTickSeat(
                        true,
                      ),
                      sbWidth(mqWidth(context, .01)),
                      dText("Unavailable seats", mqHeight(context, .017)),
                    ],
                  ),
                  sbHeight(mqHeight(context, .05)),
                  straightButton(
                    "Proceed",
                    mqHeight(context, .059),
                    mqWidth(context, .915),
                    guocolor.primaryColor,
                    8,
                    fontSize: mqHeight(context, .022),
                    fontColor: guocolor.white,
                    onT: () {
                      mynextScreen(
                          context,
                          Coupon(
                            price: widget.price,
                            id: widget.id,
                            depatureState: widget.depatureState,
                            destination: widget.destination,
                            depatureDate: widget.depatureDate,
                            passengers: widget.passengers,
                            isLocalTrip: widget.isLocalTrip,
                            isWestCoast: widget.isWestCoast,
                          ));
                    },
                  ),
                  sbHeight(mqHeight(context, .01)),
                ]),
              ),
            ),
          );
  }

  _getCharterDetails() {
    Provider.of<TerminalBloc>(context, listen: false)
        .getSingleFleet(widget.id)
        .then((value) => output(value));
  }

  output(String x) {
    var xData = jsonDecode(x);
    xData["status"] == 200 ? success(xData) : fail(xData);
  }

  success(dynamic x) {
    setState(() {
      xFleet = FleetDetails.fromJson(x);
      Provider.of<TerminalBloc>(context, listen: false).isloading = false;
    });
  }

  fail(dynamic x) {
    setState(() {
      Provider.of<TerminalBloc>(context, listen: false).isloading = false;
    });
  }
}
