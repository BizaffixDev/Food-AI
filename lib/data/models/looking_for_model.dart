import 'package:foodai_mobile/generated/assets.dart';

class LookingForModel{

  final int id;
  final String image;
  final String title;

  const LookingForModel({required this.id,required this.image, required this.title});

}


List<LookingForModel> cuisinesList = const [
  LookingForModel(image: Assets.cuisine1, title: "Mid Night Snack", id: 1),
  LookingForModel(image: Assets.cuisine2, title: "Size Matters", id: 2),
  LookingForModel(image: Assets.cuisine3, title: "Sharing Is caring ", id: 3),
  LookingForModel(image: Assets.cuisine4, title: "Fuel Eating", id: 4),
  LookingForModel(image: Assets.cuisine5, title: "Fun Eating", id: 5),
  LookingForModel(image: Assets.cuisine6, title: "High On Motions", id: 6),
  LookingForModel(image: Assets.cuisine7, title: "Best Buddy", id: 7),
  LookingForModel(image: Assets.cuisine8, title: "Family", id: 8),
  LookingForModel(image: Assets.cuisine9, title: "Friends", id: 9),
];