import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';

class TellusWhatYouLikeSubText extends StatelessWidget {
  const TellusWhatYouLikeSubText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          "Tell Us what You Like",
          style: kHeading3TextStyle.copyWith(
            fontSize: 22.sp,
            fontWeight: FontWeight.w300,
            color:const  Color(0xFF4E4E4E),
            height: 1.1,
          )
      ),
    );
  }
}


