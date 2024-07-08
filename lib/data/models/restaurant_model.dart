import 'package:foodai_mobile/common/resources/drawables.dart';
import 'package:foodai_mobile/generated/assets.dart';

class RestaurantModel {
  final int id;
  final String image;
  final String name;
  final String time;

  RestaurantModel({
    required this.id,
    required this.image,
    required this.name,
    required this.time
});
}

List<RestaurantModel> restaurantsList = [
  RestaurantModel(
    id: 1,
    image: Assets.restaurant1,
    name: "Chilis",
    time: "12 min"
  ),
  RestaurantModel(
      id: 2,
      image: Assets.restaurant2,
      name: "Kolachi",
      time: "8 min"
  ),
  RestaurantModel(
      id: 3,
      image: Assets.restaurant3,
      name: "KFC",
      time: "12 min"
  ),
  RestaurantModel(
      id: 4,
      image: Assets.restaurant4,
      name: "Food In",
      time: "8 min"
  ),
];