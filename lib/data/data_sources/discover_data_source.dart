import 'package:flutter/material.dart';
import 'package:foodai_mobile/data/data_sources/user_local_data_source.dart';
import 'package:foodai_mobile/data/models/cuisine_preferences_response_model.dart';
import 'package:foodai_mobile/data/models/cusines_response_model.dart';
import 'package:foodai_mobile/data/models/like_dislike_request_model.dart';
import 'package:foodai_mobile/data/models/like_dislike_respponse_model.dart';
import 'package:foodai_mobile/data/network/end_points.dart';
import 'package:foodai_mobile/data/network/rest_api_client.dart';
import 'package:get_it/get_it.dart';

abstract class DiscoverDataSource {

  Future<List<CuisinesData>> getCuisinesList();


  Future<List<Preference>> getCuisinesPreferenceList({required String cuisineId});

  Future<LikeDislikeResponseModel> likeDislikeResponse({
    required int userId,
    required int questionId,
    required bool userResponse,
  });
}


class DiscoverDataSourceImpl implements DiscoverDataSource {
  DiscoverDataSourceImpl()
      : _restClient = GetIt.instance<ApiService>(),
        _userLocalDataSource = GetIt.instance<UserLocalDataSource>();

  final ApiService _restClient;
  final UserLocalDataSource _userLocalDataSource;

  @override
  Future<List<CuisinesData>> getCuisinesList() async {
    final result = await _restClient.get(
      Endpoints.getCuisines,
      queryParameters: {},
    );
    print('This is the result of get cuisines list $result');
    final response = CuisinesResponseModel.fromJson(result.data);
    print('This is the response of decoded List ${response.data}');
    return response.data;
  }

  @override
  Future<List<Preference>> getCuisinesPreferenceList({required String cuisineId}) async{
    final result = await _restClient.get(
      Endpoints.getPreferencesCuisine + '/$cuisineId',
      queryParameters: {},
    );
    print('This is the result of get cuisine preferences list $result');
    final response = CuisinePreferencesResponseModel.fromJson(result.data);
    print('This is the response of decoded List ${response.data}');
    return response.data.preferences;
  }


  @override
  Future<LikeDislikeResponseModel> likeDislikeResponse({
    required int userId,
    required int questionId,
    required bool userResponse,
  }) async {
    LikeDislikeRequestModel data = LikeDislikeRequestModel(
        userId: userId,
        questionId: questionId,
        userResponse:userResponse


    );

    final result = await _restClient.post(Endpoints.likeDislikeResponse, data,
        isSignUporLogin: true);

    debugPrint('This is the result of like dislike $result');
    if (result.data == null) {
      throw Exception('Empty response');
    }
    final response = LikeDislikeResponseModel.fromJson(result.data);
    debugPrint('This is the response $response');
    return response;
  }


}