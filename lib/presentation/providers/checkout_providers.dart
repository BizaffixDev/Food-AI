import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodai_mobile/data/models/cart_response_model.dart';
import 'package:foodai_mobile/data/respository/cart_respository.dart';
import 'package:foodai_mobile/data/respository/check_out_repository.dart';
import 'package:foodai_mobile/presentation/providers/screen_state.dart';
import 'package:foodai_mobile/presentation/screens/checkout/checkout_states.dart';
import 'package:get_it/get_it.dart';
import '../../data/data_sources/user_local_data_source.dart';
import '../../data/models/login_response_model.dart';
import '../../data/network/error_handler_interceptor.dart';


final checkoutNotifyProvider =
StateNotifierProvider.autoDispose<CheckoutNotifier, CheckoutStates>((ref) {
  return CheckoutNotifier(
    checkoutRepository: GetIt.I<CheckoutRepository>(),
    userLocalDataSource: GetIt.I<UserLocalDataSource>(),
    ref: ref,
  );
});

class CheckoutNotifier extends StateNotifier<CheckoutStates> {
  CheckoutNotifier({
    required this.ref,
    required this.checkoutRepository,
    required this.userLocalDataSource,
  }) : super(CheckoutInitialState());

  final Ref ref;

  final CheckoutRepository checkoutRepository;
  final UserLocalDataSource userLocalDataSource;


  Future getUserData() async {
    LoginData? user = await userLocalDataSource.getUser();
    print(user?.email.toString());
    print(user?.userId.toString());
    print(user?.username.toString());
    ref.read(userObjectProvider.notifier).state = user!;
  }






  Future getCartData() async{
    LoginData? user = await userLocalDataSource.getUser();

    try {
      state = CartLoadingState();
      final response =  await checkoutRepository.getCartDetails(userId: user!.userId);
      ref.read(cartListProvider.notifier).state.addAll(response);
      state =  CartSuccessfulState();
    } on UnauthorizedException catch (e) {
      debugPrint('This is the unauthorized part');
      state =  CartErrorState(
          error: e.message.toString(), errorType: ErrorType.inline);
    } on BackendResponseError catch (e) {
      if (e.statusCode == 400) {
        // Handle the 400 error scenario
        // Access the errors from the responseErrors property of the BackendResponseError
        final responseErrors = e.responseErrors;
        final errorMessages = responseErrors
            .map((error) => '${error.message}: ${error.messages?.join(", ")}')
            .join("\n");
        state = CartErrorState(
            error: errorMessages.toString(), errorType: ErrorType.inline);
      } else if (e.statusCode == 422) {
        debugPrint('going inside this BackendResponseError block bro');

        state = CartErrorState(
            error: e.message, errorType: ErrorType.inline);
      } else {
        debugPrint('I guess it should be here');
        state = CartErrorState(
            error: e.message, errorType: ErrorType.other);
      }
    } on NoInternetConnectionException catch (e) {
      debugPrint('going inside this NoInternetConnectionException block bro');
      state =
          CartErrorState(error: e.message, errorType: ErrorType.other);
    } on DioError catch (e) {
      debugPrint('going inside this DioError block bro');
      debugPrint("This is e.response ${e.response}");
      if (e.response?.statusCode == 400) {
        state = CartErrorState(
            error: e.response!.data.toString(), errorType: ErrorType.other);
      }
      if (e.response != null) {
        final errorResponse = e.response!.data;
        final title = errorResponse['title'];
        debugPrint('ERROR RESPONSE: $errorResponse');
        debugPrint('Title: $title');
      }
      debugPrint(e.toString());
      state = CartErrorState(
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


final cartListProvider = StateProvider.autoDispose<List<CartDetailData>>((ref) {
  return [];
});