import 'dart:convert';
import 'dart:math';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/containers/container.dart';
import 'package:guomobile/hooks/dialog/loader.dart';
import 'package:guomobile/hooks/dialog/showmessage.dart';
import 'package:guomobile/hooks/servicehooks/hookservice.dart';
import 'package:guomobile/models/states.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/providers/callfunctions/providerbloc.dart';
import 'package:guomobile/screens/trips/guardian.dart';
import 'package:guomobile/screens/trips/selectseats.dart';
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

class TripBooking extends StatefulWidget {
  const TripBooking({super.key});

  @override
  State<TripBooking> createState() => _TripBookingState();
}

class _TripBookingState extends State<TripBooking> {
  DateTime selectedDeliveryDate = DateTime.now();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController stateC = TextEditingController();
  TextEditingController destinationC = TextEditingController();
  TextEditingController passengerC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  int clickindex = 0;
  bool isLocalTrip = false;
  bool isWestCoast = false;
  bool isdeparturTerminal = false;
  bool istc = false;
  int stateid = 0;
  bool isSelectDate = false;
  List<Datumx>? xStates;
  List<Datum>? xterminal;
  List<Datumxx>? fleeetx;
  bool oneClicked = false;

  @override
  void initState() {
    _getStates();
    _getTerminal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: guoTripDrawer(context, onT: _nav),
      key: _scaffoldKey,
      backgroundColor: guocolor.offWhite,
      appBar: guoAppBar(context, "Book A Trip", showElevation: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqHeight(context, .02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sbHeight(mqHeight(context, .04)),
            dText("Departure State", mqHeight(context, .017)),
            sbHeight(mqHeight(context, .015)),
            guoFormField(context, mqHeight(context, .05), mqWidth(context, .5),
                containercolor: guocolor.white,
                showBorder: false,
                showRadius: true,
                radiusborder: true, onT: () {
              _getStateList();
            },
                isnext: true,
                title: "Enter Address",
                isReadonly: true,
                controller: stateC),
            sbHeight(mqHeight(context, .03)),
            dText("Destination", mqHeight(context, .017)),
            sbHeight(mqHeight(context, .015)),
            guoFormField(context, mqHeight(context, .05), mqWidth(context, .5),
                containercolor: guocolor.white,
                showBorder: false,
                showRadius: true,
                radiusborder: true, onT: () {
              _getTerminalList();
            },
                isnext: true,
                title: "Enter Destination",
                isReadonly: true,
                controller: destinationC),
            sbHeight(mqHeight(context, .03)),
            dText("Departure Date", mqHeight(context, .017)),
            sbHeight(mqHeight(context, .015)),
            guoFormField(context, mqHeight(context, .05), mqWidth(context, .5),
                containercolor: guocolor.white,
                showBorder: false,
                showRadius: true,
                radiusborder: true, onT: () {
              _selectDepatureDate(context);
            },
                isnext: true,
                title: "DD/MM/YY",
                isReadonly: true,
                controller: dateC),
            sbHeight(mqHeight(context, .03)),
            dText("Passengers", mqHeight(context, .017)),
            sbHeight(mqHeight(context, .015)),
            guoFormField(context, mqHeight(context, .05), mqWidth(context, .5),
                containercolor: guocolor.white,
                showBorder: false,
                showRadius: true,
                radiusborder: true,
                isInt: true,
                onT: () {},
                isnext: true,
                title: "Select No",
                isReadonly: false,
                controller: passengerC),
            sbHeight(mqHeight(context, .03)),
            Row(
              children: [
                tickCircle(isLocalTrip ? true : false, onT: () {
                  _circleTapTrip();
                }),
                sbWidth(mqWidth(context, .01)),
                dText("Local Trip", mqHeight(context, .015),
                    color: guocolor.primaryColor),
                sbWidth(mqWidth(context, .01)),
                tickCircle(isWestCoast ? true : false, onT: () {
                  _circleTapWest();
                }),
                sbWidth(mqWidth(context, .01)),
                dText("West Coast Booking", mqHeight(context, .015),
                    color: guocolor.primaryColor),
              ],
            ),
            sbHeight(mqHeight(context, .04)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                boxTick(isdeparturTerminal ? true : false, onT: () {
                  _boxdeparture();
                }),
                Container(
                  width: mqWidth(context, .38),
                  child: dText(
                      "You must be at the departure terminal at least 30 minutes before the bus departure time, else you lose your right to your selected seat(s)",
                      mqHeight(context, .016),
                      color: Color(0xff8C8C95)),
                ),
              ],
            ),
            sbHeight(mqHeight(context, .04)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                boxTick(istc ? true : false, onT: () {
                  _boxtandc();
                }),
                Container(
                  width: mqWidth(context, .38),
                  child: dText(
                      "Agree to terms and conditions", mqHeight(context, .016),
                      color: Color(0xff8C8C95)),
                ),
              ],
            ),
            sbHeight(mqHeight(context, .04)),
            straightButton(
              "Search Availability",
              mqHeight(context, .059),
              mqWidth(context, .915),
              guocolor.primaryColor,
              8,
              fontSize: mqHeight(context, .022),
              fontColor: guocolor.white,
              onT: () {
                setState(() {
                  clickindex++;
                });

                clickindex != 1 && clickindex.isEven ? _nav() : _showDrawer();
              },
            ),
          ],
        ),
      ),
    );
  }

  _nav() {
    if (!stateC.text.isEmpty &&
        !destinationC.text.isEmpty &&
        isSelectDate &&
        !passengerC.text.isEmpty &&
        oneClicked &&
        isdeparturTerminal &&
        istc) {
      mynextScreen(
          context,
          SelectSeats(
            depatureState: stateC.text,
            destination: destinationC.text,
            depatureDate: selectedDeliveryDate,
            passengers: int.parse(passengerC.text),
            isLocalTrip: isLocalTrip ? true : false,
            isWestCoast: isWestCoast ? true : false,
          ));
    } else if (!stateC.text.isEmpty &&
        !destinationC.text.isEmpty &&
        isSelectDate &&
        !passengerC.text.isEmpty &&
        oneClicked &&
        isdeparturTerminal &&
        !istc) {
      gToast("Please accept terms and conditions to proceed");
    } else {
      gToast("Please fill all details to proceed");
    }
  }

  _showDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  _circleTapTrip() {
    setState(() {
      if (isLocalTrip) {
        setState(() {
          isLocalTrip = false;
        });
      } else {
        setState(() {
          isLocalTrip = true;
          isWestCoast = false;
          oneClicked = true;
        });
      }
    });
  }

  _boxdeparture() {
    setState(() {
      if (isdeparturTerminal) {
        setState(() {
          isdeparturTerminal = false;
        });
      } else {
        setState(() {
          isdeparturTerminal = true;
        });
      }
    });
  }

  _boxtandc() {
    setState(() {
      if (istc) {
        setState(() {
          istc = false;
        });
      } else {
        setState(() {
          istc = true;
        });
      }
    });
  }

  _circleTapWest() {
    setState(() {
      if (isWestCoast) {
        setState(() {
          isWestCoast = false;
        });
      } else {
        setState(() {
          isWestCoast = true;
          isLocalTrip = false;
          oneClicked = true;
        });
      }
    });
  }

  Widget _stateList(Datumx xstates) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .04)),
      child: Column(
        children: [
          sbHeight(mqHeight(context, .015)),
          InkWell(
              onTap: () {
                setState(() {
                  stateC.text = xstates.name;
                  stateid = xstates.id;
                  closeAction(context);
                });
              },
              child: dText(xstates.name, mqHeight(context, .015))),
          sbHeight(mqHeight(context, .015)),
          DottedLine(
            dashColor: guocolor.black.withOpacity(.1),
          ),
        ],
      ),
    );
  }

  _getTerminalList() {
    Provider.of<ProviderBloc>(context, listen: false).showTrips(context,
        list: Column(
          children: [...xterminal!.map((e) => _allT(e))],
        ),
        header: "Select Destination");
  }

  Widget _allT(Datum xt) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .04)),
      child: Column(
        children: [
          sbHeight(mqHeight(context, .015)),
          InkWell(
              onTap: () {
                setState(() {
                  destinationC.text = xt.address;
                  closeAction(context);
                });
              },
              child: dText(
                  xt.address + "," + xt.terminal, mqHeight(context, .015))),
          sbHeight(mqHeight(context, .015)),
          DottedLine(
            dashColor: guocolor.black.withOpacity(.1),
          ),
        ],
      ),
    );
  }

  _getStateList() {
    print("statex");
    Provider.of<ProviderBloc>(context, listen: false).showTrips(context,
        list: Column(
          children: [...xStates!.map((e) => _stateList(e))],
        ),
        header: "Select Depature State");
  }

  _getStates() {
    Provider.of<TerminalBloc>(context, listen: false)
        .getStates()
        .then((value) => statesx(value));
  }

  statesx(String xData) {
    var x = jsonDecode(xData);
    if (x["status"] == 200) {
      List allStates = x["data"];
      setState(() {
        xStates = allStates.map<Datumx>((e) => Datumx.fromJson(e)).toList();
      });
      print("seeeeege");
    } else {}
  }

  _getTerminal() {
    Provider.of<TerminalBloc>(context, listen: false)
        .getTerminalsNearme()
        .then((value) => terminalsx(value));
  }

  terminalsx(String x) {
    var xx = jsonDecode(x);
    if (xx["status"] == 200) {
      List allTerminals = xx["data"];
      setState(() {
        xterminal = allTerminals.map<Datum>((e) => Datum.fromJson(e)).toList();
      });
    } else {}
  }

  _selectDepatureDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDeliveryDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );
    if (selected != null)
      setState(() {
        isSelectDate = true;
        selectedDeliveryDate = selected;
        dateC.text = DateFormat("MMMM dd, yyyy").format(selected);
      });
  }
}
