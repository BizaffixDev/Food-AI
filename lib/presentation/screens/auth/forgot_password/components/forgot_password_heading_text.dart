import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class ForgotPasswordHeadingText extends StatelessWidget {
  const ForgotPasswordHeadingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w),
      child: Text(
        "Forgot Password?",
        style: kHeading3TextStyle.copyWith(
          fontSize: 36.sp,
          fontWeight: FontWeight.w200,
          color: AppColors.textColor,
        ),
      ),
    );
  }
}