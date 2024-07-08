import 'package:flutter/material.dart';
import 'package:foodai_mobile/data/data_sources/user_local_data_source.dart';
import 'package:foodai_mobile/data/models/add_to_cart_request_model.dart';
import 'package:foodai_mobile/data/models/cart_item_increment_decrement_response_model.dart';
import 'package:foodai_mobile/data/models/cart_response_model.dart';
import 'package:foodai_mobile/data/models/cusines_response_model.dart';
import 'package:foodai_mobile/data/models/restaurant_detail_response_model.dart';
import 'package:foodai_mobile/data/models/restaurants_response_model.dart';
import 'package:foodai_mobile/data/network/end_points.dart';
import 'package:foodai_mobile/data/network/rest_api_client.dart';
import 'package:get_it/get_it.dart';

import '../models/add_to_cart_response_model.dart';

abstract class CheckOutDataSource {




  Future<List<CartDetailData>> getCartDetails({required int userId});




}


class CheckOutDataSourceImpl implements CheckOutDataSource {
  CheckOutDataSourceImpl()
      : _restClient = GetIt.instance<ApiService>(),
        _userLocalDataSource = GetIt.instance<UserLocalDataSource>();

  final ApiService _restClient;
  final UserLocalDataSource _userLocalDataSource;



  @override
  Future<List<CartDetailData>> getCartDetails({required int userId}) async{


    final result = await _restClient.get(
      Endpoints.getCart + '/$userId',
      queryParameters: {},
    );
    print('This is the result of get restaurants list $result');
    final response = CartResponseModel.fromJson(result.data);
    print('This is the response of decoded List ${response.data}');
    return response.data;
  }









}