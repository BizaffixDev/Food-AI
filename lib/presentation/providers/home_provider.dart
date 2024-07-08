import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodai_mobile/data/data_sources/user_local_data_source.dart';
import 'package:foodai_mobile/data/models/login_response_model.dart';
import 'package:foodai_mobile/data/models/preferences_response_model.dart';
import 'package:foodai_mobile/data/network/error_handler_interceptor.dart';
import 'package:foodai_mobile/data/respository/home_respository.dart';
import 'package:foodai_mobile/presentation/providers/screen_state.dart';
import 'package:foodai_mobile/presentation/screens/home/home_states.dart';
import 'package:get_it/get_it.dart';

final homeNotifyProvider =
    StateNotifierProvider.autoDispose<HomeNotifier, HomeStates>((ref) {
  return HomeNotifier(
    homeRepository: GetIt.I<HomeRepository>(),
    userLocalDataSource: GetIt.I<UserLocalDataSource>(),
    ref: ref,
  );
});

class HomeNotifier extends StateNotifier<HomeStates> {
  HomeNotifier({
    required this.ref,
     required this.homeRepository,
    required this.userLocalDataSource,
  }) : super(HomeInitialState());

  final Ref ref;

  final HomeRepository homeRepository;
  final UserLocalDataSource userLocalDataSource;

  Future getUserData() async {
    LoginData? user = await userLocalDataSource.getUser();
    print(user?.email.toString());
    print(user?.userId.toString());
    print(user?.username.toString());
    ref.read(userObjectProvider.notifier).state = user!;
  }


  Future getPreferences() async {
    if (ref.watch(preferencesDiscoverProvider).isNotEmpty) {
      return;
    }
    try {
      state = DiscoverLoadingState();
      final response =  await homeRepository.getPreferencesData();
      ref.read(preferencesDiscoverProvider.notifier).state.addAll(response);
      state = DiscoverSuccessfulState();
    } on UnauthorizedException catch (e) {
      debugPrint('This is the unauthorized part');
      state = DiscoverErrorState(
          error: e.message.toString(), errorType: ErrorType.inline);
    } on BackendResponseError catch (e) {
      if (e.statusCode == 400) {
        // Handle the 400 error scenario
        // Access the errors from the responseErrors property of the BackendResponseError
        final responseErrors = e.responseErrors;
        final errorMessages = responseErrors
            .map((error) => '${error.message}: ${error.messages?.join(", ")}')
            .join("\n");
        state = DiscoverErrorState(
            error: errorMessages.toString(), errorType: ErrorType.inline);
      } else if (e.statusCode == 422) {
        debugPrint('going inside this BackendResponseError block bro');

        state = DiscoverErrorState(
            error: e.message, errorType: ErrorType.inline);
      } else {
        debugPrint('I guess it should be here');
        state = DiscoverErrorState(
            error: e.message, errorType: ErrorType.other);
      }
    } on NoInternetConnectionException catch (e) {
      debugPrint('going inside this NoInternetConnectionException block bro');
      state =
          DiscoverErrorState(error: e.message, errorType: ErrorType.other);
    } on DioError catch (e) {
      debugPrint('going inside this DioError block bro');
      debugPrint("This is e.response ${e.response}");
      if (e.response?.statusCode == 400) {
        state = DiscoverErrorState(
            error: e.response!.data.toString(), errorType: ErrorType.other);
      }
      if (e.response != null) {
        final errorResponse = e.response!.data;
        final title = errorResponse['title'];
        debugPrint('ERROR RESPONSE: $errorResponse');
        debugPrint('Title: $title');
      }
      debugPrint(e.toString());
      state = DiscoverErrorState(
          error: e.toString(), errorType: ErrorType.other);
    }
  }


  Future userResponse(
      {required int userId, required int questionId, required bool userResponse}
      ) async {

    try {


      state = DiscoverResponseLoadingState();
      await homeRepository.likeDislikeResponse(userId: userId, questionId: questionId, userResponse: userResponse);

      if(mounted){
        state = DiscoverResponseSuccessfulState();
      }


    } on UnauthorizedException catch (e) {
      debugPrint('This is the unauthorized part');
      state =DiscoverResponseErrorState(
          error: e.message.toString(), errorType: ErrorType.inline);
    } on BackendResponseError catch (e) {
      if (e.statusCode == 400) {
        // Handle the 400 error scenario
        // Access the errors from the responseErrors property of the BackendResponseError
        final responseErrors = e.responseErrors;
        final errorMessages = responseErrors
            .map((error) => '${error.message}: ${error.messages?.join(", ")}')
            .join("\n");
        state = DiscoverResponseErrorState(
            error: errorMessages.toString(), errorType: ErrorType.inline);
      } else if (e.statusCode == 422) {
        debugPrint('going inside this BackendResponseError block bro');

        state = DiscoverResponseErrorState(
            error: e.message, errorType: ErrorType.inline);
      } else {
        debugPrint('I guess it should be here');
        state = DiscoverResponseErrorState(
            error: e.message, errorType: ErrorType.other);
      }
    } on NoInternetConnectionException catch (e) {
      debugPrint('going inside this NoInternetConnectionException block bro');
      state =
          DiscoverResponseErrorState(error: e.message, errorType: ErrorType.other);
    } on DioError catch (e) {
      debugPrint('going inside this DioError block bro');
      debugPrint("This is e.response ${e.response}");
      if (e.response?.statusCode == 400) {
        state = DiscoverResponseErrorState(
            error: e.response!.data.toString(), errorType: ErrorType.other);
      }
      if (e.response != null) {
        final errorResponse = e.response!.data;
        final title = errorResponse['title'];
        debugPrint('ERROR RESPONSE: $errorResponse');
        debugPrint('Title: $title');
      }
      debugPrint(e.toString());
      state = DiscoverResponseErrorState(
          error: e.toString(), errorType: ErrorType.other);
    }
  }


}

final userObjectProvider = StateProvider<LoginData>((ref) {
  return LoginData(
      userId: 1,
      email: '',
      username: '',
      address: '',
      token: '',
      isEmailVerified: false);
});


final preferencesDiscoverProvider = StateProvider<List<PreferencesData>>((ref) {
  return [];
});