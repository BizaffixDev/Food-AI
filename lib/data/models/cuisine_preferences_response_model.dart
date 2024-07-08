// To parse this JSON data, do
//
//     final cuisinePreferencesResponseModel = cuisinePreferencesResponseModelFromJson(jsonString);

import 'dart:convert';

CuisinePreferencesResponseModel cuisinePreferencesResponseModelFromJson(String str) => CuisinePreferencesResponseModel.fromJson(json.decode(str));

String cuisinePreferencesResponseModelToJson(CuisinePreferencesResponseModel data) => json.encode(data.toJson());

class CuisinePreferencesResponseModel {
  int statusCode;
  String message;
  CuisinePreferenceData data;

  CuisinePreferencesResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CuisinePreferencesResponseModel.fromJson(Map<String, dynamic> json) => CuisinePreferencesResponseModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: CuisinePreferenceData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data.toJson(),
  };
}

class CuisinePreferenceData {
  CuisineType cuisineType;
  List<Preference> preferences;

  CuisinePreferenceData({
    required this.cuisineType,
    required this.preferences,
  });

  factory CuisinePreferenceData.fromJson(Map<String, dynamic> json) => CuisinePreferenceData(
    cuisineType: CuisineType.fromJson(json["cuisineType"]),
    preferences: List<Preference>.from(json["preferences"].map((x) => Preference.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cuisineType": cuisineType.toJson(),
    "preferences": List<dynamic>.from(preferences.map((x) => x.toJson())),
  };
}

class CuisineType {
  int cuisineId;
  String name;
  String detail;
  dynamic image;

  CuisineType({
    required this.cuisineId,
    required this.name,
    required this.detail,
    required this.image,
  });

  factory CuisineType.fromJson(Map<String, dynamic> json) => CuisineType(
    cuisineId: json["cuisineId"],
    name: json["name"],
    detail: json["detail"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "cuisineId": cuisineId,
    "name": name,
    "detail": detail,
    "image": image,
  };
}

class Preference {
  int questionId;
  String name;
  String shortDescription;
  String description;
  String profileImage;

  Preference({
    required this.questionId,
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.profileImage,
  });

  factory Preference.fromJson(Map<String, dynamic> json) => Preference(
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
