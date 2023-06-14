import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/text/text.dart';
import 'package:nb_utils/nb_utils.dart';

import '../layout/mediaqueries.dart';

gToast(String val,
    {ToastGravity? gravity,
    bool isLong = true,
    Color? bgcolor,
    Color? textColor,
    bool print = false}) {
  val.validate().isEmpty || isLinux
      ? log(val)
      : Fluttertoast.showToast(
          msg: val.validate(),
          gravity: gravity,
          toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
          backgroundColor: bgcolor,
          textColor: textColor,
        );
  if (print) log(val);
}

guoAlert(BuildContext context, String responseText,
    {bool editor = false, String? editedtext, Color? color = guocolor.red}) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: dText(responseText, mqHeight(context, .019),
          fontweight: FontWeight.w400),
      actions: [
        CupertinoDialogAction(
          child: dText(editor ? editedtext! : "Close", mqHeight(context, .019),
              color: color),
          onPressed: () {
            finish(context);
          },
        ),
      ],
    ),
  );
}
