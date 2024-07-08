// To parse this JSON data, do
//
//     final preferencesResponseModel = preferencesResponseModelFromJson(jsonString);

import 'dart:convert';

PreferencesResponseModel preferencesResponseModelFromJson(String str) => PreferencesResponseModel.fromJson(json.decode(str));

String preferencesResponseModelToJson(PreferencesResponseModel data) => json.encode(data.toJson());

class PreferencesResponseModel {
  int statusCode;
  String message;
  List<PreferencesData> data;

  PreferencesResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory PreferencesResponseModel.fromJson(Map<String, dynamic> json) => PreferencesResponseModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<PreferencesData>.from(json["data"].map((x) => PreferencesData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PreferencesData {
  int questionId;
  String name;
  String shortDescription;
  String description;
  String profileImage;

  PreferencesData({
    required this.questionId,
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.profileImage,
  });

  factory PreferencesData.fromJson(Map<String, dynamic> json) => PreferencesData(
    questionId: json["questionId"],
    name: json["name"],
    shortDescription: json["shortDescription"],
    description: json["description"],
    profileImage: json["profileImage"],
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "name": name,
    "shortDescription": shortDescription,
    "description": description,
    "profileImage": profileImage,
  };
}
