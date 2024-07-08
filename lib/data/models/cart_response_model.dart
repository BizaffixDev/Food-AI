// To parse this JSON data, do
//
//     final cartResponseModel = cartResponseModelFromJson(jsonString);

import 'dart:convert';

CartResponseModel cartResponseModelFromJson(String str) => CartResponseModel.fromJson(json.decode(str));

String cartResponseModelToJson(CartResponseModel data) => json.encode(data.toJson());

class CartResponseModel {
  int statusCode;
  String message;
  List<CartDetailData> data;

  CartResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) => CartResponseModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<CartDetailData>.from(json["data"].map((x) => CartDetailData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CartDetailData {
  int cartItemId;
  int dishId;
  int userId;
  int quantity;
  RestaurantResponse restaurantResponse;
  CuisineType cuisineType;
  RestaurantDishesResponse restaurantDishesResponse;

  CartDetailData({
    required this.cartItemId,
    required this.dishId,
    required this.userId,
    required this.quantity,
    required this.restaurantResponse,
    required this.cuisineType,
    required this.restaurantDishesResponse,
  });

  factory CartDetailData.fromJson(Map<String, dynamic> json) => CartDetailData(
    cartItemId: json["cartItemId"],
    dishId: json["dishId"],
    userId: json["userId"],
    quantity: json["quantity"],
    restaurantResponse: RestaurantResponse.fromJson(json["restaurantResponse"]),
    cuisineType: CuisineType.fromJson(json["cuisineType"]),
    restaurantDishesResponse: RestaurantDishesResponse.fromJson(json["restaurantDishesResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "cartItemId": cartItemId,
    "dishId": dishId,
    "userId": userId,
    "quantity": quantity,
    "restaurantResponse": restaurantResponse.toJson(),
    "cuisineType": cuisineType.toJson(),
    "restaurantDishesResponse": restaurantDishesResponse.toJson(),
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

class RestaurantDishesResponse {
  int restaurantDishId;
  String dishName;
  String description;
  double price;
  String cuisineName;

  RestaurantDishesResponse({
    required this.restaurantDishId,
    required this.dishName,
    required this.description,
    required this.price,
    required this.cuisineName,
  });

  factory RestaurantDishesResponse.fromJson(Map<String, dynamic> json) => RestaurantDishesResponse(
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

class RestaurantResponse {
  int restaurantId;
  String name;
  String address;
  String country;
  String city;
  String phNum;
  String website;
  String description;
  String restaurantImage;

  RestaurantResponse({
    required this.restaurantId,
    required this.name,
    required this.address,
    required this.country,
    required this.city,
    required this.phNum,
    required this.website,
    required this.description,
    required this.restaurantImage,
  });

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) => RestaurantResponse(
    restaurantId: json["restaurantId"],
    name: json["name"],
    address: json["address"],
    country: json["country"],
    city: json["city"],
    phNum: json["phNum"],
    website: json["website"],
    description: json["description"],
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
    "restaurantImage": restaurantImage,
  };
}
