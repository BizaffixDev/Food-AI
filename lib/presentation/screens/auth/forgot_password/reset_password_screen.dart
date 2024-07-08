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
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/drawables.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/generated/assets.dart';
import 'package:foodai_mobile/presentation/providers/auth_providers.dart';
import 'package:foodai_mobile/presentation/providers/screen_state.dart';
import 'package:foodai_mobile/presentation/screens/auth/forgot_password/components/reset_password_heading_text.dart';
import 'package:foodai_mobile/presentation/screens/auth/forgot_password/components/reset_your_password_text.dart';
import 'package:foodai_mobile/presentation/screens/auth/states/auth_states.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  String email;
  ResetPasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ResetPasswordScreen> {

  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();
  bool arePasswordsValid = false; // New variable to track password validity

  bool isObscure1 = true;
  bool isObscure2 = true;

  @override
  void dispose() {
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  _checkBothPasswords() {
    if (_confirmPassController.text.trim() ==
        _newPassController.text.trim() &&
        _confirmPassController.text.trim().length >= 8 &&
        _newPassController.text.trim().length >= 8) {
      return true;
    }
    return false;
  }

  _confirmPasswordChange() {
    if (_checkBothPasswords()) {
      FocusManager.instance.primaryFocus?.unfocus();
      //context.push(PagePath.login);

      ref.read(authNotifyProvider.notifier).resetPassword(
          context: context,
          email: widget.email.trim().toString(),
          password: _confirmPassController.text.trim());
    } else if (_confirmPassController.text.trim().length < 8 &&
        _newPassController.text.trim().length < 8) {
      FocusManager.instance.primaryFocus?.unfocus();
      UIFeedback.showSnackBar(context, 'Must be 8 characters long.');
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      UIFeedback.showSnackBar(context, 'The passwords do not match.');
    }
  }


  @override
  Widget build(BuildContext context) {

    ref.listen<AuthStates>(authNotifyProvider, (previous, screenState) async {
      if (screenState is NewPasswordErrorState) {
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
      }  else if (screenState is NewPasswordLoadingState) {
        debugPrint('Loading');
        showLoading(context);
      } else if (screenState is NewPasswordSuccessfulState) {
        dismissLoading(context);
        showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(35),
                topLeft: Radius.circular(35),
              ),
            ),
            context: context,
            builder: (context) {
              return SizedBox(
                height: CommonFunctions.deviceHeight(context) * 0.5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Center(
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 5,
                          width: 80,
                          decoration:
                          const BoxDecoration(color: Color(0xFFDADAD1)),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(Drawables.pencil),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "PASSWORD CREATED",
                              style: manropeHeadingTextStyle.copyWith(
                                fontSize: 14,
                                color: AppColors.primaryColor,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Text(
                          "New Password Has Been Created!",
                          style: manropeHeadingTextStyle.copyWith(
                              fontSize: 24,
                              color: const Color(0xFF27364E),
                              height: 1.2),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "You can now login with your newly created account password.",
                          style: manropeHeadingTextStyle.copyWith(
                              fontSize: 16,
                              color: const Color(0xFF5B5B5B),
                              fontWeight: FontWeight.w400,
                              height: 1.2),
                          textAlign: TextAlign.left,
                        ),
                        const Spacer(),
                        CustomButton(
                            text: "Confirm",
                            onTap: () {
                              Navigator.of(context).pop();
                              GoRouter.of(context).go(PagePath.login);
                              // Timer.periodic(Duration(seconds: 1),
                              //     (timer) {
                              //   GoRouter.of(context)
                              //       .go(PagePath.login);
                              // });
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });

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
                const ResetPasswordHeadingText(),

                const ResetYourPasswordText(),

                SizedBox(
                  height: 40.h,
                ),


                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomTextField(
                    controller: _newPassController,
                    hintText: "Create New Password",
                    obscure: isObscure1,
                    suffixIcon: isObscure1
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    obscureIconLogic: () {
                      print(isObscure1);
                      setState(() {
                        isObscure1 = !isObscure1;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomTextField(

                    controller: _confirmPassController,
                    hintText: "Re-enter New Password",
                    obscure: isObscure2,
                    suffixIcon: isObscure2
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    obscureIconLogic: () {
                      print(isObscure2);
                      setState(() {
                        isObscure2 = !isObscure2;
                      });
                    },
                  ),
                ),
                _checkBothPasswords()
                    ? Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "Your passwords Match!",
                        style: kSubtitle1TextStyle.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                )
                    : Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 4.0),
                      //   child: Icon(
                      //     Icons.incorre,
                      //     color: Colors.red,
                      //     size: 12,
                      //   ),
                      // ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "*Must be 8 charcters long",
                        style: kSubtitle1TextStyle.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),

                Center(child: CustomButton(text: "Confirm", onTap: (){

                  FocusManager.instance.primaryFocus?.unfocus();
                  Future.delayed(Duration(seconds: 1),(){
                    _confirmPasswordChange();
                  });

                },),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


