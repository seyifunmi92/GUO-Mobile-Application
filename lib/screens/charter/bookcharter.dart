import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';

import 'package:guomobile/hooks/servicehooks/hookservice.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/charter/charterdetails.dart';

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

class BookCharter extends StatefulWidget {
  const BookCharter({super.key});

  @override
  State<BookCharter> createState() => _BookCharterState();
}

class _BookCharterState extends State<BookCharter> {
  final _format = NumberFormat("#,###,000.00");

  List<Datumxx>? fleeetx;

  bool isSelelcted = false;

  @override
  void initState() {
    Provider.of<TerminalBloc>(context, listen: false).isloading = true;
    _getFleets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<TerminalBloc>(context, listen: false).isloading
        ? guoLoader()
        : Scaffold(
            backgroundColor: guocolor.offWhite,
            appBar: guoAppBar(context, "Book Charter", showElevation: false),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: mqHeight(context, .02)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sbHeight(mqHeight(context, .03)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        guoFormField(context, mqHeight(context, .05),
                            mqWidth(context, .33),
                            containercolor: guocolor.white,
                            showBorder: false,
                            showRadius: true,
                            radiusborder: true, onT: () {
                          //  _getTripType();
                        },
                            isnext: true,
                            title: "Search by",
                            //  controller: triptypeC,
                            isReadonly: true),
                        straightButton("Search", mqHeight(context, .05),
                            mqWidth(context, .07), guocolor.primaryColor, 10,
                            fontSize: mqHeight(context, .01),
                            fontColor: guocolor.white),
                      ],
                    ),
                    sbHeight(mqHeight(context, .03)),
                    dText("All Charter Buses", mqHeight(context, .018)),
                    sbHeight(mqHeight(context, .03)),
                    ...fleeetx!.map((e) => charterArray(e))
                  ],
                ),
              ),
            ),
          );
  }

  Widget charterArray(Datumxx x) {
    return Padding(
      padding: EdgeInsets.only(bottom: mqHeight(context, .02)),
      child: Center(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                mynextScreen(context, CharterDetails(x.id!));
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
            dText("N ${_format.format(x.price.toDouble())} per day",
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
}
