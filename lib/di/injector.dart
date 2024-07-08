import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodai_mobile/app/app_config.dart';
import 'package:foodai_mobile/app/utils/preference_manager.dart';
import 'package:foodai_mobile/data/data_sources/auth_data_source.dart';
import 'package:foodai_mobile/data/data_sources/cart_data_source.dart';
import 'package:foodai_mobile/data/data_sources/check_out_data_source.dart';
import 'package:foodai_mobile/data/data_sources/dine_in_data_source.dart';
import 'package:foodai_mobile/data/data_sources/discover_data_source.dart';
import 'package:foodai_mobile/data/data_sources/home_data_source.dart';
import 'package:foodai_mobile/data/data_sources/i_know_data_source.dart';
import 'package:foodai_mobile/data/data_sources/notification_data_source.dart';
import 'package:foodai_mobile/data/data_sources/reservation_data_source.dart';
import 'package:foodai_mobile/data/data_sources/user_local_data_source.dart';
import 'package:foodai_mobile/data/network/rest_api_client.dart';
import 'package:foodai_mobile/data/network/service_config_logger.dart';
import 'package:foodai_mobile/data/respository/auth_repository.dart';
import 'package:foodai_mobile/data/respository/cart_respository.dart';
import 'package:foodai_mobile/data/respository/check_out_repository.dart';
import 'package:foodai_mobile/data/respository/dine_in_respository.dart';
import 'package:foodai_mobile/data/respository/discover_respository.dart';
import 'package:foodai_mobile/data/respository/home_respository.dart';
import 'package:foodai_mobile/data/respository/i_know_respository.dart';
import 'package:foodai_mobile/data/respository/notification_repository.dart';
import 'package:foodai_mobile/data/respository/reservation_respository.dart';
import 'package:get_it/get_it.dart';

class Injector {
  Injector._();

  static final _dependency = GetIt.instance;

  static GetIt get dependency => _dependency;


  static void setup(
      {required AppConfig appConfig, required ProviderContainer container}) {
    _setUpAuthRepository();
    _setUpAuthDataSource();
    _setUpHomeRepository();
    _setUpHomeDataSource();
    _setUpDiscoverRepository();
    _setUpDiscoverDataSource();
    _setUpiKnowRepository();
    _setUpIKnowDataSource();
    _setUpReservationRepository();
    _setUpReservationDataSource();
    _setUpDineInRepository();
    _setUpDineInDataSource();
    _setUpCartRepository();
    _setUpCartDataSource();
    _setUpCheckOutRepository();
    _setUpCheckOutDataSource();
    _setUpNotificationRepository();
    _setUpNotificationDataSource();
    _setUpUserLocalDataSource();
    _setupServiceConfig();
    _setupHttpClient();

  }


  ///Create DataSource Methods here

  static void _setUpUserLocalDataSource() {
    _dependency.registerFactory<UserLocalDataSource>(() =>
        UserLocalDataSourceImpl(
            preferencesManager: SecurePreferencesManager()));
  }


  static void _setUpAuthDataSource() {
    _dependency.registerFactory<AuthDataSource>(
      AuthDataSourceImpl.new,
    );
  }

  static void _setUpHomeDataSource() {
    _dependency.registerFactory<HomeDataSource>(
      HomeDataSourceImpl.new,
    );
  }

  static void _setUpDiscoverDataSource() {
    _dependency.registerFactory<DiscoverDataSource>(
      DiscoverDataSourceImpl.new,
    );
  }

  static void _setUpIKnowDataSource() {
    _dependency.registerFactory<IKnowDataSource>(
      IKnowDataSourceImpl.new,
    );
  }

  static void _setUpReservationDataSource() {
    _dependency.registerFactory<ReservationDataSource>(
      ReservationDataSourceImpl.new,
    );
  }

  static void _setUpDineInDataSource() {
    _dependency.registerFactory<DineInDataSource>(
      DineInDataSourceImpl.new,
    );
  }

  static void _setUpCartDataSource() {
    _dependency.registerFactory<CartDataSource>(
      CartDataSourceImpl.new,
    );
  }

  static void _setUpCheckOutDataSource() {
    _dependency.registerFactory<CheckOutDataSource>(
      CheckOutDataSourceImpl.new,
    );
  }

  static void _setUpNotificationDataSource() {
    _dependency.registerFactory<NotificationDataSource>(
      NotificationDataSourceImpl.new,
    );
  }


  ///Create Repository Methods here

  static void _setUpAuthRepository() {
    _dependency.registerFactory<AuthRepository>(
          () =>
          AuthRepositoryImpl(
            _dependency(),
          ),
    );
  }

  static void _setUpHomeRepository() {
    _dependency.registerFactory<HomeRepository>(
          () =>
          HomeRepositoryImpl(
            _dependency(),
          ),
    );
  }

  static void _setUpDiscoverRepository() {
    _dependency.registerFactory<DiscoverRepository>(
          () =>
              DiscoverRepositoryImpl(
            _dependency(),
          ),
    );
  }

  static void _setUpiKnowRepository() {
    _dependency.registerFactory<IKnowRepository>(
          () =>
              IKnowRepositoryImpl(
            _dependency(),
          ),
    );
  }

  static void _setUpReservationRepository() {
    _dependency.registerFactory<ReservationRepository>(
          () =>
              ReservationRepositoryImpl(
            _dependency(),
          ),
    );
  }

  static void _setUpDineInRepository() {
    _dependency.registerFactory<DineInRepository>(
          () =>
              DineInRepositoryImpl(
            _dependency(),
          ),
    );
  }


  static void _setUpCartRepository() {
    _dependency.registerFactory<CartRepository>(
          () =>
          CartRepositoryImpl(
            _dependency(),
          ),
    );
  }

  static void _setUpCheckOutRepository() {
    _dependency.registerFactory<CheckoutRepository>(
          () =>
              CheckoutRepositoryImpl(
            _dependency(),
          ),
    );
  }

  static void _setUpNotificationRepository() {
    _dependency.registerFactory<NotificationRepository>(
          () =>
              NotificationRepositoryImpl(
            _dependency(),
          ),
    );
  }






  ///Create External-Methods here

  static void _setupHttpClient() {
    _dependency.registerFactory<ApiService>(() {
      final dio = Dio(
          BaseOptions(receiveTimeout: 5 * 1000, connectTimeout: 10 * 1000));
      final serviceConfig = _dependency<ServiceConfig>();
      dio.interceptors.addAll(serviceConfig.getInterceptors());


      // if (kIsWeb) {
      // dio.httpClientAdapter = BrowserHttpClientAdapter();
      // return ApiService(dio: dio);
      // } else
      if (!kIsWeb && Platform.isIOS || Platform.isAndroid) {
        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
            (HttpClient client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
          return client;
        };

        return ApiService(dio: dio);
      } else {
        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
            (HttpClient client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
          return client;
        };

        return ApiService(dio: dio);
      }
    });
  }


  static void _setupServiceConfig() {
    _dependency.registerFactory<ServiceConfig>(
          () => ServiceConfig(),
    );
  }

}