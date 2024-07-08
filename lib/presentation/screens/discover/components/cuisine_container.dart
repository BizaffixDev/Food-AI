import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class CuisineContainer extends StatelessWidget {
  const CuisineContainer({
    super.key, required this.image, required this.title, required this.onTap,
  });


  final String image;
  final String title;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 3,
                  spreadRadius: 2,
                  offset: Offset(1,3),
                ),
              ],
              color: Colors.white),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 90.h,
                width: 90.h,
                decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      image,
                    ),
                    fit: BoxFit.cover
                  )
                ),

              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 10.h),
                child: Text(
                  title,
                  style: kHeading3TextStyle.copyWith(
                    color: AppColors.textColor,
                    fontSize: 16.sp,
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



