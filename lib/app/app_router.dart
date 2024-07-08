import 'package:flutter/material.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/presentation/screens/auth/build_profile/build_profile_screen.dart';
import 'package:foodai_mobile/presentation/screens/auth/build_profile/build_restaurant_screen.dart';
import 'package:foodai_mobile/presentation/screens/auth/forgot_password/forgot_otp_verification_screen.dart';
import 'package:foodai_mobile/presentation/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:foodai_mobile/presentation/screens/auth/forgot_password/reset_password_screen.dart';
import 'package:foodai_mobile/presentation/screens/auth/on_boarding/on_boarding1_screen.dart';
import 'package:foodai_mobile/presentation/screens/auth/on_boarding/on_boarding2_screen.dart';
import 'package:foodai_mobile/presentation/screens/auth/location/location_screen.dart';
import 'package:foodai_mobile/presentation/screens/auth/login/login_screen.dart';
import 'package:foodai_mobile/presentation/screens/auth/otp_verification/otp_verification_screen.dart';
import 'package:foodai_mobile/presentation/screens/auth/signup/signup_screen.dart';
import 'package:foodai_mobile/presentation/screens/auth/splash_screen.dart';
import 'package:foodai_mobile/presentation/screens/bottom_nav_bar.dart';
import 'package:foodai_mobile/presentation/screens/cart/cart_screen.dart';
import 'package:foodai_mobile/presentation/screens/checkout/check_out_screen.dart';
import 'package:foodai_mobile/presentation/screens/dine_in/location_dine_in.dart';
import 'package:foodai_mobile/presentation/screens/dine_in/restaurants_list_dinein_screen.dart';
import 'package:foodai_mobile/presentation/screens/discover/discover_screen.dart';
import 'package:foodai_mobile/presentation/screens/discover/looking_for_screen.dart';
import 'package:foodai_mobile/presentation/screens/favorites/favorites_screen.dart';
import 'package:foodai_mobile/presentation/screens/home/home_screen.dart';
import 'package:foodai_mobile/presentation/screens/iKnowWhatIWant/i_know_what_i_want.dart';
import 'package:foodai_mobile/presentation/screens/profile/personal_info_screen.dart';
import 'package:foodai_mobile/presentation/screens/profile/profile_screen.dart';
import 'package:foodai_mobile/presentation/screens/reservation/cart_reservation.dart';
import 'package:foodai_mobile/presentation/screens/reservation/reservation_screen.dart';
import 'package:foodai_mobile/presentation/screens/reservation/restaurants_reservation_list_screen.dart';
import 'package:foodai_mobile/presentation/screens/restaurant/restaurant_home_screen.dart';
import 'package:go_router/go_router.dart';

///Global Key for the navigation
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<OverlayState> overlayState = GlobalKey<OverlayState>();

class AppRouter {
  AppRouter._();

  /// Background App is Live
  /// Background App is Dead(Notification late, but will open the app)
  /// Foreground notification.
  /// In App Messaging.
  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: PagePath.splash,
    routes: [



      GoRoute(
        path: PagePath.dashboard,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const BottomNavbarScreen(),
      ),

      /// AUTH ROUTES ///

      GoRoute(
        path: PagePath.splash,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => SplashScreen(),
      ),

      GoRoute(
        path: PagePath.onBoarding1,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => OnBoarding1Screen(),
      ),

      GoRoute(
        path: PagePath.onBoarding2,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => OnBoarding2Screen(),
      ),

      GoRoute(
        path: PagePath.login,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => LoginScreen(),
      ),

      GoRoute(
        path: PagePath.signup,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => SignUpScreen(),
      ),

      GoRoute(
        path: PagePath.location,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => LocationScreen(),
      ),

      GoRoute(
        path: PagePath.buildProfile,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => BuildProfileScreen(),
      ),

      GoRoute(
        path: PagePath.buildRestaurant,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => BuildRestaurantScreen(),
      ),

      GoRoute(
        path: PagePath.forgotPassword,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => ForgotPasswordScreen(),
      ),

      GoRoute(
          path: PagePath.newPassword,
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) {
            final queryParams = state.uri.queryParameters;
            final email = queryParams['email'] as String;
            return ResetPasswordScreen(
              email: email,
            );
          }),

      GoRoute(
        path: PagePath.otpVerification,
        parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) {
            final queryParams = state.uri.queryParameters;
            final email = queryParams['email'] as String;
            return OtpVerificationScreen(
              email: email,
            );
          }
      ),

      GoRoute(
          path: PagePath.forgotOtpVerification,
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) {
            final queryParams = state.uri.queryParameters;
            final email = queryParams['email'] as String;
            return ForgotOtpVerificationScreen(
              email: email,
            );
          }),


      /// HOME ROUTES ///

      GoRoute(
        path: PagePath.home,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => HomeScreen(),
      ),


      GoRoute(
        path: PagePath.restaurantHome,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final queryParams = state.uri.queryParameters;
          final restaurantId = queryParams['restaurantId'] as String;
          return RestaurantHomeScreen(
            restaurantId: restaurantId,
          );
        }
      ),


      /// DISCOVER ROUTES ///

      GoRoute(
        path: PagePath.lookingFor,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => LookingForScreen(),
      ),

      GoRoute(
        path: PagePath.discover,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final queryParams = state.uri.queryParameters;
          final cuisineId = queryParams['cuisineId'] as String;
          return DiscoverScreen(
            cuisineId: cuisineId,
          );
  },
      ),

      /// I KNOW WHAT I WANT ROUTES ///
      GoRoute(
        path: PagePath.iKnowWhatIWant,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => IKnowWhatIWantScreen(),
      ),

      /// PROFILE ///
      GoRoute(
        path: PagePath.profile,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => ProfileScreen(),
      ),

      GoRoute(
        path: PagePath.personalInfo,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => PersonalInfoScreen(),
      ),

      GoRoute(
        path: PagePath.myAddress,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => PersonalInfoScreen(),
      ),


      ///CART
      GoRoute(
        path: PagePath.cart,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => CartScreen(),
      ),

      ///CHECK OUT
      GoRoute(
        path: PagePath.checkout,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => CheckOutScreen(),
      ),

      ///DINE IN

      GoRoute(
        path: PagePath.locationDineIn,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => LocationDineInScreen(),
      ),

      GoRoute(
        path: PagePath.restaurantsListDineIn,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => DineInRestaurantsListScreen(),
      ),

      ///FAVORITES
      GoRoute(
        path: PagePath.favorites,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FavoriteScreen(),
      ),

      ///RESERVATION
      GoRoute(
        path: PagePath.reservationScreen,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const ReservationScreen(),
      ),

      GoRoute(
        path: PagePath.restaurantsListReservation,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const ReservationRestaurantsListScreen(),
      ),

      GoRoute(
        path: PagePath.cartReservation,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const CartReservationScreen(),
      ),


    ],
  );
}
