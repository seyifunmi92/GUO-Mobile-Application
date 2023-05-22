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

class SelectSeats extends StatefulWidget {
  String? depatureState;
  String? destination;
  DateTime? depatureDate;
  int? passengers;
  bool? isLocalTrip;
  bool? isWestCoast;
  SelectSeats(
      {this.depatureState,
      this.destination,
      this.depatureDate,
      this.passengers,
      this.isLocalTrip,
      this.isWestCoast});

  @override
  State<SelectSeats> createState() => _SelectSeatsState();
}

class _SelectSeatsState extends State<SelectSeats> {
  final _format = NumberFormat("#,###,000.00");

  List<Datumxx>? fleeetx;

  @override
  void initState() {
    Provider.of<TerminalBloc>(context, listen: false).isloading = true;
//  print(widget.price);
//     print(widget.id);
    print(widget.depatureState);
    print(widget.destination);
    print(widget.depatureDate);
    print(widget.passengers);
    print(widget.isLocalTrip);
    print(widget.isWestCoast);
    _getFleets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<TerminalBloc>(context, listen: false).isloading
        ? guoLoader()
        : Scaffold(
            backgroundColor: guocolor.offWhite,
            appBar: guoAppBar(context, "Select Seats", showElevation: false),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: mqHeight(context, .02)),
                child: Column(
                  children: [...fleeetx!.map((e) => fleetContainer(e))],
                ),
              ),
            ),
          );
  }

  _getFleets() {
    Provider.of<TerminalBloc>(context, listen: false)
        .getFleets()
        .then((value) => fleetx(value));
  }

  fleetx(String xfleet) {
    var x = jsonDecode(xfleet);
    if (x["status"] == 200) {
      List allfleeet = x["data"];
      setState(() {
        fleeetx = allfleeet.map<Datumxx>((e) => Datumxx.fromJson(e)).toList();
        Provider.of<TerminalBloc>(context, listen: false).isloading = false;
      });
    } else {
      setState(() {
        Provider.of<TerminalBloc>(context, listen: false).isloading = false;
      });
    }
  }

  Widget charterArray(Datumxx x) {
    return Padding(
      padding: EdgeInsets.only(bottom: mqHeight(context, .02)),
      child: Center(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                print("clickee");
                //  mynextScreen(context, SeatDetails(x.id!,x));
              },
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.network(
                  x.imageLink!,
                  height: mqHeight(context, .32),
                ),
              ),
            ),
            sbHeight(mqHeight(context, .01)),
            dText(x.name!, mqHeight(context, .02), color: Color(0xff180542)),
            sbHeight(mqHeight(context, .01)),
            dText("N ${_format.format(double.parse(x.price!))} per day",
                mqHeight(context, .017),
                color: guocolor.black.withOpacity(.8)),
            sbHeight(mqHeight(context, .01)),
            dText(x.negotiable == true ? "Negotiable" : "Not Negotiable",
                mqHeight(context, .018),
                color: Color(0xff14A15D)),
          ],
        ),
      ),
    );
  }
  //container to show all fleets

  Widget fleetContainer(Datumxx x) {
    return Padding(
      padding: EdgeInsets.only(
          top: mqHeight(context, .02), bottom: mqHeight(context, .01)),
      child: InkWell(
        onTap: () {
          print("clickee");
          mynextScreen(
              context,
              SeatDetails(
                x.id!,
                x.price!,
                depatureState: widget.depatureState,
                destination: widget.destination,
                depatureDate: widget.depatureDate,
                passengers: widget.passengers,
                isLocalTrip: widget.isLocalTrip,
                isWestCoast: widget.isWestCoast,
              ));
        },
        child: Container(
          height: mqHeight(context, .3),
          width: mqWidth(context, 1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: guocolor.white,
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
                top: mqHeight(context, .02),
                bottom: mqHeight(context, .02),
                left: mqWidth(context, .04),
                right: mqWidth(context, .04)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        sbHeight(mqHeight(context, .07)),
                        Container(
                            height: mqHeight(context, .12),
                            width: mqWidth(context, .15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: guocolor.black,
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            x.imageLink!,
                                          ),
                                          fit: BoxFit.cover)),
                                ),
                              ],
                            )),
                        sbHeight(mqHeight(context, .02)),
                        dText(x.name!, mqHeight(context, .02),
                            color: Color(0xff053984)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        dText(
                            "Bus fare: N ${_format.format(double.parse(x.price!))}",
                            mqHeight(context, .015)),
                        sbHeight(mqHeight(context, .02)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.access_time,
                              color: guocolor.grey,
                              size: mqHeight(context, .025),
                            ),
                            dText(DateFormat(" hh:mm aaa").format(x.createdAt!),
                                mqHeight(context, .015)),
                          ],
                        ),
                        sbHeight(mqHeight(context, .02)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.accessible_rounded,
                              color: guocolor.grey,
                            ),
                            dText(x.description!, mqHeight(context, .012)),
                          ],
                        ),
                        sbHeight(mqHeight(context, .02)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            tickCircle(!x.airConditioned! ? false : true),
                            sbWidth(mqWidth(context, .02)),
                            dText("A/C", mqHeight(context, .013)),
                          ],
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
