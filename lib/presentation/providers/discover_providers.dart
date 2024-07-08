import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodai_mobile/data/data_sources/user_local_data_source.dart';
import 'package:foodai_mobile/data/models/cuisine_preferences_response_model.dart';
import 'package:foodai_mobile/data/models/cusines_response_model.dart';
import 'package:foodai_mobile/data/models/login_response_model.dart';
import 'package:foodai_mobile/data/network/error_handler_interceptor.dart';
import 'package:foodai_mobile/data/respository/discover_respository.dart';
import 'package:foodai_mobile/presentation/providers/screen_state.dart';
import 'package:foodai_mobile/presentation/screens/discover/disover_states.dart';
import 'package:get_it/get_it.dart';

final discoverNotifyProvider =
StateNotifierProvider.autoDispose<DiscoverNotifier, DiscoverStates>((ref) {
  return DiscoverNotifier(
    discoverRepository: GetIt.I<DiscoverRepository>(),
    userLocalDataSource: GetIt.I<UserLocalDataSource>(),
    ref: ref,
  );
});

class DiscoverNotifier extends StateNotifier<DiscoverStates> {
  DiscoverNotifier({
    required this.ref,
    required this.discoverRepository,
    required this.userLocalDataSource,
  }) : super(DiscoverInitialState());

  final Ref ref;

  final DiscoverRepository discoverRepository;
  final UserLocalDataSource userLocalDataSource;



  Future getUserData() async {
    LoginData? user = await userLocalDataSource.getUser();
    print(user?.email.toString());
    print(user?.userId.toString());
    print(user?.username.toString());
    ref.read(userObjectProvider.notifier).state = user!;
  }



  Future getCuisines() async {
    if (ref.watch(cuisinesProvider).isNotEmpty) {
      return;
    }
    try {
      state = CuisinesLoadingState();
      final response =  await discoverRepository.getCuisinesList();
      ref.read(cuisinesProvider.notifier).state.addAll(response);
      state =  CuisinesSuccessfulState();
    } on UnauthorizedException catch (e) {
      debugPrint('This is the unauthorized part');
      state =  CuisinesErrorState(
          error: e.message.toString(), errorType: ErrorType.inline);
    } on BackendResponseError catch (e) {
      if (e.statusCode == 400) {
        // Handle the 400 error scenario
        // Access the errors from the responseErrors property of the BackendResponseError
        final responseErrors = e.responseErrors;
        final errorMessages = responseErrors
            .map((error) => '${error.message}: ${error.messages?.join(", ")}')
            .join("\n");
        state = CuisinesErrorState(
            error: errorMessages.toString(), errorType: ErrorType.inline);
      } else if (e.statusCode == 422) {
        debugPrint('going inside this BackendResponseError block bro');

        state = CuisinesErrorState(
            error: e.message, errorType: ErrorType.inline);
      } else {
        debugPrint('I guess it should be here');
        state = CuisinesErrorState(
            error: e.message, errorType: ErrorType.other);
      }
    } on NoInternetConnectionException catch (e) {
      debugPrint('going inside this NoInternetConnectionException block bro');
      state =
          CuisinesErrorState(error: e.message, errorType: ErrorType.other);
    } on DioError catch (e) {
      debugPrint('going inside this DioError block bro');
      debugPrint("This is e.response ${e.response}");
      if (e.response?.statusCode == 400) {
        state = CuisinesErrorState(
            error: e.response!.data.toString(), errorType: ErrorType.other);
      }
      if (e.response != null) {
        final errorResponse = e.response!.data;
        final title = errorResponse['title'];
        debugPrint('ERROR RESPONSE: $errorResponse');
        debugPrint('Title: $title');
      }
      debugPrint(e.toString());
      state = CuisinesErrorState(
          error: e.toString(), errorType: ErrorType.other);
    }
  }


