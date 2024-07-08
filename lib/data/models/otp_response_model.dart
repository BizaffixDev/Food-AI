// To parse this JSON data, do
//
//     final otpResponseModel = otpResponseModelFromJson(jsonString);

import 'dart:convert';

OtpResponseModel otpResponseModelFromJson(String str) => OtpResponseModel.fromJson(json.decode(str));

String otpResponseModelToJson(OtpResponseModel data) => json.encode(data.toJson());

class OtpResponseModel {
  int statusCode;
  String message;
  dynamic data;

  OtpResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) => OtpResponseModel(
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
