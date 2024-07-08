import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/app_specific_widgets/back_arrow_container.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/drawables.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/presentation/screens/profile/components/profile_list_tile_option.dart';
import 'package:foodai_mobile/presentation/screens/profile/components/profile_option.dart';
import 'package:foodai_mobile/presentation/screens/profile/profile_screen.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({super.key});

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "My Address",
          style: kHeading2TextStyle,
        ),
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 3),
          child: BackArrowIconContainer(
            isPadding: false,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.primaryColor,
                ),
                SizedBox(
                  width: 20.w,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "John Doe",
                      style: kHeading2TextStyle,
                    ),
                    Text(
                      "I Love Food",
                      style: kHeading3TextStyle.copyWith(
                          color: Color(0xFFCDCBCB),
                          height: 1.1,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ],
                ),






              ],
            ),
          ),



          ///PERSONAL INFO BAR
          Container(
            height: 145.h,
            margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: const Color(0xFFf6f8fa),
                border: Border.all(color: AppColors.textColor.withOpacity(0.2))
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileListTileOption(
                    icon: Drawables.addressIcon,
                    title: "Home",
                    subtitle: "Saadi Town",
                    onTap: (){},
                  ),

                  SizedBox(height: 5.h,),

                  ProfileListTileOption(
                    icon: Drawables.workIcon,
                    title: "Work",
                    subtitle: "Bizzafix",
                    onTap: (){},
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

