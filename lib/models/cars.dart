// To parse this JSON data, do
//
//     final allFleets = allFleetsFromJson(jsonString);

import 'dart:convert';

AllFleets allFleetsFromJson(String str) => AllFleets.fromJson(json.decode(str));

String allFleetsToJson(AllFleets data) => json.encode(data.toJson());

class AllFleets {
  AllFleets({
    this.success,
    this.status,
    this.data,
    this.message,
  });

  bool? success;
  int? status;
  List<Datumxx>? data;
  String? message;

  factory AllFleets.fromJson(Map<String, dynamic> json) => AllFleets(
        success: json["success"],
        status: json["status"],
        data: List<Datumxx>.from(json["data"].map((x) => Datumxx.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Datumxx {
  Datumxx({
    this.imagesArray,
    this.id,
    this.name,
    this.description,
    this.price,
    this.seats,
    this.negotiable,
    this.airConditioned,
    this.imageLink,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  List<String>? imagesArray;
  int? id;
  String? name;
  String? description;
  String? price;
  int? seats;
  bool? negotiable;
  bool? airConditioned;
  String? imageLink;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datumxx.fromJson(Map<String, dynamic> json) => Datumxx(
        imagesArray: json["imagesArray"] == null
            ? []
            : List<String>.from(json["imagesArray"].map((x) => x)),
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        seats: json["seats"],
        negotiable: json["negotiable"],
        airConditioned: json["airConditioned"],
        imageLink: json["imageLink"],
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "imagesArray": List<dynamic>.from(imagesArray!.map((x) => x)),
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "seats": seats,
        "negotiable": negotiable,
        "airConditioned": airConditioned,
        "imageLink": imageLink,
        "createdBy": createdBy,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
