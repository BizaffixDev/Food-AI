// To parse this JSON data, do
//
//     final forgetPasswordResponseModel = forgetPasswordResponseModelFromJson(jsonString);

import 'dart:convert';

ForgetPasswordResponseModel forgetPasswordResponseModelFromJson(String str) => ForgetPasswordResponseModel.fromJson(json.decode(str));

String forgetPasswordResponseModelToJson(ForgetPasswordResponseModel data) => json.encode(data.toJson());

class ForgetPasswordResponseModel {
  int statusCode;
  String message;
  String data;

  ForgetPasswordResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ForgetPasswordResponseModel.fromJson(Map<String, dynamic> json) => ForgetPasswordResponseModel(
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
