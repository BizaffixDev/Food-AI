import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:shimmer/shimmer.dart';

class SwipeCardShimmer extends StatelessWidget {
  const SwipeCardShimmer({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 367.07.h,
      width: 257.24.w,
      margin: EdgeInsets.only(left: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey, width: 0.2),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!, // Define your base color
        highlightColor: Colors.grey[100]!, // Define your highlight color
        direction: ShimmerDirection.ltr, // Define the direction of the shimmer animation
        child: Column(
          children: [
            /// FOOD IMAGE CONTAINER
            Container(
              height: 250.h,
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
              color: Colors.white, // Set the background color for the shimmer
            ),

            /// REST OF YOUR CONTAINER CONTENT
            // ... (your existing content)

            // To make the shimmer effect more visible, you can wrap the
            // food details and comment containers with Shimmer.fromColors
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              direction: ShimmerDirection.ltr,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                // ... (your existing content)
              ),
            ),

            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                direction: ShimmerDirection.ltr,
                child: Container(
                  padding: EdgeInsets.all(10.h),
                  // ... (your existing content)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}