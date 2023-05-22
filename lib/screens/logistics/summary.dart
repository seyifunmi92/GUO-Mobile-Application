import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/dialog/loader.dart';
import 'package:guomobile/hooks/dialog/showmessage.dart';
import 'package:guomobile/hooks/servicehooks/hookservice.dart';
import 'package:guomobile/hooks/text/text.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/providers/callfunctions/providerbloc.dart';
import 'package:guomobile/screens/payment/payment.dart';
import 'package:guomobile/services/logisticsbloc.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../asset/imageclass.dart';
import '../../hooks/buttons/buttons.dart';
import '../../hooks/layout/mediaqueries.dart';
import '../../services/accountbloc.dart';

class Summarys extends StatefulWidget {
  String? dispatchType;
  String? address;
  String? dropOffAddress;
  int? parcelWeight;
  int? category;
  String? photo1;
  String? photo2;
  String? photo3;
  String? quantity;
  String? price;
  String? senderName;
  String? senderPhone;
  String? receiverName;
  String? receiverPhone;
  int? itemQuantity;
  int? itemWeight;
  int? itemValue;
  int? subCategory;
  int? width;
  int? height;
  String? description;
  String? type;
  bool? isInstant;
  bool? isScheduled;
  bool? flexibleSchedule;

  Summarys(
      {this.dispatchType,
      this.address,
      this.dropOffAddress,
      this.parcelWeight,
      this.category,
      this.photo1,
      this.photo2,
      this.photo3,
      this.quantity,
      this.price,
      this.senderName,
      this.senderPhone,
      this.receiverName,
      this.receiverPhone,
      this.itemQuantity,
      this.itemWeight,
      this.itemValue,
      this.subCategory,
      this.width,
      this.height,
      this.description,
      this.type,
      this.isInstant,
      this.isScheduled,
      this.flexibleSchedule});

  @override
  State<Summarys> createState() => _SummarysState();
}

class imageListx {
  String imagename;

  imageListx(this.imagename);
}

class _SummarysState extends State<Summarys> {
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String longitude = "";
  String latitude = "";
  late StreamSubscription<Position> positionStream;
  bool service = false;
  String totalAmount = "";
  List imageList = [];
  String image1 = "";
  String image2 = "";
  String image3 = "";
  int xBal = 0;
  int userId = 0;
  final _format = NumberFormat("#,###,000.00");
  final _dt = DateFormat("dd MMMM yyyy").format(DateTime.now());

