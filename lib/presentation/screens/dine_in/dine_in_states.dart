import 'package:foodai_mobile/presentation/providers/screen_state.dart';

abstract class DineInStates {}

class DineInInitialState extends DineInStates {}

class DineInLoadingState extends DineInStates {}

class DineInSuccessfulState extends DineInStates {}

class DineInErrorState extends DineInStates {
  final ErrorType errorType;
  final String error;

  DineInErrorState({required this.error, required this.errorType});
}


class LocationAddLoadingState extends DineInStates {}

class LocationAddSuccessfulState extends DineInStates {}

class LocationAddErrorState extends DineInStates {
  final ErrorType errorType;
  final String error;

  LocationAddErrorState({required this.error, required this.errorType});
}

class NearestRestaurantLoadingState extends DineInStates {}

class NearestRestaurantSuccessfulState extends DineInStates {}

class NearestRestaurantErrorState extends DineInStates {
  final ErrorType errorType;
  final String error;

  NearestRestaurantErrorState({required this.error, required this.errorType});
}



