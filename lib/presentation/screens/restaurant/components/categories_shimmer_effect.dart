import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/data/models/category_model.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({
    super.key,
    required this.selectedCategory,
  });

  final CategoryModel? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!, // Color when not shimmering
        highlightColor: Colors.grey[100]!, // Color when shimmering
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = selectedCategory == category;

            return GestureDetector(
              onTap: () {
                // ... Your existing onTap logic ...
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 80.h,
                    width: 80.w,
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Color(0xFFf9f9f9),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: Center(
                      child: Image.asset(category.image, height: 50.h),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    category.name,
                    style: kHeading3TextStyle.copyWith(
                      fontSize: 16.sp,
                      height: 1.1,
                      color: isSelected ? Colors.blue : Colors.black,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}