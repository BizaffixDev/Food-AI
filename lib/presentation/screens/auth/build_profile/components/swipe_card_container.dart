import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class SwipeCardContainer extends StatelessWidget {
  const SwipeCardContainer({
    super.key, required this.itemName, required this.itemRating, required this.itemPrice, required this.itemCategory, required this.itemComment, required this.itemImage,
  });

  final String itemName;
  final String itemImage;
  final String itemRating;
  final String itemPrice;
  final String itemCategory;
  final String itemComment;

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
              itemImage,
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
                      itemName,
                      //"SHAWARMA",
                      style: kHeading2TextStyle.copyWith(
                        fontSize:itemName.length >=15  ? 14.sp : 18.sp,
                        color: AppColors.textColor,
                        height: 1.5,
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: AppColors.primaryColor,
                    ),
                    Text(
                      itemRating,
                      //"4.2",
                      style: kSubtitle1TextStyle.copyWith(
                        color: AppColors.textColor,
                        height: 1.5,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$",
                      style: kHeading2TextStyle.copyWith(
                        color: AppColors.primaryColor,
                        height: 1.5,
                      ),
                    ),
                    Text(
                      itemPrice,
                      //"5.99",
                      style: kHeading2TextStyle.copyWith(
                        color: AppColors.textColor,
                        fontSize: 18.sp,
                        height: 1.5,
                      ),
                    )
                  ],
                ),
                Text(
                  itemCategory,
                  //"Arabic Lovers",
                  style: kHeading2TextStyle.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.textColor,
                    height: 0.7,
                  ),
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
                itemComment,
                //"Who doesn't love classic Arabic shawarma?"
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