import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/app/utils/common_functions.dart';
import 'package:foodai_mobile/app/utils/ui_snackbars.dart';
import 'package:foodai_mobile/common/app_specific_widgets/back_arrow_container.dart';
import 'package:foodai_mobile/common/app_specific_widgets/custom_buttons.dart';
import 'package:foodai_mobile/common/app_specific_widgets/loader.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/generated/assets.dart';
import 'package:foodai_mobile/presentation/providers/auth_providers.dart';
import 'package:foodai_mobile/presentation/providers/screen_state.dart';
import 'package:foodai_mobile/presentation/screens/auth/forgot_password/components/enter_otp_text.dart';
import 'package:foodai_mobile/presentation/screens/auth/forgot_password/components/otp_verification_heading_text.dart';
import 'package:foodai_mobile/presentation/screens/auth/states/auth_states.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';


class OtpVerificationScreen extends ConsumerStatefulWidget {
  String email;
  OtpVerificationScreen({super.key, required this.email});

  @override
  ConsumerState<OtpVerificationScreen> createState() => _ForgotOtpVerificationScreenState();
}

class _ForgotOtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {

  int start = 120;
  bool wait = false;
  final otpController = TextEditingController();
  bool isVerificationFailed = false;
  late FocusNode _focusNode; // Add a FocusNode variable
  Timer? _timer;
  bool isResendButtonDisabled = false;


  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        setState(() {
          if (start < 1) {
            timer.cancel(); // Cancel the timer when it reaches 0
            wait = false; // Reset the wait flag
            isResendButtonDisabled = false; // Enable the "Resend" button
          } else {
            start--;
          }
        });
      },
    );
  }

  void hitResendApi() async {
    // Call your API for resending OTP here
    //Example:
    //await ref.read(authNotifyProvider.notifier).resendOtp(context, email: widget.email);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode = FocusNode(); // Initialize the FocusNode
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();

    _focusNode.dispose(); // Dispose the FocusNode when the screen is disposed
    super.dispose();
  }

  _sendOtp() {
    final otp = otpController.text.trim();
    final email = widget.email;

    ref
        .read(authNotifyProvider.notifier)
        .verifyOtp(context, email: email.toString(), otp: int.parse(otp));
  }


/*  void resendCode() async {
    if (wait) {
      // Show a snackbar indicating that the timer is still running
      UIFeedback.showSnackBar(
        context,
        "Please wait "
            "${start ~/ 60}:${(start % 60).toString().padLeft(2, '0')}"
            " for the timer to finish",
      );
    } else {
      otpController.clear(); // Clear the otpController text field
      startTimer();
      setState(() {
        wait = true;
        start = 120;
        isResendButtonDisabled = true; // Disable the "Resend" button
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {


    ref.listen<AuthStates>(authNotifyProvider, (previous, screenState) async {
      if (screenState is OtpVerifyErrorState) {
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
      }  else if (screenState is OtpVerifyLoadingState) {
        debugPrint('Loading');
        showLoading(context);
      } else if (screenState is OtpVerifySuccessfulState) {
        context.push(PagePath.buildProfile);
        dismissLoading(context);
      }
    });


    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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

                const OtpVerificationHeadingText(),

                EnterOtpText(email: widget.email),

                SizedBox(
                  height: 50.h,
                ),

                Center(
                  child: Pinput(
                    onChanged: (_) {
                      setState(() {});
                    },
                    controller: otpController,
                    length: 4,
                    keyboardType: TextInputType.number,
                    toolbarEnabled: false,
                    listenForMultipleSmsOnAndroid: true,
                    defaultPinTheme: isVerificationFailed
                        ? errorPinTheme // Change border color to red
                        : defaultPinTheme,
                    focusedPinTheme:
                    defaultPinTheme.copyDecorationWith(
                      border:
                      Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    submittedPinTheme:
                    defaultPinTheme.copyDecorationWith(
                      border:
                      Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                SizedBox(
                  height: 30.h,
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Your code will expire in ",
                      style: kSubtitle1TextStyle,
                    ),
                    Text(
                      "${start ~/ 60}:${(start % 60).toString().padLeft(2, '0')}", // Updated line
                      style: kSubtitle1TextStyle.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),


                Center(
                  child: TextButton(
                    onPressed: isResendButtonDisabled
                        ? null // Disable the button when the timer is running
                        :(){
                      // When the "Resend" button is pressed, hit the API and restart the timer
                      hitResendApi();
                      startTimer();
                      setState(() {
                        wait = true;
                        start = 120;
                        isResendButtonDisabled = true; // Disable the "Resend" button
                      });
                    },
                    child: Text(
                      "Resend Code",
                      style: kHeading3TextStyle.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: start == 0
                            ? AppColors.primaryColor
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),

                Center(child:otpController.text.length < 3 ? Container() : CustomButton(
                  onTap: () {
                    if (otpController.text.length > 3
                    // && !isVerificationFailed
                    ) {
                      _sendOtp();
                    }
                  },
                  text: "Verify",
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




