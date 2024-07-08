import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/drawables.dart';

class CustomizeBottomSheetIcon extends StatelessWidget {
  const CustomizeBottomSheetIcon({
    super.key, required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: onTap,
          child: Image.asset(Drawables.bottomSheetIcon,height: 50.h,)),
    );
  }
}