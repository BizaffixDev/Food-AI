import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class LetsBuildProfileHeadingText extends StatelessWidget {
  const LetsBuildProfileHeadingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          "Let’s Build Your Profile",
          style: kHeading3TextStyle.copyWith(
            fontSize: 32.sp,
            fontWeight: FontWeight.w300,
            color:const  Color(0xFF4E4E4E),
          )
      ),
    );
  }
}