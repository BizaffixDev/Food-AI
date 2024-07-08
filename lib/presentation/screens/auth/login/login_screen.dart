import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodai_mobile/app/utils/common_functions.dart';
import 'package:foodai_mobile/app/utils/ui_snackbars.dart';
import 'package:foodai_mobile/common/app_specific_widgets/back_arrow_container.dart';
import 'package:foodai_mobile/common/app_specific_widgets/custom_buttons.dart';
import 'package:foodai_mobile/common/app_specific_widgets/custom_textfield.dart';
import 'package:foodai_mobile/common/app_specific_widgets/loader.dart';
import 'package:foodai_mobile/common/app_specific_widgets/or_text.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/drawables.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/generated/assets.dart';
import 'package:foodai_mobile/presentation/providers/auth_providers.dart';
import 'package:foodai_mobile/presentation/providers/screen_state.dart';
import 'package:foodai_mobile/presentation/screens/auth/login/components/login_heading_text.dart';
import 'package:foodai_mobile/presentation/screens/auth/login/components/or_continue_with_text.dart';
import 'package:foodai_mobile/presentation/screens/auth/login/components/signup_here_text_button.dart';
import 'package:foodai_mobile/presentation/screens/auth/login/components/social_buttons.dart';
import 'package:foodai_mobile/presentation/screens/auth/states/auth_states.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  /// CONTROLLERS

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  /// FOCUS NODES
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  ///MEHODS

  void login() async{
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      UIFeedback.showSnackBar(
          context, "Email and Password is required",);
    } else {
      _passwordFocusNode.unfocus();
      _emailFocusNode.unfocus();
      var loggingIn = await ref
          .read(authNotifyProvider.notifier)
          .loginUser(context,
          email: _emailController.text.trim(),
          password:
          _passwordController.text.trim());

      //debugPrint("This is the response$loggingIn");
    }
  }

  @override
  Widget build(BuildContext context) {

    ref.listen<AuthStates>(authNotifyProvider, (previous, screenState) async {
      if (screenState is LoginErrorState) {
        String errorMessage = "";

        if (screenState.errorType == ErrorType.unauthorized) {
          errorMessage = 'Unauthorized: ${screenState.error}';
        } else if (screenState.errorType == ErrorType.other) {
          try {
            final errorJson = jsonDecode(screenState.error);
            if (errorJson is Map<String, dynamic> &&
                errorJson.containsKey('message')) {
              errorMessage = errorJson['message'].toString();
            }
          } catch (e) {
            // Handle JSON parsing error, if any
            errorMessage = 'Error parsing JSON';
          }
        } else {
          errorMessage = screenState.error.toString();
        }

        print('Error Message: $errorMessage');
        UIFeedback.showSnackBar(context, errorMessage, height: 140);
        dismissLoading(context);
      }  else if (screenState is LoginLoadingState) {
        debugPrint('Loading');
        showLoading(context);
      } else if (screenState is LoginSuccessfulState) {
        context.push(PagePath.home);
        dismissLoading(context);
      }
    });


    return Scaffold(
      body: SafeArea(
        child: Container(
          height: CommonFunctions.deviceHeight(context),
          width: CommonFunctions.deviceWidth(context),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.backgroundTexture), fit: BoxFit.fill),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 //BackArrowIconContainer(),
                SizedBox(height: 30.h,),
                LoginHeadingText(),
                SizedBox(
                  height: 10.h,
                ),
                SocialButtons(
                  fbTap: (){},
                  googleTap: (){},
                ),
                SizedBox(
                  height: 20.h,
                ),

                OrContinueWithText(),

                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///EMAIL
                      Text(
                        "EMAIL",
                        style: kHeading2TextStyle.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CustomTextField(
                        controller: _emailController,
                        hintText: "example@gmail.com",
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.emailAddress,
                        focusNode: _emailFocusNode,
                        onSubmit: () => FocusScope.of(context)
                            .requestFocus(_passwordFocusNode),
                      ),

                      ///PASSWORD
                      Text(
                        "PASSWORD",
                        style: kHeading2TextStyle.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: "Password",
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.phone,
                        focusNode: _passwordFocusNode,
                        onSubmit: () =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                      ),

                      TextButton(
                        onPressed: ()=>context.push(PagePath.forgotPassword),
                        child: Text("Forgot Password?", style: kSubtitle1TextStyle.copyWith(
                          color: AppColors.textColor,
                          fontSize: 14.sp,
                          height: 0.8,
                        ),),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: CustomButton(
                    text: "Login",
                    onTap: (){
                      FocusManager.instance.primaryFocus?.unfocus();
                      Future.delayed(Duration(seconds: 1),(){
                        login();
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                const OrText(),
                SignUpHereTextButton(
                  onTap: () => context.push(PagePath.signup),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




