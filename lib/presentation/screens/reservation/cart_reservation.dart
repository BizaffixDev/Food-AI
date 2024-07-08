import 'package:flutter/material.dart';
import 'package:flutter_dismissible_tile/flutter_dismissible_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/common/app_specific_widgets/custom_buttons.dart';
import 'package:foodai_mobile/common/app_specific_widgets/custom_search_field.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/drawables.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/data/models/cart_model.dart';
import 'package:foodai_mobile/data/models/history_model.dart';
import 'package:foodai_mobile/generated/assets.dart';
import 'package:foodai_mobile/presentation/screens/cart/components/cart_container.dart';
import 'package:foodai_mobile/presentation/screens/cart/components/history_container.dart';
import 'package:foodai_mobile/presentation/screens/home/components/appbar_action_button.dart';
import 'package:foodai_mobile/presentation/screens/iKnowWhatIWant/components/i_know_appbar.dart';
import 'package:foodai_mobile/presentation/screens/reservation/components/no_of_people_container.dart';
import 'package:go_router/go_router.dart';

class CartReservationScreen extends ConsumerStatefulWidget {
  const CartReservationScreen({super.key});

  @override
  ConsumerState<CartReservationScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartReservationScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  int _selectedTabIndex = 0; // Initialize with the index of the "Cart" tab

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController = TextEditingController();

  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }


  late TextEditingController _searchController;

  bool isSearchValid = true;
  bool isSearchTapped = false;

  int _itemQuantity = 1;

  ///METHODS


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


  // Function to calculate the total price
  String calculateTotalPrice(List<CartModel> cartItems) {
    double total = 0.0;
    for (var item in cartItems) {
      // Assuming 'price' is in the format "Rs XXX" where XXX is a number
      // You may need to parse the price accordingly if it's different
      final price = double.parse(item.price.split(' ')[1]);
      final quantity = item.quantity;
      total += price * quantity;
    }
    return total.toStringAsFixed(2); // Format the total to display two decimal places
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: IKnowWhatIWantAppbar(
        appBar: AppBar(),
        widgets: [
          AppbarActionIconButton(
              onTap: () {}, icon: Drawables.notificationIcon),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: false,
            indicatorColor: AppColors.white,
            unselectedLabelColor: Colors.grey,
            unselectedLabelStyle: kHeading1TextStyle.copyWith(
                fontSize: 25.sp, color: Colors.grey,height: 1.2),
            labelStyle: kHeading1TextStyle.copyWith(
              fontSize: 25.sp,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),

            labelPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
            labelColor: AppColors.black,
            tabs: const [
              // Tab(text: 'Previous Teacher',),
              Text(
                'Cart',
              ),
              Text(
                'History',
              ),
            ],
            onTap: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
            },
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [


                ///CART TAB
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          "How many people",
                          style: kHeading3TextStyle.copyWith(
                            fontSize: 18.sp,
                            color: Color(0xFF4E4E4E),
                          ),
                        ),
                        SizedBox(height: 10.h,),

                        NoOfPeopleContainer(
                          quantity: 1,
                          addTap: (){},
                          decrementTap: (){},
                        ),


                        SizedBox(height: 10.h,),




                        Text(
                          "Swipe an item to delete",
                          style: kHeading3TextStyle.copyWith(
                            fontSize: 18.sp,
                            color: Color(0xFF4E4E4E),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final item = cartItems[index];
                            return Dismissible(
                              key: UniqueKey(),
                              ///Key(item.toString()),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 20.0),
                                color: Colors.red,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              confirmDismiss: (direction) async {
                                if (direction == DismissDirection.endToStart) {
                                  return Future.value(true);

                                }
                                return  Future.value(false);
                              },
                              onDismissed: (direction) {
                                setState(() {
                                  cartItems.removeAt(index);
                                });
                              },
                              child: CartContainer(
                                name: item.name,
                                price: item.price,
                                image: item.image,
                                quantity: item.quantity,
                                addTap: (){
                                  setState(() {
                                    item.quantity++;
                                  });
                                },
                                decrementTap: (){
                                  setState(() {
                                    if (cartItems[index].quantity > 1) {
                                      cartItems[index].quantity--;
                                    } else {
                                      // Remove the item from the list when quantity reaches 0
                                      cartItems.removeAt(index);
                                    }
                                  });
                                },
                              ),
                            );

                          },
                        ),
                      ],
                    ),
                  ),
                ),


                ///HISTORY TAB
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
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
                            hintText: "Search previous order...",
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: historyItems.length,
                          itemBuilder: (context, index) {
                            final item = historyItems[index];
                            return HistoryContainer(
                              name: item.name,
                              price: item.price,
                              image: item.image,
                              quantity: item.quantity,
                              date: item.date,
                              orderId: item.orderId,
                              restaurantNname: item.restaurantName,
                            );

                          },
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),



      bottomNavigationBar: Visibility(
        visible: _selectedTabIndex == 0, // Show the bottom app bar only for "Cart" tab
        child: BottomAppBar(
          child: Container(
            height: 150.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total", style: kHeading1TextStyle.copyWith(height: 1.1)),
                    Text("Rs ${calculateTotalPrice(cartItems)}", style: kHeading2TextStyle.copyWith(height: 1.1)),
                  ],
                ),
                Spacer(),
                CustomButton(text: "Confirm", onTap: () {
                  context.push(PagePath.checkout);
                }),
              ],
            ),
          ),
        ),
      ),


    );
  }
}



