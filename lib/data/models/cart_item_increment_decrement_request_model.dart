// To parse this JSON data, do
//
//     final cartItemIncrementDecrementRequestModel = cartItemIncrementDecrementRequestModelFromJson(jsonString);

import 'dart:convert';

CartItemIncrementDecrementRequestModel cartItemIncrementDecrementRequestModelFromJson(String str) => CartItemIncrementDecrementRequestModel.fromJson(json.decode(str));

String cartItemIncrementDecrementRequestModelToJson(CartItemIncrementDecrementRequestModel data) => json.encode(data.toJson());

class CartItemIncrementDecrementRequestModel {
  int userId;
  int cartItemId;

  CartItemIncrementDecrementRequestModel({
    required this.userId,
    required this.cartItemId,
  });

  factory CartItemIncrementDecrementRequestModel.fromJson(Map<String, dynamic> json) => CartItemIncrementDecrementRequestModel(
    userId: json["userId"],
    cartItemId: json["cartItemId"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "cartItemId": cartItemId,
  };
}
