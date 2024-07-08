import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class EnterOtpText extends StatelessWidget {
  const EnterOtpText({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w),
      child: Text(
        "Enter the OTP sent to $email",
        textAlign: TextAlign.center,
        style: kHeading3TextStyle.copyWith(
            color: AppColors.textColor,
            fontSize: 16.sp,
            height: 1.1
        ),
      ),
    );
  }
}