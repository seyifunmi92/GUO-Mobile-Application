import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/containers/container.dart';
import 'package:guomobile/hooks/dialog/loader.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/hooks/text/text.dart';
import 'package:guomobile/models/nullrider.dart';
import 'package:guomobile/models/od.dart';
import 'package:guomobile/models/orderdetails.dart';
import 'package:guomobile/providers/callfunctions/providerbloc.dart';
import 'package:guomobile/screens/reviews/riderreview.dart';
import 'package:guomobile/services/orderservices.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../hooks/buttons/buttons.dart';
import '../../navigators/navigation.dart';
import '../home/home.dart';

class OrderDetails extends StatefulWidget {
  int? orderId;
  OrderDetails(this.orderId);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

OrderDetailss? xOD;
Od? xrider;
Nullrider? xridernull;

class _OrderDetailsState extends State<OrderDetails> {
  final _format = NumberFormat("#,###,000.00");

  bool isError = false;
  bool isDashboard = false;
  bool nullRider = false;
  String bookingfee = "";
  String additionalFee = "";
  String totalDistance = "";
  String subTotal = "";
  bool malePressed = false;
  bool errorOccured = false;
  String createdDate = "";
  String deliveryDate = "";
  @override
  void initState() {
    Provider.of<OrderBloc>(context, listen: false).isloading = true;
    _getOrderDetails2();
    _getOrderDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isError ? guocolor.white : guocolor.offWhite,
      appBar: guoAppBar(context, "Order Details"),
      body: Provider.of<OrderBloc>(context, listen: false).isloading
          ? Loaderx(ImageClass.loader)
          : isError
              ? Column(
                  children: [
                    sbHeight(mqHeight(context, .05)),
                    Center(child: Image.asset(ImageClass.error)),
                    sbHeight(mqHeight(context, .005)),
                    dText("Invalid Order ID", mqHeight(context, .04),
                        fontweight: FontWeight.w700),
                    sbHeight(mqHeight(context, .3)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: mqWidth(context, .02)),
                      child: straightButton(
                        "Home",
                        mqHeight(context, .059),
                        mqWidth(context, .915),
                        guocolor.primaryColor,
                        8,
                        fontSize: mqHeight(context, .022),
                        fontColor: guocolor.white,
                        onT: () {
                          mynextScreen(context, Home("x", "y", ""));
                        },
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sbHeight(mqHeight(context, .04)),
                        Container(
                            height: mqHeight(context, .22),
                            width: mqWidth(context, 1),
                            color: guocolor.transparent,
                            child: Stack(
                              children: [
                                oDetails(context),
                                Scaffold(
                                  backgroundColor: guocolor.transparent,
                                  body: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        sbHeight(mqHeight(context, .1)),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: mqWidth(context, .01)),
                                            child: bigcircle(context,
                                                Icons.pedal_bike_rounded,
                                                radius: 40))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )),
                        dText("Pick Up", mqHeight(context, .02)),
                        sbHeight(mqHeight(context, .01)),
                        dText(createdDate, mqHeight(context, .015),
                            color: guocolor.black.withOpacity(.5)),
                        sbHeight(mqHeight(context, .01)),
                        dText(xOD!.data.pickUpAddress.address,
                            mqHeight(context, .015),
                            color: guocolor.black.withOpacity(.5)),
                        sbHeight(mqHeight(context, .02)),
                        dText("Delivery", mqHeight(context, .02)),
                        sbHeight(mqHeight(context, .01)),
                        dText(deliveryDate, mqHeight(context, .015),
                            color: guocolor.black.withOpacity(.5)),
                        sbHeight(mqHeight(context, .01)),
                        dText(xOD!.data.dropOffAddress.address,
                            mqHeight(context, .015),
                            color: guocolor.black.withOpacity(.5)),
                        sbHeight(mqHeight(context, .02)),
                        dText("Tracking ID", mqHeight(context, .02)),
                        sbHeight(mqHeight(context, .01)),
                        dText(xOD!.data.trackingId, mqHeight(context, .015),
                            color: guocolor.black.withOpacity(.5)),
                        sbHeight(mqHeight(context, .02)),
                        dText("Destination", mqHeight(context, .02)),
                        sbHeight(mqHeight(context, .01)),
                        dText(xOD!.data.dropOffAddress.address,
                            mqHeight(context, .015),
                            color: guocolor.black.withOpacity(.5)),
                        sbHeight(mqHeight(context, .02)),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              circleTick(context, Icons.check),
                              sbWidth(mqWidth(context, .02)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  dText(
                                      "Parcel Created - ID (${xOD!.data.pickUpAddress.address} to ${xOD!.data.dropOffAddress.address})",
                                      mqHeight(context, .02)),
                                  sbHeight(mqHeight(context, .005)),
                                  dText(createdDate, mqHeight(context, .015),
                                      color: guocolor.black.withOpacity(.5)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        sbHeight(mqHeight(context, .04)),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              circleTick(context, Icons.check),
                              sbWidth(mqWidth(context, .02)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  dText("Picked Up", mqHeight(context, .02)),
                                  sbHeight(mqHeight(context, .005)),
                                  dText(deliveryDate, mqHeight(context, .015),
                                      color: guocolor.black.withOpacity(.5)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        sbHeight(mqHeight(context, .03)),
                        !nullRider
                            ? _showRider()
                            : Row(
                                children: [
                                  Icon(Icons.info),
                                  sbWidth(mqWidth(context, .02)),
                                  dText(
                                      "Rider details not available at the moment",
                                      mqHeight(context, .02)),
                                ],
                              ),
                        sbHeight(mqHeight(context, .03)),
                        Divider(),
                        sbHeight(mqHeight(context, .03)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            dText("Fare Details", mqHeight(context, .017)),
                          ],
                        ),
                        sbHeight(mqHeight(context, .02)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            dText("Booking Fee", mqHeight(context, .017)),
                            dText(
                                !nullRider
                                    ? "N ${_format.format(xrider!.data.bookingFee.toDouble())}"
                                    : "N ${_format.format(xridernull!.data.bookingFee.toDouble())}",
                                mqHeight(context, .017),
                                fontweight: FontWeight.w700),
                          ],
                        ),
                        sbHeight(mqHeight(context, .02)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            dText("Additional Fee", mqHeight(context, .017)),
                            dText(
                                !nullRider
                                    ? "N ${_format.format(xrider!.data.additionalFee.toDouble())}"
                                    : "N ${_format.format(xridernull!.data.additionalFee.toDouble())}",
                                mqHeight(context, .017),
                                fontweight: FontWeight.w700),
                          ],
                        ),
                        sbHeight(mqHeight(context, .02)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            dText("Total Distance", mqHeight(context, .017)),
                            dText(
                                !nullRider
                                    ? xrider!.data.totalDistance
                                    : xridernull!.data.totalDistance,
                                mqHeight(context, .018),
                                fontweight: FontWeight.w700),
                          ],
                        ),
                        sbHeight(mqHeight(context, .03)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            dText("Sub Total", mqHeight(context, .017),
                                fontweight: FontWeight.w700),
                            dText(
                                !nullRider
                                    ? "N ${_format.format(xrider!.data.subTotal.toDouble())}"
                                    : "N ${_format.format(xridernull!.data.subTotal.toDouble())}",
                                mqHeight(context, .017),
                                fontweight: FontWeight.w700),
                          ],
                        ),
                        sbHeight(mqHeight(context, .1)),
                        straightButton(
                          "View Map",
                          mqHeight(context, .059),
                          mqWidth(context, .915),
                          Color(0xff50AEF0),
                          8,
                          fontSize: mqHeight(context, .022),
                          fontColor: guocolor.white,
                          onT: () {},
                        ),
                        sbHeight(mqHeight(context, .02)),
                        !nullRider
                            ? straightButton(
                                "Call Rider",
                                mqHeight(context, .059),
                                mqWidth(context, .915),
                                guocolor.primaryColor,
                                8,
                                fontSize: mqHeight(context, .022),
                                fontColor: guocolor.white,
                                onT: () {
                                  xrider!.data.rider!.phoneNumber.runtimeType ==
                                          String
                                      ? _callRider()
                                      : toast(
                                          "Rider details not available at the moment");
                                },
                              )
                            : dText("", 0),
                        sbHeight(mqHeight(context, .02)),
                        straightButton(
                          "Download Receipt",
                          mqHeight(context, .059),
                          mqWidth(context, .915),
                          guocolor.primaryColor,
                          8,
                          fontSize: mqHeight(context, .022),
                          fontColor: guocolor.white,
                          onT: () {},
                        ),
                        sbHeight(mqHeight(context, .1)),
                      ],
                    ),
                  ),
                ),
    );
  }

  _showRider() {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(ImageClass.anayo),
        ),
        sbWidth(mqWidth(context, .02)),
        Container(
          width: mqWidth(context, .35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  dText(
                      xrider!.data.rider!.firstName +
                          " " +
                          xrider!.data.rider!.lastName,
                      mqHeight(context, .02)),
                  sbHeight(mqHeight(context, .01)),
                  dText("Rider", mqHeight(context, .013),
                      color: guocolor.primaryColor),
                ],
              ),
              straightButton(
                "Review Rider",
                mqHeight(context, .029),
                mqWidth(context, .08),
                guocolor.primaryColor,
                10,
                fontSize: mqHeight(context, .01),
                fontColor: guocolor.white,
                onT: () {
                  mynextScreen(context, Review(xrider!));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  _getOrderDetails() {
    Provider.of<OrderBloc>(context, listen: false)
        .getOrderDetails(widget.orderId!)
        .then((value) => xOutput(value));
  }

  _getOrderDetails2() {
    Provider.of<OrderBloc>(context, listen: false)
        .getOrderDetail2(widget.orderId!)
        .then((value) => xOutput2(value));
  }

  xOutput2(String x) {
    print("seyeyeyey");
    print(x);
    var xx = jsonDecode(x);
    if (xx["success"] == true) {
      if (xx["data"]["rider"] == null) {
        setState(() {
          xridernull = Nullrider.fromJson(xx);
          nullRider = true;
        });
      } else {
        setState(() {
          xrider = Od.fromJson(xx);
          nullRider = false;
          errorOccured = false;
        });
      }
    } else {
      setState(() {
        errorOccured = true;
      });
    }
  }

  xOutput(String x) {
    print("seyyyyyy");
    print(x);
    var xx = jsonDecode(x);
    if (xx["success"] == true) {
      setState(() {
        xOD = OrderDetailss.fromJson(xx);
        Provider.of<OrderBloc>(context, listen: false).isloading = false;
        createdDate =
            DateFormat("dd MMMM yyyy, hh:mm aaa").format(xOD!.data.createdAt);
        deliveryDate =
            DateFormat("dd MMMM yyyy, hh:mm aaa").format(xOD!.data.updatedAt);
      });
    } else {
      setState(() {
        isError = true;
        Provider.of<OrderBloc>(context, listen: false).isloading = false;
      });
      toast(xx["message"]);
    }
  }

  _callRider() {
    FlutterPhoneDirectCaller.callNumber(xrider!.data.rider!.phoneNumber);
  }

  // _checkbox() {
  //   if (malePressed == false) {
  //     setState(() {
  //       malePressed = true;
  //     });
  //   } else {
  //     setState(() {
  //       malePressed = false;
  //     });
  //   }
  // }

  // Widget text() {
  //   return Container(
  //     color: malePressed ? Colors.grey[60] : Colors.transparent,
  //   );
  // }
}
