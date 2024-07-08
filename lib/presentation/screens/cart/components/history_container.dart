import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class HistoryContainer extends StatelessWidget {
  const HistoryContainer({
    super.key, required this.name, required this.image, required this.price, required this.quantity, required this.restaurantNname, required this.date, required this.orderId,
  });

  final String name;
  final String restaurantNname;
  final String image;
  final String date;
  final String orderId;
  final String price;
  final String quantity;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 60.h,
                width: 60.w,
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
              SizedBox(width: 10.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,style: kHeading2TextStyle.copyWith(
                    fontSize: 16.sp,
                    height: 1.1,
                  ),),
                  Text(restaurantNname,style: kHeading2TextStyle.copyWith(
                      fontSize: 14.sp,
                      height: 1.1,
                      color: Colors.red
                  ),),
                  Text("Order ID: $orderId",style: kHeading3TextStyle.copyWith(
                    fontSize: 14.sp,
                    height: 1.1,
                    fontWeight: FontWeight.w200,
                  ),),
                  Text(date,style: kHeading3TextStyle.copyWith(
                    fontSize: 14.sp,
                    height: 1.1,
                    fontWeight: FontWeight.w200,
                  ),),



                ],
              ),
            ],
          ),
          SizedBox(width: 30.w,),
          Text(price, style: kHeading1TextStyle.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
            height: 1.1,
          ),),
        ],
      ),
    );
  }
}
