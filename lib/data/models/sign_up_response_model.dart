// To parse this JSON data, do
//
//     final signUpResponse = signUpResponseFromJson(jsonString);

import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) => SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  int statusCode;
  String message;
  SignUpData data;

  SignUpResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
    statusCode: json["statusCode"],
    message: json["message"],
    data: SignUpData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data.toJson(),
  };
}

class SignUpData {
  int userId;
  String email;
  String username;
  String address;
  String token;

  SignUpData({
    required this.userId,
    required this.email,
    required this.username,
    required this.address,
    required this.token,
  });

  factory SignUpData.fromJson(Map<String, dynamic> json) => SignUpData(
    userId: json["userId"],
    email: json["email"],
    username: json["username"],
    address: json["address"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "email": email,
    "username": username,
    "address": address,
    "token": token,
  };
}
