import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/generated/assets.dart';

class NoOfPeopleContainer extends StatelessWidget {
  NoOfPeopleContainer({
    super.key,
    required this.quantity,
    required this.addTap,
    required this.decrementTap,
  });

  int quantity;
  final VoidCallback addTap;
  final VoidCallback decrementTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 120.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        image: const DecorationImage(
          image: AssetImage(
            Assets.noOfPeopleBg,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No. of people",
            style: kHeading2TextStyle.copyWith(
              fontSize: 22.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10.h,),

          Container(
            margin: EdgeInsets.only(left: 100.w),
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            height: 30.h,
            width: 100.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient:const  LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xffffd702), Color(0xfffead1d)],
              ),

            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap:decrementTap,
                    child: const Icon(Icons.remove)),
                Text(quantity.toString(),style: kHeading3TextStyle.copyWith(fontWeight: FontWeight.w800,height: 1.5),),
                GestureDetector(
                    onTap:addTap,
                    child:const  Icon(Icons.add)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}