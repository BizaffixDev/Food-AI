// To parse this JSON data, do
//
//     final addUserLocationRequestModel = addUserLocationRequestModelFromJson(jsonString);

import 'dart:convert';

AddUserLocationRequestModel addUserLocationRequestModelFromJson(String str) => AddUserLocationRequestModel.fromJson(json.decode(str));

String addUserLocationRequestModelToJson(AddUserLocationRequestModel data) => json.encode(data.toJson());

class AddUserLocationRequestModel {
  int userId;
  double latitude;
  double longitude;
  int maxDistanceInMeters;

  AddUserLocationRequestModel({
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.maxDistanceInMeters,
  });

  factory AddUserLocationRequestModel.fromJson(Map<String, dynamic> json) => AddUserLocationRequestModel(
    userId: json["userId"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    maxDistanceInMeters: json["maxDistanceInMeters"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "latitude": latitude,
    "longitude": longitude,
    "maxDistanceInMeters": maxDistanceInMeters,
  };
}
