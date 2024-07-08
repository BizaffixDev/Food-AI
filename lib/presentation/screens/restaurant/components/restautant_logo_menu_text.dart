import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/generated/assets.dart';

class RestaurantLogoMenuText extends StatelessWidget {
  const RestaurantLogoMenuText({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100.h,
          width: 100.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image:const  DecorationImage(
                image: AssetImage(
                  Assets.restaurantLogo,
                ),
                fit: BoxFit.cover,
              )
          ),
        ),
        Text("Menu",style: kHeading2TextStyle.copyWith(
          height: 1.1,
          color: AppColors.textColor,
          fontSize: 30.sp,
        ),)
      ],
    );
  }
}