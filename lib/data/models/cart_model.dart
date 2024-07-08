import 'package:foodai_mobile/generated/assets.dart';

class CartModel {
  final String name;
  final String image;
  final String price;
   int quantity;

   CartModel({
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });
}

List<CartModel> cartItems = [
   CartModel(
    name: "THE DOPPLER",
    price: "RS 600",
    image: Assets.burgerProduct,
    quantity: 1,
  ),

   CartModel(
    name: "DOUBLE DECKER",
    price: "RS 650",
    image: Assets.burgerProduct,
    quantity: 1,
  ),


];
