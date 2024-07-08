import '../data_sources/cart_data_source.dart';
import '../models/add_to_cart_response_model.dart';
import '../models/cart_item_increment_decrement_response_model.dart';
import '../models/cart_response_model.dart';


abstract class CheckoutRepository {



  Future<List<CartDetailData>> getCartDetails({required int userId});


}


class CheckoutRepositoryImpl extends CheckoutRepository {
  final CartDataSource cartDataSource;

  CheckoutRepositoryImpl(this.cartDataSource,);


  @override
  Future<List<CartDetailData>> getCartDetails({required int userId}) {
    return cartDataSource.getCartDetails(userId: userId);
  }








}