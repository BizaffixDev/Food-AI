import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({
    super.key,
    required  this.controller,
     required this.hintText,
    this.focusNode,
     this.textInputType,
     this.textInputAction,
     this.onSubmit,
     this.onTap,
      this.isReadAble = false,
     this.obscure = false,
     this.suffixIcon,
     this.obscureIconLogic,
     this.onChanged,
     this.maxLength,


  });

  final TextEditingController controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String hintText;
  FocusNode? focusNode;
   VoidCallback? onSubmit;
   VoidCallback? onTap;
   bool? isReadAble;
    bool? obscure;
   IconData? suffixIcon;
   VoidCallback? obscureIconLogic;
   ValueChanged<String>? onChanged;
   int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscure!,
      style: kSubtitle1TextStyle,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      onEditingComplete: onSubmit,
      onTap: onTap,
      readOnly: isReadAble!,
      onChanged: onChanged,
      maxLength: maxLength,

      decoration: InputDecoration(
          fillColor: AppColors.textFieldColor,
          filled: true,
          hintText: hintText,
          hintStyle: kSubtitle1TextStyle.copyWith(
            color: Color(0xFFA3A3A3),
          ),
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.only(left:20.w),
        suffixIcon: IconButton(
          icon: Icon(
            suffixIcon,
            color: AppColors.primaryColor,// widget.obscure! == true ? Icons.visibility : Icons.visibility_off
          ),
          onPressed: obscureIconLogic,
        ),

      ),
    );
  }
}
