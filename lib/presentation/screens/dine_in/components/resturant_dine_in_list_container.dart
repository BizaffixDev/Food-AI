import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class RestaurantDineInLocationListContainer extends StatelessWidget {
  const RestaurantDineInLocationListContainer({
    super.key,
    required this.image,
    required this.name,
    required this.address,
    required this.onTap,
  });


  final String image;
  final String name;
  final String address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1,3
            ),
            spreadRadius: 4,
            blurRadius: 5,
          ),
        ],

      ),
      child: Row(
        children: [
          Container(
            height: 62.h,
            width: 62.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                  image,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(width: 10.w,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,style: kHeading3TextStyle.copyWith(
                height: 1.1,
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
              ),
              ),
              Text(address,style: kHeading3TextStyle.copyWith(
                  height: 1.1,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey
              ),
              ),
            ],
          ),

          Spacer(),


          GestureDetector(
            onTap: onTap,
            child: Container(

              height: 36.h,
              width: 55.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.r),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(1,3
                    ),
                    spreadRadius: 4,
                    blurRadius: 5,
                  ),
                ],

              ),
              child: Center(
                child: Text("Yes",style: kHeading2TextStyle.copyWith(
                    height: 1.1,
                    fontSize: 18.sp,
                    color: Color(0xFF04D700)
                ),),
              ) ,
            ),
          ),
        ],






      ),
    );
  }
}