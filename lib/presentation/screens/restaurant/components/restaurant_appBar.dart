import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:go_router/go_router.dart';

class RestaurantAppbar extends StatelessWidget implements PreferredSizeWidget{
  const RestaurantAppbar({
    super.key, required this.appBar, required this.widgets, required this.backTap
  });


  final AppBar appBar;
  final List<Widget> widgets;
  final VoidCallback backTap;


  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100.h,
      backgroundColor: Colors.transparent,
      elevation: 0,

      actions: widgets,




      leading:  Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: backTap,
          child: Container(
            margin: EdgeInsets.only(left: 10.w),
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
              child: Icon(Icons.arrow_back_ios,color: AppColors.primaryColor,),
            ),
          ),
        ),
      ),
    );
  }
  @override
  Size get preferredSize =>  Size.fromHeight(100.h);
}