import 'dart:convert';

class CategoriesList {
  CategoriesList({
    required this.success,
    required this.status,
    required this.data,
    required this.message,
  });

  bool success;
  int status;
  List<Datum> data;
  String message;

  factory CategoriesList.fromJson(Map<String, dynamic> json) => CategoriesList(
        success: json["success"],
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.description,
    required this.estimatedAmountPerKg,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String description;
  String estimatedAmountPerKg;
  int createdBy;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        description: json["description"] ?? "",
        estimatedAmountPerKg: json["estimatedAmountPerKg"] ?? "",
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "estimatedAmountPerKg": estimatedAmountPerKg,
        "createdBy": createdBy,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
