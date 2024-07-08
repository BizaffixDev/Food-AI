import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/app/utils/ui_snackbars.dart';
import 'package:foodai_mobile/common/app_specific_widgets/custom_buttons.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/generated/assets.dart';
import 'package:foodai_mobile/presentation/providers/screen_state.dart';
import 'package:foodai_mobile/presentation/screens/iKnowWhatIWant/components/i_know_appbar.dart';
import 'package:foodai_mobile/presentation/screens/reservation/components/restaurant_reservation_heading_text.dart';
import 'package:foodai_mobile/presentation/screens/reservation/components/sub_heading_text.dart';


class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {


  final List<String> people = ['1', '2', '4', '6', '8'];
  String selectedPeople = '';

  final List<String> preference = ['Veg','Non-Veg'];
  String selectedPreference = '';

  final List<String> slots = ['11:30 am','12:00 pm'];
  String selectedSlots = '';


  ///METHODS
  String getImageForSelectedPerson(String person) {
    if (person == '1') {
      return Assets.reservation1;
    } else if (person == '2') {
      return Assets.reservation2;
    } else if (person == '4') {
      return Assets.reservation4;
    } else if (person == '6') {
      return Assets.reservation6;
    }else if (person == '8') {
      return Assets.reservation8;
    } else {

      return Assets.reservation0;
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IKnowWhatIWantAppbar(
        appBar: AppBar(),
        widgets: [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RestaurantReservationHeadingText(),

              SizedBox(height: 20.h,),

              Center(
                child: Container(
                    height: 200.h,
                    width: 300.w,
                    child: Image.asset(getImageForSelectedPerson(selectedPeople)),),
              ),

              SizedBox(height: 30.h,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date",style: kHeading3TextStyle.copyWith(
                        height: 1.1,
                        fontSize: 20.sp,
                      ),),
                      Text("1 DEC 2023",style: kHeading2TextStyle.copyWith(
                        height: 1.1,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryColor,
                      )),


                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Time",style: kHeading3TextStyle.copyWith(
                        height: 1.1,
                        fontSize: 20.sp,
                      ),),
                      Text("11:30 PM",style: kHeading2TextStyle.copyWith(
                        height: 1.1,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryColor,
                      )),


                    ],
                  ),
                ],
              ),

              SizedBox(height: 30.h,),

              SubHeadingText(
                text: "How Many People",
              ),

              SizedBox(height: 15.h,),

              Container(

                child: Wrap(
                  // alignment: WrapAlignment.spaceBetween,
                  spacing: 4,
                  children: List<Widget>.generate(
                    people.length,
                        (int index) {
                      final peoples =
                      people[index];
                      return ChoiceChip(
                        padding:
                        EdgeInsets.symmetric(
                            horizontal: 15.w,vertical: 10.h),
                        backgroundColor:
                        Colors.white,
                        selectedColor: AppColors
                            .primaryColor,
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                              4),
                          side: BorderSide(
                              color: AppColors
                                  .primaryColor),
                        ),
                        label: Text(
                          peoples,
                          style:
                          kHeading2TextStyle
                              .copyWith(
                            color: Colors.black,
                            fontSize: 18.sp,
                          ),
                        ),
                        selected:
                        selectedPeople ==
                            peoples,
                        onSelected:
                            (bool selected) {
                          if (selected) {
                            setState(() {
                              selectedPeople =
                                  peoples;
                            });
                          }
                        },
                      );
                    },
                  ).toList(),
                ),
              ),


              SizedBox(height: 30.h,),

              SubHeadingText(
                text: "Any Food Preference ?",
              ),

              SizedBox(height: 15.h,),

              Container(

                child: Wrap(
                  // alignment: WrapAlignment.spaceBetween,
                  spacing: 4,
                  children: List<Widget>.generate(
                    preference.length,
                        (int index) {
                      final preferences =
                      preference[index];
                      return ChoiceChip(
                        padding:
                        EdgeInsets.symmetric(
                            horizontal: 15.w,vertical: 10.h),
                        backgroundColor:
                        Colors.white,
                        selectedColor: AppColors
                            .primaryColor,
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                              4),
                          side: BorderSide(
                              color: AppColors
                                  .primaryColor),
                        ),
                        label: Text(
                          preferences,
                          style:
                          kHeading2TextStyle
                              .copyWith(
                            color: Colors.black,
                            fontSize: 18.sp,
                          ),
                        ),
                        selected:
                        selectedPreference ==
                            preferences,
                        onSelected:
                            (bool selected) {
                          if (selected) {
                            setState(() {
                              selectedPreference =
                                  preferences;
                            });
                          }
                        },
                      );
                    },
                  ).toList(),
                ),
              ),

              SizedBox(height: 30.h,),

              SubHeadingText(
                text: "Slots available",
              ),

              SizedBox(height: 15.h,),

              Container(

                child: Wrap(
                  // alignment: WrapAlignment.spaceBetween,
                  spacing: 4,
                  children: List<Widget>.generate(
                    slots.length,
                        (int index) {
                      final slot =
                      slots[index];
                      return ChoiceChip(
                        padding:
                        EdgeInsets.symmetric(
                            horizontal: 15.w,vertical: 10.h),
                        backgroundColor:
                        Colors.white,
                        selectedColor: AppColors
                            .primaryColor,
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                              4),
                          side: BorderSide(
                              color: AppColors
                                  .primaryColor),
                        ),
                        label: Text(
                          slot,
                          style:
                          kHeading2TextStyle
                              .copyWith(
                            color: Colors.black,
                            fontSize: 18.sp,
                          ),
                        ),
                        selected:
                        selectedSlots ==
                            slot,
                        onSelected:
                            (bool selected) {
                          if (selected) {
                            setState(() {
                              selectedSlots =
                                  slot;
                            });
                          }
                        },
                      );
                    },
                  ).toList(),
                ),
              ),

              SizedBox(height: 30.h,),

              Center(child: CustomButton(text: "Confirm", onTap: (){
                if(selectedPeople == '' || selectedPreference == '' || selectedSlots == '' ){
                  UIFeedback.showSnackBar(context, "Please select options");
                }else{
                  UIFeedback.showSnackBar(context, "All Set", stateType: StateType.success);
                }
              })),

              SizedBox(height: 20.h,),




            ],
          ),
        ),
      ),
    );
  }
}


