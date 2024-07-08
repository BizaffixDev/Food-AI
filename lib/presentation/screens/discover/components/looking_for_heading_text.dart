import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class LookingForHeadingText extends StatelessWidget {
  const LookingForHeadingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 33.w),
      child: Text("Looking For?", style: kHeading3TextStyle.copyWith(
        fontSize: 36.sp,
        fontWeight: FontWeight.w200,
      ),),
    );
  }
}