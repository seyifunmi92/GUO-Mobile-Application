import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/servicehooks/hookservice.dart';
import 'package:guomobile/models/fleetdetail.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/charter/successful.dart';
import 'package:guomobile/screens/payment/payment.dart';
import 'package:guomobile/screens/reviews/successreview.dart';
import 'package:guomobile/services/terminalbloc.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../asset/imageclass.dart';
import '../../hooks/appbars/appbar.dart';
import '../../hooks/buttons/buttons.dart';
import '../../hooks/formfields/formfields.dart';
import '../../hooks/layout/mediaqueries.dart';
import '../../hooks/text/text.dart';
import '../../models/cars.dart';
import '../../models/terminals.dart';
import '../../providers/callfunctions/providerbloc.dart';

class BookCharter extends StatefulWidget {
  int id;
  int? fee;
  BookCharter(this.id, {this.fee});

  @override
  State<BookCharter> createState() => _BookCharterState();
}

class _BookCharterState extends State<BookCharter> {
  TextEditingController passengerC = TextEditingController();
  TextEditingController firstNameC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController messageC = TextEditingController();
  TextEditingController startDateC = TextEditingController();
  TextEditingController endDateC = TextEditingController();
  bool isSelectDate = false;

  DateTime selectedDeliveryDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: guocolor.offWhite,
      appBar: guoAppBar(context, "Request Charter"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqHeight(context, .02)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sbHeight(mqHeight(context, .03)),
              dText("First Name", mqHeight(context, .017)),
              sbHeight(mqHeight(context, .01)),
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
                title: "Oluwaseyi",
                controller: firstNameC,
              ),
              sbHeight(mqHeight(context, .02)),
              dText("Last Name", mqHeight(context, .017)),
              sbHeight(mqHeight(context, .01)),
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
                title: "Fatunmole",
                controller: lastNameC,
              ),
              sbHeight(mqHeight(context, .02)),
              dText("Email", mqHeight(context, .017)),
              sbHeight(mqHeight(context, .01)),
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
                title: "oluwaseyi@nerdbug.io",
                controller: emailC,
              ),
              sbHeight(mqHeight(context, .02)),
              dText("Passengers", mqHeight(context, .017)),
              sbHeight(mqHeight(context, .01)),
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
                title: "",
                isInt: true,
                controller: passengerC,
              ),
              sbHeight(mqHeight(context, .02)),
              dText("Start Date", mqHeight(context, .017)),
              sbHeight(mqHeight(context, .01)),
              guoFormField(
                  context, mqHeight(context, .05), mqWidth(context, .5),
                  containercolor: guocolor.white,
                  showBorder: false,
                  showRadius: true,
                  radiusborder: true, onT: () {
                _selectStartDate(context);
              },
                  isnext: true,
                  title: "",
                  controller: startDateC,
                  isReadonly: true),
              sbHeight(mqHeight(context, .02)),
              dText("End Date", mqHeight(context, .017)),
              sbHeight(mqHeight(context, .01)),
              guoFormField(
                  context, mqHeight(context, .05), mqWidth(context, .5),
                  containercolor: guocolor.white,
                  showBorder: false,
                  showRadius: true,
                  radiusborder: true, onT: () {
                _selectEndDate(context);
              },
                  isnext: true,
                  title: "",
                  controller: endDateC,
                  isReadonly: true),
              sbHeight(mqHeight(context, .02)),
              dText("Message", mqHeight(context, .017)),
              sbHeight(mqHeight(context, .01)),
              guoFormField(
                context,
                mqHeight(context, .1),
                mqWidth(context, .5),
                containercolor: guocolor.white,
                showBorder: false,
                showRadius: true,
                radiusborder: true,
                onT: () {},
                isnext: true,
                title: "Type here",
                controller: messageC,
              ),
              sbHeight(mqHeight(context, .03)),
              straightButton(
                "Submit",
                mqHeight(context, .059),
                mqWidth(context, .915),
                guocolor.primaryColor,
                8,
                fontSize: mqHeight(context, .022),
                fontColor: guocolor.white,
                onT: () {
                  _runProceed();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectStartDate(BuildContext context) async {
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
        startDateC.text = DateFormat("MMMM dd, yyyy").format(selected);
      });
  }

  void _selectEndDate(BuildContext context) async {
    final DateTime? selected2 = await showDatePicker(
      context: context,
      initialDate: selectedDeliveryDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );
    if (selected2 != null)
      setState(() {
        isSelectDate = true;
        selectedDeliveryDate = selected2;
        endDateC.text = DateFormat("MMMM dd, yyyy").format(selected2);
      });
  }

  _negotiateCharter() {
    Provider.of<TerminalBloc>(context, listen: false)
        .requestCharter(
            widget.id,
            startDateC.text,
            endDateC.text,
            passengerC.text.toInt(),
            firstNameC.text,
            lastNameC.text,
            emailC.text,
            messageC.text)
        .then((value) => outputx(value));
  }

  outputx(String x) {
    var xx = jsonDecode(x);
    print(xx);
    if (xx["success"] == true) {
      closeAction(context);
      mynextScreen(
          context,
          Payment(
            amount: widget.fee,
            email: emailC.text,
          ));
    } else {
      closeAction(context);
      toast(xx["message"]);
    }
  }

  _runProceed() {
    setState(() {
      Provider.of<TerminalBloc>(context, listen: false).isloading = true;
    });
    Provider.of<TerminalBloc>(context, listen: false).isloading
        ? Provider.of<ProviderBloc>(context, listen: false)
            .showAnimatedLoader(context, ImageClass.loader)
        : null;
    _negotiateCharter();
  }
}
