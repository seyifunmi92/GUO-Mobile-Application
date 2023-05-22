

import 'dart:convert';

FleetDetails fleetDetailsFromJson(String str) =>
    FleetDetails.fromJson(json.decode(str));

String fleetDetailsToJson(FleetDetails data) => json.encode(data.toJson());

class FleetDetails {
  FleetDetails({
    this.success,
    this.status,
    this.data,
    this.message,
  });

  bool? success;
  int? status;
  Data? data;
  String? message;

  factory FleetDetails.fromJson(Map<String, dynamic> json) => FleetDetails(
        success: json["success"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "data": data!.toJson(),
        "message": message,
      };
}

class Data {
  Data({
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

  dynamic imagesArray;
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        imagesArray: json["imagesArray"],
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
        "imagesArray": imagesArray,
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
