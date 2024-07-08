import 'package:foodai_mobile/generated/assets.dart';

class DineInRestaurantsListModel {
  final String image;
  final String name;
  final String address;

  DineInRestaurantsListModel({
    required this.image,
    required this.name,
    required this.address,
  });
}

List<DineInRestaurantsListModel> restaurantsDineInList = [

  DineInRestaurantsListModel(
    image: Assets.restaurant4,
    name: "Foods In",
    address: "Malir Cantt",
  ),

  DineInRestaurantsListModel(
    image: Assets.restaurant3,
    name: "KFC",
    address: "Malir Cantt",
  ),

];
