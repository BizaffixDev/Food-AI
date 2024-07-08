import '../data_sources/cart_data_source.dart';
import '../models/add_to_cart_response_model.dart';
import '../models/cart_item_increment_decrement_response_model.dart';
import '../models/cart_response_model.dart';


abstract class CartRepository {

  Future<AddToCartResponseModel> addToCart({
    required int dishId,
    required int userId,
    required int quantity,
  });


  Future<List<CartDetailData>> getCartDetails({required int userId});

  Future<CartIncDecData> incrementItem({required int userId, required int cartItemId});
  Future<CartIncDecData> decrementItem({required int userId, required int cartItemId});

}


class CartRepositoryImpl extends CartRepository {
  final CartDataSource cartDataSource;

  CartRepositoryImpl(this.cartDataSource,);

  @override
  Future<AddToCartResponseModel> addToCart({required int dishId, required int userId, required int quantity}) {
    return cartDataSource.addToCart(dishId: dishId, userId: userId, quantity: quantity);
  }

  @override
  Future<List<CartDetailData>> getCartDetails({required int userId}) {
    return cartDataSource.getCartDetails(userId: userId);
  }



  @override
  Future<CartIncDecData> incrementItem({required int userId, required int cartItemId}) {
    return cartDataSource.incrementItem(userId: userId, cartItemId: cartItemId);
  }

  @override
  Future<CartIncDecData> decrementItem({required int userId, required int cartItemId}) {
    return cartDataSource.decrementItem(userId: userId, cartItemId: cartItemId);
  }




}