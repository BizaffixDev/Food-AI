import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class SubHeading extends StatelessWidget {
  const SubHeading({
    super.key,
    required this.text
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: kHeading2TextStyle.copyWith(
      height: 1.1,
      fontSize: 24.sp,
    ),);
  }
}
