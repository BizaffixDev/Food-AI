import 'package:foodai_mobile/data/data_sources/dine_in_data_source.dart';
import 'package:foodai_mobile/data/models/add_user_location_response_model.dart';
import 'package:foodai_mobile/data/models/like_dislike_respponse_model.dart';
import 'package:foodai_mobile/data/models/nearest_restaurant_response_model.dart';


abstract class DineInRepository {

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


class DineInRepositoryImpl extends DineInRepository {
  final DineInDataSource dineInDataSource;

  DineInRepositoryImpl(this.dineInDataSource,);

  @override
  Future<AddUserLocationResponseModel> addUserLocation({required int userId, required double latitude, required double longitude, required int maxDistance}) {
   return dineInDataSource.addUserLocation(userId: userId, latitude: latitude, longitude: longitude, maxDistance: maxDistance);
  }

  @override
  Future<List<NearestRestaurantsData>> getNearestRestaurant({required int userId, required double latitude, required double longitude, required int maxDistance}) {
    return dineInDataSource.getNearestRestaurant(userId: userId, latitude: latitude, longitude: longitude, maxDistance: maxDistance);
  }




}