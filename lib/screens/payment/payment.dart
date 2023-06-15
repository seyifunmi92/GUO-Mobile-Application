import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/containers/container.dart';
import 'package:guomobile/hooks/dialog/loader.dart';
import 'package:guomobile/hooks/servicehooks/hookservice.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/providers/callfunctions/providerbloc.dart';
import 'package:guomobile/screens/auth/forgotpassword/resetsuccess.dart';
import 'package:guomobile/screens/logistics/paymentstatus.dart';
import 'package:guomobile/services/accountbloc.dart';
import 'package:guomobile/services/orderservices.dart';
import 'package:guomobile/services/terminalbloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../hooks/appbars/appbar.dart';
import '../../hooks/buttons/buttons.dart';
import '../../hooks/formfields/formfields.dart';
import '../../hooks/layout/mediaqueries.dart';
import '../../hooks/text/text.dart';

class Payment extends StatefulWidget {
  int? amount;
  String? email;
  Payment({this.amount, this.email});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String flutterwavePublicKey =
      "FLWPUBK_TEST-372cd55cbcf66b4cdf3a2b26d9db5cff-X";
  String flutterwaveSecretKey =
      "FLWSECK_TEST-891b7c0d5c50f4ade215bd8d85b9b8d3-X";
  String flutterwaveEncryptionKey = "FLWSECK_TESTb2fbedc60bfc";
  String publicKey = "pk_test_6a714f4dc8a4b0925ff2b904cb19401e2c31e02f";
  final plugin = PaystackPlugin();
  CheckoutResponse? xResponse;
  @override
  void initState() {
    _getEmail();
    _initializePaystack();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: guocolor.offWhite,
      appBar: guoAppBar(context, "Payment"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqHeight(context, .02)),
        child: Column(
          children: [
            sbHeight(mqHeight(context, .02)),
            paymentCard(context, "Pay With Flutterwave",
                image: ImageClass.flutterwave, onT: () {
              _initializeFlutterwave();
            }),
            sbHeight(mqHeight(context, .02)),
            paymentCard(context, "Pay With Paystack",
                image: ImageClass.paystack, onT: () {
              _checkOut();
            }),
            sbHeight(mqHeight(context, .02)),
            paymentCard(context, "Pay With Wallet", image: ImageClass.wallet,
                onT: () {
              Provider.of<ProviderBloc>(context, listen: false)
                  .showPaymentDialog2(context, widget.amount!);
            }),
          ],
        ),
      ),
    );
  }

  _initializePaystack() {
    print("initializing");
    plugin.initialize(publicKey: publicKey);
    print(plugin.initialize(publicKey: publicKey));
    var x = plugin.initialize(publicKey: publicKey);
    print(x);
    if (x != null) {
      print("Paystack initialized");
    } else {
      print("no o");
    }
  }

  _checkOut() async {
    int amount = widget.amount! * 100;
    Charge x = Charge()
      ..amount = amount
      ..reference = 'ref_${DateTime.now().millisecondsSinceEpoch}'
      ..email = widget.email
      ..currency = "NGN";

    plugin
        .checkout(context, method: CheckoutMethod.card, charge: x)
        .then((value) => xoutput(value));
  }

  xoutput(dynamic x) {
    print(x);
    CheckoutResponse xResponse = x;
    print(xResponse.account);
    print(xResponse.message);
    if (xResponse.status == "true") {
      mynextScreen(
          context,
          PaymentStatus(
            lowBalance: false,
          ));
      toast(xResponse.message);
    } else {
      toast(xResponse.message);
    }
  }

  _getEmail() async {
    SharedPreferences x = await SharedPreferences.getInstance();
    var xx = x.getString("email");
    if (widget.email == null) {
      setState(() {
        widget.email = xx;
      });
    }
  }

  _initializeFlutterwave() {
    Provider.of<OrderBloc>(context, listen: false)
        .flutterwavePaymentHandler(
          context,
          fullname: "Oluwaseyi Fatunmole",
          phoneNumber: "08137330706",
          email: widget.email,
          amount: widget.amount,
          encryptionKey: flutterwaveEncryptionKey,
          publicKey: flutterwavePublicKey,
          paymentOptions: "Card",
          currency: "NGN",
          txRef: " 'ref_${DateTime.now().millisecondsSinceEpoch}'",
          title: "My payment",
          description: "Payment for trip",
          redirectUrl: "https://facebook.com",
          isTestMode: true,
        )
        .then((value) => flutterwaveCheckout(value));
  }

  flutterwaveCheckout(String x) {
    print(x);
  }
}
