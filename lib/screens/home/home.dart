import 'package:flutter/material.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/hooks/servicehooks/hookservice.dart';
import 'package:intl/intl.dart';
import '../../../hooks/text/text.dart';
import '../../asset/imageclass.dart';

class Home extends StatefulWidget {
  String firstName;
  String lastName;
  Home(this.firstName, this.lastName);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String name = "Anayo";
  final _dt = DateFormat("dd MMMM yyyy hh:mm aaa").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: guoLogoAppBarDash(context, "Hello ${widget.firstName} ",
          "What do you want to do today?",
          isCenter: false, showElevation: false, onT: () {
        _scaffoldKey.currentState!.openDrawer();
      }),
      drawer: guoDrawer(context, ImageClass.anayo, widget.firstName),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            sbHeight(mqHeight(context, .02)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dashContainer(
                    context, mqHeight(context, .055), mqWidth(context, .33)),
                dashSearch(context, () {})
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
                dashContainer2(context, ImageClass.charter1),
                dashContainer2(context, ImageClass.charter2),
              ],
            ),
            sbHeight(mqHeight(context, .01)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dashContainer2(context, ImageClass.charter3),
                dashContainer2(context, ImageClass.charter4),
              ],
            ),
          ]),
        ),
      ),
      bottomNavigationBar: bottomNavDash(
          context,
          () {},
          "Home",
          "Wallet",
          "Near Me",
          "My Trips",
          "Orders",
          ImageClass.icons1,
          ImageClass.icons2,
          ImageClass.icons4,
          ImageClass.icon2,
          ImageClass.icons3),
    );
  }
}
