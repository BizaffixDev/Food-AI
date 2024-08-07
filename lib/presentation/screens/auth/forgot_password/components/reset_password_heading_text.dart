import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class ResetPasswordHeadingText extends StatelessWidget {
  const ResetPasswordHeadingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w),
      child: Text(
        "Reset Password?",
        style: kHeading3TextStyle.copyWith(
          fontSize: 36.sp,
          fontWeight: FontWeight.w200,
          color: AppColors.textColor,
        ),
      ),
    );
  }
}
