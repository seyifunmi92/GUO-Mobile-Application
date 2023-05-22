import 'package:flutter/material.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/providers/callfunctions/providerbloc.dart';
import 'package:guomobile/screens/auth/login/login.dart';
import 'package:guomobile/screens/onboarding/onboarding.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageBloc extends ChangeNotifier {
  bool firstInstall = true;
  String sessionToken = "";

  setToken(String value) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var _token = _shared.setString("token", value);
    _token;
    notifyListeners();
  }

  removeToken(String value) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    _shared.clear();
  }

  setFirstname(String value) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var firstname = _shared.setString("firstname", value);
    firstname;
    notifyListeners();
  }

  setCustomerId(int value) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var id = _shared.setInt("id", value);
    id;
    notifyListeners();
  }

  getEmail(String value) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var email = _shared.setString("email", value);
    email;
    notifyListeners();
  }

  getLastname(String value) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var lastName = _shared.setString("lastname", value);
    lastName;
    notifyListeners();
  }

  getPhone(String? value) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var phone = _shared.setString("phone", value!);
    phone;
    notifyListeners();
  }

  setBool(String key, bool value) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    _shared.setBool(key, value);
  }

  removeBool(String value) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    _shared.remove(value);
  }

  pushNotificationSettings(bool value) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var pushnotificationStatus = _shared.setBool("pushNotifications", value);
    pushnotificationStatus;
    notifyListeners();
  }

  emailNotificationSettings(bool value) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var emailnotificationStatus = _shared.setBool("emailNotifications", value);
    emailnotificationStatus;
    notifyListeners();
  }

  refreshapp() {
    removeBool("firstInstall");
    removeToken("token");
  }

  getStatus(BuildContext context) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? _token = _shared.getString("token");
    bool? status = _shared.getBool("firstInstall");
    print(_token);
    print(status);
    _token == null && status == null
        ? setFirstLaunch(context)
        : _token != null && status == false
            ? returningUser(context)
            : _token == null && status == false
                ? noLogUser(context)
                : mynextScreen(context, Onboarding());
  }

  setFirstLaunch(BuildContext context) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    var status = _shared.setBool("firstInstall", false);
    Provider.of<ProviderBloc>(context, listen: false).onChangeNext(context);
    return status;
  }

  returningUser(BuildContext context) {
    mynextScreen(context, Login());
  }

  noLogUser(BuildContext context) {
    mynextScreen(context, Login());
  }
}
