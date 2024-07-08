import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';

class AppbarActionIconButton extends StatelessWidget {
  const AppbarActionIconButton({
    super.key, required this.onTap, required this.icon,
  });

  final VoidCallback onTap;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding:  EdgeInsets.all(5.h),
          margin: EdgeInsets.only(right: 20.w),
          width: 45.w,
          height: 45.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.white,
            boxShadow:const  [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(3,4),
              ),
            ],
          ),
          child: Center(
            child: Image.asset(icon,height: 30.h,width: 30.h,),
          ),
        ),
      ),
    );
  }
}
