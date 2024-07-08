import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:foodai_mobile/app/app_router.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/strings.dart';

class FoodApp extends ConsumerStatefulWidget {
  const FoodApp({Key? key}) : super(key: key);

  @override
  ConsumerState<FoodApp> createState() => _MossYogaState();
}

class _MossYogaState extends ConsumerState<FoodApp> {
  @override
  void initState() {
    super.initState();
  }

  void setSystenPreferences() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.primaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setSystenPreferences();
    // final curentLocale = ref.watch(localeProvider);
    // ref.watch(authProvider);

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: Strings.appName,
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          builder: DevicePreview.appBuilder,
          routerDelegate: AppRouter.router.routerDelegate,
          routeInformationProvider: AppRouter.router.routeInformationProvider,
          routeInformationParser: AppRouter.router.routeInformationParser,
        );
      },
    );

  }
}

