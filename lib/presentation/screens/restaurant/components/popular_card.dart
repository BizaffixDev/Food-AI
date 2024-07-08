import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/drawables.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/presentation/screens/home/components/appbar_action_button.dart';

class PopularCard extends StatelessWidget {
   PopularCard({
    super.key,
    required this.image,
    required this.name,
    required this.tagline,
    required this.rating,
    required this.price,
    this.addCart,
  });

  final String image;
  final String name;
  final String tagline;
  final String rating;
  final String price;
  VoidCallback? addCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      width: 180.w,
      margin: EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
            image: AssetImage(
              image,
              //Assets.burgerProduct,
            ),
            fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Spacer(),
              Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.topRight,
                  child: AppbarActionIconButton(
                      onTap: addCart!, icon: Drawables.cartIcon)),
            ],
          ),
          Container(
            alignment: Alignment.bottomLeft,
            width: 17.w,
            height: 100.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              border: Border.all(color: AppColors.primaryColor),
              color: Color(0x82ffffff),),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (var letter in "POPULAR".split(''))
                  Padding(
                    padding:  EdgeInsets.only(left: 3.w),
                    child: Text(
                      letter,
                      style: kHeading3TextStyle.copyWith(
                        height: 1.1,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Spacer(),
          Container(
            height: 115.h,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    //"THE DOPPLER",
                    style: kHeading2TextStyle.copyWith(
                      height: 1.1,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    tagline,
                    // "The classic burger is an all time BBQ favorite! This super easy",
                    style: kHeading3TextStyle.copyWith(
                        height: 1.1, fontSize: 14.sp, color: Color(0xFF7B7B7B)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.primaryColor,
                      ),
                      Text(
                        rating,
                        // "4.5",
                        style: kHeading2TextStyle.copyWith(
                          height: 1.1,
                          fontSize: 16.sp,
                        ),
                      ),
                      Spacer(),
                      Text(
                        price,
                        //"Rs 600",
                        style: kHeading2TextStyle.copyWith(
                          height: 1.1,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}