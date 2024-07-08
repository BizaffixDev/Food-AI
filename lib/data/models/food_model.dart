import 'package:foodai_mobile/generated/assets.dart';

class FoodModel{
  final String image;
  final String name;
  final String tagline;
  final String rating;
  final String price;

  FoodModel({
    required this.image, required this.name, required this.tagline, required this.rating, required this.price,
  });

}



List<FoodModel> popularItems = [

  FoodModel(image: Assets.burgerProduct, name: "The Doppler", tagline: "The classic burger is an all time BBQ favorite! This super easy", rating: "4.5", price:"RS 600"),
  FoodModel(image: Assets.burgerProduct, name: "The Doppler", tagline: "The classic burger is an all time BBQ favorite! This super easy", rating: "4.5", price:"RS 600"),
  FoodModel(image: Assets.burgerProduct, name: "The Doppler", tagline: "The classic burger is an all time BBQ favorite! This super easy", rating: "4.5", price:"RS 600"),
  FoodModel(image: Assets.burgerProduct, name: "The Doppler", tagline: "The classic burger is an all time BBQ favorite! This super easy", rating: "4.5", price:"RS 600"),

];