

import 'dart:convert';



class CategorybyId {
    CategorybyId({
        required this.success,
        required this.status,
        required this.data,
        required this.message,
    });

    bool success;
    int status;
    Data data;
    String message;

    factory CategorybyId.fromJson(Map<String, dynamic> json) => CategorybyId(
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
        required this.name,
        required this.categoryId,
        required this.description,
        required this.estimatedAmountPerKg,
        required this.createdBy,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String name;
    int categoryId;
    String description;
    String estimatedAmountPerKg;
    int createdBy;
    DateTime createdAt;
    DateTime updatedAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        categoryId: json["categoryId"],
        description: json["description"],
        estimatedAmountPerKg: json["estimatedAmountPerKg"],
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "categoryId": categoryId,
        "description": description,
        "estimatedAmountPerKg": estimatedAmountPerKg,
        "createdBy": createdBy,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
