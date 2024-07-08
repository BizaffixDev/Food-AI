// To parse this JSON data, do
//
//     final otpRequestModel = otpRequestModelFromJson(jsonString);

import 'dart:convert';

OtpRequestModel otpRequestModelFromJson(String str) => OtpRequestModel.fromJson(json.decode(str));

String otpRequestModelToJson(OtpRequestModel data) => json.encode(data.toJson());

class OtpRequestModel {
  int otp;
  String email;

  OtpRequestModel({
    required this.otp,
    required this.email,
  });

  factory OtpRequestModel.fromJson(Map<String, dynamic> json) => OtpRequestModel(
    otp: json["otp"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "otp": otp,
    "email": email,
  };
}
