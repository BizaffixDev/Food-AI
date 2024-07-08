import 'package:foodai_mobile/common/resources/drawables.dart';

class CategoryModel{

  final String image;
  final String name;
  bool isSelected;

  CategoryModel({
    required this.image,
    required this.name,
    this.isSelected = false, // Initialize isSelected as false
});

}

List<CategoryModel> categories = [
  
  CategoryModel(image: Drawables.burger, name: "Burger",isSelected: true),
  CategoryModel(image: Drawables.sandwich, name: "Sandwich"),
  CategoryModel(image: Drawables.bbq, name: "Bbq"),
  CategoryModel(image: Drawables.chinese, name: "Chinese"),

];