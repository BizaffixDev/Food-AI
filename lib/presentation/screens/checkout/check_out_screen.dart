import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/app/utils/common_functions.dart';
import 'package:foodai_mobile/common/app_specific_widgets/custom_buttons.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/drawables.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/generated/assets.dart';
import 'package:foodai_mobile/presentation/screens/checkout/checkout_states.dart';
import 'package:foodai_mobile/presentation/screens/checkout/components/checkout_container.dart';
import 'package:foodai_mobile/presentation/screens/home/components/appbar_action_button.dart';
import 'package:foodai_mobile/presentation/screens/iKnowWhatIWant/components/i_know_appbar.dart';
import 'package:go_router/go_router.dart';
import '../../../app/utils/ui_snackbars.dart';
import '../../../common/app_specific_widgets/loader.dart';
import '../../../data/models/cart_response_model.dart';
import '../../providers/checkout_providers.dart';
import '../../providers/screen_state.dart';


class CheckOutScreen extends ConsumerStatefulWidget {
  const CheckOutScreen({super.key});

  @override
  ConsumerState<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends ConsumerState<CheckOutScreen> {


  String _selectedPaymentMethod = 'COD'; // Default selection


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(checkoutNotifyProvider.notifier).getCartData();
    });

  }


  // Function to calculate the total price
  String calculateTotalPrice(List<CartDetailData> cartItems) {
    double total = 0.0;
    for (var item in cartItems) {
      // Assuming 'price' is in the format "Rs XXX" where XXX is a number
      // You may need to parse the price accordingly if it's different
      final price =item.restaurantDishesResponse.price;
      final quantity = item.quantity;
      total += price * quantity;
    }
    return total.toStringAsFixed(2); // Format the total to display two decimal places
  }


  @override
  Widget build(BuildContext context) {
    ref.listen<CheckoutStates>(checkoutNotifyProvider, (previous, screenState) async {
      if (screenState is CartErrorState) {
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


      else if (screenState is  CartLoadingState) {
        debugPrint('Loading');
        showLoading(context);
      }

      else if (screenState is   CartSuccessfulState) {
        dismissLoading(context);
        setState(() {

        });
      }
    });

    List<CartDetailData> cartList = ref.watch(cartListProvider);
    return Scaffold(
      appBar: IKnowWhatIWantAppbar(
        appBar: AppBar(),
        widgets: [
          AppbarActionIconButton(
              onTap: () {}, icon: Drawables.notificationIcon),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w,bottom: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Checkout",
                style: kHeading3TextStyle.copyWith(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textColor,
                ),
              ),

              Text(
                "My Order",
                style: kHeading3TextStyle.copyWith(
                  fontSize: 18.sp,
                  color: Color(0xFF4E4E4E),
                  height: 1.1,
                ),
              ),

              Container(
                height: CommonFunctions.deviceHeight(context) * 0.45,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartList.length,
                  itemBuilder: (context, index) {
                    final item = cartList[index];
                    return CheckoutContainer(
                      name: item.restaurantDishesResponse.dishName,
                      price: item.restaurantDishesResponse.price.toString(),
                      image: Assets.burger,
                    );

                  },
                ),
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total", style: kHeading1TextStyle.copyWith(height: 1.1)),
                  Text("Rs ${calculateTotalPrice(cartList)}", style: kHeading2TextStyle.copyWith(height: 1.1)),
                ],
              ),

              RadioListTile(
                title: Text('Cash on Delivery',style: kHeading3TextStyle.copyWith(
                  height: 1.1,
                  fontWeight: FontWeight.w800
                ),),
                value: 'COD',
                fillColor: MaterialStatePropertyAll(AppColors.primaryColor),
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
              ),
              RadioListTile(
                title: Text('Online Payment',style: kHeading3TextStyle.copyWith(
                    height: 1.1,
                    fontWeight: FontWeight.w700
                ),),
                value: 'Online Payment',
                groupValue: _selectedPaymentMethod,
                fillColor: MaterialStatePropertyAll(AppColors.primaryColor),
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
              ),


              Center(child: CustomButton(text: "Proceed", onTap: (){
                showModalBottomSheet<void>(
                  context: context,
                  isDismissible: false,
                  enableDrag: false,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return SizedBox(
                      height:
                      CommonFunctions.deviceHeight(
                          context) *
                          0.5,
                      child: Center(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          mainAxisSize:
                          MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: 20.h,
                            ),
                            Image.asset(
                                Assets.orderPlaced,
                            height: 100.h,),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              "Hurray !!! \nYour Order has been placed",
                              style:
                              kHeading2TextStyle
                                  .copyWith(
                                fontSize: 20.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              margin:
                              EdgeInsets.symmetric(
                                  horizontal: 20.w),
                              child: Text(
                                "Order ID : 23232",
                                style:
                                kHeading3TextStyle
                                    .copyWith(
                                  fontSize: 14.sp,
                                  color: const Color(
                                      0xFF606060),
                                  height: 1.2,
                                ),
                                textAlign:
                                TextAlign.center,
                              ),
                            ),


                            SizedBox(
                              height: 20.h,
                            ),

                            CustomButton(text: "Continue To Shopping", onTap: (){
                              context.go(PagePath.home);
                            }),

                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );



              })),




            ],
          ),
        ),
      ),
    );
  }
}
