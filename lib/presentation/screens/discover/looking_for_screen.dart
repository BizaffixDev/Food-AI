import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/app/utils/common_functions.dart';
import 'package:foodai_mobile/app/utils/ui_snackbars.dart';
import 'package:foodai_mobile/common/app_specific_widgets/back_arrow_container.dart';
import 'package:foodai_mobile/common/app_specific_widgets/custom_search_field.dart';
import 'package:foodai_mobile/common/app_specific_widgets/loader.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/drawables.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/data/models/cusines_response_model.dart';
import 'package:foodai_mobile/data/models/looking_for_model.dart';
import 'package:foodai_mobile/generated/assets.dart';
import 'package:foodai_mobile/presentation/providers/discover_providers.dart';
import 'package:foodai_mobile/presentation/providers/screen_state.dart';
import 'package:foodai_mobile/presentation/screens/discover/components/cuisine_container.dart';
import 'package:foodai_mobile/presentation/screens/discover/components/looking_for_heading_text.dart';
import 'package:foodai_mobile/presentation/screens/discover/components/top_appbar_icon_row.dart';
import 'package:foodai_mobile/presentation/screens/discover/disover_states.dart';
import 'package:foodai_mobile/presentation/screens/home/components/appbar_action_button.dart';
import 'package:go_router/go_router.dart';


class LookingForScreen extends ConsumerStatefulWidget {
  const LookingForScreen({super.key});

  @override
  ConsumerState<LookingForScreen> createState() => _LookingForScreenState();
}

class _LookingForScreenState extends ConsumerState<LookingForScreen> {

  late TextEditingController _searchController;

  bool isSearchValid = true;
  bool isSearchTapped = false;


  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(discoverNotifyProvider.notifier).getCuisines();
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


    ref.listen<DiscoverStates>(discoverNotifyProvider, (previous, screenState) async {
      if (screenState is CuisinesErrorState) {
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
      else if (screenState is CuisinesLoadingState) {
        debugPrint('Loading');
        showLoading(context);
      }

      else if (screenState is  CuisinesSuccessfulState) {
        dismissLoading(context);
        setState(() {

        });
      }
    });


    List<CuisinesData> cuisinesList = ref.watch(cuisinesProvider);


    return SafeArea(
      child: Scaffold(
        body: Container(
          height: CommonFunctions.deviceHeight(context),
          width: CommonFunctions.deviceWidth(context),
          decoration:const  BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                Assets.backgroundTexture,
              ),
              fit: BoxFit.fill
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  const TopAppBarIconsRow(),

                  const LookingForHeadingText(),

                Container(
                  padding: EdgeInsets.only(left: 33.w),
                  child: Text(
                    "Click card to select what interest you",
                    style: kSubtitle1TextStyle.copyWith(
                      fontSize: 16.sp,
                      height: 1.1,
                      color: AppColors.textColor,
                    ),

                  ),
                ),


                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: SearchPage(
                      searchController: _searchController,
                      isNotHome: true,
                      // Set to true if it's My Teachers tab
                      onSearch: handleSearch,
                      onSearchTap: handleSearchTap,
                      onSearchFocusChange: handleSearchFocusChange,
                      isSearchValid: isSearchValid,
                      isSearchTapped: isSearchTapped,
                      hintText: "Search Cuisines...",
                    ),
                  ),
                ),




                SizedBox(height: 20.h,),

                Container(
                  height: CommonFunctions.deviceHeight(context) * 1,
                  padding: EdgeInsets.symmetric(horizontal: 33.w),
                  child: GridView.builder(
                    //shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Number of items in each row
                      childAspectRatio: 0.7.h,
                      crossAxisSpacing: 10, //horizontal gap
                      mainAxisSpacing: 10// vertical gap
                    ),
                    itemCount: cuisinesList.length,
                      itemBuilder: (context, index){
                        final cuisine =  cuisinesList[index];
                        return CuisineContainer(
                          image: "https://burgerlab.com.pk/wp-content/uploads/2022/01/doppler.png",
                          //cuisine.image,
                          title: cuisine.name,
                          onTap: (){
                            context.push('${PagePath.discover}?cuisineId=${cuisine.cuisineId}');
                            print("CUISINE ID ===== ${cuisine.cuisineId}");
                          },

                        );
                      }
                  ),
                ),


                SizedBox(height: 20.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

