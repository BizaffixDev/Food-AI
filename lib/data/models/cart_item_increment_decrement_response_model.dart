// To parse this JSON data, do
//
//     final cartItemIncrementDecrementResponseModel = cartItemIncrementDecrementResponseModelFromJson(jsonString);

import 'dart:convert';

CartItemIncrementDecrementResponseModel cartItemIncrementDecrementResponseModelFromJson(String str) => CartItemIncrementDecrementResponseModel.fromJson(json.decode(str));

String cartItemIncrementDecrementResponseModelToJson(CartItemIncrementDecrementResponseModel data) => json.encode(data.toJson());

class CartItemIncrementDecrementResponseModel {
  int statusCode;
  String message;
  CartIncDecData data;

  CartItemIncrementDecrementResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CartItemIncrementDecrementResponseModel.fromJson(Map<String, dynamic> json) => CartItemIncrementDecrementResponseModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: CartIncDecData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data.toJson(),
  };
}

class CartIncDecData {
  int dishId;
  int userId;
  int quantity;
  dynamic restaurantDish;
  dynamic user;
  int id;
  bool isDeleted;
  int createdBy;
  DateTime createdOn;
  int modifiedBy;
  DateTime modifiedOn;

  CartIncDecData({
    required this.dishId,
    required this.userId,
    required this.quantity,
    required this.restaurantDish,
    required this.user,
    required this.id,
    required this.isDeleted,
    required this.createdBy,
    required this.createdOn,
    required this.modifiedBy,
    required this.modifiedOn,
  });

  factory CartIncDecData.fromJson(Map<String, dynamic> json) => CartIncDecData(
    dishId: json["dishId"],
    userId: json["userId"],
    quantity: json["quantity"],
    restaurantDish: json["restaurantDish"],
    user: json["user"],
    id: json["id"],
    isDeleted: json["isDeleted"],
    createdBy: json["createdBy"],
    createdOn: DateTime.parse(json["createdOn"]),
    modifiedBy: json["modifiedBy"],
    modifiedOn: DateTime.parse(json["modifiedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "dishId": dishId,
    "userId": userId,
    "quantity": quantity,
    "restaurantDish": restaurantDish,
    "user": user,
    "id": id,
    "isDeleted": isDeleted,
    "createdBy": createdBy,
    "createdOn": createdOn.toIso8601String(),
    "modifiedBy": modifiedBy,
    "modifiedOn": modifiedOn.toIso8601String(),
  };
}
