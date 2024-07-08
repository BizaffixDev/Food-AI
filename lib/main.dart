import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:foodai_mobile/app/app_config.dart';
import 'package:foodai_mobile/di/injector.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:foodai_mobile/app/app.dart';





final GlobalKey<NavigatorState> foodAppNavigatorKey =
GlobalKey<NavigatorState>();

Future<void> main() async {



  final container = ProviderContainer();
  Injector.setup(appConfig: AppConfig.dev(), container: container);


  runApp(
      UncontrolledProviderScope(
        container: container,
        child: DevicePreview(
          enabled: false,
          builder: (context) {
            return FoodApp(
              key: foodAppNavigatorKey,
            );
          },
        ),
      )
  );


}
