import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/app/utils/common_functions.dart';
import 'package:foodai_mobile/app/utils/ui_snackbars.dart';
import 'package:foodai_mobile/common/app_specific_widgets/back_arrow_container.dart';
import 'package:foodai_mobile/common/app_specific_widgets/bottom_sheet_icon.dart';
import 'package:foodai_mobile/common/app_specific_widgets/loader.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/data/models/preferences_response_model.dart';
import 'package:foodai_mobile/generated/assets.dart';
import 'package:foodai_mobile/presentation/providers/auth_providers.dart';
import 'package:foodai_mobile/presentation/providers/screen_state.dart';
import 'package:foodai_mobile/presentation/screens/auth/build_profile/components/card_shimmer.dart';
import 'package:foodai_mobile/presentation/screens/auth/build_profile/components/lets_build_profile_text.dart';
import 'package:foodai_mobile/presentation/screens/auth/build_profile/components/like_dislike_buttons.dart';
import 'package:foodai_mobile/presentation/screens/auth/build_profile/components/swipe_card_container.dart';
import 'package:foodai_mobile/presentation/screens/auth/build_profile/components/swipe_restaurant_container.dart';
import 'package:foodai_mobile/presentation/screens/auth/build_profile/components/tell_us_what_you_like_text.dart';
import 'package:foodai_mobile/presentation/screens/auth/states/auth_states.dart';
import 'package:go_router/go_router.dart';

class BuildRestaurantScreen extends ConsumerStatefulWidget {
  const BuildRestaurantScreen({super.key});

  @override
  ConsumerState<BuildRestaurantScreen> createState() => _BuildProfileScreenState();
}

class _BuildProfileScreenState extends ConsumerState<BuildRestaurantScreen> {
  final CardSwiperController controller = CardSwiperController();

  bool lastCardSwiped = false; // Initialize a flag to track the last card swipe


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(authNotifyProvider.notifier).getPreferences();
    });
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    ref.listen<AuthStates>(authNotifyProvider, (previous, screenState) async {
      if (screenState is PreferencesErrorState) {
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
      }
      else if (screenState is UserResponseErrorState) {
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
      }
      else if (screenState is PreferencesLoadingState) {
        debugPrint('Loading');
        showLoading(context);
      }
      else if (screenState is UserResponseLoadingState) {
        debugPrint('Loading');
        showLoading(context);
        lastCardSwiped == true ? context.go(PagePath.home) : null;
      }
      else if (screenState is PreferencesSuccessfulState) {
        dismissLoading(context);
        setState(() {

        });
      }
      else if (screenState is UserResponseSuccessfulState) {
        dismissLoading(context);
        setState(() {
        });
      }
    });

    List<PreferencesData> preferencesList = ref.watch(preferencesProvider);

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
                height: 20.h,
              ),
               Container(
                 padding: EdgeInsets.only(left: 30.w),
                 child: Text(
                     "Restaurants",
                     style: kHeading3TextStyle.copyWith(
                       fontSize: 32.sp,
                       fontWeight: FontWeight.w300,
                       color:const  Color(0xFF4E4E4E),
                     )
                 ),
               ),

              SizedBox(
                height: 20.h,
              ),

              /// SWIPE CARD HERE

              preferencesList.isEmpty
                  ?

              Container(

                  margin: EdgeInsets.symmetric(horizontal: 40.w,),
                  height: 380.h,child: SwipeCardShimmer())

                  : Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 40.w,
                ),
                height: 380.h,
                child: CardSwiper(
                  controller: controller,
                  cardsCount: preferencesList.length,
                  onSwipe: (
                      int previousIndex,
                      int? currentIndex,
                      CardSwiperDirection direction,
                      ) {
                    debugPrint(
                      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
                    );

                    if (currentIndex != null) {
                      final bool swipeRight = direction == CardSwiperDirection.right;
                      final bool swipeLeft = direction == CardSwiperDirection.left;

                      // Call userResponse with the appropriate parameters
                      ref.read(authNotifyProvider.notifier).userResponse(
                        userId: 1, // Replace with the actual user ID
                        questionId: preferencesList[currentIndex]
                            .questionId, // Get questionId from your data
                        userResponse: swipeRight, // Pass true for a right swipe, false for a left swipe
                      );

                      // Check if it's a right swipe and the last card is currently being swiped
                      if (swipeRight && lastCardSwiped ) {
                        // Navigate to the next screen when the last card is swiped to the right
                        //context.push(PagePath.home); // Replace with your route
                      }else if (swipeLeft && lastCardSwiped ) {
                        // Navigate to the next screen when the last card is swiped to the right
                        // context.push(PagePath.home); // Replace with your route
                      }

                      // Check if currentIndex is the last card
                      if (currentIndex == preferencesList.length - 1) {
                        lastCardSwiped = true; // Set the flag to indicate the last card is being swiped
                      }
                    }
                    return true;
                  },
                  numberOfCardsDisplayed: 1,
                  //backCardOffset: const Offset(40, 40),
                  padding: EdgeInsets.only(left: 24.0),
                  cardBuilder: (
                      context,
                      index,
                      horizontalThresholdPercentage,
                      verticalThresholdPercentage,
                      ) =>
                  buildCards(preferencesList)[index],
                ),
              ),



              SizedBox(
                height: 40.h,
              ),

              LikeDislikeButtons(
                disLikeTap: controller.swipeLeft,
                likeTap: controller.swipeRight,
              ),

              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Spacer(),
                  // CustomizeBottomSheetIcon(
                  //   onTap: () {},
                  // ),

                  Spacer(),

                  Container(
                      padding: EdgeInsets.only(right: 20.w),
                      child: GestureDetector(
                        onTap: (){
                          context.go(PagePath.home);
                          print("tapped");
                        },
                        child: Text("Skip",style:kHeading2TextStyle.copyWith(
                          height: 0.2,
                          fontWeight: FontWeight.w300,
                        ),),
                      ))
                ],
              ),

              SizedBox(height: 20.w,),
            ],
          ),
        ),
      ),
    );
  }

  bool _onSwipe(
      int previousIndex,
      int? currentIndex,
      CardSwiperDirection direction,
      ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );

    return true;
  }
}

List<Widget> buildCards(List<PreferencesData> preferencesList) {
  return preferencesList.map((data) {
    return SwipeRestaurantCardContainer(
      restaurantName: "KFC",
      restaurantImage: "https://upload.wikimedia.org/wikipedia/en/thumb/5/57/KFC_logo-image.svg/1200px-KFC_logo-image.svg.png"
    );

    //   Card(
    //   child: Column(
    //     children: [
    //       Image.network(data.profileImage),
    //       Text(data.name),
    //       Text(data.shortDescription),
    //       Text(data.description),
    //     ],
    //   ),
    // );
  }).toList();
}
