import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AccountBloc extends ChangeNotifier {
  String account = "";
  bool isLoading = false;
  bool isHeader = false;
  String status = "";
  String BaseUrl = "https://jqh6xi5wg3.execute-api.us-east-2.amazonaws.com/dev";
  String accept = "Accept";
  String cType = "Content-Type";
  String xAccept = "application/json";
  String xContent = "application/json";
  String signUp = "/api/auth/register";
  String login = "/api/auth/login";

  Future<String> createCustomer(String firstName, String lastName,
      String phoneNumber, String email, String password) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var sessionHeaders = <String, String>{
      HttpHeaders.authorizationHeader: isHeader ? "Bearer $sessionID" : "",
      accept: xAccept,
      cType: xContent,
    };
    try {
      var xData = <String, dynamic>{
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "email": email,
        "password": password
      };
      var url = Uri.parse(BaseUrl + signUp);
      final xResponse = await http.post(url,
          body: jsonEncode(xData), headers: sessionHeaders);
      if (xResponse.statusCode == 200) {
        print(xResponse.body);
        return xResponse.body;
      } else {
        print(xResponse.body);

        return xResponse.body;
      }
    } on SocketException catch (xError) {
      return xError.message;
    }
  }

  Future<String> Logincst(
    String email,
    String password,
  ) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var sessionHeaders = <String, String>{
      HttpHeaders.authorizationHeader: isHeader ? "Bearer $sessionID" : "",
      accept: xAccept,
      cType: xContent,
    };
    try {
      var xData = <String, dynamic>{
        "email": email,
        "password": password,
      };
      var url = Uri.parse(BaseUrl + login);
      final xResponse = await http.post(url,
          body: jsonEncode(xData), headers: sessionHeaders);
      if (xResponse.statusCode == 200) {
        print(xResponse.body);
        return xResponse.body;
      } else {
        print(xResponse.body);
        print(xResponse.statusCode);

        return xResponse.body;
      }
    } on SocketException catch (xError) {
      return xError.message;
    }
  }
}
