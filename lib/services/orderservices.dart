import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
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

  Future<String> flutterwavePaymentHandler(
    BuildContext context, {
    String? fullname,
    String? phoneNumber,
    String? email,
    int? amount,
    String? encryptionKey,
    String? publicKey,
    String? paymentOptions,
    String? currency,
    String? txRef,
    String? title,
    String? description,
    String? redirectUrl,
    bool? isTestMode,
  }) async {
    try {
      Customer x =
          Customer(email: email!, name: fullname, phoneNumber: phoneNumber);
      Customization y = Customization(title: title, description: description);

      Flutterwave xx = Flutterwave(
        context: context,
        publicKey: publicKey!,
        txRef: txRef!,
        amount: amount.toString(),
        customer: x,
        paymentOptions: paymentOptions!,
        customization: y,
        redirectUrl: redirectUrl!,
        isTestMode: isTestMode!,
        currency: currency!,
      );
      final ChargeResponse xResponse = await xx.charge();

      if (xResponse.success = true) {
        var xData = <String, dynamic>{
          "status": xResponse.status,
          "success": xResponse.success,
          "transactionId": xResponse.transactionId,
          "transactionReference": xResponse.txRef,
        };
        var xenconde = jsonEncode(xData);
        print("bababa");
        return xenconde;
      } else {
        print("bababa");
        return xResponse.status.toString();
      }
    } on SocketException catch (error) {
      print(error);
      print("bababa");

      return error.message;
    }
  }
}
