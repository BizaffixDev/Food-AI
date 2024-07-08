

import '../../providers/screen_state.dart';

abstract class NotificationStates {}

class NotificationInitialState extends NotificationStates {}

class  NotificationLoadingState extends NotificationStates {}
class  NotificationSuccessfulState extends NotificationStates {
}

class  NotificationErrorState extends NotificationStates {
  final ErrorType errorType;
  final String error;

  NotificationErrorState({required this.error, required this.errorType});
}





