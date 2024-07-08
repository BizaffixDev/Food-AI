import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/app_specific_widgets/back_arrow_container.dart';
import 'package:foodai_mobile/common/app_specific_widgets/custom_buttons.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/drawables.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/presentation/screens/profile/components/profile_option.dart';
import 'package:foodai_mobile/presentation/screens/profile/profile_screen.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Profile",
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
                  ProfileOption(
                    icon: Drawables.profileIcon,
                    text: "Personal Info",
                    onTap: (){
                      context.push(PagePath.personalInfo);
                    },
                  ),

                  ProfileOption(
                    icon: Drawables.addressIcon,
                    text: "Address",
                    onTap: (){
                      context.push(PagePath.myAddress);
                    },
                  ),
                ],
              ),
            ),
          ),

          ///SETTINGS BAR
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
                  ProfileOption(
                    icon: Drawables.cartProfileIcon,
                    text: "Cart",
                    onTap: (){

                    },
                  ),

                  ProfileOption(
                    icon: Drawables.settingsIcon,
                    text: "Settings",
                    onTap: (){},
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),


          CustomButton(text: "Logout", onTap: (){}),

          SizedBox(height: 20.h,),
        ],
      ),
    );
  }
}

