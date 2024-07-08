import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/drawables.dart';
import 'package:foodai_mobile/presentation/screens/home/components/appbar_action_button.dart';
import 'package:go_router/go_router.dart';

class TopAppBarIconsRow extends StatelessWidget {
  const  TopAppBarIconsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: ()=>context.pop(),
              child: Container(
                padding:  EdgeInsets.only(left: 10.w),
                width: 45.w,
                height: 45.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.white,
                  boxShadow:const  [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(3,4),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppbarActionIconButton(onTap: (){}, icon: Drawables.notificationIcon),
              AppbarActionIconButton(onTap: (){}, icon: Drawables.cartIcon),
            ],
          ),
        ],
      ),
    );
  }
}
