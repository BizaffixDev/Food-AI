import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:foodai_mobile/app/utils/common_functions.dart';
import 'package:foodai_mobile/app/utils/ui_snackbars.dart';
import 'package:foodai_mobile/common/app_specific_widgets/bottom_sheet_icon.dart';
import 'package:foodai_mobile/common/app_specific_widgets/custom_buttons.dart';
import 'package:foodai_mobile/common/app_specific_widgets/loader.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/data/models/cuisine_preferences_response_model.dart';
import 'package:foodai_mobile/generated/assets.dart';
import 'package:foodai_mobile/presentation/providers/discover_providers.dart';
import 'package:foodai_mobile/presentation/providers/screen_state.dart';
import 'package:foodai_mobile/presentation/screens/auth/build_profile/components/card_shimmer.dart';
import 'package:foodai_mobile/presentation/screens/auth/build_profile/components/like_dislike_buttons.dart';
import 'package:foodai_mobile/presentation/screens/auth/build_profile/components/swipe_card_container.dart';
import 'package:foodai_mobile/presentation/screens/discover/components/top_appbar_icon_row.dart';
import 'package:foodai_mobile/presentation/screens/discover/disover_states.dart';
import 'package:go_router/go_router.dart';

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({required this.cuisineId, super.key});

  final String cuisineId;

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  final CardSwiperController controller = CardSwiperController();

  bool lastCardSwiped = false; // Initialize a flag to track the last card swipe

  List<Widget> cards = [
    const SwipeCardContainer(
      itemName: "THE DOPPLER",
      itemRating: "4.5",
      itemCategory: "BEEF LOVERS",
      itemImage: Assets.burger,
      itemComment: "Who doesn't love classic Beef burger?",
      itemPrice: "5.66",
    ),
    const SwipeCardContainer(
      itemName: "PEPPERONI",
      itemRating: "4.3",
      itemCategory: "PIZZA LOVERS",
      itemImage: Assets.pizza,
      itemComment: "Who doesn't love cheezy pepporoni pizza?",
      itemPrice: "5.66",
    ),
    const SwipeCardContainer(
      itemName: "SHAWARMA",
      itemRating: "4.3",
      itemCategory: "ARABIC LOVERS",
      itemImage: Assets.roll,
      itemComment: "Who doesn't love classic arabic shawarma?",
      itemPrice: "5.66",
    )
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String? selectedCuisine;
  String? selectedRestaurant;

  double lowerPriceValue = 50;
  double upperPriceValue = 180;

  double lowerRatingValue = 1;
  double upperRatingValue = 4;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(discoverNotifyProvider.notifier).getPreferencesCuisines(cuisineId: widget.cuisineId);
    });
  }


  @override
  Widget build(BuildContext context) {

      ref.listen<DiscoverStates>(discoverNotifyProvider, (previous, screenState) async {
      if (screenState is PreferenceCuisinesErrorState) {
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
      else if (screenState is PreferenceResponseErrorState) {
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
      else if (screenState is PreferenceCuisinesLoadingState) {
        debugPrint('Loading');
        showLoading(context);
      }
      else if (screenState is PreferenceResponseLoadingState) {
        debugPrint('Loading');
        showLoading(context);
        lastCardSwiped == true ? context.go("${PagePath.restaurantHome}?restaurantId=10") : null;
      }
      else if (screenState is PreferenceCuisinesSuccessfulState) {
        dismissLoading(context);
        setState(() {

        });
      }
      else if (screenState is PreferenceResponseSuccessfulState) {
        dismissLoading(context);
        setState(() {
        });
      }
    });


        List<Preference> preferencesList = ref.watch(preferencesCuisinesProvider);
      return SafeArea(
      child: Scaffold(
        body: Container(
          height: CommonFunctions.deviceHeight(context),
          width: CommonFunctions.deviceWidth(context),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                Assets.backgroundTexture,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopAppBarIconsRow(),
              SizedBox(
                height: 20.h,
              ),
              Container(
                padding: EdgeInsets.only(left: 33.w),
                child: Text(
                  "Discover",
                  style: kHeading3TextStyle.copyWith(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 33.w),
                child: Text(
                  "Lets Try",
                  style: kSubtitle1TextStyle.copyWith(
                    fontSize: 16.sp,
                    height: 1.1,
                    color: AppColors.textColor,
                  ),
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
                      ref.read(discoverNotifyProvider.notifier).userResponse(
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
              CustomizeBottomSheetIcon(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.white,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 600.h,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                /* Container(
                                  height: 20,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Color(0XFF3C3A3A).withOpacity(0.6),

                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(
                                         Drawables.openBottomSheetIcon
                                      ),
                                      fit: BoxFit.fill
                                    ),

                                  ),
                                   ),*/

                                SizedBox(height: 30.h),
                                Text(
                                  'Customize',
                                  style: kHeading2TextStyle,
                                ),
                               const HeadingTextModamSheet(title: "Cuisine"),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20.w),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.textColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: selectedCuisine ??
                                              cuisines[
                                                  0], // Initially selected value
                                          onChanged: (String? newValue) {
                                            // When the user selects a cuisine, update the selected value
                                            setState(() {
                                              selectedCuisine = newValue;
                                            });
                                          },
                                          items: cuisines
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style:
                                                    kHeading3TextStyle.copyWith(
                                                        fontSize: 16.sp,
                                                        height: 1.1,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),

                                const HeadingTextModamSheet(title: "Specify Restaurant"),


                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20.w),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.textColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: selectedRestaurant ??
                                              restaurants[
                                                  0], // Initially selected value
                                          onChanged: (String? newValue) {
                                            // When the user selects a cuisine, update the selected value
                                            setState(() {
                                              selectedRestaurant = newValue;
                                            });
                                          },
                                          items: restaurants
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style:
                                                    kHeading3TextStyle.copyWith(
                                                        fontSize: 16.sp,
                                                        height: 1.1,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                   const  HeadingTextModamSheet(title: "Price Range"),

                                    Container(
                                      margin: EdgeInsets.only(right: 20.w),
                                      child: Text(
                                        upperPriceValue.toString() + " Rs",
                                        style: kHeading3TextStyle.copyWith(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w800,
                                          height: 1.1,
                                        ),
                                      ),
                                    )


                                  ],
                                ),

                                FlutterSlider(
                                  values: [lowerPriceValue, upperPriceValue],
                                  rangeSlider: true,
                                  max: 1000,
                                  min: 0,
                                  trackBar: FlutterSliderTrackBar(
                                    activeTrackBarHeight: 5,
                                    inactiveTrackBar: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.withOpacity(0.4),
                                    ),
                                    activeTrackBar: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.primaryColor,
                                    ),
                                  ),

                                  tooltip: FlutterSliderTooltip(
                                    boxStyle: FlutterSliderTooltipBox(
                                        decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                    textStyle: TextStyle(
                                        fontSize: 17,
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  onDragging:
                                      (handlerIndex, lowerValue, upperValue) {
                                    setState(() {
                                      this.lowerPriceValue = lowerValue;
                                      this.upperPriceValue = upperValue;
                                    });
                                  },
                                ),
                                SizedBox(height: 20.h),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    const HeadingTextModamSheet(title: "Specify Rating"),


                                    Container(
                                      margin: EdgeInsets.only(right: 20.w),
                                      child: Text(
                                        upperRatingValue.toString(),
                                        style: kHeading3TextStyle.copyWith(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w800,
                                          height: 1.1,
                                        ),
                                      ),
                                    )
                                  ],
                                ),

                                FlutterSlider(
                                  values: [lowerRatingValue, upperRatingValue],
                                  rangeSlider: true,
                                  max: 5,
                                  min: 0,
                                  trackBar: FlutterSliderTrackBar(
                                    activeTrackBarHeight: 5,
                                    inactiveTrackBar: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.withOpacity(0.4),
                                    ),
                                    activeTrackBar: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  tooltip: FlutterSliderTooltip(
                                    boxStyle: FlutterSliderTooltipBox(
                                        decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                    textStyle: TextStyle(
                                        fontSize: 17,
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  onDragging:
                                      (handlerIndex, lowerValue, upperValue) {
                                    setState(() {
                                      this.lowerRatingValue = lowerValue;
                                      this.upperRatingValue = upperValue;
                                    });
                                  },
                                ),
                                CustomButton(text: "Customize", onTap: ()=>context.pop()),
                              ],
                            ),
                          ),
                        );
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeadingTextModamSheet extends StatelessWidget {
  const HeadingTextModamSheet({
    super.key, required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: 20.w),
        child: Text(
         title,
          style: kHeading3TextStyle.copyWith(
            fontSize: 18.sp,
            height: 1.1,
          ),
        ),
      ),
    );
  }
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

final List<String> cuisines = [
  "Burger",
  "Chinese",
  "Continental",
  "Thai",
];

final List<String> restaurants = [
  "Kaybees",
  "KBC",
  "Kababjee",
  "Kafee House",
];


List<Widget> buildCards(List<Preference> preferencesList) {
  return preferencesList.map((data) {
    return SwipeCardContainer(
      itemName: data.name,
      itemRating: "4.5",
      itemCategory: "BEEF LOVERS",
      itemImage: "https://img.freepik.com/free-vector/isolated-delicious-hamburger-cartoon_1308-134213.jpg",
      // data.profileImage ? "https://img.freepik.com/free-vector/isolated-delicious-hamburger-cartoon_1308-134213.jpg",
      itemComment: data.description,
      itemPrice: "5.66",
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