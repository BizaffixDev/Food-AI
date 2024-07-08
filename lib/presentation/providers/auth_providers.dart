import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodai_mobile/data/data_sources/user_local_data_source.dart';
import 'package:foodai_mobile/data/models/login_response_model.dart';
import 'package:foodai_mobile/data/models/preferences_response_model.dart';
import 'package:foodai_mobile/data/network/error_handler_interceptor.dart';
import 'package:foodai_mobile/data/respository/auth_repository.dart';
import 'package:foodai_mobile/presentation/providers/screen_state.dart';
import 'package:foodai_mobile/presentation/screens/auth/states/auth_states.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';



///This is the provider for the AuthNotifier Below,
///use this whereever you need authNotifier methods.
final authNotifyProvider =
StateNotifierProvider.autoDispose<AuthNotifier, AuthStates>((ref) {
  return AuthNotifier(
   authRepository: GetIt.I<AuthRepository>(),
    userLocalDataSource: GetIt.I<UserLocalDataSource>(),
    ref: ref,
  );
});




/// STATE NOTIFIER ONLY NOTIFIES ITS CHILDREN ANYWHERE THEY ARE IN THE APP.

class AuthNotifier extends StateNotifier<AuthStates> {
  AuthNotifier({
    required this.ref,
    required this.authRepository,
    required this.userLocalDataSource,
  }) : super(AuthInitialState());



  final Ref ref;
  final AuthRepository authRepository;
  final UserLocalDataSource userLocalDataSource;


  ///getting current location of user


