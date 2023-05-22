import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/dialog/loader.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/hooks/servicehooks/hookservice.dart';
import 'package:guomobile/models/userdata.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/providers/callfunctions/providerbloc.dart';
import 'package:guomobile/screens/charter/bookcharter.dart';
import 'package:guomobile/screens/logistics/bookdispatch.dart';
import 'package:guomobile/screens/logistics/selectdispatch.dart';
import 'package:guomobile/screens/orders/orderdetails.dart';
import 'package:guomobile/screens/trips/childtrip.dart';
import 'package:guomobile/screens/trips/tripbooking.dart';
import 'package:guomobile/services/accountbloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../hooks/text/text.dart';
import '../../asset/imageclass.dart';

class Home extends StatefulWidget {
  String firstName;
  String lastName;
  String status;
  Home(this.firstName, this.lastName, this.status);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String myT = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String name = "Anayo";
  bool showWalkthrough = false;
  bool isloading = false;
  int cstId = 0;
  TextEditingController orderC = TextEditingController();
  final _dt = DateFormat("dd MMMM yyyy hh:mm aaa").format(DateTime.now());
  UserData? xUser;
  @override
  void initState() {
    isloading = true;
    getT();
    getId();
    widget.firstName == "x" ? getName() : null;
    widget.status == "firstinstall" ? showWalkthrough = true : false;
    showWalkthrough
        ? Provider.of<ProviderBloc>(context, listen: false).showTimer(context)
        : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Scaffold(body: Loaderx(ImageClass.loader))
        : Scaffold(
            key: _scaffoldKey,
            appBar: guoLogoAppBarDash(
              context,
              xUser?.data.user.profileImage == null
                  ? ImageClass.download
                  : xUser!.data.user.profileImage,
              "Hello ${widget.firstName} ",
              "What do you want to do today?",
              isCenter: false,
              showElevation: false,
              onT: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
            drawer: guoDrawer(
                context,
                xUser?.data.user.profileImage == null
                    ? ImageClass.download
                    : xUser!.data.user.profileImage,
                widget.firstName,
                asset: xUser?.data.user.profileImage == null ? true : false,
                isguest: widget.firstName == "guest" ? true : false),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sbHeight(mqHeight(context, .02)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          dashContainer(
                            context,
                            mqHeight(context, .055),
                            mqWidth(context, .33),
                            myController: orderC,
                          ),
                          dashSearch(context, () {
                            mynextScreen(
                                context, OrderDetails(int.parse(orderC.text)));
                          }),
                        ],
                      ),
                      sbHeight(mqHeight(context, .02)),
                      dText("Upcoming Trips", mqHeight(context, .019)),
                      sbHeight(mqHeight(context, .02)),
                      dashContainerTrip(context, " Lagos - Enugu", _dt, 438),
                      sbHeight(mqHeight(context, .025)),
                      dText("Things you should do", mqHeight(context, .019)),
                      sbHeight(mqHeight(context, .015)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          dashContainer2(
                              context,
                              showWalkthrough
                                  ? ImageClass.book1
                                  : ImageClass.charter1, onT: () {
                            mynextScreen(context, TripBooking());
                          }),
                          dashContainer2(
                              context,
                              showWalkthrough
                                  ? ImageClass.book2
                                  : ImageClass.charter2,
                              onT: () =>
                                  mynextScreen(context, SelectDispatch())),
                        ],
                      ),
                      sbHeight(mqHeight(context, .01)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          dashContainer2(context, ImageClass.charter3, onT: () {
                            mynextScreen(context, BookCharter());
                          }),
                          dashContainer2(context, ImageClass.charter4, onT: () {
                            mynextScreen(context, ChildTrip());
                          }),
                        ],
                      ),
                    ]),
              ),
            ),
            bottomNavigationBar: bottomNavDash(context, isHome: true),
          );
  }

  getT() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var _token = _shared.getString("token");
    setState(() {
      myT = _token ?? "";
    });
    print(myT);
  }

  getName() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var name = _shared.getString("firstname");
    setState(() {
      widget.firstName = name!;
    });
    print(widget.firstName);
  }

  getId() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var nameId = _shared.getInt("id");
    setState(() {
      cstId = nameId ?? 0;
    });
    print(cstId);
    getCustomerDetails();
  }

  getCustomerDetails() {
    Provider.of<AccountBloc>(context, listen: false)
        .getUser(cstId)
        .then((value) => xdetails(value));
  }

  xdetails(String x) {
    var xData1 = jsonDecode(x);
    if (xData1["status"] == 200) {
      setState(() {
        xUser = UserData.fromJson(xData1);
        isloading = false;
      });
    } else {
      setState(() {
        isloading = false;
        //  xUser = UserData.fromJson(xData1);
      });
    }
  }
}
