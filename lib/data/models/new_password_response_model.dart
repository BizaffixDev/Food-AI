// To parse this JSON data, do
//
//     final newPasswordResponseModel = newPasswordResponseModelFromJson(jsonString);

import 'dart:convert';

NewPasswordResponseModel newPasswordResponseModelFromJson(String str) => NewPasswordResponseModel.fromJson(json.decode(str));

String newPasswordResponseModelToJson(NewPasswordResponseModel data) => json.encode(data.toJson());

class NewPasswordResponseModel {
  int statusCode;
  String message;
  dynamic data;

  NewPasswordResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory NewPasswordResponseModel.fromJson(Map<String, dynamic> json) => NewPasswordResponseModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data,
  };
}
