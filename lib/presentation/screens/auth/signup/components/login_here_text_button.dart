import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class LoginHereTextButton extends StatelessWidget {
  final VoidCallback onTap;
  const LoginHereTextButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(
      onPressed: onTap,
      child: Text(
        "Login Here",
        style: kSubtitle1TextStyle.copyWith(
          color: AppColors.textBlueColor,
          fontSize: 16.sp,
          height: 0.6,
        ),
      ),
    ));
  }
}
