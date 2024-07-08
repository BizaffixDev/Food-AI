import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class OrContinueWithText extends StatelessWidget {
  const OrContinueWithText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Or Continue With",style: kHeading2TextStyle.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w300,
      ),),
    );
  }
}