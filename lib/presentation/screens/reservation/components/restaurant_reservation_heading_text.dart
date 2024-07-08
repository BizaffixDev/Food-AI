import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class RestaurantReservationHeadingText extends StatelessWidget {
  const RestaurantReservationHeadingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text("Restaurant Reservation",style: kHeading3TextStyle.copyWith(
      height: 1.1,
      fontSize: 25.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.textColor,
    ),);
  }
}