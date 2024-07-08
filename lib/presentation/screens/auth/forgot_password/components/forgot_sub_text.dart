import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class ForgotSubText extends StatelessWidget {
  const ForgotSubText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w),
      child: Text(
        "To recover your account, enter your\nregistered email address with Food AI.",
        style: kSubtitle1TextStyle.copyWith(
          fontSize: 16.sp,
          height: 1.1,
          color: AppColors.textColor,
        ),

      ),
    );
  }
}


