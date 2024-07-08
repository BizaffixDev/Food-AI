import 'package:foodai_mobile/presentation/providers/screen_state.dart';

abstract class CartStates {}

class CartInitialState extends CartStates {}


class AddCartLoadingState extends CartStates {}

class AddCartSuccessfulState extends CartStates {}

class AddCartErrorState extends CartStates {
  final ErrorType errorType;
  final String error;

  AddCartErrorState({required this.error, required this.errorType});
}



class CartLoadingState extends CartStates {}

class CartSuccessfulState extends CartStates {}

class CartErrorState extends CartStates {
  final ErrorType errorType;
  final String error;

  CartErrorState({required this.error, required this.errorType});
}

class ItemIncrementDecrementLoadingState extends CartStates {}

class ItemIncrementDecrementSuccessfulState extends CartStates {}

class ItemIncrementDecrementErrorState extends CartStates {
  final ErrorType errorType;
  final String error;

  ItemIncrementDecrementErrorState({required this.error, required this.errorType});
}

