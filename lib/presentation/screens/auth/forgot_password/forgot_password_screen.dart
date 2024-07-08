import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/app/utils/common_functions.dart';
import 'package:foodai_mobile/app/utils/ui_snackbars.dart';
import 'package:foodai_mobile/common/app_specific_widgets/back_arrow_container.dart';
import 'package:foodai_mobile/common/app_specific_widgets/custom_buttons.dart';
import 'package:foodai_mobile/common/app_specific_widgets/custom_textfield.dart';
import 'package:foodai_mobile/common/app_specific_widgets/loader.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/generated/assets.dart';
import 'package:foodai_mobile/presentation/providers/auth_providers.dart';
import 'package:foodai_mobile/presentation/providers/screen_state.dart';
import 'package:foodai_mobile/presentation/screens/auth/forgot_password/components/forgot_password_heading_text.dart';
import 'package:foodai_mobile/presentation/screens/auth/forgot_password/components/forgot_sub_text.dart';
import 'package:foodai_mobile/presentation/screens/auth/states/auth_states.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = true;
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
  }

  @override
  void dispose() {
    _isMounted = false;
    _emailController.dispose();
    super.dispose();
  }

  void _validateEmail() {
    String email = _emailController.text.trim();
    bool isValid =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(email);
    if (_isMounted) {
      setState(() {
        print(isValid);
        _isEmailValid = isValid;
      });
    }
  }

  void _sendEmail() {
    _validateEmail();
    final email = _emailController.text.trim();
    if (_isMounted && _isEmailValid) {

      //context.push('${PagePath.forgotOtpVerification}?email=$email');

      FocusScope.of(context).unfocus();
      ref
          .read(authNotifyProvider.notifier)
          .forgetPassword(context, email: _emailController.text.trim());
    }else{
      UIFeedback.showSnackBar(context, "Please provide your registered email address.");
    }
  }

  @override
  Widget build(BuildContext context) {


    ref.listen<AuthStates>(authNotifyProvider, (previous, screenState) async {
      if (screenState is ForgetPasswordErrorState) {
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
      }  else if (screenState is ForgetPasswordLoadingState) {
        debugPrint('Loading');
        showLoading(context);
      } else if (screenState is ForgetPasswordSuccessfulState) {
        final email = _emailController.text.trim();
        context.push('${PagePath.forgotOtpVerification}?email=$email');
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               BackArrowIconContainer(),
              SizedBox(
                height: 50.h,
              ),
              const ForgotPasswordHeadingText(),
              const ForgotSubText(),
              SizedBox(
                height: 100.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: CustomTextField(
                  controller: _emailController,
                  hintText: "Enter your email",
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              
              Center(child: CustomButton(text: "Send Email", onTap: _sendEmail)),
            ],
          ),
        ),
      ),
    );
  }
}
