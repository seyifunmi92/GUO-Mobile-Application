import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/dialog/loader.dart';
import 'package:guomobile/hooks/servicehooks/hookservice.dart';
import 'package:guomobile/services/accountbloc.dart';
import 'package:guomobile/services/terminalbloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../hooks/appbars/appbar.dart';
import '../../hooks/layout/mediaqueries.dart';
import '../../hooks/text/text.dart';

class Trips extends StatefulWidget {
  const Trips({super.key});

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  bool emptyList = false;
  @override
  void initState() {
    Provider.of<AccountBloc>(context, listen: false).isLoading = true;
    _getCustId();
    super.initState();
  }

  int cid = 0;
  bool upcomingSelected = true;
  bool pastSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: guocolor.white,
      appBar: guoAppBar(context, "My Trips"),
      bottomNavigationBar: bottomNavDash(context, isTrips: true),
      body: Provider.of<AccountBloc>(context, listen: false).isLoading
          ? Loaderx(ImageClass.loader)
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
              child: Column(
                children: [
                  sbHeight(mqHeight(context, .02)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => setState(() {
                          upcomingSelected = true;
                          pastSelected = false;
                          //  xEmail.clear();
                        }),
                        child: dText("Upcoming Trips", mqHeight(context, .02),
                            color: upcomingSelected
                                ? guocolor.primaryColor
                                : const Color(0xff8C8C95)),
                      ),
                      InkWell(
                        onTap: () => setState(() {
                          pastSelected = true;
                          upcomingSelected = false;
                        }),
                        child: dText("Past Trips", mqHeight(context, .02),
                            color: upcomingSelected
                                ? const Color(0xff8C8C95)
                                : guocolor.primaryColor),
                      ),
                    ],
                  ),
                  sbHeight(mqHeight(context, .008)),
                  Stack(children: [
                    const Divider(
                      color: Color(0xff8C8C95),
                    ),
                    Positioned(
                      top: 4,
                      left: upcomingSelected
                          ? 0
                          : MediaQuery.of(context).size.width / 2.3,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 7,
                        color: guocolor.primaryColor,
                      ),
                    )
                  ]),
                  sbHeight(mqHeight(context, .02)),
                  emptyList ? empty() : dText("text", 0),
                ],
              ),
            ),
    );
  }

  Widget empty() {
    return Column(
      children: [
        sbHeight(mqHeight(context, .08)),
        Image.asset(ImageClass.error),
        sbHeight(mqHeight(context, .05)),
        dText("No trips at the moment", mqHeight(context, .028)),
      ],
    );
  }

  _getCustId() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var x = _shared.getInt("id");
    setState(() {
      cid = x!;
    });
    print(cid);
    gettrips();
  }

  gettrips() {
    Provider.of<TerminalBloc>(context, listen: false)
        .getmytriphistory(cid)
        .then((value) => xtrips(value));
  }

  xtrips(String x) {
    var bodyT = jsonDecode(x);
    if (bodyT["status"] == 200) {
      List tripx = bodyT["data"];
      if (tripx.isEmpty) {
        print("empty list bro");
        setState(() {
          emptyList = true;
          Provider.of<AccountBloc>(context, listen: false).isLoading = false;
        });
      } else {}
    }
  }
}
