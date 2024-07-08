import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/app/utils/common_functions.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/data/models/dine_in_restaurants_model.dart';
import 'package:foodai_mobile/presentation/screens/dine_in/components/resturant_dine_in_list_container.dart';
import 'package:foodai_mobile/presentation/screens/iKnowWhatIWant/components/i_know_appbar.dart';
import 'package:go_router/go_router.dart';

class ReservationRestaurantsListScreen extends StatefulWidget {
  const ReservationRestaurantsListScreen({super.key});

  @override
  State<ReservationRestaurantsListScreen> createState() =>
      _ReservationRestaurantsListScreenState();
}

class _ReservationRestaurantsListScreenState
    extends State<ReservationRestaurantsListScreen> {
  @override
  Widget build(BuildContext context) {
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
                "Find Your Favorite Restaurant",
                style: kHeading3TextStyle.copyWith(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                ),
              ),

              SizedBox(height: 10.w,),


              ListView.builder(
                  shrinkWrap: true,
                  itemCount: restaurantsDineInList.length,
                  itemBuilder: (context, index) {
                    final restaurant = restaurantsDineInList[index];
                    return RestaurantDineInLocationListContainer(
                      image: restaurant.image,
                      name: restaurant.name,
                      address: restaurant.address,
                      onTap: (){
                        context.push(PagePath.reservationScreen);
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


