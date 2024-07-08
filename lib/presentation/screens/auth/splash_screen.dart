import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/app/utils/common_functions.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/generated/assets.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();





    Timer(const Duration(seconds: 5), () {
      context.go(PagePath.onBoarding1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: CommonFunctions.deviceHeight(context),
        width: CommonFunctions.deviceWidth(context),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                Assets.backgroundTexture,
              ),
              fit: BoxFit.fill),
        ),
        child: Center(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10.w,right: 20.w),
                child: Image.asset(Assets.splashImage),
              ),
              Positioned(
                bottom: 165.h,
                left: 80.h,
                child: Text(
                  "FOOD AI",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                    fontSize: 58.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
