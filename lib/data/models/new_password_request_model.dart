// To parse this JSON data, do
//
//     final newPasswordRequestModel = newPasswordRequestModelFromJson(jsonString);

import 'dart:convert';

NewPasswordRequestModel newPasswordRequestModelFromJson(String str) => NewPasswordRequestModel.fromJson(json.decode(str));

String newPasswordRequestModelToJson(NewPasswordRequestModel data) => json.encode(data.toJson());

class NewPasswordRequestModel {
  String email;
  String password;
  String confirmPassword;

  NewPasswordRequestModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  factory NewPasswordRequestModel.fromJson(Map<String, dynamic> json) => NewPasswordRequestModel(
    email: json["email"],
    password: json["password"],
    confirmPassword: json["confirmPassword"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "confirmPassword": confirmPassword,
  };
}
