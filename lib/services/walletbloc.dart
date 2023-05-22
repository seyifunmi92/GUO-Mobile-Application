import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class WalletBloc extends ChangeNotifier {
  bool isHeader = true;
  bool isLoading = false;
  String BaseUrl = "https://jqh6xi5wg3.execute-api.us-east-2.amazonaws.com/dev";
  String accept = "Accept";
  String cType = "Content-Type";
  String xAccept = "application/json";
  String xContent = "application/json";

  Future<String> walletBalance(int customerId) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var sessionHeaders = <String, String>{
      HttpHeaders.authorizationHeader: isHeader ? "Bearer $sessionID" : "",
      accept: xAccept,
      cType: xContent,
    };
    try {
      var url =
          Uri.parse(BaseUrl + "/api/auth/wallet/get-balance/${customerId}");
      final xResponse = await http.get(url, headers: sessionHeaders);
      print(url);
      print(sessionHeaders);
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

  Future<String> debitWallet(
      double amount, String service, String transactionId) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var sessionHeaders = <String, String>{
      HttpHeaders.authorizationHeader: isHeader ? "Bearer $sessionID" : "",
      accept: xAccept,
      cType: xContent,
    };
    try {
      var xData = <String, dynamic>{
        "amount": amount,
        "service": service,
        "transactionId": transactionId,
      };
      print(xData);

      var url = Uri.parse(BaseUrl + "/api/auth//wallet/debit-wallet");
      final xResponse = await http.post(url,
          body: jsonEncode(xData), headers: sessionHeaders);
      print(url);
      print(sessionHeaders);
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
