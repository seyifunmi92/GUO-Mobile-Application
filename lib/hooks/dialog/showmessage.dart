import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

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
