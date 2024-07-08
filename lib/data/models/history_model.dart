import 'package:foodai_mobile/generated/assets.dart';

class HistoryModel {
  final String name;
  final String restaurantName;
  final String orderId;
  final String date;
  final String image;
  final String price;
  final String quantity;

  const HistoryModel( {
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.restaurantName, required this.orderId, required this.date,
  });
}

List<HistoryModel> historyItems = [
  const HistoryModel(
    name: "THE DOPPLER",
    price: "RS 600",
    image: Assets.burgerProduct,
    quantity: "1",
    date: "12 Mar 23  12:23 Am",
    orderId: "3434",
    restaurantName: "Foods In"
  ),

  const HistoryModel(
      name: "Double Decker",
      price: "RS 800",
      image: Assets.burgerProduct,
      quantity: "1",
      date: "12 Mar 23  12:23 Am",
      orderId: "3636",
      restaurantName: "Foods In"
  ),


];
