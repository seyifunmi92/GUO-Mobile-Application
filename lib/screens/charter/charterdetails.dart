import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/servicehooks/hookservice.dart';
import 'package:guomobile/models/fleetdetail.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/charter/negotiateprice.dart';
import 'package:guomobile/services/terminalbloc.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../hooks/appbars/appbar.dart';
import '../../hooks/buttons/buttons.dart';
import '../../hooks/layout/mediaqueries.dart';
import '../../hooks/text/text.dart';

class CharterDetails extends StatefulWidget {
  int id;
  CharterDetails(this.id);

  @override
  State<CharterDetails> createState() => _CharterDetailsState();
}

class _CharterDetailsState extends State<CharterDetails> {
  final _format = NumberFormat("#,###,000.00");

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
            appBar: guoAppBar(
              context,
              "Book Charter",
              showElevation: false,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: mqHeight(context, .02)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sbHeight(mqHeight(context, .02)),
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Image.network(
                      xFleet!.data!.imageLink!,
                      height: mqHeight(context, .32),
                    ),
                  ),
                  sbHeight(mqHeight(context, .02)),
                  dText("Car Name", mqHeight(context, .018)),
                  sbHeight(mqHeight(context, .01)),
                  dText(xFleet!.data!.name!, mqHeight(context, .019),
                      fontweight: FontWeight.w800),
                  sbHeight(mqHeight(context, .03)),
                  dText("Description", mqHeight(context, .018),
                      color: guocolor.primaryColor),
                  sbHeight(mqHeight(context, .03)),
                  dText(xFleet!.data!.description!, mqHeight(context, .017),
                      color: guocolor.black.withOpacity(.8)),
                  sbHeight(mqHeight(context, .03)),
                  dText("Charter Fee", mqHeight(context, .017),
                      color: guocolor.black.withOpacity(.8)),
                  sbHeight(mqHeight(context, .01)),
                  dText(
                      "N ${_format.format(xFleet!.data!.price.toDouble())} per day",
                      mqHeight(context, .017),
                      color: guocolor.black.withOpacity(.8),
                      fontweight: FontWeight.w700),
                  sbHeight(mqHeight(context, .15)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      straightButton("Negotiate Price", mqHeight(context, .05),
                          mqWidth(context, .2), guocolor.primaryColor, 10,
                          fontSize: mqHeight(context, .017),
                          fontColor: guocolor.white, onT: () {
                        mynextScreen(
                            context,
                            BookCharter(
                              xFleet!.data!.id!,
                              fee: xFleet!.data!.price.toDouble().toInt(),
                            ));
                      }),
                      straightButton("Make Request", mqHeight(context, .05),
                          mqWidth(context, .2), guocolor.white, 10,
                          fontSize: mqHeight(context, .017),
                          fontColor: guocolor.primaryColor,
                          showBorder: true),
                    ],
                  )
                ],
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

//   {
//     "vehicleId": 1,
//     "startDate": "2022-11-26",
//     "endDate": "2022-12-05",
//     "passengers": 1,
//     "firstName": "Stephen",
//     "lastName": "Kubes",
//     "email": "samplemail@gmail.com",
//     "message": "I need this particular vehicle for some days"
// }
}
