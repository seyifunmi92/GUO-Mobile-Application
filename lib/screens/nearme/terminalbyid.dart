import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/containers/container.dart';
import 'package:guomobile/hooks/dialog/loader.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/hooks/servicehooks/hookservice.dart';
import 'package:guomobile/hooks/text/text.dart';
import 'package:guomobile/models/terminals.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/services/terminalbloc.dart';
import 'package:provider/provider.dart';

import '../../asset/imageclass.dart';

class TerminalDetails extends StatefulWidget {
  int id;
  TerminalDetails(this.id);

  @override
  State<TerminalDetails> createState() => _TerminalDetailsState();
}

class _TerminalDetailsState extends State<TerminalDetails> {
  Terminalid? xId;
  @override
  void initState() {
    getTbyId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: xId == null
          ? Loaderx(ImageClass.loader)
          : Stack(
              children: [
                Container(
                    height: mqHeight(context, .4),
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            xId!.data.imageLink,
                            fit: BoxFit.fitWidth,
                            colorBlendMode: BlendMode.darken,
                          ),
                        ),
                        Scaffold(
                          backgroundColor: Colors.black54,
                        )
                      ],
                    )),
                Scaffold(
                  backgroundColor: guocolor.transparent,
                  body: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sbHeight(mqHeight(context, .05)),
                          CircleAvatar(
                            backgroundColor: guocolor.transparent,
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  finishContext(context);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: guocolor.black,
                                ),
                              ),
                            ),
                          ),
                          sbHeight(mqHeight(context, .18)),
                          dText(xId!.data.terminal, mqHeight(context, .023),
                              color: guocolor.white,
                              fontweight: FontWeight.w700),
                          sbHeight(mqHeight(context, .01)),
                          dText(xId!.data.address, mqHeight(context, .02),
                              color: guocolor.white.withOpacity(.9),
                              fontweight: FontWeight.w600),
                          sbHeight(mqHeight(context, .08)),
                          dText("Things you should do", mqHeight(context, .023),
                              color: guocolor.black.withOpacity(1)),
                          sbHeight(mqHeight(context, .02)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              dashContainer2(context, ImageClass.book1),
                              dashContainer2(context, ImageClass.book2),
                            ],
                          )
                        ]),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: bottomNavDash(context, isNearme: true),
    );
  }

  getTbyId() {
    Provider.of<TerminalBloc>(context, listen: false)
        .getTerminalsNearmebyId(widget.id)
        .then((value) => output(value));
  }

  output(String x) {
    print(x);

    var bodyT = jsonDecode(x);
    bodyT["status"] == 200 ? success(bodyT) : fail();
  }

  success(dynamic bodyT) {
    setState(() {
      xId = Terminalid.fromJson(bodyT);
    });
  }

  fail() {}
}
