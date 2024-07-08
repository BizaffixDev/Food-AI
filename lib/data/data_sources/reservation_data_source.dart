import 'package:foodai_mobile/data/data_sources/user_local_data_source.dart';

import 'package:foodai_mobile/data/network/rest_api_client.dart';
import 'package:get_it/get_it.dart';

abstract class ReservationDataSource {

  //Future<List<RestaurantData>> getRestaurantList();


}


class ReservationDataSourceImpl implements ReservationDataSource {
  ReservationDataSourceImpl()
      : _restClient = GetIt.instance<ApiService>(),
        _userLocalDataSource = GetIt.instance<UserLocalDataSource>();

  final ApiService _restClient;
  final UserLocalDataSource _userLocalDataSource;




}