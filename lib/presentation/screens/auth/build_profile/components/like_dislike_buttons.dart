import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/drawables.dart';

class LikeDislikeButtons extends StatelessWidget {
  const LikeDislikeButtons({
    super.key, required this.likeTap, required this.disLikeTap,
  });

  final VoidCallback likeTap;
  final VoidCallback disLikeTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        GestureDetector(
          onTap: disLikeTap,
          child: Container(
            height: 80.h,
            width: 80.h,
            padding: EdgeInsets.all(25.h),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(1,3),
                ),
              ],
            ),

            child: Center(
              child: Image.asset(Drawables.disLikeIcon,),
            ),
          ),
        ),

        SizedBox(width: 45.w,),

        GestureDetector(
          onTap: likeTap,
          child: Container(
            height: 80.h,
            width: 80.h,
            padding: EdgeInsets.all(25.h),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(1,3),
                ),
              ],
            ),

            child: Center(
              child: Image.asset(Drawables.likeIcon),
            ),
          ),
        ),

      ],
    );
  }
}