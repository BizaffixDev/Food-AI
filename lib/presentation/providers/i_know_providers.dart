import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodai_mobile/data/data_sources/user_local_data_source.dart';
import 'package:foodai_mobile/data/models/cusines_response_model.dart';
import 'package:foodai_mobile/data/models/restaurants_response_model.dart';
import 'package:foodai_mobile/data/network/error_handler_interceptor.dart';
import 'package:foodai_mobile/data/respository/discover_respository.dart';
import 'package:foodai_mobile/data/respository/i_know_respository.dart';
import 'package:foodai_mobile/presentation/providers/screen_state.dart';
import 'package:foodai_mobile/presentation/screens/iKnowWhatIWant/i_know_states.dart';
import 'package:get_it/get_it.dart';

import '../../data/models/login_response_model.dart';
import '../../data/models/restaurant_detail_response_model.dart';

final iKnowNotifyProvider =
StateNotifierProvider.autoDispose<IKnowNotifier, IKnowStates>((ref) {
  return IKnowNotifier(
    iKnowRepository: GetIt.I<IKnowRepository>(),
    userLocalDataSource: GetIt.I<UserLocalDataSource>(),
    ref: ref,
  );
});

class IKnowNotifier extends StateNotifier<IKnowStates> {
  IKnowNotifier({
    required this.ref,
    required this.iKnowRepository,
    required this.userLocalDataSource,
  }) : super(IKnowInitialState());

  final Ref ref;

  final IKnowRepository iKnowRepository;
  final UserLocalDataSource userLocalDataSource;


  Future getRestaurants() async {
    if (ref.watch(restaurantsListProvider).isNotEmpty) {
      return;
    }
    try {
      state = IKnowLoadingState();
      final response =  await iKnowRepository.getRestaurantList();
      ref.read(restaurantsListProvider.notifier).state.addAll(response);
      state =  IKnowSuccessfulState();
    } on UnauthorizedException catch (e) {
      debugPrint('This is the unauthorized part');
      state =  IKnowErrorState(
          error: e.message.toString(), errorType: ErrorType.inline);
    } on BackendResponseError catch (e) {
      if (e.statusCode == 400) {
        // Handle the 400 error scenario
        // Access the errors from the responseErrors property of the BackendResponseError
        final responseErrors = e.responseErrors;
        final errorMessages = responseErrors
            .map((error) => '${error.message}: ${error.messages?.join(", ")}')
            .join("\n");
        state = IKnowErrorState(
            error: errorMessages.toString(), errorType: ErrorType.inline);
      } else if (e.statusCode == 422) {
        debugPrint('going inside this BackendResponseError block bro');

        state = IKnowErrorState(
            error: e.message, errorType: ErrorType.inline);
      } else {
        debugPrint('I guess it should be here');
        state = IKnowErrorState(
            error: e.message, errorType: ErrorType.other);
      }
    } on NoInternetConnectionException catch (e) {
      debugPrint('going inside this NoInternetConnectionException block bro');
      state =
          IKnowErrorState(error: e.message, errorType: ErrorType.other);
    } on DioError catch (e) {
      debugPrint('going inside this DioError block bro');
      debugPrint("This is e.response ${e.response}");
      if (e.response?.statusCode == 400) {
        state = IKnowErrorState(
            error: e.response!.data.toString(), errorType: ErrorType.other);
      }
      if (e.response != null) {
        final errorResponse = e.response!.data;
        final title = errorResponse['title'];
        debugPrint('ERROR RESPONSE: $errorResponse');
        debugPrint('Title: $title');
      }
      debugPrint(e.toString());
      state = IKnowErrorState(
          error: e.toString(), errorType: ErrorType.other);
    }
  }

