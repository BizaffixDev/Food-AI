// To parse this JSON data, do
//
//     final likeDislikeResponseModel = likeDislikeResponseModelFromJson(jsonString);

import 'dart:convert';

LikeDislikeResponseModel likeDislikeResponseModelFromJson(String str) => LikeDislikeResponseModel.fromJson(json.decode(str));

String likeDislikeResponseModelToJson(LikeDislikeResponseModel data) => json.encode(data.toJson());

class LikeDislikeResponseModel {
  int statusCode;
  String message;
  String data;

  LikeDislikeResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory LikeDislikeResponseModel.fromJson(Map<String, dynamic> json) => LikeDislikeResponseModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data,
  };
}
