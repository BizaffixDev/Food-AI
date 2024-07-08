// To parse this JSON data, do
//
//     final restaurantsResponseModel = restaurantsResponseModelFromJson(jsonString);

import 'dart:convert';

RestaurantsResponseModel restaurantsResponseModelFromJson(String str) => RestaurantsResponseModel.fromJson(json.decode(str));

String restaurantsResponseModelToJson(RestaurantsResponseModel data) => json.encode(data.toJson());

class RestaurantsResponseModel {
  int statusCode;
  String message;
  List<RestaurantData> data;

  RestaurantsResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory RestaurantsResponseModel.fromJson(Map<String, dynamic> json) => RestaurantsResponseModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<RestaurantData>.from(json["data"].map((x) => RestaurantData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class RestaurantData {
  int restaurantId;
  String name;
  String address;
  String country;
  String city;
  String phNum;
  String website;
  String description;
  List<dynamic> restarantsDishes;
  List<dynamic> restaurantDeals;
  List<dynamic> restaurantTimings;

  RestaurantData({
    required this.restaurantId,
    required this.name,
    required this.address,
    required this.country,
    required this.city,
    required this.phNum,
    required this.website,
    required this.description,
    required this.restarantsDishes,
    required this.restaurantDeals,
    required this.restaurantTimings,
  });

  factory RestaurantData.fromJson(Map<String, dynamic> json) => RestaurantData(
    restaurantId: json["restaurantId"],
    name: json["name"],
    address: json["address"],
    country: json["country"],
    city: json["city"],
    phNum: json["phNum"],
    website: json["website"],
    description: json["description"],
    restarantsDishes: List<dynamic>.from(json["restarantsDishes"].map((x) => x)),
    restaurantDeals: List<dynamic>.from(json["restaurantDeals"].map((x) => x)),
    restaurantTimings: List<dynamic>.from(json["restaurantTimings"].map((x) => x)),
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
    "restarantsDishes": List<dynamic>.from(restarantsDishes.map((x) => x)),
    "restaurantDeals": List<dynamic>.from(restaurantDeals.map((x) => x)),
    "restaurantTimings": List<dynamic>.from(restaurantTimings.map((x) => x)),
  };
}
