import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/drawables.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget{
  const HomeAppbar({
    super.key, required this.appBar, required this.widgets,
    required this.drawerOpenTap,
  });


  final AppBar appBar;
  final List<Widget> widgets;
  final VoidCallback drawerOpenTap;

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
          onTap: drawerOpenTap,
          child: Container(
            margin: EdgeInsets.only(left: 5.w),
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
              child: Icon(Icons.menu,color: AppColors.primaryColor,),
            ),
          ),
        ),
      ),


    );
  }
  @override
  Size get preferredSize =>  Size.fromHeight(100.h);
}

