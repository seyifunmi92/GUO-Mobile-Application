import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/containers/container.dart';
import 'package:guomobile/hooks/dialog/loader.dart';
import 'package:guomobile/hooks/dialog/showmessage.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/home/home.dart';
import 'package:guomobile/screens/logistics/inputselections.dart';
import 'package:guomobile/screens/logistics/paymentstatus.dart';
import 'package:guomobile/services/walletbloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../hooks/buttons/buttons.dart';
import '../../hooks/servicehooks/hookservice.dart';
import '../../hooks/text/text.dart';

class SelectPay extends StatefulWidget {
  int totalAmount;
  SelectPay(this.totalAmount);

  @override
  State<SelectPay> createState() => _SelectPayState();
}

class _SelectPayState extends State<SelectPay> {
  bool isLoading = false;
  int customerId = 0;
  bool walletSelected = false;
  String currentBalance = "0.00";
  bool showBalance = false;
  bool lowBalance = false;
  final _format = NumberFormat("#,###,000.00");

  @override
  void initState() {
    _getCustomerId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: Loaderx(ImageClass.loader),
      child: Scaffold(
        backgroundColor: guocolor.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
          child: Column(
            children: [],
          ),
        ),
        bottomNavigationBar:
            walletSelected ? afterPayContainer() : beforePayContainer(),
      ),
    );
  }

  Widget beforePayContainer() {
    return Container(
      height: mqHeight(context, .45),
      width: totalWidth(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: guocolor.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sbHeight(mqHeight(context, .04)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dText(
                  "Price",
                  mqHeight(context, .02),
                  color: guocolor.black.withOpacity(1),
                ),
                dispatchCircleHome(
                    Color(0xff8C8C95), Icons.electric_bike_outlined,
                    iconcolor: Color(0xff8C8C95)),
              ],
            ),
            sbHeight(mqHeight(context, .02)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dText("N ${_format.format(widget.totalAmount)}",
                    mqHeight(context, .023),
                    color: guocolor.black.withOpacity(.8),
                    fontweight: FontWeight.w700),
                dText("Bike Delivery", mqHeight(context, .02),
                    color: guocolor.black.withOpacity(.4)),
              ],
            ),
            sbHeight(mqHeight(context, .06)),
            straightButton(
              "Pay From Wallet",
              mqHeight(context, .059),
              mqWidth(context, .915),
              guocolor.primaryColor,
              8,
              fontSize: mqHeight(context, .022),
              fontColor: guocolor.white,
              onT: () {
                setState(() {
                  walletSelected = true;
                });
              },
            ),
            sbHeight(mqHeight(context, .013)),
            straightButton(
              "Pay At Station",
              mqHeight(context, .059),
              mqWidth(context, .915),
              guocolor.white,
              8,
              fontSize: mqHeight(context, .022),
              fontColor: guocolor.primaryColor,
              showBorder: true,
              onT: () {
                mynextScreen(context, Home("x", "", ""));
                //  guoAlert(context, "Pay at station mode has been activated");
                //  closeAction(context);
                // mynextScreen(context, InputSelections());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget afterPayContainer() {
    return Container(
      height: mqHeight(context, .5),
      width: totalWidth(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: guocolor.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sbHeight(mqHeight(context, .04)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dText("Payment Summary", mqHeight(context, .022),
                    color: guocolor.black.withOpacity(1),
                    fontweight: FontWeight.w700),
                InkWell(
                  onTap: () {
                    closeAction(context);
                  },
                  child: Icon(
                    Icons.cancel,
                    color: guocolor.primaryColor.withOpacity(1),
                  ),
                ),
              ],
            ),
            sbHeight(mqHeight(context, .04)),
            dashContainerWallet(
                context,
                "Wallet Balance",
                "dateTime",
                currentBalance != "0.00"
                    ? "N ${_format.format(currentBalance.toDouble())}"
                    : "N ${currentBalance}"),
            sbHeight(mqHeight(context, .12)),
            straightButton(
              "Pay From Wallet (N${_format.format(widget.totalAmount)})",
              mqHeight(context, .059),
              mqWidth(context, .915),
              guocolor.primaryColor,
              8,
              fontSize: mqHeight(context, .02),
              fontColor: guocolor.white,
              onT: () {
                setState(() {
                  isLoading = true;
                });
                _payFromWallet();
              },
            ),
          ],
        ),
      ),
    );
  }

  _getWallet() {
    Provider.of<WalletBloc>(context, listen: false)
        .walletBalance(customerId)
        .then((value) => outputx(value));
  }

  outputxx(String xvalue) {
    print(xvalue);
    var x = jsonDecode(xvalue);

    if (x["success"] == true) {
      print("arararara");
      setState(() {
        isLoading = false;
      });
      mynextScreen(
          context,
          PaymentStatus(
            lowBalance: false,
          ));
    } else {
      setState(() {
        isLoading = false;
      });
      toast(x["message"]);
    }
  }

  outputx(String resp) {
    var x = jsonDecode(resp);
    if (x["status"] == 200) {
      String balance = x["data"]["currentBalance"];
      setState(() {
        showBalance = true;
        currentBalance = balance;
      });
      print(currentBalance);
    } else {
      setState(() {
        showBalance = false;
        currentBalance = "0.00";
      });
      print(currentBalance);
    }
  }

  _debitWAllet() {
    Provider.of<WalletBloc>(context, listen: false)
        .debitWallet(widget.totalAmount.toDouble(), "Logistics",
            "ref_${DateTime.now().microsecondsSinceEpoch}")
        .then((value) => outputxx(value));
  }

  _getCustomerId() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var xid = _shared.getInt("id");
    setState(() {
      customerId = xid!;
    });
    _getWallet();
  }

  _payFromWallet() {
    print(currentBalance);
    int xbalance = currentBalance.toDouble().toInt();

    print("${xbalance} -  ${widget.totalAmount}");
    xbalance < widget.totalAmount ? lowBalance == true : false;
    if (xbalance < widget.totalAmount) {
      setState(() {
        lowBalance = true;
        isLoading = false;
      });
      mynextScreen(
          context,
          PaymentStatus(
            lowBalance: true,
          ));
    } else {
      setState(() {
        lowBalance = false;
      });
      _debitWAllet();
    }
  }
}
