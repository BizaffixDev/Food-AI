// To parse this JSON data, do
//
//     final likeDislikeRequestModel = likeDislikeRequestModelFromJson(jsonString);

import 'dart:convert';

LikeDislikeRequestModel likeDislikeRequestModelFromJson(String str) => LikeDislikeRequestModel.fromJson(json.decode(str));

String likeDislikeRequestModelToJson(LikeDislikeRequestModel data) => json.encode(data.toJson());

class LikeDislikeRequestModel {
  int questionId;
  bool userResponse;
  int userId;

  LikeDislikeRequestModel({
    required this.questionId,
    required this.userResponse,
    required this.userId,
  });

  factory LikeDislikeRequestModel.fromJson(Map<String, dynamic> json) => LikeDislikeRequestModel(
    questionId: json["questionId"],
    userResponse: json["userResponse"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "userResponse": userResponse,
    "userId": userId,
  };
}
