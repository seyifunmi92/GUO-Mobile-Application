import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TerminalBloc extends ChangeNotifier {
  bool isHeader = true;
  bool isloading = false;
  String BaseUrl = "https://c97krsi296.execute-api.us-east-2.amazonaws.com/dev";
  String accept = "Accept";
  String cType = "Content-Type";
  String xAccept = "application/json";
  String xContent = "application/json";
  String getTerminals = "/api/transport/terminals";
  String states = "/api/transport/states";
  String fleets = "/api/transport/fleets";
  String minorBooking = "/api/transport/trips/minor-booking";
  String negotiateCharter = "/api/transport/charter/negotiate";

  Future<String> getTerminalsNearme() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var sessionHeaders = <String, String>{
      HttpHeaders.authorizationHeader: isHeader ? "Bearer $sessionID" : "",
      accept: xAccept,
      cType: xContent,
    };
    try {
      var url = Uri.parse(BaseUrl + getTerminals);
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

  Future<String> getTerminalsNearmebyId(int id) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var sessionHeaders = <String, String>{
      HttpHeaders.authorizationHeader: isHeader ? "Bearer $sessionID" : "",
      accept: xAccept,
      cType: xContent,
    };
    try {
      var url = Uri.parse(BaseUrl + "/api/transport/terminals/${id}");
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

  Future<String> getmytriphistory(int id) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var sessionHeaders = <String, String>{
      HttpHeaders.authorizationHeader: isHeader ? "Bearer $sessionID" : "",
      accept: xAccept,
      cType: xContent,
    };
    try {
      var url = Uri.parse(BaseUrl + "/api/transport/trips/${id}");
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

  Future<String> getStates() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var sessionHeaders = <String, String>{
      HttpHeaders.authorizationHeader: isHeader ? "Bearer $sessionID" : "",
      accept: xAccept,
      cType: xContent,
    };
    try {
      var url = Uri.parse(BaseUrl + states);
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

  Future<String> getFleets() async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var sessionHeaders = <String, String>{
      HttpHeaders.authorizationHeader: isHeader ? "Bearer $sessionID" : "",
      accept: xAccept,
      cType: xContent,
    };
    try {
      var url = Uri.parse(BaseUrl + fleets);
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

  Future<String> getSingleFleet(int id) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var sessionHeaders = <String, String>{
      HttpHeaders.authorizationHeader: isHeader ? "Bearer $sessionID" : "",
      accept: xAccept,
      cType: xContent,
    };
    try {
      var url = Uri.parse(BaseUrl + "/api/transport/fleets/${id}");
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

  Future<String> minorTrip(
    int vehicleId,
    int departureStateId,
    int terminalId,
    int destinationId,
    bool isRoundTrip,
    String bookingType,
    DateTime depatureDate,
    String guardianName,
    String guardianEmail,
    String guardianPhoneNumber,
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
        "vehicleId": vehicleId,
        "departureStateId": departureStateId,
        "terminalId": terminalId,
        "destinationId": departureStateId,
        "isRoundTrip": isRoundTrip,
        "bookingType": bookingType,
        "departureDate": depatureDate.toIso8601String(),
        "guardianName": guardianName,
        "guardianEmail": guardianEmail,
        "guardianPhoneNumber": guardianPhoneNumber,
      };

      var url = Uri.parse(BaseUrl + minorBooking);
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

  Future<String> requestCharter(
    int vehicleId,
    String startDate,
    String endDate,
    int passengers,
    String firstName,
    String lastName,
    String email,
    String message,
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
        "vehicleId": vehicleId,
        "startDate": startDate,
        "endDate": endDate,
        "passengers": passengers,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "message": message,
      };

      var url = Uri.parse(BaseUrl + negotiateCharter);
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
