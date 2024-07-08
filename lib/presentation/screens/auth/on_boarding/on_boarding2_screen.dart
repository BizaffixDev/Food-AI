import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/app/utils/common_functions.dart';
import 'package:foodai_mobile/common/app_specific_widgets/custom_buttons.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/generated/assets.dart';
import 'package:go_router/go_router.dart';


class OnBoarding2Screen extends StatelessWidget {
  const OnBoarding2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: CommonFunctions.deviceHeight(context),
        width: CommonFunctions.deviceWidth(context),
        decoration:const  BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.backgroundTexture),
              fit: BoxFit.fill
          ),
        ),

        child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(Assets.onBoarding2Image,),
              Text("AI Based Food\nRecommendation is Where\nYour Comfort Food Lives",style: kHeading2TextStyle.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 22.sp,
                height: 1.5,
              ),
                textAlign: TextAlign.center,),

              SizedBox(
                height: 10.h,
              ),

              Text("Enjoy a fast and smooth food delivery at\nyour doorstep",style: kSubtitle1TextStyle.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                height: 1.5,
              ),
                textAlign: TextAlign.center,),

              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                onTap: ()=>context.push(PagePath.login),
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
