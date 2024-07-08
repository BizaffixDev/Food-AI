import 'package:foodai_mobile/presentation/providers/screen_state.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessfulState extends HomeStates {}

class HomeErrorState extends HomeStates {
  final ErrorType errorType;
  final String error;

  HomeErrorState({required this.error, required this.errorType});
}


class DiscoverLoadingState extends HomeStates {}

class DiscoverSuccessfulState extends HomeStates {}

class DiscoverErrorState extends HomeStates {
  final ErrorType errorType;
  final String error;

  DiscoverErrorState({required this.error, required this.errorType});
}


class DiscoverResponseLoadingState extends HomeStates {}

class DiscoverResponseSuccessfulState extends HomeStates {}

class DiscoverResponseErrorState extends HomeStates {
  final ErrorType errorType;
  final String error;

  DiscoverResponseErrorState({required this.error, required this.errorType});
}


