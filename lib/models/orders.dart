
import 'dart:convert';


class Orderhistory {
    Orderhistory({
        required this.success,
        required this.status,
        required this.data,
        required this.message,
    });

    bool success;
    int status;
    List<Datum> data;
    String message;

    factory Orderhistory.fromJson(Map<String, dynamic> json) => Orderhistory(
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
        this.driverId,
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
    dynamic driverId;
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

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        pickUpAddress: Address.fromJson(json["pickUpAddress"]),
        dropOffAddress: Address.fromJson(json["dropOffAddress"]),
        otherPhoneNumber: List<String>.from(json["otherPhoneNumber"].map((x) => x)),
        type: json["type"],
        status: List<Status>.from(json["status"].map((x) => Status.fromJson(x))),
        id: json["id"],
        trackingId: json["trackingId"],
        dispatchType: json["dispatchType"],
        senderName: json["senderName"],
        senderPhoneNumber: json["senderPhoneNumber"],
        receiverName: json["receiverName"],
        receiverPhoneNumber: json["receiverPhoneNumber"],
        driverId: json["driverId"],
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