  Future<Position> getCurrentLocation() async{
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error("Location services are enabled");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('Location permissions are denied');
      }

    }
    if(permission == LocationPermission.deniedForever){
      return Future.error('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition();
  }




  Future loginUser(BuildContext context,
      {required String email,
        required String password}) async {
    try {
      state = LoginLoadingState();
      final response = await authRepository.loginUser(
         email: email, password: password);
      LoginResponseModel signupToSignIn = LoginResponseModel(
        statusCode: response.statusCode,
        message: response.message,
        data: LoginData(
          email: response.data.email,
          userId: response.data.userId,
          token: response.data.token,
          username: response.data.username,
          address: response.data.address,
          isEmailVerified: response.data.isEmailVerified,
        ),
      );
      await userLocalDataSource.persistUser(signupToSignIn);
      debugPrint(
          'This is user persisted in SignUp With google ${await userLocalDataSource.getUser()}');
      state = LoginSuccessfulState();
      // debugPrint(response);
      return;
    } on UnauthorizedException catch (e) {
      debugPrint('This is the unauthorized part');
      state = LoginErrorState(error: e.response!.statusMessage.toString(), errorType: ErrorType.inline);
    } on BackendResponseError catch (e) {
      if (e.statusCode == 400) {
        // Handle the 400 error scenario
        // Access the errors from the responseErrors property of the BackendResponseError
        final responseErrors = e.responseErrors;
        final errorMessages = responseErrors
            .map((error) => error.messages?.first)
            .join("\n");
        state = LoginErrorState(
            error: errorMessages ?? '',
            errorType: ErrorType.inline);
      } else if (e.statusCode == 422) {
        debugPrint('going inside this BackendResponseError block bro');

        state = LoginErrorState(error: e.message, errorType: ErrorType.inline);
      } else {
        debugPrint('I guess it should be here');
        state = LoginErrorState(error: e.message, errorType: ErrorType.other);
      }
    } on NoInternetConnectionException catch (e) {
      debugPrint('going inside this NoInternetConnectionException block bro');
      state = LoginErrorState(error: e.message, errorType: ErrorType.other);
    } on DioError catch (e) {
      debugPrint('going inside this DioError block bro');
      debugPrint("This is e.response ${e.response}");
      if (e.response?.statusCode == 400) {
        state = LoginErrorState(
            error: e.response!.data.toString(), errorType: ErrorType.other);
      }
      if (e.response != null) {
        final errorResponse = e.response!.data;
        final title = errorResponse['title'];
        debugPrint('ERROR RESPONSE: $errorResponse');
        debugPrint('Title: $title');
      }
      debugPrint(e.toString());
      state = LoginErrorState(error: e.toString(), errorType: ErrorType.other);
    }
  }


  Future signupUser(BuildContext context,
      {required String username,
        required String email,
        required String password,
        required String address,
        required String phoneNumber}) async {
    try {
      state = SignUpLoadingState();
      final response = await authRepository.signupUser(
          username: username, email: email, password: password,
      address: address,phoneNumber: phoneNumber);
      LoginResponseModel signupToSignIn = LoginResponseModel(
        statusCode: response.statusCode,
        message: response.message,
        data: LoginData(
          email: response.data.email,
          userId: response.data.userId,
          address: response.data.address,
          token: response.data.token,
          isEmailVerified: false,
          username: response.data.username,
        ),
      );
      await userLocalDataSource.persistUser(signupToSignIn);
      debugPrint(
          'This is user persisted in SignUp With google ${await userLocalDataSource.getUser()}');
      // LoginResponseModel loginResponseModel = LoginResponseModel(
      //   userId: response.userId,
      //   email: response.email.toString(),
      //   // password: password,
      //   username: username,
      //   token: response.userId.toString(),
      //   userType: response.userType.toString(),
      //   message: response.message.toString(),
      // );

      state = SignUpSuccessfulState();
      // debugPrint(response);
      return;
    } on UnauthorizedException catch (e) {
      debugPrint('This is the unauthorized part');
      state = SignUpErrorState(error: e.message, errorType: ErrorType.inline);
    } on BackendResponseError catch (e) {
      if (e.statusCode == 400) {
        // Handle the 400 error scenario
        // Access the errors from the responseErrors property of the BackendResponseError
        final responseErrors = e.responseErrors;
        final errorMessages = responseErrors
            .map((error) => '${error.messages?.join(", ")}')
            .join("\n");
        state = SignUpErrorState(
            error: errorMessages.toString(), errorType: ErrorType.inline);
      } else if (e.statusCode == 422) {
        debugPrint('going inside this BackendResponseError block bro');

        state = SignUpErrorState(error: e.message, errorType: ErrorType.inline);
      } else {
        debugPrint('I guess it should be here');
        state = SignUpErrorState(error: e.message, errorType: ErrorType.other);
      }
    } on NoInternetConnectionException catch (e) {
      debugPrint('going inside this NoInternetConnectionException block bro');
      state = SignUpErrorState(error: e.message, errorType: ErrorType.other);
    } on DioError catch (e) {
      debugPrint('going inside this DioError block bro');
      debugPrint("This is e.response ${e.response}");
      if (e.response?.statusCode == 400) {
        state = SignUpErrorState(
            error: e.response!.data.toString(), errorType: ErrorType.other);
      }
      if (e.response != null) {
        final errorResponse = e.response!.data;
        final title = errorResponse['title'];
        debugPrint('ERROR RESPONSE: $errorResponse');
        debugPrint('Title: $title');
      }
      debugPrint(e.toString());
      state = SignUpErrorState(error: e.toString(), errorType: ErrorType.other);
    }
  }



  Future verifyOtp(BuildContext context,
      {required String email, required int otp}) async {
    try {
      state = OtpVerifyLoadingState();
      final response =
      await authRepository.verifyOtp(email: email, otp: otp);
      print("this is the response from backend $response");
      if (response.message == 'Otp verified.') {
        state = OtpVerifySuccessfulState();
      } else {
        state = OtpVerifyErrorState(
            error: response.message.toString(), errorType: ErrorType.other);
      }
    } on UnauthorizedException catch (e) {
      debugPrint('This is the unauthorized part');
      state = OtpVerifyErrorState(
          error: e.message.toString(), errorType: ErrorType.inline);
    } on BackendResponseError catch (e) {
      if (e.statusCode == 400) {
        // Handle the 400 error scenario
        // Access the errors from the responseErrors property of the BackendResponseError
        final responseErrors = e.responseErrors;
        final errorMessages = responseErrors
            .map((error) => '${error.message}: ${error.messages?.join(", ")}')
            .join("\n");
        state = OtpVerifyErrorState(
            error: errorMessages.toString(), errorType: ErrorType.inline);
      } else if (e.statusCode == 422) {
        debugPrint('going inside this BackendResponseError block bro');

        state = OtpVerifyErrorState(
            error: e.message, errorType: ErrorType.inline);
      } else {
        debugPrint('I guess it should be here');
        state = OtpVerifyErrorState(
            error: e.message, errorType: ErrorType.other);
      }
    } on NoInternetConnectionException catch (e) {
      debugPrint('going inside this NoInternetConnectionException block bro');
      state = OtpVerifyErrorState(
          error: e.message, errorType: ErrorType.other);
    } on DioError catch (e) {
      debugPrint('going inside this DioError block bro');
      debugPrint("This is e.response ${e.response}");
      if (e.response?.statusCode == 400) {
        state = OtpVerifyErrorState(
            error: e.response!.data.toString(), errorType: ErrorType.other);
      }
      if (e.response != null) {
        final errorResponse = e.response!.data;
        final title = errorResponse['title'];
        debugPrint('ERROR RESPONSE: $errorResponse');
        debugPrint('Title: $title');
      }
      debugPrint(e.toString());
      state = OtpVerifyErrorState(
          error: e.toString(), errorType: ErrorType.other);
    }
  }



  Future forgetPassword(BuildContext context,
      {required String email}) async {
    try {
      state = ForgetPasswordLoadingState();
      final response =
      await authRepository.forgetPassword(email: email);
      print("this is the response from backend $response");
      if (response.message == 'Please, check mail for otp.') {
        state = ForgetPasswordSuccessfulState();
      } else {
        state = ForgetPasswordErrorState(
            error: response.message.toString(), errorType: ErrorType.other);
      }
    } on UnauthorizedException catch (e) {
      debugPrint('This is the unauthorized part');
      state = ForgetPasswordErrorState(
          error: e.message.toString(), errorType: ErrorType.inline);
    } on BackendResponseError catch (e) {
      if (e.statusCode == 400) {
        // Handle the 400 error scenario
        // Access the errors from the responseErrors property of the BackendResponseError
        final responseErrors = e.responseErrors;
        final errorMessages = responseErrors
            .map((error) => '${error.message}: ${error.messages?.join(", ")}')
            .join("\n");
        state = ForgetPasswordErrorState(
            error: errorMessages.toString(), errorType: ErrorType.inline);
      } else if (e.statusCode == 422) {
        debugPrint('going inside this BackendResponseError block bro');

        state = ForgetPasswordErrorState(
            error: e.message, errorType: ErrorType.inline);
      } else {
        debugPrint('I guess it should be here');
        state = ForgetPasswordErrorState(
            error: e.message, errorType: ErrorType.other);
      }
    } on NoInternetConnectionException catch (e) {
      debugPrint('going inside this NoInternetConnectionException block bro');
      state = ForgetPasswordErrorState(
          error: e.message, errorType: ErrorType.other);
    } on DioError catch (e) {
      debugPrint('going inside this DioError block bro');
      debugPrint("This is e.response ${e.response}");
      if (e.response?.statusCode == 400) {
        state = ForgetPasswordErrorState(
            error: e.response!.data.toString(), errorType: ErrorType.other);
      }
      if (e.response != null) {
        final errorResponse = e.response!.data;
        final title = errorResponse['title'];
        debugPrint('ERROR RESPONSE: $errorResponse');
        debugPrint('Title: $title');
      }
      debugPrint(e.toString());
      state = ForgetPasswordErrorState(
          error: e.toString(), errorType: ErrorType.other);
    }
  }


  Future verifyForgetOtp(BuildContext context,
      {required String email, required int otp}) async {
    try {
      state = OtpVerifyForgetLoadingState();
      final response =
      await authRepository.verifyOtp(email: email, otp: otp);
      print("this is the response from backend $response");
      if (response.message == 'Otp verified.') {
        state = OtpVerifyForgetSuccessfulState();
      } else {
        state = OtpVerifyForgetErrorState(
            error: response.message.toString(), errorType: ErrorType.other);
      }
    } on UnauthorizedException catch (e) {
      debugPrint('This is the unauthorized part');
      state = OtpVerifyForgetErrorState(
          error: e.message.toString(), errorType: ErrorType.inline);
    } on BackendResponseError catch (e) {
      if (e.statusCode == 400) {
        // Handle the 400 error scenario
        // Access the errors from the responseErrors property of the BackendResponseError
        final responseErrors = e.responseErrors;
        final errorMessages = responseErrors
            .map((error) => '${error.message}: ${error.messages?.join(", ")}')
            .join("\n");
        state = OtpVerifyForgetErrorState(
            error: errorMessages.toString(), errorType: ErrorType.inline);
      } else if (e.statusCode == 422) {
        debugPrint('going inside this BackendResponseError block bro');

        state = OtpVerifyForgetErrorState(
            error: e.message, errorType: ErrorType.inline);
      } else {
        debugPrint('I guess it should be here');
        state = OtpVerifyForgetErrorState(
            error: e.message, errorType: ErrorType.other);
      }
    } on NoInternetConnectionException catch (e) {
      debugPrint('going inside this NoInternetConnectionException block bro');
      state = OtpVerifyForgetErrorState(
          error: e.message, errorType: ErrorType.other);
    } on DioError catch (e) {
      debugPrint('going inside this DioError block bro');
      debugPrint("This is e.response ${e.response}");
      if (e.response?.statusCode == 400) {
        state = OtpVerifyForgetErrorState(
            error: e.response!.data.toString(), errorType: ErrorType.other);
      }
      if (e.response != null) {
        final errorResponse = e.response!.data;
        final title = errorResponse['title'];
        debugPrint('ERROR RESPONSE: $errorResponse');
        debugPrint('Title: $title');
      }
      debugPrint(e.toString());
      state = OtpVerifyForgetErrorState(
          error: e.toString(), errorType: ErrorType.other);
    }
  }



  Future resetPassword(
      {required BuildContext context,
        required String email,
        required String password}) async {
    try {
      state = NewPasswordLoadingState();
      final response =
      await authRepository.newPassword(email: email, password: password);
      if (response.message.toString() == 'Password Changed Successfully.') {
        state = NewPasswordSuccessfulState();
      } else {
        state = NewPasswordErrorState(
            error: response.message.toString(), errorType: ErrorType.inline);
      }
    } on UnauthorizedException catch (e) {
      debugPrint('This is the unauthorized part');
      state = NewPasswordErrorState(
          error: e.message.toString(), errorType: ErrorType.inline);
    } on BackendResponseError catch (e) {
      if (e.statusCode == 400) {
        // Handle the 400 error scenario
        // Access the errors from the responseErrors property of the BackendResponseError
        final responseErrors = e.responseErrors;
        final errorMessages = responseErrors
            .map((error) => '${error.message}: ${error.messages?.join(", ")}')
            .join("\n");
        state = NewPasswordErrorState(
            error: errorMessages.toString(), errorType: ErrorType.inline);
      } else if (e.statusCode == 422) {
        debugPrint('going inside this BackendResponseError block bro');

        state = NewPasswordErrorState(
            error: e.message, errorType: ErrorType.inline);
      } else {
        debugPrint('I guess it should be here');
        state = NewPasswordErrorState(
            error: e.message, errorType: ErrorType.other);
      }
    } on NoInternetConnectionException catch (e) {
      debugPrint('going inside this NoInternetConnectionException block bro');
      state =
          NewPasswordErrorState(error: e.message, errorType: ErrorType.other);
    } on DioError catch (e) {
      debugPrint('going inside this DioError block bro');
      debugPrint("This is e.response ${e.response}");
      if (e.response?.statusCode == 400) {
        state = NewPasswordErrorState(
            error: e.response!.data.toString(), errorType: ErrorType.other);
      }
      if (e.response != null) {
        final errorResponse = e.response!.data;
        final title = errorResponse['title'];
        debugPrint('ERROR RESPONSE: $errorResponse');
        debugPrint('Title: $title');
      }
      debugPrint(e.toString());
      state = NewPasswordErrorState(
          error: e.toString(), errorType: ErrorType.other);
    }
  }



  Future getPreferences() async {
    if (ref.watch(preferencesProvider).isNotEmpty) {
      return;
    }
    try {
      state = PreferencesLoadingState();
     final response =  await authRepository.getPreferencesData();
     ref.read(preferencesProvider.notifier).state.addAll(response);
      state = PreferencesSuccessfulState();



    } on UnauthorizedException catch (e) {
      debugPrint('This is the unauthorized part');
      state = PreferencesErrorState(
          error: e.message.toString(), errorType: ErrorType.inline);
    } on BackendResponseError catch (e) {
      if (e.statusCode == 400) {
        // Handle the 400 error scenario
        // Access the errors from the responseErrors property of the BackendResponseError
        final responseErrors = e.responseErrors;
        final errorMessages = responseErrors
            .map((error) => '${error.message}: ${error.messages?.join(", ")}')
            .join("\n");
        state = PreferencesErrorState(
            error: errorMessages.toString(), errorType: ErrorType.inline);
      } else if (e.statusCode == 422) {
        debugPrint('going inside this BackendResponseError block bro');

        state = PreferencesErrorState(
            error: e.message, errorType: ErrorType.inline);
      } else {
        debugPrint('I guess it should be here');
        state = PreferencesErrorState(
            error: e.message, errorType: ErrorType.other);
      }
    } on NoInternetConnectionException catch (e) {
      debugPrint('going inside this NoInternetConnectionException block bro');
      state =
          PreferencesErrorState(error: e.message, errorType: ErrorType.other);
    } on DioError catch (e) {
      debugPrint('going inside this DioError block bro');
      debugPrint("This is e.response ${e.response}");
      if (e.response?.statusCode == 400) {
        state = PreferencesErrorState(
            error: e.response!.data.toString(), errorType: ErrorType.other);
      }
      if (e.response != null) {
        final errorResponse = e.response!.data;
        final title = errorResponse['title'];
        debugPrint('ERROR RESPONSE: $errorResponse');
        debugPrint('Title: $title');
      }
      debugPrint(e.toString());
      state = PreferencesErrorState(
          error: e.toString(), errorType: ErrorType.other);
    }
  }


  Future userResponse(
  {required int userId, required int questionId, required bool userResponse}
      ) async {

    try {


        state = UserResponseLoadingState();
        await authRepository.likeDislikeResponse(userId: userId, questionId: questionId, userResponse: userResponse);

        if(mounted){
          state = UserResponseSuccessfulState();
        }


    } on UnauthorizedException catch (e) {
      debugPrint('This is the unauthorized part');
      state = UserResponseErrorState(
          error: e.message.toString(), errorType: ErrorType.inline);
    } on BackendResponseError catch (e) {
      if (e.statusCode == 400) {
        // Handle the 400 error scenario
        // Access the errors from the responseErrors property of the BackendResponseError
        final responseErrors = e.responseErrors;
        final errorMessages = responseErrors
            .map((error) => '${error.message}: ${error.messages?.join(", ")}')
            .join("\n");
        state = UserResponseErrorState(
            error: errorMessages.toString(), errorType: ErrorType.inline);
      } else if (e.statusCode == 422) {
        debugPrint('going inside this BackendResponseError block bro');

        state = UserResponseErrorState(
            error: e.message, errorType: ErrorType.inline);
      } else {
        debugPrint('I guess it should be here');
        state = UserResponseErrorState(
            error: e.message, errorType: ErrorType.other);
      }
    } on NoInternetConnectionException catch (e) {
      debugPrint('going inside this NoInternetConnectionException block bro');
      state =
          UserResponseErrorState(error: e.message, errorType: ErrorType.other);
    } on DioError catch (e) {
      debugPrint('going inside this DioError block bro');
      debugPrint("This is e.response ${e.response}");
      if (e.response?.statusCode == 400) {
        state = UserResponseErrorState(
            error: e.response!.data.toString(), errorType: ErrorType.other);
      }
      if (e.response != null) {
        final errorResponse = e.response!.data;
        final title = errorResponse['title'];
        debugPrint('ERROR RESPONSE: $errorResponse');
        debugPrint('Title: $title');
      }
      debugPrint(e.toString());
      state = UserResponseErrorState(
          error: e.toString(), errorType: ErrorType.other);
    }
  }



}


final userIdProvider = StateProvider<int>((ref) {
  return 0;
});

final questionIdProvider = StateProvider<int>((ref) {
  return 0;
});


final preferencesProvider = StateProvider<List<PreferencesData>>((ref) {
  return [];
});


final userAddressProvider = StateProvider<String>((ref) {
  return '';
});
