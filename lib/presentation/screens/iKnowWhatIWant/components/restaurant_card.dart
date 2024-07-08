import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    super.key,
    required this.name,
    required this.image,
    required this.time,
    required this.onTap
  });


  final String image;
  final String name;
  final String time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 184.h,
          width: 147.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              boxShadow:  [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.1),
                  blurRadius: 6,
                  spreadRadius: 1,
                  offset: Offset(1,3),
                ),
              ],
              color: Colors.white),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                padding: EdgeInsets.all(12.h),
                child: Image.asset(
                  image,
                  height: 100.h,

                ),
              ),

              SizedBox(height: 40.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                  name,
                  style: kHeading3TextStyle.copyWith(
                    color: AppColors.textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                  time,
                  style: kHeading3TextStyle.copyWith(
                    color: AppColors.textColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
      ),
    );
  }
}
