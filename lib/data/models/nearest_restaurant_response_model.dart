// To parse this JSON data, do
//
//     final nearestRestaurantResponseModel = nearestRestaurantResponseModelFromJson(jsonString);

import 'dart:convert';

NearestRestaurantResponseModel nearestRestaurantResponseModelFromJson(String str) => NearestRestaurantResponseModel.fromJson(json.decode(str));

String nearestRestaurantResponseModelToJson(NearestRestaurantResponseModel data) => json.encode(data.toJson());

class NearestRestaurantResponseModel {
  int statusCode;
  String message;
  List<NearestRestaurantsData> data;

  NearestRestaurantResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory NearestRestaurantResponseModel.fromJson(Map<String, dynamic> json) => NearestRestaurantResponseModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<NearestRestaurantsData>.from(json["data"].map((x) => NearestRestaurantsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class NearestRestaurantsData {
  int restaurantId;
  String name;
  String address;
  String country;
  String city;
  String phNum;
  String website;
  String description;
  String distanceInMeters;
  String restaurantImage;

  NearestRestaurantsData({
    required this.restaurantId,
    required this.name,
    required this.address,
    required this.country,
    required this.city,
    required this.phNum,
    required this.website,
    required this.description,
    required this.distanceInMeters,
    required this.restaurantImage,
  });

  factory NearestRestaurantsData.fromJson(Map<String, dynamic> json) => NearestRestaurantsData(
    restaurantId: json["restaurantId"],
    name: json["name"],
    address: json["address"],
    country: json["country"],
    city: json["city"],
    phNum: json["phNum"],
    website: json["website"],
    description: json["description"],
    distanceInMeters: json["distanceInMeters"],
    restaurantImage: json["restaurantImage"],
  );

  Map<String, dynamic> toJson() => {
    "restaurantId": restaurantId,
    "name": name,
    "address": address,
    "country": country,
    "city": city,
    "phNum": phNum,
    "website": website,
    "description": description,
    "distanceInMeters": distanceInMeters,
    "restaurantImage": restaurantImage,
  };
}
