import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/presentation/screens/home/home_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNavbarScreen extends StatefulWidget {
  const BottomNavbarScreen({
    super.key,
  });



  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
  PersistentTabController _controller = PersistentTabController();
  bool _hideNavBar = false;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 1);
    _hideNavBar = false;
  }


  List<Widget> _buildScreens() {
    return [
      const Center(child: Text("Messages"),),
      const HomeScreen(),
      const Center(child: Text("Delivery"),),
      const Center(child: Text("Profile"),),



    ];
  }


  List<PersistentBottomNavBarItem> _navBarsItems(){
    return [

      PersistentBottomNavBarItem(
        icon: Icon(Icons.message,color: AppColors.primaryColor,),
        title: ("Messages"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
        activeColorSecondary: Colors.black,
        textStyle: kHeading2TextStyle.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black
        ),
      ),

      PersistentBottomNavBarItem(
        icon:  Icon(Icons.home,color: AppColors.primaryColor,),
        title: ("Home"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
        activeColorSecondary: Colors.black,
        textStyle: kHeading2TextStyle.copyWith(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black
        ),

      ),



      PersistentBottomNavBarItem(
        icon:  Icon(Icons.directions_bike_sharp, color: AppColors.primaryColor,),
        title: ("Delivery"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
        activeColorSecondary:Colors.black,
        textStyle: kHeading2TextStyle.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black
        ),
      ),

      PersistentBottomNavBarItem(
        icon:  Icon(Icons.person,color: AppColors.primaryColor,),
        title: ("Profile"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
        activeColorSecondary: Colors.black,
        textStyle: kHeading2TextStyle.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black
        ),
      ),

    ];


  }


  @override
  Widget build(BuildContext context) {
     return PersistentTabView(
      context,
     // margin: EdgeInsets.symmetric(horizontal: 20.w),,
       padding: NavBarPadding.symmetric(horizontal: 20.w),

      screens:_buildScreens(),
      items: _navBarsItems(),
      controller: _controller,
      confineInSafeArea: true,
      backgroundColor: Color(0xFFFFFFFF),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(50.0),
        colorBehindNavBar: Colors.white,
        border: Border.all(color: Colors.black12,width: 1)
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),

      navBarStyle:
      NavBarStyle.style1,
    );
  }
}
