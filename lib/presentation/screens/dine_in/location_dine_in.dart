import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodai_mobile/app/utils/ui_snackbars.dart';
import 'package:foodai_mobile/common/app_specific_widgets/custom_buttons.dart';
import 'package:foodai_mobile/common/app_specific_widgets/loader.dart';
import 'package:foodai_mobile/common/resources/colors.dart';
import 'package:foodai_mobile/common/resources/page_path.dart';
import 'package:foodai_mobile/common/resources/text_styles.dart';
import 'package:foodai_mobile/presentation/providers/dine_in_providers.dart';
import 'package:foodai_mobile/presentation/providers/screen_state.dart';
import 'package:foodai_mobile/presentation/screens/dine_in/dine_in_states.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationDineInScreen extends ConsumerStatefulWidget {
  const LocationDineInScreen({super.key});

  @override
  ConsumerState<LocationDineInScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends ConsumerState<LocationDineInScreen> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.970029, 67.172481),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(24.970029, 67.172481),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);


  List<Marker> _marker = [];


  final List<Marker> _list = const [
    Marker(markerId: MarkerId('1'),
        position: LatLng(24.970029, 67.172481),
        infoWindow: InfoWindow(title: "My Position")
    ),


  ];

  String address = '';


  loadInitialData(){

    ref.read(dineInNotifyProvider.notifier).getCurrentLocation().then((value) async{
      print("LATITUDE ${value.latitude} LONGITUDE ${value.longitude}");


      _marker.add(
        Marker(markerId: MarkerId("!"),
            position: LatLng(value.latitude,value.longitude),
            infoWindow:const  InfoWindow(
              title: "My current location",
            )),
      );

      CameraPosition cameraPosition = CameraPosition(target:  LatLng(value.latitude,value.longitude),zoom: 14,);

      final GoogleMapController controller =await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      // List<Placemark> placemarks = await placemarkFromCoordinates(value.latitude, value.longitude);

      //address = placemarks.reversed.last.name.toString();

      setState(() {});

    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadInitialData();

  }

  @override
  Widget build(BuildContext context) {

    ref.listen<DineInStates>(dineInNotifyProvider, (previous, screenState) async {
      if (screenState is LocationAddErrorState) {
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
      else if (screenState is LocationAddLoadingState) {
        debugPrint('Loading');
        showLoading(context);
      }

      else if (screenState is  LocationAddSuccessfulState) {
        dismissLoading(context);
        setState(() {

        });
      }
    });


    return SafeArea(
      child: Scaffold(

        body: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              //  myLocationButtonEnabled: true,

              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: Set<Marker>.of(_marker),
              zoomControlsEnabled: false,
            ),

            Container(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              margin:  EdgeInsets.only(top: 20.w),
              child: TextField(
                onChanged: (value) {
                  // Handle address search
                  // You can use Geocoding APIs or other services to get the address from the user's search
                },
                decoration: InputDecoration(
                    hintText: 'Search Location',
                    suffixIcon: Icon(Icons.search),
                    fillColor: Colors.white.withOpacity(0.6),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.r),

                    )
                ),
              ),
            ),

            if (address != '')
              Positioned(
                bottom: 80.h,
                left: 50.h,
                right: 50.h,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 26.h,horizontal: 26.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text("Your Location",style: kHeading3TextStyle.copyWith(
                        fontSize: 18.sp,
                      ),),


                      Container(
                        width: 300.h,
                        child: Row(
                          children: [
                            Icon(Icons.pin_drop_rounded,color: Colors.red,),

                            Expanded(
                              child: Text(address,
                                style: kSubtitle1TextStyle,
                                overflow: TextOverflow.ellipsis,),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h,),


                      CustomButton(text: "Set Location", onTap: (){
                        context.push(PagePath.restaurantsListDineIn);
                      }),
                    ],
                  ),
                ),
              ),


          ],
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () async{

            ref.read(dineInNotifyProvider.notifier).getCurrentLocation().then((value) async{
              print("LATITUDE ${value.latitude} LONGITUDE ${value.longitude}");

              ref.read(dineInNotifyProvider.notifier).addUserLocation(latitude: value.latitude, longitude: value.longitude, maxDistance: 1000);


              _marker.add(
                Marker(markerId: MarkerId("!"),
                    position: LatLng(value.latitude,value.longitude),
                    infoWindow:const  InfoWindow(
                      title: "My current location",
                    )),
              );

              CameraPosition cameraPosition = CameraPosition(target:  LatLng(value.latitude,value.longitude),zoom: 14,);

              final GoogleMapController controller =await _controller.future;

              controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

              List<Placemark> placemarks = await placemarkFromCoordinates(value.latitude, value.longitude);

              address = "${placemarks.reversed.first.street.toString()} ${placemarks.reversed.first.name.toString()} ${placemarks.reversed.first.locality.toString()}";
              print( "ADDRESS=== " + address);
              ref.read(userAddressProvider.notifier).state = address;
              ref.read(latitudeProvider.notifier).state = value.latitude;
              ref.read(longtudeProvider.notifier).state = value.longitude;
              setState(() {});

            });






          },
          child: Icon(Icons.my_location, ),

        ),
      ),

    );
  }
}
