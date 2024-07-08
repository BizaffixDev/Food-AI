import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class ProfileOption extends StatelessWidget {
  const ProfileOption({
    super.key, required this.text, required this.icon, required this.onTap,
  });

  final String text;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: [
            Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(icon,height: 28.h),
              ),
            ),

            SizedBox(width: 20.w,),

            Text(text,style: kHeading2TextStyle.copyWith(
              color: Color(0xFF72747C),
              fontSize: 15.sp,
            ),),

            Spacer(),

            Icon(Icons.arrow_forward_ios,color: Color(0xFF72747C,),size: 20.h),
          ],
        ),
      ),
    );
  }
}
