

import 'dart:convert';

Od odFromJson(String str) => Od.fromJson(json.decode(str));

String odToJson(Od data) => json.encode(data.toJson());

class Od {
  Od({
    required this.success,
    required this.status,
    required this.data,
    required this.message,
  });

  bool success;
  int status;
  Data data;
  String message;

  factory Od.fromJson(Map<String, dynamic> json) => Od(
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
    required this.order,
    this.rider,
    required this.bookingFee,
    required this.additionalFee,
    required this.totalDistance,
    required this.subTotal,
  });

  Order order;
  Rider? rider;
  String bookingFee;
  String additionalFee;
  String totalDistance;
  String subTotal;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        order: Order.fromJson(json["order"]),
        rider: Rider.fromJson(json["rider"]),
        bookingFee: json["bookingFee"],
        additionalFee: json["additionalFee"],
        totalDistance: json["totalDistance"],
        subTotal: json["subTotal"],
      );

  Map<String, dynamic> toJson() => {
        "order": order.toJson(),
        "rider": rider!.toJson(),
        "bookingFee": bookingFee,
        "additionalFee": additionalFee,
        "totalDistance": totalDistance,
        "subTotal": subTotal,
      };
}

class Order {
  Order({
    required this.pickUpAddress,
    required this.dropOffAddress,
    required this.otherPhoneNumber,
    required this.type,
    required this.status,
    required this.id,
    required this.trackingId,
    required this.dispatchType,
    required this.senderName,
    required this.senderPhoneNumber,
    required this.receiverName,
    required this.receiverPhoneNumber,
    required this.driverId,
    required this.isInstant,
    required this.isScheduled,
    required this.flexibleSchedule,
    required this.itemQuantity,
    required this.itemWeight,
    required this.itemValue,
    required this.amount,
    required this.category,
    required this.subCategory,
    required this.width,
    required this.height,
    required this.description,
    this.pickUpDate,
    this.images,
    required this.userId,
    this.paymentId,
    this.reviews,
    this.rating,
    required this.createdBy,
    required this.isViewed,
    required this.createdAt,
    required this.updatedAt,
  });

  Address pickUpAddress;
  Address dropOffAddress;
  List<String> otherPhoneNumber;
  String type;
  List<Status> status;
  int id;
  String trackingId;
  String dispatchType;
  String senderName;
  String senderPhoneNumber;
  String receiverName;
  String receiverPhoneNumber;
  int? driverId;
  bool isInstant;
  bool isScheduled;
  bool flexibleSchedule;
  int itemQuantity;
  int itemWeight;
  String itemValue;
  String amount;
  int category;
  int subCategory;
  int width;
  int height;
  String description;
  dynamic pickUpDate;
  dynamic images;
  int userId;
  dynamic paymentId;
  dynamic reviews;
  dynamic rating;
  int createdBy;
  int isViewed;
  DateTime createdAt;
  DateTime updatedAt;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        pickUpAddress: Address.fromJson(json["pickUpAddress"]),
        dropOffAddress: Address.fromJson(json["dropOffAddress"]),
        otherPhoneNumber:
            List<String>.from(json["otherPhoneNumber"].map((x) => x)),
        type: json["type"],
        status:
            List<Status>.from(json["status"].map((x) => Status.fromJson(x))),
        id: json["id"],
        trackingId: json["trackingId"],
        dispatchType: json["dispatchType"],
        senderName: json["senderName"],
        senderPhoneNumber: json["senderPhoneNumber"],
        receiverName: json["receiverName"],
        receiverPhoneNumber: json["receiverPhoneNumber"],
        driverId: json["driverId"] == null ? 0 : json["driverId"],
        isInstant: json["isInstant"],
        isScheduled: json["isScheduled"],
        flexibleSchedule: json["flexibleSchedule"],
        itemQuantity: json["itemQuantity"],
        itemWeight: json["itemWeight"],
        itemValue: json["itemValue"],
        amount: json["amount"],
        category: json["category"],
        subCategory: json["subCategory"],
        width: json["width"],
        height: json["height"],
        description: json["description"],
        pickUpDate: json["pickUpDate"],
        images: json["images"],
        userId: json["userId"],
        paymentId: json["paymentId"],
        reviews: json["reviews"],
        rating: json["rating"],
        createdBy: json["createdBy"],
        isViewed: json["isViewed"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "pickUpAddress": pickUpAddress.toJson(),
        "dropOffAddress": dropOffAddress.toJson(),
        "otherPhoneNumber": List<dynamic>.from(otherPhoneNumber.map((x) => x)),
        "type": type,
        "status": List<dynamic>.from(status.map((x) => x.toJson())),
        "id": id,
        "trackingId": trackingId,
        "dispatchType": dispatchType,
        "senderName": senderName,
        "senderPhoneNumber": senderPhoneNumber,
        "receiverName": receiverName,
        "receiverPhoneNumber": receiverPhoneNumber,
        "driverId": driverId,
        "isInstant": isInstant,
        "isScheduled": isScheduled,
        "flexibleSchedule": flexibleSchedule,
        "itemQuantity": itemQuantity,
        "itemWeight": itemWeight,
        "itemValue": itemValue,
        "amount": amount,
        "category": category,
        "subCategory": subCategory,
        "width": width,
        "height": height,
        "description": description,
        "pickUpDate": pickUpDate,
        "images": images,
        "userId": userId,
        "paymentId": paymentId,
        "reviews": reviews,
        "rating": rating,
        "createdBy": createdBy,
        "isViewed": isViewed,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Address {
  Address({
    required this.address,
    required this.longitude,
    required this.latitude,
  });

  String address;
  String longitude;
  String latitude;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"],
        longitude: json["longitude"],
        latitude: json["latitude"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "longitude": longitude,
        "latitude": latitude,
      };
}

class Status {
  Status({
    required this.dateTime,
    required this.location,
    required this.user,
    required this.innerTrackingId,
    required this.description,
  });

  DateTime dateTime;
  String location;
  String user;
  String innerTrackingId;
  String description;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        dateTime: DateTime.parse(json["dateTime"]),
        location: json["location"],
        user: json["user"],
        innerTrackingId: json["innerTrackingId"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "dateTime": dateTime.toIso8601String(),
        "location": location,
        "user": user,
        "innerTrackingId": innerTrackingId,
        "description": description,
      };
}

class Rider {
  Rider({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.password,
    required this.phoneNumber,
    required this.trips,
    required this.status,
    this.profileImage,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  dynamic password;
  String phoneNumber;
  int trips;
  String status;
  dynamic profileImage;
  int createdBy;
  DateTime createdAt;
  DateTime updatedAt;

  factory Rider.fromJson(Map<String, dynamic> json) => Rider(
        id: json["id"],
        firstName: json["firstName"] == null ? "" : json["firstName"],
        lastName: json["lastName"] == null ? "" : json["lastName"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        trips: json["trips"],
        status: json["status"],
        profileImage: json["profileImage"],
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "trips": trips,
        "status": status,
        "profileImage": profileImage,
        "createdBy": createdBy,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
