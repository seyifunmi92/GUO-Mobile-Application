import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/containers/container.dart';
import 'package:guomobile/hooks/dialog/loader.dart';
import 'package:guomobile/hooks/servicehooks/hookservice.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/providers/callfunctions/providerbloc.dart';
import 'package:guomobile/screens/auth/forgotpassword/resetsuccess.dart';
import 'package:guomobile/screens/payment/payment.dart';
import 'package:guomobile/services/accountbloc.dart';
import 'package:guomobile/services/terminalbloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../hooks/appbars/appbar.dart';
import '../../hooks/buttons/buttons.dart';
import '../../hooks/formfields/formfields.dart';
import '../../hooks/layout/mediaqueries.dart';
import '../../hooks/text/text.dart';

class Guardian extends StatefulWidget {
  int? vehicleId;
  int? departureStateId;
  int? terminalId;
  int? destinationId;
  bool? isRoundTrip;
  String? bookingType;
  DateTime? departureDate;
  int? amount;

  Guardian(
      {this.vehicleId,
      this.departureStateId,
      this.terminalId,
      this.destinationId,
      this.isRoundTrip,
      this.bookingType,
      this.departureDate,
      this.amount});

  @override
  State<Guardian> createState() => _GuardianState();
}

class _GuardianState extends State<Guardian> {
  TextEditingController gnamec = TextEditingController();
  TextEditingController gemailc = TextEditingController();
  TextEditingController gphonec = TextEditingController();
  TextEditingController gcouponc = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // closeAction(context);
    return Scaffold(
      backgroundColor: guocolor.offWhite,
      appBar: guoAppBar(context, "Guardian Details"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqHeight(context, .02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sbHeight(mqHeight(context, .04)),
            dText("Full Name", mqHeight(context, .018)),
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
              title: "Enter",
              controller: gnamec,
            ),
            sbHeight(mqHeight(context, .03)),
            dText("Email", mqHeight(context, .018)),
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
              title: "Enter",
              controller: gemailc,
            ),
            sbHeight(mqHeight(context, .03)),
            dText("Phone Number", mqHeight(context, .018)),
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
              title: "Enter",
              controller: gphonec,
            ),
            sbHeight(mqHeight(context, .03)),
            dText("Coupon Code", mqHeight(context, .018)),
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
              title: "Enter",
              controller: gcouponc,
            ),
            sbHeight(mqHeight(context, .3)),
            straightButton(
              "Submit",
              mqHeight(context, .059),
              mqWidth(context, .915),
              guocolor.primaryColor,
              8,
              fontSize: mqHeight(context, .022),
              fontColor: guocolor.white,
              onT: () {
                _check();
              },
            ),
          ],
        ),
      ),
    );
  }

  _errorToast() {
    toast("Please enter all fields to proceed");
  }

  _check() {
    if (gnamec.text.isEmpty) {
      _errorToast();
    } else if (gemailc.text.isEmpty) {
      _errorToast();
    } else if (gphonec.text.isEmpty) {
      _errorToast();
    } else {
      _runProceed();
    }
  }

  _bookTrip() {
    Provider.of<TerminalBloc>(context, listen: false)
        .minorTrip(
            widget.vehicleId!,
            widget.departureStateId!,
            widget.terminalId!,
            widget.destinationId!,
            widget.isRoundTrip!,
            widget.bookingType!,
            widget.departureDate!,
            gnamec.text,
            gemailc.text,
            gphonec.text)
        .then((value) => output(value));
  }

  output(String xx) {
    var x = jsonDecode(xx);
    x["success"] == true ? success(x) : failed(x);
  }

  success(dynamic x) {
    setState(() {
      toast(x["message"]);
    });
    closeAction(context);

    // Provider.of<ProviderBloc>(context, listen: false)
    //     .showPaymentDialog2(context, 300);

    mynextScreen(
        context,
        Payment(
          amount: widget.amount,
          email: gemailc.text,
        ));
  }

  failed(dynamic x) {
    setState(() {});
    closeAction(context);
  }

  _runProceed() {
    setState(() {
      Provider.of<TerminalBloc>(context, listen: false).isloading = true;
    });
    Provider.of<TerminalBloc>(context, listen: false).isloading
        ? Provider.of<ProviderBloc>(context, listen: false)
            .showAnimatedLoader(context, ImageClass.loader)
        : null;
    _bookTrip();
  }
}
