import 'package:guomobile/hooks/text/text.dart';

import '../asset/imageclass.dart';

class ObSlider {
  String image1;
  String image2;

  ObSlider(this.image1, this.image2);
}

List slider = [
  ObSlider(ImageClass.ob1, ImageClass.ob2),
  ObSlider(ImageClass.ob5, ImageClass.ob3),
  ObSlider(ImageClass.ob6, ImageClass.ob4),
];

class ObText {
  String title;
  String subTitle;

  ObText(this.title, this.subTitle);
}

List myText = [
  ObText(GuoText.ob1, GuoText.ob4),
  ObText(GuoText.ob2, GuoText.ob5),
  ObText(GuoText.ob3, GuoText.ob6),
];

class Signup {
  Signup({
    required this.success,
    required this.status,
    required this.data,
    required this.message,
  });

  bool success;
  int status;
  Data data;
  String message;

  factory Signup.fromJson(Map<String, dynamic> json) => Signup(
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

  String user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
      };
}

class Loginmodel {
  Loginmodel({
    required this.success,
    required this.status,
    required this.data,
    required this.message,
  });

  bool success;
  int status;
  Datax data;
  String message;

  factory Loginmodel.fromJson(Map<String, dynamic> json) => Loginmodel(
        success: json["success"],
        status: json["status"],
        data: Datax.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "data": data.toJson(),
        "message": message,
      };
}

class Datax {
  Datax({
    required this.user,
    required this.walletBallance,
    required this.role,
    required this.accessToken,
  });

  User user;
  String walletBallance;
  String role;
  String accessToken;

  factory Datax.fromJson(Map<String, dynamic> json) => Datax(
        user: User.fromJson(json["user"]),
        walletBallance: json["walletBallance"],
        role: json["role"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "walletBallance": walletBallance,
        "role": role,
        "accessToken": accessToken,
      };
}

class User {
  User({
    this.topDestinations,
     this.id,
     this.firstName,
     this.lastName,
     this.email,
     this.phoneNumber,
    this.address,
    this.dob,
     this.roleId,
    this.profileImage,
    this.referralCode,
    this.referredBy,
    this.nextOfKin,
    this.nextOfKinNumber,
    this.totalReferred,
    this.loyaltyPoints,
     this.isVerified,
     this.status,
     this.token,
    this.tokenExpire,
     this.createdAt,
     this.updatedAt,
    this.deletedAt,
  });

  dynamic topDestinations;
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  dynamic phoneNumber;
  dynamic address;
  dynamic dob;
  int? roleId;
  dynamic profileImage;
  String? referralCode;
  dynamic referredBy;
  dynamic nextOfKin;
  dynamic nextOfKinNumber;
  dynamic totalReferred;
  dynamic loyaltyPoints;
  bool? isVerified;
  String? status;
  String? token;
  dynamic tokenExpire;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        topDestinations: json["topDestinations"],
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        dob: json["dob"],
        roleId: json["roleId"],
        profileImage: json["profileImage"],
        referralCode: json["referralCode"],
        referredBy: json["referredBy"],
        nextOfKin: json["nextOfKin"],
        nextOfKinNumber: json["nextOfKinNumber"],
        totalReferred: json["totalReferred"],
        loyaltyPoints: json["loyaltyPoints"],
        isVerified: json["isVerified"],
        status: json["status"],
        token: json["token"],
        tokenExpire: json["tokenExpire"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
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
        "tokenExpire": tokenExpire,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
