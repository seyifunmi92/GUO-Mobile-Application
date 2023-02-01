import 'package:flutter/material.dart';

class ValidationBloc extends ChangeNotifier {
  List data = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  bool checkComplete = false;
  bool validFirstname = true;
  bool validLastName = true;
  bool validEmail = true;
  bool validPhone = true;
  bool validPassword = true;
  String phoneValidation = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  String emailValidation =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  String regexPassword = r'^[a-zA-Z0-9]+$';
  bool showPass = false;

  hideKey(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
