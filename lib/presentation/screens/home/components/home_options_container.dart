import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';


class HomeOptionsContainer extends StatelessWidget {
  const HomeOptionsContainer({
    super.key,
    required this.onTap, required this.title, required this.color1, required this.color2, required this.image,
  });
  final VoidCallback onTap;
  final String title;
  final Color color1;
  final Color color2;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200.h,
        width: 325.w,
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          gradient:  LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              color1,color2
             // Color(0xff53E88B), Color(0xff15BE77)
            ],
          ),
          image:  DecorationImage(
            image: AssetImage(
             image,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.only(right: 70.w, bottom: 50.h),
            child: Text(
              title,
              style: kHeading3TextStyle.copyWith(
                color: Colors.white,
                height: 1.1,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ),
    );
  }
}