  Future getRestaurantDetails({required int restaurantId}) async {

    try {
      state = RestaurantDetailLoadingState();
      final response =  await iKnowRepository.getRestaurantDetails(restaurantId: restaurantId);
      ref.read(restaurantDishesProvider.notifier).state.addAll(response.restarantsDishes);
      ref.read(restaurantDealsProvider.notifier).state.addAll(response.restaurantDeals);
      ref.read(restaurantTimingsProvider.notifier).state.addAll(response.restaurantTimings);
      ref.read(restaurantLogoImageProvider.notifier).state = response.restaurantImage;
      state = RestaurantDetailSuccessfulState();
    } on UnauthorizedException catch (e) {
      debugPrint('This is the unauthorized part');
      state =  RestaurantDetailErrorState(
          error: e.message.toString(), errorType: ErrorType.inline);
    } on BackendResponseError catch (e) {
      if (e.statusCode == 400) {
        // Handle the 400 error scenario
        // Access the errors from the responseErrors property of the BackendResponseError
        final responseErrors = e.responseErrors;
        final errorMessages = responseErrors
            .map((error) => '${error.message}: ${error.messages?.join(", ")}')
            .join("\n");
        state = RestaurantDetailErrorState(
            error: errorMessages.toString(), errorType: ErrorType.inline);
      } else if (e.statusCode == 422) {
        debugPrint('going inside this BackendResponseError block bro');

        state = RestaurantDetailErrorState(
            error: e.message, errorType: ErrorType.inline);
      } else {
        debugPrint('I guess it should be here');
        state = RestaurantDetailErrorState(
            error: e.message, errorType: ErrorType.other);
      }
    } on NoInternetConnectionException catch (e) {
      debugPrint('going inside this NoInternetConnectionException block bro');
      state =
          RestaurantDetailErrorState(error: e.message, errorType: ErrorType.other);
    } on DioError catch (e) {
      debugPrint('going inside this DioError block bro');
      debugPrint("This is e.response ${e.response}");
      if (e.response?.statusCode == 400) {
        state = RestaurantDetailErrorState(
            error: e.response!.data.toString(), errorType: ErrorType.other);
      }
      if (e.response != null) {
        final errorResponse = e.response!.data;
        final title = errorResponse['title'];
        debugPrint('ERROR RESPONSE: $errorResponse');
        debugPrint('Title: $title');
      }
      debugPrint(e.toString());
      state = RestaurantDetailErrorState(
          error: e.toString(), errorType: ErrorType.other);
    }
  }


  Future addToCart({
    required int dishId,
    required int quantity,
  }) async{
    LoginData? user = await userLocalDataSource.getUser();

    try {
      state = AddCartLoadingState();
      final response =  await iKnowRepository.addToCart(dishId: dishId, userId: user!.userId, quantity: quantity);
      state =  AddCartSuccessfulState();
    } on UnauthorizedException catch (e) {
      debugPrint('This is the unauthorized part');
      state =  AddCartErrorState(
          error: e.message.toString(), errorType: ErrorType.inline);
    } on BackendResponseError catch (e) {
      if (e.statusCode == 400) {
        // Handle the 400 error scenario
        // Access the errors from the responseErrors property of the BackendResponseError
        final responseErrors = e.responseErrors;
        final errorMessages = responseErrors
            .map((error) => '${error.message}: ${error.messages?.join(", ")}')
            .join("\n");
        state = AddCartErrorState(
            error: errorMessages.toString(), errorType: ErrorType.inline);
      } else if (e.statusCode == 422) {
        debugPrint('going inside this BackendResponseError block bro');

        state = AddCartErrorState(
            error: e.message, errorType: ErrorType.inline);
      } else {
        debugPrint('I guess it should be here');
        state = AddCartErrorState(
            error: e.message, errorType: ErrorType.other);
      }
    } on NoInternetConnectionException catch (e) {
      debugPrint('going inside this NoInternetConnectionException block bro');
      state =
          AddCartErrorState(error: e.message, errorType: ErrorType.other);
    } on DioError catch (e) {
      debugPrint('going inside this DioError block bro');
      debugPrint("This is e.response ${e.response}");
      if (e.response?.statusCode == 400) {
        state = AddCartErrorState(
            error: e.response!.data.toString(), errorType: ErrorType.other);
      }
      if (e.response != null) {
        final errorResponse = e.response!.data;
        final title = errorResponse['title'];
        debugPrint('ERROR RESPONSE: $errorResponse');
        debugPrint('Title: $title');
      }
      debugPrint(e.toString());
      state = AddCartErrorState(
          error: e.toString(), errorType: ErrorType.other);
    }
  }





}


final restaurantsListProvider = StateProvider<List<RestaurantData>>((ref) {
  return [];
});

final restaurantNameProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

final restaurantLogoImageProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

final restaurantDishesProvider = StateProvider.autoDispose<List<RestarantsDish>>((ref) {
  return [];
});

final restaurantDealsProvider = StateProvider.autoDispose<List<dynamic>>((ref) {
  return [];
});

final restaurantTimingsProvider = StateProvider.autoDispose<List<RestaurantTiming>>((ref) {
  return [];
});