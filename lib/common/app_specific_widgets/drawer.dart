import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/presentation/providers/home_provider.dart';
import 'package:go_router/go_router.dart';
import '../resources/colors.dart';

class DrawerScreen extends ConsumerStatefulWidget {
  const DrawerScreen({super.key});

  @override
  ConsumerState<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends ConsumerState<DrawerScreen> {
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

  @override
  Widget build(BuildContext context) {
    // int userId = ref.watch(studentIdProvider.notifier).state;
    ref.watch(userObjectProvider.notifier).state.username;
    // String email = ref.watch(emailProvider.notifier).state;
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
           DrawerHeader(
            decoration: const BoxDecoration(
              gradient:  LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xffffd702), Color(0xfffead1d)],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 94.h,
                  width: 94.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white

                  ),
                  child: Center(
                    child: Text(ref.watch(userObjectProvider.notifier).state.username[0],style: kHeading1TextStyle.copyWith(
                      height: 1.1,
                    ),),
                  ),
                ),
                Text(ref.watch(userObjectProvider.notifier).state.username == null ? "" :
                ref.watch(userObjectProvider.notifier).state.username ,style: kHeading2TextStyle.copyWith(

                ),),
              ],
            ),
          ),


          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: ListTile(
              leading:
                   Icon(Icons.person_outline_rounded,
                    color: AppColors.primaryColor,),
              title:  Text(
                'My Profile',
                style: kHeading3TextStyle.copyWith(
                  color: Colors.black,
                  fontSize: 16.sp,
                  height: 1.2,
                ),
              ),
              onTap: () {
                // Handle drawer item tap
                context.push(PagePath.profile);
              },
            ),
          ),


          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: ListTile(
              leading:  Icon(Icons.notifications_none_outlined,
                color: AppColors.primaryColor,
                  ),
              title:  Text(
                'Notifications',
                style: kHeading3TextStyle.copyWith(
                  color: Colors.black,
                  fontSize: 16.sp,
                  height: 1.2,
                ),
              ),
              onTap: () {
               // context.push(PagePath.notificationStudent);
              },
            ),
          ),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: ListTile(
              leading:  Icon(Icons.favorite,
                color: AppColors.primaryColor,
              ),
              title:  Text(
                'Favorites',
                style: kHeading3TextStyle.copyWith(
                  color: Colors.black,
                  fontSize: 16.sp,
                  height: 1.2,
                ),
              ),
              onTap: () {
                context.push(PagePath.favorites);
              },
            ),
          ),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: ListTile(
              leading:  Icon(Icons.airplane_ticket_outlined,
                color: AppColors.primaryColor,
              ),
              title:  Text(
                'Vouchers & Offers',
                style: kHeading3TextStyle.copyWith(
                  color: Colors.black,
                  fontSize: 16.sp,
                  height: 1.2,
                ),
              ),
              onTap: () {
                // context.push(PagePath.notificationStudent);
              },
            ),
          ),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: ListTile(
              leading:  Icon(Icons.help,
                color: AppColors.primaryColor,
              ),
              title:  Text(
                'Help Center',
                style: kHeading3TextStyle.copyWith(
                  color: Colors.black,
                  fontSize: 16.sp,
                  height: 1.2,
                ),
              ),
              onTap: () {
                // context.push(PagePath.notificationStudent);
              },
            ),
          ),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: ListTile(
              leading:  Icon(Icons.settings,
                color: AppColors.primaryColor,
              ),
              title:  Text(
                'Settings',
                style: kHeading3TextStyle.copyWith(
                  color: Colors.black,
                  fontSize: 16.sp,
                  height: 1.2,
                ),
              ),
              onTap: () {
                // context.push(PagePath.notificationStudent);
              },
            ),
          ),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: ListTile(
              leading:  Icon(Icons.power_settings_new,
                color: AppColors.primaryColor,
              ),
              title:  Text(
                'Log out',
                style: kHeading3TextStyle.copyWith(
                  color: Colors.black,
                  fontSize: 16.sp,
                  height: 1.2,
                ),
              ),
              onTap: () {
                 context.go(PagePath.login);
              },
            ),
          ),

        ],
      ),
    );
  }
}
