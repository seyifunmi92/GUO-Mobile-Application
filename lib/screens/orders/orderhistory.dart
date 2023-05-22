import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/containers/container.dart';
import 'package:guomobile/hooks/dialog/loader.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/models/orders.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/orders/orderdetails.dart';
import 'package:guomobile/services/orderservices.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  final _format = NumberFormat("#,###,000.00");

  Orderhistory? xorders;
  List<Datum>? xhistory;

  @override
  void initState() {
    Provider.of<OrderBloc>(context, listen: false).isloading = true;
    _getUserId();
    super.initState();
  }

  int userId = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: guocolor.offWhite,
      appBar: guoAppBar(context, "Order History", showElevation: false),
      body: Provider.of<OrderBloc>(context, listen: false).isloading
          ? Loaderx(ImageClass.loader)
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
              child: Column(
                children: [
                  sbHeight(mqHeight(context, .03)),
                  ...xhistory!.map((e) => _orderContainer(e)),
                ],
              ),
            ),
      bottomNavigationBar: bottomNavDash(context, isOrders: true),
    );
  }

  Widget _orderContainer(Datum myD) {
    String createdDate =
        DateFormat("dd MMMM yyyy, hh:mm aaa").format(myD.createdAt).toString();
    return shadowContainer2(
        context,
        mqHeight(context, .1),
        mqWidth(context, 1),
        myD.pickUpAddress.address,
        myD.dropOffAddress.address,
        "N" + _format.format(myD.amount.toDouble()),
        createdDate, () {
      mynextScreen(
          context,
          OrderDetails(
            myD.id,
          ));
    });
  }

  _getOrderHistory() {
    Provider.of<OrderBloc>(context, listen: false)
        .getOrderHistory(userId)
        .then((value) => outputx(value));
  }

  outputx(String x) {
    var xdata = jsonDecode(x);
    if (xdata["success"] == true) {
      List myxList = xdata["data"];
      setState(() {
        xorders = Orderhistory.fromJson(xdata);
        xhistory = myxList.map<Datum>((x) => Datum.fromJson(x)).toList();
        Provider.of<OrderBloc>(context, listen: false).isloading = false;
      });
    } else {
      setState(() {
        Provider.of<OrderBloc>(context, listen: false).isloading = false;
      });
      toast(xdata["message"]);
    }
  }

  _getUserId() async {
    SharedPreferences x = await SharedPreferences.getInstance();
    var xx = x.getInt("id");
    print("xx == $xx");
    setState(() {
      userId = xx!;
    });
    _getOrderHistory();
  }
}
