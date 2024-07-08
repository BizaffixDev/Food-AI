import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodai_mobile/data/data_sources/user_local_data_source.dart';
import 'package:foodai_mobile/data/models/login_response_model.dart';
import 'package:foodai_mobile/data/models/nearest_restaurant_response_model.dart';
import 'package:foodai_mobile/data/network/error_handler_interceptor.dart';
import 'package:foodai_mobile/data/respository/dine_in_respository.dart';
import 'package:foodai_mobile/presentation/providers/screen_state.dart';
import 'package:foodai_mobile/presentation/screens/dine_in/dine_in_states.dart';
import 'package:foodai_mobile/presentation/screens/iKnowWhatIWant/i_know_states.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';

final dineInNotifyProvider =
StateNotifierProvider.autoDispose<DineInNotifier, DineInStates>((ref) {
  return DineInNotifier(
    dineInRepository: GetIt.I<DineInRepository>(),
    userLocalDataSource: GetIt.I<UserLocalDataSource>(),
    ref: ref,
  );
});

class DineInNotifier extends StateNotifier<DineInStates> {
  DineInNotifier({
    required this.ref,
    required this.dineInRepository,
    required this.userLocalDataSource,
  }) : super(DineInInitialState());

  final Ref ref;

  final DineInRepository dineInRepository;
  final UserLocalDataSource userLocalDataSource;

  Future getUserData() async {
    LoginData? user = await userLocalDataSource.getUser();
    print(user?.email.toString());
    print(user?.userId.toString());
    print(user?.username.toString());
    ref.read(userObjectProvider.notifier).state = user!;
  }


  ///getting current location of user

  Future<Position> getCurrentLocation( ) async{
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


  Future addUserLocation(
      { required double latitude, required double longitude,required int maxDistance}
      ) async {
    LoginData? user = await userLocalDataSource.getUser();
    try {


      state = LocationAddLoadingState();
      await dineInRepository.addUserLocation(userId: user!.userId, latitude: latitude, longitude: longitude, maxDistance: maxDistance);

      if(mounted){
        state = LocationAddSuccessfulState();
      }


    } on UnauthorizedException catch (e) {
      debugPrint('This is the unauthorized part');
      state = LocationAddErrorState(
          error: e.message.toString(), errorType: ErrorType.inline);
    } on BackendResponseError catch (e) {
      if (e.statusCode == 400) {
        // Handle the 400 error scenario
        // Access the errors from the responseErrors property of the BackendResponseError
        final responseErrors = e.responseErrors;
        final errorMessages = responseErrors
            .map((error) => '${error.message}: ${error.messages?.join(", ")}')
            .join("\n");
        state = LocationAddErrorState(
            error: errorMessages.toString(), errorType: ErrorType.inline);
      } else if (e.statusCode == 422) {
        debugPrint('going inside this BackendResponseError block bro');

        state = LocationAddErrorState(
            error: e.message, errorType: ErrorType.inline);
      } else {
        debugPrint('I guess it should be here');
        state = LocationAddErrorState(
            error: e.message, errorType: ErrorType.other);
      }
    } on NoInternetConnectionException catch (e) {
      debugPrint('going inside this NoInternetConnectionException block bro');
      state =
          LocationAddErrorState(error: e.message, errorType: ErrorType.other);
    } on DioError catch (e) {
      debugPrint('going inside this DioError block bro');
      debugPrint("This is e.response ${e.response}");
      if (e.response?.statusCode == 400) {
        state = LocationAddErrorState(
            error: e.response!.data.toString(), errorType: ErrorType.other);
      }
      if (e.response != null) {
        final errorResponse = e.response!.data;
        final title = errorResponse['title'];
        debugPrint('ERROR RESPONSE: $errorResponse');
        debugPrint('Title: $title');
      }
      debugPrint(e.toString());
      state = LocationAddErrorState(
          error: e.toString(), errorType: ErrorType.other);
    }
  }



  Future getNearestRestaurant({required double latitude, required double longitude,required int maxDistance}) async {
    LoginData? user = await userLocalDataSource.getUser();
    if (ref.watch(nearestRestaurantProvider).isNotEmpty) {
      return;
    }
    try {
      state = NearestRestaurantLoadingState();
      final response =  await dineInRepository.getNearestRestaurant(
          userId: user!.userId,
          latitude: latitude,
          longitude: longitude,
          maxDistance: maxDistance,
      );
      ref.read(nearestRestaurantProvider.notifier).state.addAll(response);
      state = NearestRestaurantSuccessfulState();
    } on UnauthorizedException catch (e) {
      debugPrint('This is the unauthorized part');
      state = NearestRestaurantErrorState(
          error: e.message.toString(), errorType: ErrorType.inline);
    } on BackendResponseError catch (e) {
      if (e.statusCode == 400) {
        // Handle the 400 error scenario
        // Access the errors from the responseErrors property of the BackendResponseError
        final responseErrors = e.responseErrors;
        final errorMessages = responseErrors
            .map((error) => '${error.message}: ${error.messages?.join(", ")}')
            .join("\n");
        state = NearestRestaurantErrorState(
            error: errorMessages.toString(), errorType: ErrorType.inline);
      } else if (e.statusCode == 422) {
        debugPrint('going inside this BackendResponseError block bro');

        state = NearestRestaurantErrorState(
            error: e.message, errorType: ErrorType.inline);
      } else {
        debugPrint('I guess it should be here');
        state = NearestRestaurantErrorState(
            error: e.message, errorType: ErrorType.other);
      }
    } on NoInternetConnectionException catch (e) {
      debugPrint('going inside this NoInternetConnectionException block bro');
      state =
          NearestRestaurantErrorState(error: e.message, errorType: ErrorType.other);
    } on DioError catch (e) {
      debugPrint('going inside this DioError block bro');
      debugPrint("This is e.response ${e.response}");
      if (e.response?.statusCode == 400) {
        state = NearestRestaurantErrorState(
            error: e.response!.data.toString(), errorType: ErrorType.other);
      }
      if (e.response != null) {
        final errorResponse = e.response!.data;
        final title = errorResponse['title'];
        debugPrint('ERROR RESPONSE: $errorResponse');
        debugPrint('Title: $title');
      }
      debugPrint(e.toString());
      state = NearestRestaurantErrorState(
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


final userAddressProvider = StateProvider<String>((ref) {
  return '';
});

final latitudeProvider = StateProvider<double>((ref) {
  return 0;
});

final longtudeProvider = StateProvider<double>((ref) {
  return 0;
});



final nearestRestaurantProvider = StateProvider<List<NearestRestaurantsData>>((ref) {
  return [];
});
