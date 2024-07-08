

import 'package:foodai_mobile/presentation/providers/screen_state.dart';

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

/// LOGIN STATES
class LoginLoadingState extends AuthStates {}
class LoginSuccessfulState extends AuthStates {}
class LoginErrorState extends AuthStates {
  final ErrorType errorType;
  final String error;

  LoginErrorState({required this.error, required this.errorType});
}


/// SIGN UP STATES
class SignUpLoadingState extends AuthStates {}
class SignUpSuccessfulState extends AuthStates {}
class SignUpErrorState extends AuthStates {
  final ErrorType errorType;
  final String error;

  SignUpErrorState({required this.error, required this.errorType});
}



/// OTP VERIFICATION STATES
class OtpVerifyLoadingState extends AuthStates {}
class OtpVerifySuccessfulState extends AuthStates {}
class OtpVerifyErrorState extends AuthStates {
  final ErrorType errorType;
  final String error;

  OtpVerifyErrorState({required this.error, required this.errorType});
}


/// FORGET PASSWORD STATES
class ForgetPasswordLoadingState extends AuthStates {}
class  ForgetPasswordSuccessfulState extends AuthStates {}
class  ForgetPasswordErrorState extends AuthStates {
  final ErrorType errorType;
  final String error;

  ForgetPasswordErrorState({required this.error, required this.errorType});
}


/// FORGOT OTP VERIFICATION STATES
class OtpVerifyForgetLoadingState extends AuthStates {}
class OtpVerifyForgetSuccessfulState extends AuthStates {}
class OtpVerifyForgetErrorState extends AuthStates {
  final ErrorType errorType;
  final String error;

  OtpVerifyForgetErrorState({required this.error, required this.errorType});
}


/// NEW PASSWORD STATES
class NewPasswordLoadingState extends AuthStates {}
class NewPasswordSuccessfulState extends AuthStates {}
class  NewPasswordErrorState extends AuthStates {
  final ErrorType errorType;
  final String error;

  NewPasswordErrorState({required this.error, required this.errorType});
}



/// GET PREFERENCES STATES
class PreferencesLoadingState extends AuthStates {}
class PreferencesSuccessfulState extends AuthStates {}
class  PreferencesErrorState extends AuthStates {
  final ErrorType errorType;
  final String error;

  PreferencesErrorState({required this.error, required this.errorType});
}


/// LiKE DISLIKE PREFERENCES STATES
class UserResponseLoadingState extends AuthStates {}
class UserResponseSuccessfulState extends AuthStates {}
class  UserResponseErrorState extends AuthStates {
  final ErrorType errorType;
  final String error;

  UserResponseErrorState({required this.error, required this.errorType});
}










