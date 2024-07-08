// To parse this JSON data, do
//
//     final noificationResponseModel = noificationResponseModelFromJson(jsonString);

import 'dart:convert';

NotificationResponseModel notificationResponseModelFromJson(String str) => NotificationResponseModel.fromJson(json.decode(str));

String notificationResponseModelToJson(NotificationResponseModel data) => json.encode(data.toJson());

class NotificationResponseModel {
  int statusCode;
  String message;
  NotificationData data;

  NotificationResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) => NotificationResponseModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: NotificationData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data.toJson(),
  };
}

class NotificationData {
  int notificationId;
  String type;
  String name;
  String detail;
  String message;
  bool isRead;
  bool isDelete;

  NotificationData({
    required this.notificationId,
    required this.type,
    required this.name,
    required this.detail,
    required this.message,
    required this.isRead,
    required this.isDelete,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    notificationId: json["notificationId"],
    type: json["type"],
    name: json["name"],
    detail: json["detail"],
    message: json["message"],
    isRead: json["isRead"],
    isDelete: json["isDelete"],
  );

  Map<String, dynamic> toJson() => {
    "notificationId": notificationId,
    "type": type,
    "name": name,
    "detail": detail,
    "message": message,
    "isRead": isRead,
    "isDelete": isDelete,
  };
}
