import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/app/utils/common_functions.dart';
import 'package:foodai_mobile/app/utils/ui_snackbars.dart';
import 'package:foodai_mobile/common/app_specific_widgets/custom_search_field.dart';
import 'package:foodai_mobile/common/app_specific_widgets/loader.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/drawables.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/data/models/restaurant_model.dart';
import 'package:foodai_mobile/data/models/restaurants_response_model.dart';
import 'package:foodai_mobile/generated/assets.dart';
import 'package:foodai_mobile/presentation/providers/i_know_providers.dart';
import 'package:foodai_mobile/presentation/providers/screen_state.dart';
import 'package:foodai_mobile/presentation/screens/home/components/appbar_action_button.dart';
import 'package:foodai_mobile/presentation/screens/iKnowWhatIWant/components/i_know_appbar.dart';
import 'package:foodai_mobile/presentation/screens/iKnowWhatIWant/components/restaurant_card.dart';
import 'package:foodai_mobile/presentation/screens/iKnowWhatIWant/i_know_states.dart';
import 'package:go_router/go_router.dart';

class IKnowWhatIWantScreen extends ConsumerStatefulWidget {
  const IKnowWhatIWantScreen({super.key});

  @override
  ConsumerState<IKnowWhatIWantScreen> createState() => _IKnowWhatIWantScreenState();
}

class _IKnowWhatIWantScreenState extends ConsumerState<IKnowWhatIWantScreen> {

  late TextEditingController _searchController;

  bool isSearchValid = true;
  bool isSearchTapped = false;


  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(iKnowNotifyProvider.notifier).getRestaurants();
    });
  }


  void handleSearch(String query) async {
    print('Search: $query');


    // setState(() {
    //   isSearchValid = query.isNotEmpty;
    // });
    // FocusScope.of(context).unfocus();
    // if (isSearchValid) {
    //   // Perform search logic here
    //   // searchTeachers(query);
    //   print('Search: $query');
    //   await ref
    //       .read(onDemandStudentNotifierProvider.notifier)
    //       .getTopRatedTeachersBySearch(
    //         gender: "",
    //         occupation: "",
    //         name: query,
    //         city: "",
    //         maxPrice:"",
    //     minPrice: "",
    //     badgeName: "",
    //     startTime: "",
    //       );
    // }
  }

  void handleSearchTap() {
    setState(() {
      isSearchTapped = true;
    });
  }

  void handleSearchFocusChange() {
    setState(() {
      isSearchTapped = false;
    });
  }



  @override
  Widget build(BuildContext context) {


    ref.listen<IKnowStates>(iKnowNotifyProvider, (previous, screenState) async {
      if (screenState is IKnowErrorState) {
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
      else if (screenState is IKnowLoadingState) {
        debugPrint('Loading');
        showLoading(context);
      }

      else if (screenState is  IKnowSuccessfulState) {
        dismissLoading(context);
        setState(() {

        });
      }
    });


    List<RestaurantData> restaurantsList = ref.watch(restaurantsListProvider);


    return  Scaffold(
      appBar: IKnowWhatIWantAppbar(appBar: AppBar(), widgets: [
        AppbarActionIconButton(
          onTap: () {},
          icon: Drawables.notificationIcon,
        ),
        AppbarActionIconButton(
          onTap: () {},
          icon: Drawables.cartIcon,
        ),
      ], ),

      body: Container(
        height: CommonFunctions.deviceHeight(context),
        width: CommonFunctions.deviceWidth(context),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                Assets.backgroundTexture
              ),
              fit: BoxFit.fill,
            ),
        ),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Find Your Favorite\nRestaurant",
                  style: kHeading3TextStyle.copyWith(
                      fontSize: 25.sp,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w800,
                      height: 1.1
                  )
              ),

              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SearchPage(
                  searchController: _searchController,
                  isNotHome: false,
                  // Set to true if it's My Teachers tab
                  onSearch: handleSearch,
                  onSearchTap: handleSearchTap,
                  onSearchFocusChange: handleSearchFocusChange,
                  isSearchValid: isSearchValid,
                  isSearchTapped: isSearchTapped,
                  hintText: "Search Cuisines...",
                ),
              ),


              Container(
                //padding: EdgeInsets.symmetric(horizontal: 33.w),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of items in each row
                       childAspectRatio: 0.8.h,
                        crossAxisSpacing: 8, //horizontal gap
                        mainAxisSpacing: 5// vertical gap
                    ),
                    itemCount: restaurantsList.length,
                    itemBuilder: (context, index){
                      final restaurant =  restaurantsList[index];
                      return RestaurantCard(
                        onTap: (){
                          context.push("${PagePath.restaurantHome}?restaurantId=${restaurant.restaurantId}");
                          print("RESTAURANT ID ===== ${restaurant.restaurantId}");
                        },
                        image: Assets.restaurant3,
                        name: restaurant.name,
                        time: restaurant.description,
                      );
                    }
                ),
              ),

              SizedBox(height: 20.h,),

            ],
          ),
        ),
      ),
    );
  }
}

