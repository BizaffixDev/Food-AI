// To parse this JSON data, do
//
//     final addToCartResponseModel = addToCartResponseModelFromJson(jsonString);

import 'dart:convert';

AddToCartResponseModel addToCartResponseModelFromJson(String str) => AddToCartResponseModel.fromJson(json.decode(str));

String addToCartResponseModelToJson(AddToCartResponseModel data) => json.encode(data.toJson());

class AddToCartResponseModel {
  int statusCode;
  String message;
  dynamic data;

  AddToCartResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory AddToCartResponseModel.fromJson(Map<String, dynamic> json) => AddToCartResponseModel(
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
