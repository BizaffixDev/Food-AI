import 'package:flutter/material.dart';
import 'package:foodai_mobile/data/data_sources/user_local_data_source.dart';
import 'package:foodai_mobile/data/models/add_user_location_request_model.dart';
import 'package:foodai_mobile/data/models/add_user_location_response_model.dart';
import 'package:foodai_mobile/data/models/cusines_response_model.dart';
import 'package:foodai_mobile/data/models/nearest_restaurant_response_model.dart';
import 'package:foodai_mobile/data/models/restaurants_response_model.dart';
import 'package:foodai_mobile/data/network/end_points.dart';
import 'package:foodai_mobile/data/network/rest_api_client.dart';
import 'package:get_it/get_it.dart';

abstract class DineInDataSource {
  Future<AddUserLocationResponseModel> addUserLocation({
    required int userId,
    required double latitude,
    required double longitude,
    required int maxDistance,
  });

  Future<List<NearestRestaurantsData>> getNearestRestaurant({
    required int userId,
    required double latitude,
    required double longitude,
    required int maxDistance,
  });
}

class DineInDataSourceImpl implements DineInDataSource {
  DineInDataSourceImpl()
      : _restClient = GetIt.instance<ApiService>(),
        _userLocalDataSource = GetIt.instance<UserLocalDataSource>();

  final ApiService _restClient;
  final UserLocalDataSource _userLocalDataSource;

  @override
  Future<AddUserLocationResponseModel> addUserLocation({
    required int userId,
    required double latitude,
    required double longitude,
    required int maxDistance,
  }) async {
    AddUserLocationRequestModel data = AddUserLocationRequestModel(
      userId: userId,
      latitude: latitude,
      longitude: longitude,
      maxDistanceInMeters: maxDistance,
    );

    final result = await _restClient.post(
      Endpoints.addUserLocation,
      data,
    );

    debugPrint('This is the result of add location $result');
    if (result.data == null) {
      throw Exception('Empty response');
    }
    final response = AddUserLocationResponseModel.fromJson(result.data);
    debugPrint('This is the response $response');
    return response;
  }

  @override
  Future<List<NearestRestaurantsData>> getNearestRestaurant({
    required int userId,
    required double latitude,
    required double longitude,
    required int maxDistance,
  }) async{
    AddUserLocationRequestModel data = AddUserLocationRequestModel(
      userId: userId,
      latitude: latitude,
      longitude: longitude,
      maxDistanceInMeters: maxDistance,
    );

    final result = await _restClient.post(
      Endpoints.nearestRestaurant,
      data,
    );

    debugPrint('This is the result of get nearest restaurant $result');
    if (result.data == null) {
      throw Exception('Empty response');
    }
    final response = NearestRestaurantResponseModel.fromJson(result.data);
    debugPrint('This is the response $response');
    return response.data;
  }
}
