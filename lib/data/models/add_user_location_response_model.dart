// To parse this JSON data, do
//
//     final addUserLocationResponseModel = addUserLocationResponseModelFromJson(jsonString);

import 'dart:convert';

AddUserLocationResponseModel addUserLocationResponseModelFromJson(String str) => AddUserLocationResponseModel.fromJson(json.decode(str));

String addUserLocationResponseModelToJson(AddUserLocationResponseModel data) => json.encode(data.toJson());

class AddUserLocationResponseModel {
  int statusCode;
  String message;
  dynamic data;

  AddUserLocationResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory AddUserLocationResponseModel.fromJson(Map<String, dynamic> json) => AddUserLocationResponseModel(
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
