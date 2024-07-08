import 'package:flutter/material.dart';
import 'package:foodai_mobile/data/data_sources/user_local_data_source.dart';
import 'package:foodai_mobile/data/models/forget_password_request_model.dart';
import 'package:foodai_mobile/data/models/forget_password_response_model.dart';
import 'package:foodai_mobile/data/models/like_dislike_request_model.dart';
import 'package:foodai_mobile/data/models/like_dislike_respponse_model.dart';
import 'package:foodai_mobile/data/models/login_request_model.dart';
import 'package:foodai_mobile/data/models/login_response_model.dart';
import 'package:foodai_mobile/data/models/new_password_request_model.dart';
import 'package:foodai_mobile/data/models/new_password_response_model.dart';
import 'package:foodai_mobile/data/models/otp_request_model.dart';
import 'package:foodai_mobile/data/models/otp_response_model.dart';
import 'package:foodai_mobile/data/models/preferences_response_model.dart';
import 'package:foodai_mobile/data/models/sign_up_request_model.dart';
import 'package:foodai_mobile/data/models/sign_up_response_model.dart';
import 'package:foodai_mobile/data/network/end_points.dart';
import 'package:foodai_mobile/data/network/rest_api_client.dart';
import 'package:get_it/get_it.dart';

abstract class AuthDataSource {

  Future<LoginResponseModel> loginUser({
    required String email,
    required String password
});

  Future<SignUpResponse> signupUser(
      {required String username,
        required String email,
        required String password,
      required String address,
      required String phoneNumber}
      );



  Future<OtpResponseModel> verifyOtp(
      {required String email,
        required int otp,
        }
      );


  Future<ForgetPasswordResponseModel> forgetPassword(
      {required String email});

  Future<NewPasswordResponseModel> newPassword({
    required String email,
    required String password
  });


  Future<List<PreferencesData>> getPreferencesData();

  Future<LikeDislikeResponseModel> likeDislikeResponse({
    required int userId,
    required int questionId,
    required bool userResponse,
});


}



class AuthDataSourceImpl implements AuthDataSource {
  AuthDataSourceImpl()
      : _restClient = GetIt.instance<ApiService>(),
        _userLocalDataSource = GetIt.instance<UserLocalDataSource>();

  final ApiService _restClient;
  final UserLocalDataSource _userLocalDataSource;




  @override
  Future<LoginResponseModel> loginUser({required String email, required String password}) async{
    LoginRequestModel data = LoginRequestModel(
        email: email,
    password: password,
    );

    final result = await _restClient.post(Endpoints.login, data,
        isSignUporLogin: true);

    debugPrint('This is the result for login $result');
    if (result.data == null) {
      throw Exception('Empty response');
    }
    final response = LoginResponseModel.fromJson(result.data);
    debugPrint('This is the response $response');
    return response;
  }



  @override
  Future<SignUpResponse> signupUser({required String username,
    required String email,
    required String password,
    required String address,
    required String phoneNumber}) async{
    SignupRequest data = SignupRequest(
        fullname: username,
        email: email,
        password: password,
        confirmPassword: password,
    address: address,
    phoneNumber: phoneNumber);

    final result = await _restClient.post(Endpoints.signupUser, data,
        isSignUporLogin: true);

    debugPrint('This is the result $result');
    if (result.data == null) {
      throw Exception('Empty response');
    }
    final response = SignUpResponse.fromJson(result.data);
    debugPrint('This is the response $response');
    return response;
  }

  @override
  Future<OtpResponseModel> verifyOtp({required String email, required int otp}) async{
    OtpRequestModel data = OtpRequestModel(
    email: email,
    otp: otp,
    );

    final result = await _restClient.post(Endpoints.otpVerify, data,
        isSignUporLogin: true);

    debugPrint('This is the result od otp verification $result');
    if (result.data == null) {
      throw Exception('Empty response');
    }
    final response = OtpResponseModel.fromJson(result.data);
    debugPrint('This is the response $response');
    return response;
  }

  @override
  Future<ForgetPasswordResponseModel> forgetPassword({required String email}) async{
    ForgetPasswordRequestModel data = ForgetPasswordRequestModel(
      email: email,

    );

    final result = await _restClient.post(Endpoints.forgetPassword, data,
        isSignUporLogin: true);

    debugPrint('This is the result of forget Otp $result');
    if (result.data == null) {
      throw Exception('Empty response');
    }
    final response = ForgetPasswordResponseModel.fromJson(result.data);
    debugPrint('This is the response $response');
    return response;
  }

  @override
  Future<NewPasswordResponseModel> newPassword({required String email, required String password})async{
    NewPasswordRequestModel data = NewPasswordRequestModel(
      email: email,
      password:password,
      confirmPassword: password,


    );

    final result = await _restClient.post(Endpoints.newPassword, data,
        isSignUporLogin: true);

    debugPrint('This is the result of new password $result');
    if (result.data == null) {
      throw Exception('Empty response');
    }
    final response = NewPasswordResponseModel.fromJson(result.data);
    debugPrint('This is the response $response');
    return response;
  }

  @override
  Future<List<PreferencesData>> getPreferencesData() async{
    final result = await _restClient.get(
      Endpoints.getPreferences,
      queryParameters: {},
    );
    print('This is the result of get Preferences list $result');
    final response = PreferencesResponseModel.fromJson(result.data);
    print('This is the response of decoded List ${response.data}');
    return response.data;
  }

  @override
  Future<LikeDislikeResponseModel> likeDislikeResponse({
    required int userId,
    required int questionId,
    required bool userResponse,
}) async {
    LikeDislikeRequestModel data = LikeDislikeRequestModel(
     userId: userId,
      questionId: questionId,
      userResponse:userResponse


    );

    final result = await _restClient.post(Endpoints.likeDislikeResponse, data,
        isSignUporLogin: true);

    debugPrint('This is the result of like dislike $result');
    if (result.data == null) {
      throw Exception('Empty response');
    }
    final response = LikeDislikeResponseModel.fromJson(result.data);
    debugPrint('This is the response $response');
    return response;
  }


}
