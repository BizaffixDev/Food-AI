import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class ProfileListTileOption extends StatelessWidget {
  const ProfileListTileOption({
    super.key, required this.subtitle, required this.icon, required this.onTap,required  this.title
  });

  final String subtitle;
  final String title;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListTile(
          leading: Container(
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
          title:Text(title,style: kHeading3TextStyle.copyWith(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            height: 1.1,
          ),),
          subtitle: Text(subtitle,style: kHeading2TextStyle.copyWith(
            color: Color(0xFF72747C),
            fontSize: 15.sp,
            height: 1.1,
          ),),
          trailing: Icon(Icons.arrow_forward_ios,color: Color(0xFF72747C,),size: 20.h),
        ),


        // Row(
        //   children: [
        //     Container(
        //       height: 40.h,
        //       width: 40.w,
        //       decoration: BoxDecoration(
        //         color: Colors.white,
        //         shape: BoxShape.circle,
        //       ),
        //       child: Center(
        //         child: Image.asset(icon,height: 28.h),
        //       ),
        //     ),
        //
        //     SizedBox(width: 20.w,),
        //
        //     Text(text,style: kHeading2TextStyle.copyWith(
        //       color: Color(0xFF72747C),
        //       fontSize: 15.sp,
        //     ),),
        //
        //     Spacer(),
        //
        //     Icon(Icons.arrow_forward_ios,color: Color(0xFF72747C,),size: 20.h),
        //   ],
        // ),
      ),
    );
  }
}
