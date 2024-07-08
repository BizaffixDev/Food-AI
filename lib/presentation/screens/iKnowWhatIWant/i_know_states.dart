import 'package:foodai_mobile/presentation/providers/screen_state.dart';

abstract class IKnowStates {}

class IKnowInitialState extends IKnowStates {}

class IKnowLoadingState extends IKnowStates {}

class IKnowSuccessfulState extends IKnowStates {}

class IKnowErrorState extends IKnowStates {
  final ErrorType errorType;
  final String error;

  IKnowErrorState({required this.error, required this.errorType});
}



class RestaurantDetailLoadingState extends IKnowStates {}

class RestaurantDetailSuccessfulState extends IKnowStates {}

class RestaurantDetailErrorState extends IKnowStates {
  final ErrorType errorType;
  final String error;

  RestaurantDetailErrorState({required this.error, required this.errorType});
}

class AddCartLoadingState extends IKnowStates {}

class AddCartSuccessfulState extends IKnowStates {}

class AddCartErrorState extends IKnowStates {
  final ErrorType errorType;
  final String error;

  AddCartErrorState({required this.error, required this.errorType});
}

