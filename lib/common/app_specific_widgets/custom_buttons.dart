import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 233.w,
        height: 57.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient:const  LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xffffd702), Color(0xfffead1d)],
          ),
        ),
        child: Center(
          child: Text(text,style: kSubtitle1TextStyle.copyWith(
            fontSize:  20.sp,
            fontWeight: FontWeight.w700,
            height: 1,
          ),),
        ),
      ),
    );
  }
}
