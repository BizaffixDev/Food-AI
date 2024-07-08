import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/app/utils/common_functions.dart';
import 'package:foodai_mobile/common/app_specific_widgets/custom_buttons.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/generated/assets.dart';
import 'package:foodai_mobile/presentation/providers/auth_providers.dart';
import 'package:go_router/go_router.dart';

class OnBoarding1Screen extends ConsumerStatefulWidget {
  const OnBoarding1Screen({super.key});

  @override
  ConsumerState<OnBoarding1Screen> createState() => _OnBoarding1ScreenState();
}

class _OnBoarding1ScreenState extends ConsumerState<OnBoarding1Screen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(authNotifyProvider.notifier).getCurrentLocation();
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
              image: AssetImage(Assets.backgroundTexture), fit: BoxFit.fill),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                Assets.onBoarding1Image,
              ),
              Text(
                "Find your Comfort\nFood here",
                style: kHeading2TextStyle.copyWith(
                  fontSize: 22.sp,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Here You Can find a chef or dish for\nevery taste and color. Enjoy!",
                style: kSubtitle1TextStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                onTap: () => context.push(PagePath.onBoarding2),
                text: "Next",
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
