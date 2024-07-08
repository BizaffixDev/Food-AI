import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/app_specific_widgets/drawer.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/drawables.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/generated/assets.dart';
import 'package:foodai_mobile/presentation/providers/home_provider.dart';
import 'package:foodai_mobile/presentation/screens/home/components/appbar_action_button.dart';
import 'package:foodai_mobile/presentation/screens/home/components/dine_in_heading_text.dart';
import 'package:foodai_mobile/presentation/screens/home/components/home_appbar.dart';
import 'package:foodai_mobile/presentation/screens/home/components/home_delivery_heading_text.dart';
import 'package:foodai_mobile/presentation/screens/home/components/home_options_container.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();


  bool _apiCalled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("called once $_apiCalled");
    if (!_apiCalled) {
      _apiCalled = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await ref.read(homeNotifyProvider.notifier).getUserData();
      });
    }
  }


    final List<Widget> _homeDeliveryOptions = [
    HomeOptionsContainer(
      onTap: (){
      },
      title: "Discovery",
      color1:const  Color(0xffffd702),
      color2:const  Color(0xfffead1d),
      image: "assets/images/discovery.png",
    ),
    HomeOptionsContainer(
      onTap: (){},
      title: "I Know What\nI Want",
      color1:const  Color(0xff53E88B),
      color2:const  Color(0xff15BE77),
      image: Assets.IKnowWhatIWant,
    ),
  ];


  final List<Widget> _dineinOptions = [
    HomeOptionsContainer(
      onTap: (){
       // context.push(PagePath.dashboard);
      },
      title: "Dine In Now",
      color1:const  Color(0xffFF5733),
      color2:const  Color(0xffFA5F55),
      image: Assets.dineIn,
    ),
    HomeOptionsContainer(
      onTap: (){},
      title: "Reservation",
      color1:const  Color(0xff4e4154),
      color2:const  Color(0xff7e625d),
      image: Assets.reservation,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.scaffoldBgWhiteColor,
      appBar: HomeAppbar(
        appBar: AppBar(),
        widgets: [
          AppbarActionIconButton(
            onTap: () {

            },
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

        drawerOpenTap: (){
          // Open the drawer here
          _scaffoldKey.currentState!.openDrawer();
        },
      ),
      drawer:  DrawerScreen(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 31.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeDeilveryHeadingText(),


              HomeOptionsContainer(
                onTap: (){
                    context.push(PagePath.lookingFor);
                  },
                title: "Discovery",
                color1:const  Color(0xffffd702),
                color2:const  Color(0xfffead1d),
                image: "assets/images/discovery.png",
              ),
              HomeOptionsContainer(
                onTap: (){
                  context.push(PagePath.iKnowWhatIWant);
                },
                title: "I Know What\nI Want",
                color1:const  Color(0xff53E88B),
                color2:const  Color(0xff15BE77),
                image: Assets.IKnowWhatIWant,
              ),


            /*  ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _homeDeliveryOptions.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _homeDeliveryOptions[index];
                },
              ),*/

              const DineInHeadingText(),


              HomeOptionsContainer(
                onTap: (){
                  context.push(PagePath.locationDineIn);
                },
                title: "Dine In Now",
                color1:const  Color(0xffFF5733),
                color2:const  Color(0xffFA5F55),
                image: "assets/images/dine_in2.png",
              ),
              HomeOptionsContainer(
                onTap: (){
                  context.push(PagePath.restaurantsListReservation);
                },
                title: "Reservation",
                color1:const  Color(0xff4e4154),
                color2:const  Color(0xff7e625d),
                image: Assets.reservation,
              ),

             /* ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _dineinOptions.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _dineinOptions[index];
                },
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

