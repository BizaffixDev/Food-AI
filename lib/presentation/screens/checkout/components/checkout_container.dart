import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class CheckoutContainer extends StatelessWidget {
   const CheckoutContainer({
    super.key, required this.name, required this.image, required this.price,
  });

  final String name;
  final String image;
  final String price;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 4,
            blurRadius: 6,
            offset: Offset(1,4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 84.h,
            width: 72.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image:  DecorationImage(
                image: AssetImage(
                  image,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20.w,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,style: kHeading2TextStyle.copyWith(
                fontSize: 20.sp,
                height: 1.1,
              ),),
              Text(price,style: kHeading3TextStyle.copyWith(
                fontSize: 16.sp,
                height: 1.1,
                fontWeight: FontWeight.w200,
              ),),



            ],
          ),
        ],
      ),
    );
  }
}
