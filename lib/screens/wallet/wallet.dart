import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/auth/forgotpassword/resetpass.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../hooks/buttons/buttons.dart';
import '../../../hooks/dialog/showmessage.dart';
import '../../../hooks/text/text.dart';
import '../../../providers/callfunctions/providerbloc.dart';
import '../../../services/accountbloc.dart';
import '../../hooks/containers/container.dart';
import '../../hooks/servicehooks/hookservice.dart';
import '../../services/walletbloc.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String currentBalance = "0.00";
  bool showBalance = false;
  bool lowBalance = false;
  int customerId = 0;
  final _format = NumberFormat("#,###,000.00");

  @override
  void initState() {
    _getCustomerId();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: guoAppBar(context, "My Wallet"),
      bottomNavigationBar: bottomNavDash(context, isWallet: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Column(
          children: [
            sbHeight(mqHeight(context, .048)),
            dashContainerWallet(
                context,
                "Wallet Balance",
                "dateTime",
                currentBalance != "0.00"
                    ? "N ${_format.format(double.parse(currentBalance))}"
                    : "N ${currentBalance}"),
            sbHeight(mqHeight(context, .048)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dText("Recent Transactions", mqHeight(context, .02)),
                dText("View All", mqHeight(context, .02)),
              ],
            ),
            sbHeight(mqHeight(context, .048)),
            containSet(context, "All Expense Paid Trip to Maldives   ",
                "400pts", Icons.reviews_sharp),
                   sbHeight(mqHeight(context, .018)),
            containSet(context, "All Expense Paid Trip to Maldives   ",
                "400pts", Icons.reviews_sharp),
                   sbHeight(mqHeight(context, .018)),
            containSet(context, "All Expense Paid Trip to Maldives   ",
                "400pts", Icons.reviews_sharp),
          ],
        ),
      ),
    );
  }

  _getCustomerId() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var xid = _shared.getInt("id");
    setState(() {
      customerId = xid!;
    });
    _getWallet();
  }

  _getWallet() {
    Provider.of<WalletBloc>(context, listen: false)
        .walletBalance(customerId)
        .then((value) => outputx(value));
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
}
