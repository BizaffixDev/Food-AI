import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/app/utils/common_functions.dart';
import 'package:foodai_mobile/app/utils/ui_snackbars.dart';
import 'package:foodai_mobile/common/app_specific_widgets/back_arrow_container.dart';
import 'package:foodai_mobile/common/app_specific_widgets/custom_buttons.dart';
import 'package:foodai_mobile/common/app_specific_widgets/custom_textfield.dart';
import 'package:foodai_mobile/common/app_specific_widgets/loader.dart';
import 'package:foodai_mobile/common/app_specific_widgets/or_text.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/common/resources/strings.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/generated/assets.dart';
import 'package:foodai_mobile/presentation/providers/auth_providers.dart';
import 'package:foodai_mobile/presentation/providers/screen_state.dart';
import 'package:foodai_mobile/presentation/screens/auth/signup/components/login_here_text_button.dart';
import 'package:foodai_mobile/presentation/screens/auth/signup/components/signup_heading_text.dart';
import 'package:foodai_mobile/presentation/screens/auth/states/auth_states.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {


  /// CONTROLLERS
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController(text: '+92');
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  /// FOCUS NODES
  final FocusNode _fullNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool isObscure = false;


  String? lat;
  String? lng;



  ///METHODS

  void signup() async{
    if (_fullNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty
        ) {
      UIFeedback.showSnackBar(
        context, "All fields are required",);
      print(ref.read(userAddressProvider));
    }
    // else if (isChecked == false) {
    //   UIFeedback.showSnackBar(context,
    //       "Please agree to the terms and conditions",
    //       stateType: StateType.error, height: 140);
    // }
    else if (!Strings.emailRegex
        .hasMatch(_emailController.text)) {
      UIFeedback.showSnackBar(context,
        "Please enter valid email address",);
    }
    // else if (!Strings.phoneRegex.hasMatch(_phoneController.text)) {
    //   UIFeedback.showSnackBar(context,
    //     "Invalid phone number format. Use +92xxxxxxxxxx",);
    //  // return 'Invalid phone number format. Use "+92xxxxxxxxxx"';
    // }
    else {
      _fullNameFocusNode.unfocus();
      _passwordFocusNode.unfocus();
      _emailFocusNode.unfocus();
      _addressFocusNode.unfocus();


      var signup = await ref
          .read(authNotifyProvider.notifier)
          .signupUser(
        context,
        username: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        phoneNumber: _phoneController.text,
        address: ref.read(userAddressProvider),
      );

      print(ref.read(userAddressProvider));

      debugPrint("This is the response of Sign Up $signup");
    }
  }





  @override
  Widget build(BuildContext context) {


    ref.listen<AuthStates>(authNotifyProvider, (previous, screenState) async {
      if (screenState is SignUpErrorState) {
        if (screenState.errorType == ErrorType.unauthorized) {
          print('going inside unauthorized block in UI');
          UIFeedback.showSnackBar(context, screenState.error.toString(),
              height: 140);
          dismissLoading(context);
        } else if (screenState.errorType == ErrorType.other) {
          print("This is the error thats not shwoing: ${screenState.error}");
          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error Bro')));
          UIFeedback.showSnackBar(context, screenState.error.toString(),
              height: 140);
          dismissLoading(context);
        } else {
          print("This is the error thats not shwoing: ${screenState.error}");
          UIFeedback.showSnackBar(context, screenState.error.toString(),
              height: 140);
          dismissLoading(context);
        }
      }  else if (screenState is SignUpLoadingState) {
        debugPrint('Loading');
        showLoading(context);
      } else if (screenState is SignUpSuccessfulState) {
        final email = _emailController.text.trim();
        context.push('${PagePath.otpVerification}?email=$email');
        dismissLoading(context);
      }
    });

   String userAddress = ref.watch(userAddressProvider);



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
                BackArrowIconContainer(),
                SignUpHeadingText(),
                SizedBox(
                  height: 40.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///FULLNAME
                      Text(
                        "FULL NAME",
                        style: kHeading2TextStyle.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CustomTextField(
                        controller: _fullNameController,
                        hintText: "John Doe",
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        focusNode: _fullNameFocusNode,
                        onSubmit: ()=>FocusScope.of(context)
                            .requestFocus(_emailFocusNode),
                      ),

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
                        onSubmit: ()=>FocusScope.of(context)
                            .requestFocus(_phoneFocusNode),
                      ),

                      ///PHONE
                      Text(
                        "PHONE",
                        style: kHeading2TextStyle.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CustomTextField(
                        controller: _phoneController,
                        hintText: "+92XXXXXXXXXX",
                        maxLength: 13,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.phone,
                        focusNode: _phoneFocusNode,
                        onSubmit: ()=>FocusScope.of(context)
                            .requestFocus(_addressFocusNode),
                      ),

                      ///ADDRESS
                      Text(
                        "ADDRESS",
                        style: kHeading2TextStyle.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CustomTextField(
                        controller: _addressController,
                        hintText: userAddress == "" ? "Get your location" : userAddress,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.streetAddress,
                        focusNode: _addressFocusNode,
                        onSubmit: ()=>FocusScope.of(context)
                            .requestFocus(_passwordFocusNode),
                        onTap: (){
                          context.push(PagePath.location);
                        },


                        isReadAble: true,
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
                        onSubmit: ()=>FocusManager.instance.primaryFocus?.unfocus(),
                        obscure: isObscure,
                        suffixIcon: isObscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        obscureIconLogic: () {
                          print(isObscure);
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 30.h,
                ),

                Center(child: CustomButton(text: "Signup", onTap: (){
                  FocusManager.instance.primaryFocus?.unfocus();
                  Future.delayed(Duration(seconds: 1),(){
                    signup();
                  });

                },

                ),),

                SizedBox(
                  height: 30.h,
                ),

                const OrText(),

                LoginHereTextButton(
                  onTap: ()=>context.push(PagePath.login),
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}