  Future getPreferencesCuisines({required String cuisineId}) async {
    if (ref.watch(preferencesCuisinesProvider).isNotEmpty) {
      return;
    }
    try {
      state = PreferenceCuisinesLoadingState();
      final response =  await discoverRepository.getCuisinesPreferenceList(cuisineId: cuisineId);
      ref.read(preferencesCuisinesProvider.notifier).state.addAll(response);
      state =  PreferenceCuisinesSuccessfulState();
    } on UnauthorizedException catch (e) {
      debugPrint('This is the unauthorized part');
      state =  PreferenceCuisinesErrorState(
          error: e.message.toString(), errorType: ErrorType.inline);
    } on BackendResponseError catch (e) {
      if (e.statusCode == 400) {
        // Handle the 400 error scenario
        // Access the errors from the responseErrors property of the BackendResponseError
        final responseErrors = e.responseErrors;
        final errorMessages = responseErrors
            .map((error) => '${error.message}: ${error.messages?.join(", ")}')
            .join("\n");
        state = PreferenceCuisinesErrorState(
            error: errorMessages.toString(), errorType: ErrorType.inline);
      } else if (e.statusCode == 422) {
        debugPrint('going inside this BackendResponseError block bro');

        state = PreferenceCuisinesErrorState(
            error: e.message, errorType: ErrorType.inline);
      } else {
        debugPrint('I guess it should be here');
        state = PreferenceCuisinesErrorState(
            error: e.message, errorType: ErrorType.other);
      }
    } on NoInternetConnectionException catch (e) {
      debugPrint('going inside this NoInternetConnectionException block bro');
      state =
          PreferenceCuisinesErrorState(error: e.message, errorType: ErrorType.other);
    } on DioError catch (e) {
      debugPrint('going inside this DioError block bro');
      debugPrint("This is e.response ${e.response}");
      if (e.response?.statusCode == 400) {
        state = PreferenceCuisinesErrorState(
            error: e.response!.data.toString(), errorType: ErrorType.other);
      }
      if (e.response != null) {
        final errorResponse = e.response!.data;
        final title = errorResponse['title'];
        debugPrint('ERROR RESPONSE: $errorResponse');
        debugPrint('Title: $title');
      }
      debugPrint(e.toString());
      state = PreferenceCuisinesErrorState(
          error: e.toString(), errorType: ErrorType.other);
    }
  }



  Future userResponse(
      {required int userId, required int questionId, required bool userResponse}
      ) async {

    try {


      state = PreferenceResponseLoadingState();
      await discoverRepository.likeDislikeResponse(userId: userId, questionId: questionId, userResponse: userResponse);

      if(mounted){
        state = PreferenceResponseSuccessfulState();
      }


    } on UnauthorizedException catch (e) {
      debugPrint('This is the unauthorized part');
      state =PreferenceResponseErrorState(
          error: e.message.toString(), errorType: ErrorType.inline);
    } on BackendResponseError catch (e) {
      if (e.statusCode == 400) {
        // Handle the 400 error scenario
        // Access the errors from the responseErrors property of the BackendResponseError
        final responseErrors = e.responseErrors;
        final errorMessages = responseErrors
            .map((error) => '${error.message}: ${error.messages?.join(", ")}')
            .join("\n");
        state = PreferenceResponseErrorState(
            error: errorMessages.toString(), errorType: ErrorType.inline);
      } else if (e.statusCode == 422) {
        debugPrint('going inside this BackendResponseError block bro');

        state = PreferenceResponseErrorState(
            error: e.message, errorType: ErrorType.inline);
      } else {
        debugPrint('I guess it should be here');
        state = PreferenceResponseErrorState(
            error: e.message, errorType: ErrorType.other);
      }
    } on NoInternetConnectionException catch (e) {
      debugPrint('going inside this NoInternetConnectionException block bro');
      state =
          PreferenceResponseErrorState(error: e.message, errorType: ErrorType.other);
    } on DioError catch (e) {
      debugPrint('going inside this DioError block bro');
      debugPrint("This is e.response ${e.response}");
      if (e.response?.statusCode == 400) {
        state = PreferenceResponseErrorState(
            error: e.response!.data.toString(), errorType: ErrorType.other);
      }
      if (e.response != null) {
        final errorResponse = e.response!.data;
        final title = errorResponse['title'];
        debugPrint('ERROR RESPONSE: $errorResponse');
        debugPrint('Title: $title');
      }
      debugPrint(e.toString());
      state = PreferenceResponseErrorState(
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



final cuisinesProvider = StateProvider<List<CuisinesData>>((ref) {
  return [];
});

final preferencesCuisinesProvider = StateProvider<List<Preference>>((ref) {
  return [];
});