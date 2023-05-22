import 'dart:convert';
import 'dart:math';
import 'package:dotted_line/dotted_line.dart';
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

class ChildTrip extends StatefulWidget {
  const ChildTrip({super.key});

  @override
  State<ChildTrip> createState() => _ChildTripState();
}

class _ChildTripState extends State<ChildTrip> {
  final formkey = GlobalKey();
  DateTime selectedDeliveryDate = DateTime.now();
  bool isSelectDate = false;
  String finalDate = "";
  bool isT = false;
  int? stateid;
  int? destId;
  int? terminalid;
  int? vehicleid;
  int? amount = 0;
  List<Datumx>? xStates;
  List<Datum>? xterminal;
  List<Datumxx>? fleeetx;
  TextEditingController triptypeC = TextEditingController();
  TextEditingController bookingC = TextEditingController();
  TextEditingController stateC = TextEditingController();
  TextEditingController destinationC = TextEditingController();
  TextEditingController terminalC = TextEditingController();
  TextEditingController departureC = TextEditingController();
  TextEditingController carC = TextEditingController();
  final _format = NumberFormat("#,###,000.00");

  @override
  void initState() {
    _getStates();
    _getTerminal();
    _getFleets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: guocolor.offWhite,
      appBar: guoAppBar(context, "Minor Booking"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqHeight(context, .02)),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sbHeight(mqHeight(context, .02)),
              pageTitle(context, "Book a trip as a minor"),
              sbHeight(mqHeight(context, .03)),
              dText("Choose Trip Type", mqHeight(context, .017)),
              sbHeight(mqHeight(context, .01)),
              guoFormField(
                  context, mqHeight(context, .05), mqWidth(context, .5),
                  containercolor: guocolor.white,
                  showBorder: false,
                  showRadius: true,
                  radiusborder: true,
                  onT: () {
                    _getTripType();
                  },
                  isnext: true,
                  title: "Select trip",
                  controller: triptypeC,
                  isReadonly: true,
                  validator: (x) {
                    if (x.isEmpty) {
                      print("emojsks");
                      return "Noooo";
                    }
                  }),
              sbHeight(mqHeight(context, .02)),
              dText("Choose Booking Type", mqHeight(context, .017)),
              sbHeight(mqHeight(context, .01)),
              guoFormField(
                context,
                mqHeight(context, .05),
                mqWidth(context, .5),
                containercolor: guocolor.white,
                showBorder: false,
                showRadius: true,
                radiusborder: true,
                onT: () {
                  _getBookType();
                },
                isnext: true,
                title: "Select type",
                controller: bookingC,
                isReadonly: true,
              ),
              sbHeight(mqHeight(context, .02)),
              dText("Depature State", mqHeight(context, .017)),
              sbHeight(mqHeight(context, .01)),
              guoFormField(
                context,
                mqHeight(context, .05),
                mqWidth(context, .5),
                containercolor: guocolor.white,
                showBorder: false,
                showRadius: true,
                radiusborder: true,
                onT: () {
                  _getStateList();
                },
                isnext: true,
                title: "Select state",
                controller: stateC,
                isReadonly: true,
              ),
              sbHeight(mqHeight(context, .02)),
              dText("Destination", mqHeight(context, .017)),
              sbHeight(mqHeight(context, .01)),
              guoFormField(
                  context, mqHeight(context, .05), mqWidth(context, .5),
                  containercolor: guocolor.white,
                  showBorder: false,
                  showRadius: true,
                  radiusborder: true, onT: () {
                setState(() {
                  isT = false;
                });
                _getTerminalList();
              },
                  isnext: true,
                  title: "Select destination",
                  controller: destinationC,
                  isReadonly: true),
              sbHeight(mqHeight(context, .02)),
              dText("Terminal", mqHeight(context, .017)),
              sbHeight(mqHeight(context, .01)),
              guoFormField(
                context,
                mqHeight(context, .05),
                mqWidth(context, .5),
                containercolor: guocolor.white,
                showBorder: false,
                showRadius: true,
                radiusborder: true,
                onT: () {
                  setState(() {
                    isT = true;
                  });
                  _getTerminalList();
                },
                isnext: true,
                title: "Select",
                controller: terminalC,
                isReadonly: true,
              ),
              //   sbHeight(mqHeight(context, .02)),
              // dText("Category", mqHeight(context, .017)),
              // sbHeight(mqHeight(context, .01)),
              // guoFormField(
              //   context,
              //   mqHeight(context, .05),
              //   mqWidth(context, .5),
              //   containercolor: guocolor.white,
              //   showBorder: false,
              //   showRadius: true,
              //   radiusborder: true,
              //   onT: () {},
              //   isnext: true,
              //   title: "Select",
              //   //  controller: cityc,
              // ),
              // sbHeight(mqHeight(context, .02)),
              // dText("No of Adults", mqHeight(context, .017)),
              // sbHeight(mqHeight(context, .01)),
              // guoFormField(
              //   context,
              //   mqHeight(context, .05),
              //   mqWidth(context, .5),
              //   containercolor: guocolor.white,
              //   showBorder: false,
              //   showRadius: true,
              //   radiusborder: true,
              //   onT: () {},
              //   isnext: true,
              //   title: "Enter",
              //   //  controller: cityc,
              // ),
              sbHeight(mqHeight(context, .02)),
              dText("Departure Date", mqHeight(context, .017)),
              sbHeight(mqHeight(context, .01)),
              guoFormField(
                context,
                mqHeight(context, .05),
                mqWidth(context, .5),
                containercolor: guocolor.white,
                showBorder: false,
                showRadius: true,
                radiusborder: true,
                onT: () {
                  _selectDepatureDate(context);
                },
                isnext: true,
                title: "DD/MM/YYYY",
                isReadonly: true,
                controller: departureC,
              ),
              sbHeight(mqHeight(context, .02)),
              dText("Select Car Type", mqHeight(context, .017)),
              sbHeight(mqHeight(context, .01)),
              guoFormField(
                context,
                mqHeight(context, .05),
                mqWidth(context, .5),
                containercolor: guocolor.white,
                showBorder: false,
                showRadius: true,
                radiusborder: true,
                onT: () {
                  _getCars();
                },
                isnext: true,
                title: "Select car",
                controller: carC,
                isReadonly: true,
              ),
              // sbHeight(mqHeight(context, .03)),
              // Row(
              //   children: [
              //     tickCircle(true),
              //     sbWidth(mqWidth(context, .01)),
              //     dText("Round Trip", mqHeight(context, .015),
              //         color: guocolor.primaryColor),
              //     sbWidth(mqWidth(context, .01)),
              //     tickCircle(false),
              //     sbWidth(mqWidth(context, .01)),
              //     dText("One way Trip", mqHeight(context, .015),
              //         color: guocolor.primaryColor),
              //   ],
              // ),
              // sbHeight(mqHeight(context, .02)),
              // Row(
              //   children: [
              //     tickCircle(true),
              //     sbWidth(mqWidth(context, .01)),
              //     dText("Local Trip", mqHeight(context, .015),
              //         color: guocolor.primaryColor),
              //     sbWidth(mqWidth(context, .02)),
              //     tickCircle(false),
              //     sbWidth(mqWidth(context, .01)),
              //     dText("West Coast Booking", mqHeight(context, .015),
              //         color: guocolor.primaryColor),
              //   ],
              // ),
              sbHeight(mqHeight(context, .05)),
              straightButton(
                "Proceed",
                mqHeight(context, .059),
                mqWidth(context, .915),
                guocolor.primaryColor,
                8,
                fontSize: mqHeight(context, .02),
                fontColor: guocolor.white,
                onT: () {
                  _check();
                },
              ),
              sbHeight(mqHeight(context, .03)),
            ],
          ),
        ),
      ),
    );
  }

  _check() {
    if (triptypeC.text.isEmpty) {
      _errorToast();
    } else if (bookingC.text.isEmpty) {
      _errorToast();
    } else if (stateC.text.isEmpty) {
      _errorToast();
    } else if (destinationC.text.isEmpty) {
      _errorToast();
    } else if (terminalC.text.isEmpty) {
      _errorToast();
    } else if (departureC.text.isEmpty) {
      _errorToast();
    } else if (carC.text.isEmpty) {
      _errorToast();
    } else {
      print(triptypeC.text);
      _moveData();
    }
  }

  _errorToast() {
    toast("Please enter all fields to proceed");
  }

  _moveData() {
    mynextScreen(
        context,
        Guardian(
          vehicleId: vehicleid,
          departureStateId: stateid,
          terminalId: terminalid,
          destinationId: destId,
          isRoundTrip: triptypeC.text == "Round Trip" ? true : false,
          bookingType: bookingC.text,
          departureDate: selectedDeliveryDate,
          amount: amount,
        ));
  }

  _getCars() {
    Provider.of<ProviderBloc>(context, listen: false).showTrips(context,
        list: Column(
          children: [...fleeetx!.map((e) => fleetData(e))],
        ),
        header: "Select Car Type");
  }

  _getTripType() {
    Provider.of<ProviderBloc>(context, listen: false).showTrips(context,
        list: Column(
          children: [...trips.map((e) => _tripData(e))],
        ),
        header: "Select Trip Type");
  }

  _getBookType() {
    Provider.of<ProviderBloc>(context, listen: false).showTrips(context,
        list: Column(
          children: [...bookings.map((e) => _bookData(e))],
        ),
        header: "Select Booking Type");
  }

  _getStateList() {
    Provider.of<ProviderBloc>(context, listen: false).showTrips(context,
        list: Column(
          children: [...xStates!.map((e) => _stateList(e))],
        ),
        header: "Select Depature State");
  }

  _getTerminalList() {
    Provider.of<ProviderBloc>(context, listen: false).showTrips(context,
        list: Column(
          children: [...xterminal!.map((e) => _allT(e))],
        ),
        header: "Select Terminal");
  }

  _getStates() {
    Provider.of<TerminalBloc>(context, listen: false)
        .getStates()
        .then((value) => statesx(value));
  }

  _getTerminal() {
    Provider.of<TerminalBloc>(context, listen: false)
        .getTerminalsNearme()
        .then((value) => terminalsx(value));
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
      });
    } else {}
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

  statesx(String xData) {
    var x = jsonDecode(xData);
    if (x["status"] == 200) {
      List allStates = x["data"];
      setState(() {
        xStates = allStates.map<Datumx>((e) => Datumx.fromJson(e)).toList();
      });
    } else {}
  }

  List trips = [MyTrips("One way"), MyTrips("Round Trip")];
  List bookings = [Bookings("Local"), Bookings("International")];

  Widget _tripData(MyTrips xtrips) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .04)),
      child: Column(
        children: [
          sbHeight(mqHeight(context, .015)),
          InkWell(
              onTap: () {
                setState(() {
                  triptypeC.text = xtrips.tripx!;
                  closeAction(context);
                });
              },
              child: dText(xtrips.tripx!, mqHeight(context, .015))),
          sbHeight(mqHeight(context, .015)),
          DottedLine(
            dashColor: guocolor.black.withOpacity(.1),
          ),
        ],
      ),
    );
  }

  Widget fleetData(Datumxx x) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .04)),
      child: Column(
        children: [
          sbHeight(mqHeight(context, .015)),
          InkWell(
              onTap: () {
                setState(() {
                  carC.text = x.name!;
                  vehicleid = x.id;
                  amount =x.price.toDouble().toInt();
                  closeAction(context);
                });
              },
              child: Column(
                children: [
                  Image.network(
                    x.imageLink!,
                    fit: BoxFit.fill,
                    height: mqHeight(context, .1),
                  ),
                  sbHeight(mqHeight(context, .01)),
                  dText(x.name!, mqHeight(context, .015),
                      fontweight: FontWeight.w700),
                  sbHeight(mqHeight(context, .005)),
                  dText(x.description! + " - " + "${x.seats} seats",
                      mqHeight(context, .015),
                      fontweight: FontWeight.w500),
                  sbHeight(mqHeight(context, .005)),
                  dText(
                      x.airConditioned == true
                          ? "Air Conditioned"
                          : "Not AirConditioned",
                      mqHeight(context, .015),
                      fontweight: FontWeight.w500),
                  sbHeight(mqHeight(context, .005)),
                  dText("N" + " " + _format.format(double.parse(x.price!)),
                      mqHeight(context, .015),
                      fontweight: FontWeight.w700, color: guocolor.green),
                ],
              )),
          sbHeight(mqHeight(context, .01)),
          DottedLine(
            dashColor: guocolor.black.withOpacity(.1),
          ),
        ],
      ),
    );
  }

  Widget _allT(Datum xt) {
    destinationState() {
      setState(() {
        destinationC.text = xt.address + "," + xt.terminal;
        destId = xt.id;
        closeAction(context);
      });
    }

    terminalState() {
      setState(() {
        terminalC.text = xt.address + "," + xt.terminal;
        terminalid = xt.id;
        closeAction(context);
      });
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .04)),
      child: Column(
        children: [
          sbHeight(mqHeight(context, .015)),
          InkWell(
              onTap: () {
                !isT ? destinationState() : terminalState();
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

  Widget _bookData(Bookings xbook) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .04)),
      child: Column(
        children: [
          sbHeight(mqHeight(context, .015)),
          InkWell(
              onTap: () {
                setState(() {
                  bookingC.text = xbook.bookx!;
                  closeAction(context);
                });
              },
              child: dText(xbook.bookx!, mqHeight(context, .015))),
          sbHeight(mqHeight(context, .015)),
          DottedLine(
            dashColor: guocolor.black.withOpacity(.1),
          ),
        ],
      ),
    );
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
                  print(stateid);
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

  void _selectDepatureDate(BuildContext context) async {
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
        departureC.text = DateFormat("MMMM dd, yyyy").format(selected);
      });
  }
}

class MyTrips {
  String? tripx;
  MyTrips(this.tripx);
}

class Bookings {
  String? bookx;
  Bookings(this.bookx);
}
