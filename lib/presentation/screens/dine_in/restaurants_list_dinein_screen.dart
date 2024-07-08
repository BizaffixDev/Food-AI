import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/app/utils/common_functions.dart';
import 'package:foodai_mobile/app/utils/ui_snackbars.dart';
import 'package:foodai_mobile/common/app_specific_widgets/loader.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/data/models/dine_in_restaurants_model.dart';
import 'package:foodai_mobile/data/models/nearest_restaurant_response_model.dart';
import 'package:foodai_mobile/presentation/providers/dine_in_providers.dart';
import 'package:foodai_mobile/presentation/providers/screen_state.dart';
import 'package:foodai_mobile/presentation/screens/dine_in/components/resturant_dine_in_list_container.dart';
import 'package:foodai_mobile/presentation/screens/dine_in/dine_in_states.dart';
import 'package:foodai_mobile/presentation/screens/iKnowWhatIWant/components/i_know_appbar.dart';
import 'package:go_router/go_router.dart';

class DineInRestaurantsListScreen extends ConsumerStatefulWidget {
  const DineInRestaurantsListScreen({super.key});

  @override
  ConsumerState<DineInRestaurantsListScreen> createState() =>
      _DineInRestaurantsListScreenState();
}

class _DineInRestaurantsListScreenState
    extends ConsumerState<DineInRestaurantsListScreen> {
  bool _apiCalled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("called once $_apiCalled");
    if (!_apiCalled) {
      _apiCalled = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await ref.read(dineInNotifyProvider.notifier).getNearestRestaurant(
              latitude: ref.read(latitudeProvider),
              longitude: ref.read(longtudeProvider),
              maxDistance: 50000,
            );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<DineInStates>(dineInNotifyProvider,
        (previous, screenState) async {
      if (screenState is NearestRestaurantErrorState) {
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
      } else if (screenState is NearestRestaurantLoadingState) {
        debugPrint('Loading');
        showLoading(context);
      } else if (screenState is NearestRestaurantSuccessfulState) {
        dismissLoading(context);
        setState(() {});
      }
    });


    List<NearestRestaurantsData> restaurantsList = ref.watch(nearestRestaurantProvider);

    return Scaffold(
      appBar: IKnowWhatIWantAppbar(
        appBar: AppBar(),
        widgets: [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Are you dining here?",
                style: kHeading3TextStyle.copyWith(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                ),
              ),
              SizedBox(
                height: 10.w,
              ),

              restaurantsList.isEmpty ? const Center(
                child: Text("No Restaurants in your area"),
              ) :

              ListView.builder(
                  shrinkWrap: true,
                  itemCount: restaurantsList.length,
                  itemBuilder: (context, index) {
                    final restaurant = restaurantsList[index];
                    return RestaurantDineInLocationListContainer(
                      image: restaurant.restaurantImage,
                      name: restaurant.name,
                      address: restaurant.address,
                      onTap: () {
                        context.push(PagePath.restaurantHome);
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
