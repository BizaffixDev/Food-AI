import 'package:foodai_mobile/presentation/providers/screen_state.dart';

abstract class CheckoutStates {}

class CheckoutInitialState extends CheckoutStates {}


class CartLoadingState extends CheckoutStates {}

class CartSuccessfulState extends CheckoutStates {}

class CartErrorState extends CheckoutStates {
  final ErrorType errorType;
  final String error;

  CartErrorState({required this.error, required this.errorType});
}