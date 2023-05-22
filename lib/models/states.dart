// To parse this JSON data, do
//
//     final stateList = stateListFromJson(jsonString);

import 'dart:convert';

StateList stateListFromJson(String str) => StateList.fromJson(json.decode(str));

String stateListToJson(StateList data) => json.encode(data.toJson());

class StateList {
    StateList({
        required this.success,
        required this.status,
        required this.data,
        required this.message,
    });

    bool success;
    int status;
    List<Datumx> data;
    String message;

    factory StateList.fromJson(Map<String, dynamic> json) => StateList(
        success: json["success"],
        status: json["status"],
        data: List<Datumx>.from(json["data"].map((x) => Datumx.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class Datumx {
    Datumx({
        required this.id,
        required this.countryId,
        required this.name,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    int countryId;
    String name;
    DateTime createdAt;
    DateTime updatedAt;

    factory Datumx.fromJson(Map<String, dynamic> json) => Datumx(
        id: json["id"],
        countryId: json["countryId"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "countryId": countryId,
        "name": name,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
