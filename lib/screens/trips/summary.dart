import 'dart:convert';
import 'dart:math';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/containers/container.dart';
import 'package:guomobile/hooks/dialog/loader.dart';
import 'package:guomobile/hooks/servicehooks/hookservice.dart';
import 'package:guomobile/models/states.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/providers/callfunctions/providerbloc.dart';
import 'package:guomobile/screens/trips/coupon.dart';
import 'package:guomobile/screens/trips/guardian.dart';
import 'package:guomobile/services/accountbloc.dart';
import 'package:guomobile/services/terminalbloc.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../hooks/appbars/appbar.dart';
import '../../hooks/buttons/buttons.dart';
import '../../hooks/formfields/formfields.dart';
import '../../hooks/layout/mediaqueries.dart';
import '../../hooks/text/text.dart';
import '../../models/cars.dart';
import '../../models/fleetdetail.dart';
import '../../models/terminals.dart';

class TripSummary extends StatefulWidget {
  String? price;
  int? id;
  String? depatureState;
  String? destination;
  DateTime? depatureDate;
  int? passengers;
  bool? isLocalTrip;
  bool? isWestCoast;
  TripSummary(
      {this.price,
      this.id,
      this.depatureState,
      this.destination,
      this.depatureDate,
      this.passengers,
      this.isLocalTrip,
      this.isWestCoast});

  @override
  State<TripSummary> createState() => _TripSummaryState();
}

class _TripSummaryState extends State<TripSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: guoAppBar(context, "Summary", showElevation: false),
    );
  }
}
