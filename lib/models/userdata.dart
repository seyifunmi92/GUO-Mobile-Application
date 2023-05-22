import 'dart:convert';
import 'package:guomobile/asset/imageclass.dart';

class UserData {
  UserData({
    required this.success,
    required this.status,
    required this.data,
    required this.message,
  });

  bool success;
  int status;
  Data data;
  String message;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
    required this.user,
  });

  User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}

class User {
  User({
    this.topDestinations,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.address,
    this.dob,
    required this.roleId,
    required this.profileImage,
    required this.referralCode,
    this.referredBy,
    this.nextOfKin,
    this.nextOfKinNumber,
    this.totalReferred,
    this.loyaltyPoints,
    required this.isVerified,
    required this.status,
    required this.token,
    required this.tokenExpire,
    required this.createdAt,
    required this.updatedAt,
  });
//   {
//     "vehicleId": 1,
//     "departureStateId": 25,
//     "terminalId": 1,
//     "destinationId": 5,
//     "isRoundTrip": false,
//     "guardianName": "John Doe",
//     "guardianEmail": "stephen@nerdbug.io",
//     "guardianPhoneNumber": "09092373298"
// }

//endpoint to get car type

  dynamic topDestinations;
  int id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  dynamic address;
  dynamic dob;
  int roleId;
  String profileImage;
  String referralCode;
  dynamic referredBy;
  dynamic nextOfKin;
  dynamic nextOfKinNumber;
  dynamic totalReferred;
  dynamic loyaltyPoints;
  bool isVerified;
  String status;
  String token;
  DateTime tokenExpire;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        topDestinations: json["topDestinations"],
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"] ?? "",
        address: json["address"],
        dob: json["dob"],
        roleId: json["roleId"],
        profileImage: json["profileImage"] == null
            ? ImageClass.loader
            : json["profileImage"],
        referralCode: json["referralCode"] ?? "",
        referredBy: json["referredBy"] ?? "",
        nextOfKin: json["nextOfKin"],
        nextOfKinNumber: json["nextOfKinNumber"],
        totalReferred: json["totalReferred"],
        loyaltyPoints: json["loyaltyPoints"],
        isVerified: json["isVerified"],
        status: json["status"] == null ? "" : json["status"],
        token: json["token"] ?? "",
        tokenExpire: json["tokenExpire"] == null
            ? DateTime.now()
            : DateTime.parse(json["tokenExpire"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "topDestinations": topDestinations,
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "address": address,
        "dob": dob,
        "roleId": roleId,
        "profileImage": profileImage,
        "referralCode": referralCode,
        "referredBy": referredBy,
        "nextOfKin": nextOfKin,
        "nextOfKinNumber": nextOfKinNumber,
        "totalReferred": totalReferred,
        "loyaltyPoints": loyaltyPoints,
        "isVerified": isVerified,
        "status": status,
        "token": token,
        "tokenExpire": tokenExpire.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
