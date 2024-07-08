import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/drawables.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class DineInHeadingText extends StatelessWidget {
  const DineInHeadingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              "Dine in",
              style: kHeading3TextStyle.copyWith(
                  fontSize: 30.sp,
                  color: AppColors.textColor,
                  height: 1.1
              )
          ),
          Image.asset(Drawables.dineInIcon,height: 80.h,),

        ],
      ),
    );
  }
}
