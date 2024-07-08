// To parse this JSON data, do
//
//     final restaurantDetailResponseModel = restaurantDetailResponseModelFromJson(jsonString);

import 'dart:convert';

RestaurantDetailResponseModel restaurantDetailResponseModelFromJson(String str) => RestaurantDetailResponseModel.fromJson(json.decode(str));

String restaurantDetailResponseModelToJson(RestaurantDetailResponseModel data) => json.encode(data.toJson());

class RestaurantDetailResponseModel {
  int statusCode;
  String message;
  RestaurantDetailData data;

  RestaurantDetailResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory RestaurantDetailResponseModel.fromJson(Map<String, dynamic> json) => RestaurantDetailResponseModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: RestaurantDetailData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data.toJson(),
  };
}

class RestaurantDetailData {
  int restaurantId;
  String name;
  String address;
  String country;
  String city;
  String phNum;
  String website;
  String description;
  double latitude;
  double longitude;
  String restaurantImage;
  List<RestarantsDish> restarantsDishes;
  List<dynamic> restaurantDeals;
  List<RestaurantTiming> restaurantTimings;

  RestaurantDetailData({
    required this.restaurantId,
    required this.name,
    required this.address,
    required this.country,
    required this.city,
    required this.phNum,
    required this.website,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.restaurantImage,
    required this.restarantsDishes,
    required this.restaurantDeals,
    required this.restaurantTimings,
  });

  factory RestaurantDetailData.fromJson(Map<String, dynamic> json) => RestaurantDetailData(
    restaurantId: json["restaurantId"],
    name: json["name"],
    address: json["address"],
    country: json["country"],
    city: json["city"],
    phNum: json["phNum"],
    website: json["website"],
    description: json["description"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    restaurantImage: json["restaurantImage"],
    restarantsDishes: List<RestarantsDish>.from(json["restarantsDishes"].map((x) => RestarantsDish.fromJson(x))),
    restaurantDeals: List<dynamic>.from(json["restaurantDeals"].map((x) => x)),
    restaurantTimings: List<RestaurantTiming>.from(json["restaurantTimings"].map((x) => RestaurantTiming.fromJson(x))),
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
    "latitude": latitude,
    "longitude": longitude,
    "restaurantImage": restaurantImage,
    "restarantsDishes": List<dynamic>.from(restarantsDishes.map((x) => x.toJson())),
    "restaurantDeals": List<dynamic>.from(restaurantDeals.map((x) => x)),
    "restaurantTimings": List<dynamic>.from(restaurantTimings.map((x) => x.toJson())),
  };
}

class RestarantsDish {
  int restaurantDishId;
  String dishName;
  String description;
  double price;
  String cuisineName;

  RestarantsDish({
    required this.restaurantDishId,
    required this.dishName,
    required this.description,
    required this.price,
    required this.cuisineName,
  });

  factory RestarantsDish.fromJson(Map<String, dynamic> json) => RestarantsDish(
    restaurantDishId: json["restaurantDishId"],
    dishName: json["dishName"],
    description: json["description"],
    price: json["price"],
    cuisineName: json["cuisineName"],
  );

  Map<String, dynamic> toJson() => {
    "restaurantDishId": restaurantDishId,
    "dishName": dishName,
    "description": description,
    "price": price,
    "cuisineName": cuisineName,
  };
}

class RestaurantTiming {
  int restaurantTimingId;
  String weekDays;
  String openingTime;
  String closingTime;

  RestaurantTiming({
    required this.restaurantTimingId,
    required this.weekDays,
    required this.openingTime,
    required this.closingTime,
  });

  factory RestaurantTiming.fromJson(Map<String, dynamic> json) => RestaurantTiming(
    restaurantTimingId: json["restaurantTimingId"],
    weekDays: json["weekDays"],
    openingTime: json["openingTime"],
    closingTime: json["closingTime"],
  );

  Map<String, dynamic> toJson() => {
    "restaurantTimingId": restaurantTimingId,
    "weekDays": weekDays,
    "openingTime": openingTime,
    "closingTime": closingTime,
  };
}
