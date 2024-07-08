// To parse this JSON data, do
//
//     final cusinesResponseModel = cusinesResponseModelFromJson(jsonString);

import 'dart:convert';

CuisinesResponseModel cuisinesResponseModelFromJson(String str) => CuisinesResponseModel.fromJson(json.decode(str));

String cuisinesResponseModelToJson(CuisinesResponseModel data) => json.encode(data.toJson());

class CuisinesResponseModel {
  int statusCode;
  String message;
  List<CuisinesData> data;

  CuisinesResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CuisinesResponseModel.fromJson(Map<String, dynamic> json) => CuisinesResponseModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<CuisinesData>.from(json["data"].map((x) => CuisinesData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CuisinesData {
  int cuisineId;
  String name;
  String detail;
  String image;

  CuisinesData({
    required this.cuisineId,
    required this.name,
    required this.detail,
    required this.image,
  });

  factory CuisinesData.fromJson(Map<String, dynamic> json) => CuisinesData(
    cuisineId: json['cuisineId'],
    name: json["name"],
    detail: json["detail"],
    image: json["image"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "cuisineId": cuisineId,
    "name": name,
    "detail": detail,
    "image": image,
  };
}
