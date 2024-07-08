import 'package:flutter/material.dart';
import 'package:foodai_mobile/data/data_sources/user_local_data_source.dart';
import 'package:foodai_mobile/data/models/cusines_response_model.dart';
import 'package:foodai_mobile/data/models/restaurant_detail_response_model.dart';
import 'package:foodai_mobile/data/models/restaurants_response_model.dart';
import 'package:foodai_mobile/data/network/end_points.dart';
import 'package:foodai_mobile/data/network/rest_api_client.dart';
import 'package:get_it/get_it.dart';

import '../models/add_to_cart_request_model.dart';
import '../models/add_to_cart_response_model.dart';

abstract class IKnowDataSource {

  Future<List<RestaurantData>> getRestaurantList();
  Future<RestaurantDetailData> getRestaurantDetails({required int restaurantId});

  Future<AddToCartResponseModel> addToCart({
    required int dishId,
    required int userId,
    required int quantity,
  });




}


class IKnowDataSourceImpl implements IKnowDataSource {
  IKnowDataSourceImpl()
      : _restClient = GetIt.instance<ApiService>(),
        _userLocalDataSource = GetIt.instance<UserLocalDataSource>();

  final ApiService _restClient;
  final UserLocalDataSource _userLocalDataSource;

  @override
  Future<AddToCartResponseModel> addToCart({
    required int dishId,
    required int userId,
    required int quantity,
  }) async{
    AddToCartRequestModel data = AddToCartRequestModel(dishId: dishId, userId: userId, quantity: quantity);

    final result = await _restClient.post(Endpoints.addToCart, data,);

    debugPrint('This is the result for add to cart $result');
    if (result.data == null) {
      throw Exception('Empty response');
    }
    final response = AddToCartResponseModel.fromJson(result.data);
    debugPrint('This is the response $response');
    return response;
  }


  @override
  Future<List<RestaurantData>> getRestaurantList() async {
    final result = await _restClient.get(
      Endpoints.getRestaurants,
      queryParameters: {},
    );
    print('This is the result of get restaurants list $result');
    final response = RestaurantsResponseModel.fromJson(result.data);
    print('This is the response of decoded List ${response.data}');
    return response.data;
  }

  @override
  Future<RestaurantDetailData> getRestaurantDetails({required int restaurantId}) async{
    final result = await _restClient.get(
      Endpoints.getRestaurantDetails,
      queryParameters: {
        "restaurantId": restaurantId
      },
    );
    print('This is the result of get restaurants list $result');
    final response = RestaurantDetailResponseModel.fromJson(result.data);
    print('This is the response of decoded List ${response.data}');
    return response.data;
  }


}