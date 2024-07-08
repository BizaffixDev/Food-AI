import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/drawables.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/data/models/category_model.dart';
import 'package:foodai_mobile/data/models/food_model.dart';
import 'package:foodai_mobile/generated/assets.dart';
import 'package:foodai_mobile/presentation/screens/home/components/appbar_action_button.dart';
import 'package:foodai_mobile/presentation/screens/restaurant/components/categories_shimmer_effect.dart';
import 'package:foodai_mobile/presentation/screens/restaurant/components/popular_card.dart';
import 'package:foodai_mobile/presentation/screens/restaurant/components/restaurant_appBar.dart';
import 'package:foodai_mobile/presentation/screens/restaurant/components/restautant_logo_menu_text.dart';
import 'package:foodai_mobile/presentation/screens/restaurant/components/sub_heading_text.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/utils/ui_snackbars.dart';
import '../../../common/app_specific_widgets/loader.dart';
import '../../../data/models/restaurant_detail_response_model.dart';
import '../../providers/cart_providers.dart';
import '../../providers/i_know_providers.dart';
import '../../providers/screen_state.dart';
import '../iKnowWhatIWant/i_know_states.dart';

class RestaurantHomeScreen extends ConsumerStatefulWidget {
  const RestaurantHomeScreen({super.key,required this.restaurantId});

  final String restaurantId;

  @override
  ConsumerState<RestaurantHomeScreen> createState() =>
      _RestaurantHomeScreenState();
}

class _RestaurantHomeScreenState extends ConsumerState<RestaurantHomeScreen> {
  CategoryModel? selectedCategory;


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(iKnowNotifyProvider.notifier).getRestaurantDetails(restaurantId: int.parse(widget.restaurantId));
    });
  }


  @override
  Widget build(BuildContext context) {

    ref.listen<IKnowStates>(iKnowNotifyProvider, (previous, screenState) async {
      if (screenState is RestaurantDetailErrorState) {
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
      }  else if (screenState is AddCartErrorState) {
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
      else if (screenState is  RestaurantDetailLoadingState) {
        debugPrint('Loading');
        showLoading(context);
      }
      else if (screenState is  AddCartLoadingState) {
        debugPrint('Loading');
        showLoading(context);
      }

      else if (screenState is   RestaurantDetailSuccessfulState) {
        dismissLoading(context);
        setState(() {

        });
      } else if (screenState is   AddCartSuccessfulState) {
        dismissLoading(context);
        UIFeedback.showSnackBar(context, "Item added successfully",
            stateType: StateType.success,
            height: 140);
        setState(() {

        });
      }
    });

    List<RestarantsDish> restaurantsDishes = ref.watch(restaurantDishesProvider);
    List<dynamic> restaurantsDeals = ref.watch(restaurantDealsProvider);
    List<RestaurantTiming> restaurantsTimings = ref.watch(restaurantTimingsProvider);

    return Scaffold(
      appBar: RestaurantAppbar(
        appBar: AppBar(),
        backTap: ()=>context.go(PagePath.home),
        widgets: [
          AppbarActionIconButton(
            onTap: () {},
            icon: Drawables.favIcon,
          ),
          AppbarActionIconButton(
            onTap: () {},
            icon: Drawables.searchIcon,
          ),
          AppbarActionIconButton(
            onTap: () {},
            icon: Drawables.notificationIcon,
          ),
          AppbarActionIconButton(
            onTap: () {
              context.push(PagePath.cart);
            },
            icon: Drawables.cartIcon,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w,right: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RestaurantLogoMenuText(),

              //CategoriesShimmer(selectedCategory: selectedCategory)

              Container(
                height: 150.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selectedCategory == category;
                    return GestureDetector(
                      onTap: () {

                        // Set the selected category
                        setState(() {
                          for (int i = 0; i < categories.length; i++) {
                            categories[i].isSelected = (i == index);
                          }
                        });

                        // // Update the selected category
                        // setState(() {
                        //   if (isSelected) {
                        //     selectedCategory = null; // Deselect the category
                        //   } else {
                        //     selectedCategory = category; // Select the category
                        //   }
                        // });
                        //
                        // // You can perform actions here based on the selection status
                        // if (isSelected) {
                        //   // Category is deselected, perform action here
                        //   print('${category.name} is deselected!');
                        // } else {
                        //   // Category is selected, perform action here
                        //   print('${category.name} is selected!');
                        // }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 80.h,
                            width: 80.w,
                            margin: EdgeInsets.symmetric(horizontal: 2.w),
                            decoration: BoxDecoration(
                                color: category.isSelected
                                    ? AppColors.primaryColor
                                    : Color(0xFFf9f9f9),
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Colors.grey.shade300)),
                            child: Center(
                              child: SvgPicture.asset(
                                category.image,
                                height: 50.h,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            category.name,
                            style: kHeading3TextStyle.copyWith(
                              fontSize: 16.sp,
                              height: 1.1,
                              fontWeight:
                              category.isSelected ? FontWeight.w700 : FontWeight.w300,
                              color:
                              category.isSelected ? Colors.black : AppColors.textColor,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),

              SubHeading(
                text: "Popular",
              ),

              SizedBox(
                height: 10.h,
              ),


            Container(
              height: 300.h,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: restaurantsDishes.length,
                itemBuilder: (context, index) {
                  final foodItem = restaurantsDishes[index];
                  return PopularCard(
                    name: foodItem.dishName,
                    image: Assets.burger,
                    price: foodItem.price.toString(),
                    rating: "4.5",
                    tagline: foodItem.description,
                    addCart: (){
                      ref.read(iKnowNotifyProvider.notifier).addToCart(dishId: foodItem.restaurantDishId, quantity: 1);
                    },
                  );
                },
              ),
            ),

              SizedBox(
                height: 10.h,
              ),

              SubHeading(
                text: "Exclusive Deals",
              ),

              SizedBox(
                height: 10.h,
              ),

              Container(
                height: 300.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: restaurantsDishes.length,
                  itemBuilder: (context, index) {
                    final foodItem = restaurantsDishes[index];
                    return PopularCard(
                      name: foodItem.dishName,
                      image: Assets.burger,
                      price: foodItem.price.toString(),
                      rating: "4.5",
                      tagline: foodItem.description,
                      addCart: (){

                      },
                    );
                  },
                ),
              ),




        ],
          ),
        ),
      ),
    );
  }
}


//keytool -genkey -v -keystore %userprofile%\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload