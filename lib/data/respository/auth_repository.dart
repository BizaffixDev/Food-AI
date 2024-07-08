import 'package:foodai_mobile/data/data_sources/auth_data_source.dart';
import 'package:foodai_mobile/data/models/forget_password_response_model.dart';
import 'package:foodai_mobile/data/models/like_dislike_respponse_model.dart';
import 'package:foodai_mobile/data/models/login_response_model.dart';
import 'package:foodai_mobile/data/models/new_password_response_model.dart';
import 'package:foodai_mobile/data/models/otp_response_model.dart';
import 'package:foodai_mobile/data/models/preferences_response_model.dart';
import 'package:foodai_mobile/data/models/sign_up_response_model.dart';

abstract class AuthRepository {


  Future<LoginResponseModel> loginUser({
    required String email,
    required String password
  });

  Future<SignUpResponse> signupUser( {required String username,
    required String email,
    required String password,
    required String address,
    required String phoneNumber});


  Future<OtpResponseModel> verifyOtp(
      {required String email,
        required int otp,
      }
      );


  Future<ForgetPasswordResponseModel> forgetPassword(
      {required String email}
      );


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


class AuthRepositoryImpl extends AuthRepository{
   final AuthDataSource authDataSource;

   AuthRepositoryImpl(
      this.authDataSource,
      );


   @override
   Future<LoginResponseModel> loginUser({required String email, required String password}) {
     return authDataSource.loginUser(email: email, password: password);
   }


  @override
  Future<SignUpResponse> signupUser({required String username, required String email, required String password, required String address,
    required String phoneNumber}) {
    return authDataSource.signupUser(username: username, email: email, password: password,address:address,phoneNumber:phoneNumber);
  }

  @override
  Future<OtpResponseModel> verifyOtp({required String email, required int otp}) {
    return authDataSource.verifyOtp(email: email, otp: otp);
  }

  @override
  Future<ForgetPasswordResponseModel> forgetPassword({required String email}) {
    return authDataSource.forgetPassword(email: email);
  }

  @override
  Future<NewPasswordResponseModel> newPassword({required String email, required String password}) {
    return authDataSource.newPassword(email: email, password: password);
  }

  @override
  Future<List<PreferencesData>> getPreferencesData() {
    return authDataSource.getPreferencesData();
  }

  @override
  Future<LikeDislikeResponseModel> likeDislikeResponse({required int userId, required int questionId, required bool userResponse}) {
    return authDataSource.likeDislikeResponse(userId: userId, questionId: questionId, userResponse: userResponse);
  }





}