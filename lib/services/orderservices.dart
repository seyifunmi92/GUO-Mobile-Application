import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderBloc extends ChangeNotifier {
  bool isHeader = true;
  bool isloading = false;
  String BaseUrl = "https://u4xd2j9nyd.execute-api.us-east-2.amazonaws.com/dev";
  String accept = "Accept";
  String cType = "Content-Type";
  String xContent = "application/json";
  String xAccept = "application/json";

  Future<String> getOrderHistory(int userId) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var sessionHeaders = <String, String>{
      HttpHeaders.authorizationHeader: isHeader ? "Bearer $sessionID" : "",
      accept: xAccept,
      cType: xContent,
    };
    try {
      var url = Uri.parse(BaseUrl + "/api/logistics/users/${userId}/orders");
      print(url);
      final xResponse = await http.get(url, headers: sessionHeaders);
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

  Future<String> getOrderDetails(int orderId) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var sessionHeaders = <String, String>{
      HttpHeaders.authorizationHeader: isHeader ? "Bearer $sessionID" : "",
      accept: xAccept,
      cType: xContent,
    };
    try {
      var url = Uri.parse(BaseUrl + "/api/logistics/orders/${orderId}");
      print(url);
      final xResponse = await http.get(url, headers: sessionHeaders);
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

  Future<String> getOrderDetail2(int orderId) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var sessionHeaders = <String, String>{
      HttpHeaders.authorizationHeader: isHeader ? "Bearer $sessionID" : "",
      accept: xAccept,
      cType: xContent,
    };
    try {
      var url = Uri.parse(BaseUrl + "/api/logistics/orders/${orderId}/details");
      print(url);
      final xResponse = await http.get(url, headers: sessionHeaders);
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
