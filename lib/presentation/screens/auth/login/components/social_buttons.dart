import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/drawables.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class SocialButtons extends StatelessWidget {
  final VoidCallback fbTap;
  final VoidCallback googleTap;
  const SocialButtons({
    super.key,
    required this.fbTap,
    required this.googleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: fbTap,
          child: Container(
            width: 130.w,
            padding: EdgeInsets.fromLTRB(22.w, 30.h, 22.w, 15.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: Offset(3,1),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  Drawables.fbIcon,
                  height: 58.h,
                  width: 60.w,
                ),
                SizedBox(height: 15.h,),
                FittedBox(
                  child: Text("Facebook",style: kHeading2TextStyle.copyWith(
                    fontSize: 16.sp,
                  ),),
                ),
              ],
            ),
          ),
        ),

        SizedBox(width: 10.w,),

        GestureDetector(
          onTap: googleTap,
          child: Container(
            width: 130.w,
            padding: EdgeInsets.fromLTRB(22.w, 30.h, 22.w, 15.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: Offset(3,1),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  Drawables.googleIcon,
                  height: 58.h,
                  width: 60.w,
                ),
                SizedBox(height: 15.h,),
                FittedBox(
                  child: Text("Google",style: kHeading2TextStyle.copyWith(
                    fontSize: 16.sp,
                  ),),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}