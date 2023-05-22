import 'package:flutter/material.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/hooks/servicehooks/hookservice.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/logistics/bookdispatch.dart';

import '../../asset/imageclass.dart';

class SelectDispatch extends StatefulWidget {
  const SelectDispatch({super.key});

  @override
  State<SelectDispatch> createState() => _SelectDispatchState();
}

class _SelectDispatchState extends State<SelectDispatch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: guoAppBar(context, "Book Dispatch"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Column(children: [
          sbHeight(mqHeight(context, .02)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dashContainer2(context, ImageClass.cargo),
              dashContainer2(
                context,
                ImageClass.parcel,
                onT: () => mynextScreen(context, BookDispatch()),
              ),
            ],
          ),
          sbHeight(mqHeight(context, .02)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dashContainer2(context, ImageClass.ecommerce),
              dashContainer2(context, ImageClass.haulage),
            ],
          ),
        ]),
      ),
    );
  }
}
