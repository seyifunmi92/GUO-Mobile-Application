import 'package:flutter/material.dart';

class AllTerminal {
  AllTerminal({
    required this.success,
    required this.status,
    required this.data,
  });

  bool success;
  int status;
  List<Datum> data;

  factory AllTerminal.fromJson(Map<String, dynamic> json) => AllTerminal(
        success: json["success"],
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.countryId,
    required this.stateId,
    required this.terminal,
    required this.address,
    required this.phoneNumber,
    required this.isInternational,
    required this.imageLink,
    required this.latitude,
    required this.longitude,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int countryId;
  int stateId;
  String terminal;
  String address;
  String phoneNumber;
  bool isInternational;
  String imageLink;
  String latitude;
  String longitude;
  int createdBy;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        countryId: json["countryId"],
        stateId: json["stateId"],
        terminal: json["terminal"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        isInternational: json["isInternational"],
        imageLink: json["imageLink"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "countryId": countryId,
        "stateId": stateId,
        "terminal": terminal,
        "address": address,
        "phoneNumber": phoneNumber,
        "isInternational": isInternational,
        "imageLink": imageLink,
        "latitude": latitude,
        "longitude": longitude,
        "createdBy": createdBy,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Terminalid {
  Terminalid({
    required this.success,
    required this.status,
    required this.data,
    required this.message,
  });

  bool success;
  int status;
  Data data;
  String message;

  factory Terminalid.fromJson(Map<String, dynamic> json) => Terminalid(
        success: json["success"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    required this.id,
    required this.countryId,
    required this.stateId,
    required this.terminal,
    required this.address,
    required this.phoneNumber,
    required this.isInternational,
    required this.imageLink,
    required this.latitude,
    required this.longitude,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int countryId;
  int stateId;
  String terminal;
  String address;
  String phoneNumber;
  bool isInternational;
  String imageLink;
  String latitude;
  String longitude;
  int createdBy;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        countryId: json["countryId"],
        stateId: json["stateId"],
        terminal: json["terminal"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        isInternational: json["isInternational"],
        imageLink: json["imageLink"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "countryId": countryId,
        "stateId": stateId,
        "terminal": terminal,
        "address": address,
        "phoneNumber": phoneNumber,
        "isInternational": isInternational,
        "imageLink": imageLink,
        "latitude": latitude,
        "longitude": longitude,
        "createdBy": createdBy,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
