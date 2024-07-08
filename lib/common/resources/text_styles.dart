import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:foodai_mobile/common/resources/colors.dart';

TextStyle kHeading1TextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w700,
  fontSize: 28.sp,
  height: 2,
  color: AppColors.black,
);

TextStyle kHeading2TextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  fontSize: 24.sp,
  height: 2,
  color: AppColors.black,
);


TextStyle kHeading3TextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w300,
  fontSize: 20.sp,
  height: 2,
  color: AppColors.black,
);


TextStyle kSubtitle1TextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w400,
  fontSize: 16.sp,
  height: 2,
  color: AppColors.black,
);



TextStyle manropeHeadingTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w700,
  fontSize: 28.sp,
  height: 2,
  color: AppColors.black,
);


PinTheme defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: kHeading3TextStyle.copyWith(
    fontWeight: FontWeight.w800,
    fontSize: 24,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.black38, width: 2),
  ),
);
PinTheme errorPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: kHeading3TextStyle.copyWith(
    fontWeight: FontWeight.w800,
    fontSize: 24,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.red, width: 2),
  ),
);


