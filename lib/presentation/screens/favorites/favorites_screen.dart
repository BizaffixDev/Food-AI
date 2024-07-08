import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/data/models/restaurant_model.dart';
import 'package:foodai_mobile/presentation/screens/iKnowWhatIWant/components/i_know_appbar.dart';
import 'package:foodai_mobile/presentation/screens/iKnowWhatIWant/components/restaurant_card.dart';
import 'package:go_router/go_router.dart';


class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: IKnowWhatIWantAppbar(
        appBar: AppBar(),
        widgets: [],
      ),

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Favorites Restaurants',
              style: kHeading3TextStyle.copyWith(
                color: Colors.black,
                fontSize: 25.sp,
                fontWeight: FontWeight.w700,
                height: 1.2,
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
                        context.push(PagePath.restaurantHome);
                      },
                      image: restaurant.image,
                      name: restaurant.name,
                      time: restaurant.time,
                    );
                  }
              ),
            ),

          ],
        ),
      ),

    );
  }
}
