import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:go_router/go_router.dart';

class BackArrowIconContainer extends StatelessWidget {
   BackArrowIconContainer({
    super.key,
    this.isPadding = true
  });

  bool? isPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:isPadding == true ?  EdgeInsets.fromLTRB(28.w,20.h,0,0) : EdgeInsets.zero,
      child: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: ()=>context.pop(),
          child: Container(
            padding:  EdgeInsets.only(left: 10.w),
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
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}