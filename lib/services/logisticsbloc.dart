import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LogisticsBloc extends ChangeNotifier {
  bool isHeader = true;
  bool serviceStatus = false;
  bool isloading = false;
  String BaseUrl = "https://u4xd2j9nyd.execute-api.us-east-2.amazonaws.com/dev";
  String accept = "Accept";
  String cType = "Content-Type";
  String xAccept = "application/json";
  String xContent = "application/json";
  String calculateOrder = "/api/logistics/calculate";
  String createOrderResource = "/api/logistics/save-order";
  String categrories = "/api/logistics/categories";
  String subcategrories = "/api/logistics/subcategories";

  Future<String> calculatePrice(
      String address,
      String longitude,
      String latitude,
      String daddress,
      String dLongitude,
      String dLatitude,
      int parcelWeight,
      int category) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var sessionHeaders = <String, String>{
      HttpHeaders.authorizationHeader: isHeader ? "Bearer $sessionID" : "",
      accept: xAccept,
      cType: xContent,
    };
    try {
      var xData = <String, dynamic>{
        "pickUpAddress": {
          "address": address,
          "longitude": longitude,
          "latitude": latitude,
        },
        "dropOffAddress": {
          "address": address,
          "longitude": dLongitude,
          "latitude": dLatitude,
        },
        "parcelWeight": parcelWeight,
        "category": category
      };
      var url = Uri.parse(BaseUrl + calculateOrder);
      final xResponse = await http.post(url,
          body: jsonEncode(xData), headers: sessionHeaders);
      print(jsonEncode(xData));
      print(url);
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

  Future<String> createOrder(
    String dispatchType,
    String address,
    String longitude,
    String latitude,
    String senderName,
    String senderPhoneNumber,
    String daddress,
    String dlongitude,
    String dlatitude,
    String receiverName,
    String receiverPhoneNumber,
    String phone1,
    String phone2,
    String phone3,
    bool isInstant,
    bool isScheduled,
    bool flexibleSchedule,
    int itemQuantity,
    int itemWeight,
    int itemValue,
    int category,
    int subCategory,
    int width,
    int height,
    String description,
    String type,
    int amount,
    int userId,
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
        "dispatchType": dispatchType,
        "pickUpAddress": {
          "address": address,
          "longitude": longitude,
          "latitude": latitude,
        },
        "senderName": senderName,
        "senderPhoneNumber": senderPhoneNumber,
        "dropOffAddress": {
          "address": daddress,
          "longitude": dlongitude,
          "latitude": dlatitude,
        },
        "receiverName": receiverName,
        "receiverPhoneNumber": receiverPhoneNumber,
        "otherPhoneNumber": [phone1, phone2],
        "isInstant": isInstant,
        "isScheduled": isScheduled,
        "flexibleSchedule": flexibleSchedule,
        "itemQuantity": itemQuantity,
        "itemWeight": itemWeight,
        "itemValue": itemValue,
        "category": category,
        "subCategory": subCategory,
        "width": width,
        "height": height,
        "description": description,
        "type": type,
        "amount": amount,
        "userId": userId,
      };
      print(xData);
      var url = Uri.parse(BaseUrl + createOrderResource);
      final xResponse = await http.post(url,
          body: jsonEncode(xData), headers: sessionHeaders);
      print(xData);
      print(url);
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

  Future<String> rateTrip(
    int rating,
    String reviews,
    int orderId,
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
        "rating": rating,
        "reviews": reviews,
      };
      print(xData);
      var url = Uri.parse(BaseUrl + "/api/logistics/orders/${orderId}/rate");
      final xResponse = await http.post(url,
          body: jsonEncode(xData), headers: sessionHeaders);
      print(jsonEncode(xData));
      print(url);
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

  Future<String> getCategories() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var sessionHeaders = <String, String>{
      HttpHeaders.authorizationHeader: isHeader ? "Bearer $sessionID" : "",
      accept: xAccept,
      cType: xContent,
    };
    try {
      var url = Uri.parse(BaseUrl + categrories);
      final xResponse = await http.get(url, headers: sessionHeaders);
      print(url);
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

  Future<String> getCategoriesbyid(int categoryId) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var sessionHeaders = <String, String>{
      HttpHeaders.authorizationHeader: isHeader ? "Bearer $sessionID" : "",
      accept: xAccept,
      cType: xContent,
    };
    try {
      var url = Uri.parse(
          BaseUrl + "/api/logistics/categories/${categoryId}/subcategories");
      final xResponse = await http.get(url, headers: sessionHeaders);
      print(url);
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

  Future<String> getSubCategories() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var sessionHeaders = <String, String>{
      HttpHeaders.authorizationHeader: isHeader ? "Bearer $sessionID" : "",
      accept: xAccept,
      cType: xContent,
    };
    try {
      var url = Uri.parse(BaseUrl + subcategrories);
      final xResponse = await http.get(url, headers: sessionHeaders);
      print(url);
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
