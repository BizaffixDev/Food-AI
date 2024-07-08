import 'package:foodai_mobile/presentation/providers/screen_state.dart';

abstract class DiscoverStates {}

class DiscoverInitialState extends DiscoverStates {}

class CuisinesLoadingState extends DiscoverStates {}

class CuisinesSuccessfulState extends DiscoverStates {}

class CuisinesErrorState extends DiscoverStates {
  final ErrorType errorType;
  final String error;

  CuisinesErrorState({required this.error, required this.errorType});
}

class PreferenceCuisinesLoadingState extends DiscoverStates {}

class PreferenceCuisinesSuccessfulState extends DiscoverStates {}

class PreferenceCuisinesErrorState extends DiscoverStates {
  final ErrorType errorType;
  final String error;

  PreferenceCuisinesErrorState({required this.error, required this.errorType});
}


class PreferenceResponseLoadingState extends DiscoverStates {}

class PreferenceResponseSuccessfulState extends DiscoverStates {}

class PreferenceResponseErrorState extends DiscoverStates {
  final ErrorType errorType;
  final String error;

  PreferenceResponseErrorState({required this.error, required this.errorType});
}



