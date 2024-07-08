import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class SignUpHeadingText extends StatelessWidget {
  const SignUpHeadingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 42.w),
      child: Text("Signup", style: kHeading3TextStyle.copyWith(
        fontSize: 36.sp,
        fontWeight: FontWeight.w200,
      ),),
    );
  }
}