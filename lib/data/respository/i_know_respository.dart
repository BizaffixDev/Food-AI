import 'package:foodai_mobile/data/data_sources/home_data_source.dart';
import 'package:foodai_mobile/data/data_sources/i_know_data_source.dart';
import 'package:foodai_mobile/data/models/preferences_response_model.dart';
import 'package:foodai_mobile/data/models/restaurants_response_model.dart';

import '../models/add_to_cart_response_model.dart';
import '../models/restaurant_detail_response_model.dart';

abstract class IKnowRepository {

  Future<List<RestaurantData>> getRestaurantList();
  Future<RestaurantDetailData> getRestaurantDetails({required int restaurantId});
  Future<AddToCartResponseModel> addToCart({
    required int dishId,
    required int userId,
    required int quantity,
  });


}


class IKnowRepositoryImpl extends IKnowRepository {
  final IKnowDataSource iKnowDataSource;

  IKnowRepositoryImpl(this.iKnowDataSource,);

  @override
  Future<List<RestaurantData>> getRestaurantList() {
    return iKnowDataSource.getRestaurantList();
  }

  @override
  Future<RestaurantDetailData> getRestaurantDetails({required int restaurantId}) {
    return iKnowDataSource.getRestaurantDetails(restaurantId: restaurantId);
  }


  @override
  Future<AddToCartResponseModel> addToCart({required int dishId, required int userId, required int quantity}) {
    return iKnowDataSource.addToCart(dishId: dishId, userId: userId, quantity: quantity);
  }

}