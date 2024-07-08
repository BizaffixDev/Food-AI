import 'package:foodai_mobile/data/data_sources/dine_in_data_source.dart';
import 'package:foodai_mobile/data/data_sources/reservation_data_source.dart';


abstract class ReservationRepository {

  //Future<List<RestaurantData>> getRestaurantList();



}


class ReservationRepositoryImpl extends ReservationRepository {
  final ReservationDataSource reservationDataSource;

  ReservationRepositoryImpl(this.reservationDataSource,);




}