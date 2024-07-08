// To parse this JSON data, do
//
//     final addToCartRequestModel = addToCartRequestModelFromJson(jsonString);

import 'dart:convert';

AddToCartRequestModel addToCartRequestModelFromJson(String str) => AddToCartRequestModel.fromJson(json.decode(str));

String addToCartRequestModelToJson(AddToCartRequestModel data) => json.encode(data.toJson());

class AddToCartRequestModel {
  int dishId;
  int userId;
  int quantity;

  AddToCartRequestModel({
    required this.dishId,
    required this.userId,
    required this.quantity,
  });

  factory AddToCartRequestModel.fromJson(Map<String, dynamic> json) => AddToCartRequestModel(
    dishId: json["dishId"],
    userId: json["userId"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "dishId": dishId,
    "userId": userId,
    "quantity": quantity,
  };
}
