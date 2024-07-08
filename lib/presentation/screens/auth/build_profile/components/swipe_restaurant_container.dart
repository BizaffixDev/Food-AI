import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class SwipeRestaurantCardContainer extends StatelessWidget {
  const SwipeRestaurantCardContainer({
    super.key, required this.restaurantName,   required this.restaurantImage,
  });

  final String restaurantName;
  final String restaurantImage;



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 367.07.h,
      width: 257.24.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey, width: 0.2),
      ),
      child: Column(
        children: [
          /// FOOD IMAGE CONTAINER
          Container(
            height: 250.h,
            padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 20.w),
            child: Image.network(
              restaurantImage,
            ),
          ),

          /// FOOD DETAILS CONTAINER
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      restaurantName,
                      //"SHAWARMA",
                      style: kHeading2TextStyle.copyWith(
                        fontSize:restaurantName.length >=15  ? 14.sp : 18.sp,
                        color: AppColors.textColor,
                        height: 1.5,
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 8.h,),
              ],
            ),
          ),

          /// FOOD COMMENT CONTAINER
          Expanded(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
                gradient:const  LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xffffd702), Color(0xfffead1d)],
                ),
              ),

              child: Text(
                "Who doesn't love classic Arabic shawarma?",
                style: kSubtitle1TextStyle.copyWith(
                  color: AppColors.textColor,
                  height: 1,
                ),),
            ),
          ),
        ],
      ),
    );
  }
}