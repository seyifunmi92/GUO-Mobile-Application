import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  String reset = "/api/auth/reset-password";
  String resendReset = "/api/auth/resend-reset-password";
  String updatePassword = "/api/auth/update-password";
  String validateTok = "/api/auth/validate-reset-password";
  String changePasss = "/api/auth/user/update-password";
  String userupdate = "/api/auth/user/update";

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
    String phoneNumber,
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
        "phoneNumber": phoneNumber,
        "password": password,
      };
      var url = Uri.parse(BaseUrl + login);
      print(email);
      print(phoneNumber);
      print(password);
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

  Future<String> resetPassword(
    String email,
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
      };
      var url = Uri.parse(BaseUrl + reset);
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

  Future<String> uploadImage(
    XFile profileImage,
    int id,
  ) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var sessionHeaders = <String, String>{
      HttpHeaders.authorizationHeader: "Bearer $sessionID",
      accept: xAccept,
      cType: xContent,
    };
    try {
      var xData = <String, dynamic>{
        "profileimage": profileImage,
      };
      var url = Uri.parse(BaseUrl + "/api/auth/user/profile-image/${id}");
      print(url);
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

  Future<String> updateData(
    String firstName,
    String lastName,
    String phoneNumber,
    String email,
  ) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var sessionHeaders = <String, String>{
      HttpHeaders.authorizationHeader: "Bearer $sessionID",
      accept: xAccept,
      cType: xContent,
    };
    try {
      var xData = <String, dynamic>{
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "email": email,
      };
      var url = Uri.parse(BaseUrl + userupdate);
      print(url);
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

  Future<String> changeuserPassword(
    String email,
    String oldPassword,
    String password,
  ) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var sessionHeaders = <String, String>{
      HttpHeaders.authorizationHeader: "Bearer $sessionID",
      accept: xAccept,
      cType: xContent,
    };
    try {
      var xData = <String, dynamic>{
        "email": email,
        "oldPassword": oldPassword,
        "password": password,
      };
      print(sessionHeaders);
      var url = Uri.parse(BaseUrl + changePasss);
      final xResponse = await http.post(url,
          body: jsonEncode(xData), headers: sessionHeaders);
      print(xData);
      print(url);
      print(jsonEncode(xData));
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

  Future<String> resendresetPassword(
    String email,
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
      };
      var url = Uri.parse(BaseUrl + resendReset);
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

  Future<String> validteToken(
    String token,
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
        "token": token,
      };
      var url = Uri.parse(BaseUrl + validateTok);
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

  Future<String> changePassword(
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
      var url = Uri.parse(BaseUrl + updatePassword);
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

  Future<String> mpath(int id, String path) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var url = Uri.parse(BaseUrl + "/api/auth/user/profile-image/${id}");
    var req = http.MultipartRequest("POST", url);
    print(url);
    req.headers.addAll({HttpHeaders.authorizationHeader: "Bearer $sessionID"});
    req.files.add(await http.MultipartFile.fromPath("profileImage", path));
    var response = await req.send();
    var xResponse = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      print(xResponse.body);
      return xResponse.body;
    } else {
      print(xResponse.body);

      return xResponse.body;
    }
  }

 

  Future<String> getUser(int id) async {
    SharedPreferences _shared = await SharedPreferences.getInstance();
    String? sessionID = _shared.getString("token");
    var sessionHeaders = <String, String>{
      HttpHeaders.authorizationHeader: "Bearer $sessionID",
      accept: xAccept,
      cType: xContent,
    };
    try {
      var url = Uri.parse(BaseUrl + "/api/auth/user/${id}");
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
