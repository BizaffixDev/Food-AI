import 'package:flutter/material.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class OrText extends StatelessWidget {
  const OrText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("OR",style: kSubtitle1TextStyle.copyWith(
        color: Color(0xFF8B8B8B),
        height: 1.1,
      ),),
    );
  }
}