  @override
  void initState() {
    Provider.of<LogisticsBloc>(context, listen: false).isloading = true;

    _checkGps();
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // closeAction(context);
    return Scaffold(
      appBar: guoAppBar(context, "Summary"),
      body: Provider.of<LogisticsBloc>(context, listen: false).isloading
          ? Loaderx(ImageClass.loader)
          : SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sbHeight(mqHeight(context, .02)),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...imageList.map((x) => displayImage(x)),
                          ],
                        ),
                      ),
                      sbHeight(mqHeight(context, .03)),
                      dText("Quantity : ${widget.quantity}",
                          mqHeight(context, .017)),
                      sbHeight(mqHeight(context, .025)),
                      dText("Value : N ${_format.format(widget.price.toInt())}",
                          mqHeight(context, .017)),
                      sbHeight(mqHeight(context, .025)),
                      dText("Pick Up Address", mqHeight(context, .017),
                          color: Color(0xff4C5D77).withOpacity(.7)),
                      sbHeight(mqHeight(context, .005)),
                      dText(widget.address!, mqHeight(context, .017)),
                      sbHeight(mqHeight(context, .025)),
                      dText("Delivery Address", mqHeight(context, .017),
                          color: Color(0xff4C5D77).withOpacity(.7)),
                      sbHeight(mqHeight(context, .005)),
                      dText(widget.dropOffAddress!, mqHeight(context, .017)),
                      sbHeight(mqHeight(context, .025)),
                      dText("Date", mqHeight(context, .014),
                          color: Color(0xff4C5D77).withOpacity(.7)),
                      sbHeight(mqHeight(context, .005)),
                      dText(_dt, mqHeight(context, .017)),
                      sbHeight(mqHeight(context, .025)),
                      dText("Senders Name", mqHeight(context, .017),
                          color: Color(0xff4C5D77).withOpacity(.7)),
                      sbHeight(mqHeight(context, .005)),
                      dText(widget.senderName!, mqHeight(context, .017)),
                      sbHeight(mqHeight(context, .025)),
                      dText("Senders Phone", mqHeight(context, .017),
                          color: Color(0xff4C5D77).withOpacity(.7)),
                      sbHeight(mqHeight(context, .005)),
                      dText(widget.senderPhone!, mqHeight(context, .017)),
                      sbHeight(mqHeight(context, .025)),
                      dText("Receivers Name", mqHeight(context, .017),
                          color: Color(0xff4C5D77).withOpacity(.7)),
                      sbHeight(mqHeight(context, .005)),
                      dText(widget.receiverName!, mqHeight(context, .017)),
                      sbHeight(mqHeight(context, .025)),
                      dText("Receivers Phone", mqHeight(context, .017),
                          color: Color(0xff4C5D77).withOpacity(.7)),
                      sbHeight(mqHeight(context, .005)),
                      dText(widget.receiverPhone!, mqHeight(context, .017)),
                      sbHeight(mqHeight(context, .025)),
                      dText("Amount", mqHeight(context, .017),
                          color: Color(0xff4C5D77).withOpacity(.7)),
                      sbHeight(mqHeight(context, .005)),
                      dText("N$totalAmount", mqHeight(context, .017)),
                      sbHeight(mqHeight(context, .07)),
                      straightButton(
                        "Proceed",
                        mqHeight(context, .059),
                        mqWidth(context, .915),
                        guocolor.primaryColor,
                        8,
                        fontSize: mqHeight(context, .022),
                        fontColor: guocolor.white,
                        onT: () {
                          _runFunction();
                        },
                      ),
                      sbHeight(mqHeight(context, .05)),
                    ]),
              ),
            ),
    );
  }

  _runFunction() {
    setState(() {
      Provider.of<AccountBloc>(context, listen: false).isLoading = true;
    });
    _loader();
    _createOrder();
  }

  _loader() {
    if (Provider.of<AccountBloc>(context, listen: false).isLoading) {
      Provider.of<ProviderBloc>(context, listen: false)
          .showAnimatedLoader(context, ImageClass.loader);
    }
  }

  _calculateTotalPrice() {
    Provider.of<LogisticsBloc>(context, listen: false)
        .calculatePrice(
            widget.address!,
            longitude,
            latitude,
            widget.dropOffAddress!,
            "10",
            "-30",
            widget.parcelWeight!,
            widget.category!)
        .then((value) => output(value));
  }

  output(String x) {
    var xy = jsonDecode(x);
    if (xy["status"] == 200) {
      setState(() {
        totalAmount = _format.format(xy["data"]);
        print(totalAmount);
        xBal = xy["data"];
        Provider.of<LogisticsBloc>(context, listen: false).isloading = false;
      });
    } else {
      setState(() {
        Provider.of<LogisticsBloc>(context, listen: false).isloading = false;
      });
      toasty(context, xy["message"]);
    }
  }

  _checkGps() async {
    Provider.of<LogisticsBloc>(context, listen: false).serviceStatus =
        await Geolocator.isLocationServiceEnabled();
    geoLocationpermission();
  }

  geoLocationpermission() async {
    if (Provider.of<LogisticsBloc>(context, listen: false).serviceStatus) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        print(permission);
      } else if (permission == LocationPermission.denied) {
        print("denied permision");
      } else if (permission == LocationPermission.deniedForever) {
        print("denied forever bro");
      } else {
        setState(() {
          print(permission);
          print("permission dey");
          haspermission = true;
        });
      }
    } else {
      print("gps connection not available");
    }

    getLiveLocation();
  }

  getLiveLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      longitude = position.longitude.toString();
      latitude = position.latitude.toString();
    });
    _getUserId();

    _calculateTotalPrice();
  }

  getList() {
    List xList = [
      imageListx(widget.photo1!),
      imageListx(widget.photo2!),
      imageListx(widget.photo3!),
    ];
    setState(() {
      imageList = xList;
    });
  }

  _createOrder() {
    Provider.of<LogisticsBloc>(context, listen: false)
        .createOrder(
          widget.dispatchType!,
          widget.address!,
          longitude,
          latitude,
          widget.senderName!,
          widget.senderPhone!,
          widget.dropOffAddress!,
          "10",
          "10",
          widget.receiverName!,
          widget.receiverPhone!,
          "",
          "",
          "",
          widget.isInstant!,
          widget.isScheduled!,
          widget.flexibleSchedule!,
          widget.itemQuantity!,
          widget.itemWeight!,
          widget.itemValue!,
          widget.category!,
          widget.subCategory!,
          widget.width!,
          widget.height!,
          widget.description!,
          widget.type!,
          xBal,
          userId,
        )
        .then((value) => outputxx(value));
  }

  outputxx(String responsex) {
    print(responsex);
    var x = jsonDecode(responsex);
    if (x["success"] == true) {
      setState(() {});
      closeAction(context);
      gToast(x["message"]);
      mynextScreen(
          context,
          Payment(
            amount: xBal,
          ));
 
    } else {
      setState(() {});
      closeAction(context);
      toasty(context, x["message"]);
    }
  }

  Widget displayImage(imageListx x) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(right: mqWidth(context, .02)),
        child: Container(
          height: mqHeight(context, .25),
          width: mqWidth(context, .36),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.file(
                File(x.imagename),
                fit: BoxFit.fill,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  _getUserId() async {
    SharedPreferences x = await SharedPreferences.getInstance();
    var xx = x.getInt("id");
    print("xx == $xx");
    setState(() {
      userId = xx!;
    });
  }
}
