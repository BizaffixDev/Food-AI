// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  int statusCode;
  String message;
  LoginData data;

  LoginResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: LoginData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data.toJson(),
  };
}

class LoginData {
  int userId;
  String email;
  String username;
  String address;
  String token;
  bool isEmailVerified;

  LoginData({
    required this.userId,
    required this.email,
    required this.username,
    required this.address,
    required this.token,
    required this.isEmailVerified,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    userId: json["userId"],
    email: json["email"],
    username: json["username"],
    address: json["address"],
    token: json["token"],
    isEmailVerified: json["isEmailVerified"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "email": email,
    "username": username,
    "address": address,
    "token": token,
    "isEmailVerified": isEmailVerified,
  };
}
