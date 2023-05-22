import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/containers/container.dart';
import 'package:guomobile/hooks/dialog/loader.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/hooks/servicehooks/hookservice.dart';
import 'package:guomobile/models/terminals.dart';

import 'package:guomobile/services/terminalbloc.dart';
import 'package:provider/provider.dart';

class Nearme extends StatefulWidget {
  const Nearme({super.key});

  @override
  State<Nearme> createState() => _NearmeState();
}

class _NearmeState extends State<Nearme> {
  AllTerminal? xTerminal;
  List<Datum>? xList;
  @override
  void initState() {
    getAllTerminals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: guoAppBar(context, "Terminals Near Me"),
      bottomNavigationBar: bottomNavDash(context, isNearme: true),
      body: xList == null
          ? Loaderx(ImageClass.loader)
          : SingleChildScrollView(
              child: Column(
                  children: [...xList!.map((x) => terminalCustom(context, x))]),
            ),
    );
  }

  getAllTerminals() {
    Provider.of<TerminalBloc>(context, listen: false)
        .getTerminalsNearme()
        .then((value) => tOutput(value));
  }

  tOutput(String xData) {
    var x = jsonDecode(xData);
    print(x);
    x["status"] == 200 ? _success(x) : failed();
  }

  _success(x) {
    List xTList = x["data"];
    setState(() {
      xTerminal = AllTerminal.fromJson(x);
      xList = xTList.map<Datum>((x1) => Datum.fromJson(x1)).toList();
      print(xList![3].longitude);
    });
  }

  failed() {}
}
