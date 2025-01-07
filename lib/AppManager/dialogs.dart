import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:lottie/lottie.dart';
import 'package:namaz_reminders/LocationSelectionPage/locationPageView.dart';
import 'package:namaz_reminders/Widget/myButton.dart';
import '../DashBoard/dashboardController.dart';
import '../DataModels/LoginResponse.dart';
import '../Widget/appColor.dart';
import '../Widget/text_theme.dart';
import '../main.dart';

String constantGoogleKey = "AIzaSyAPscPVLVlvdE4nB-Z-wgOUQfwkPZckgBU";
// Rx<TextEditingController> locationController = TextEditingController().obs;

class Dialogs {
  static void actionBottomSheet({String? title,required String subTitle,required Function okPressEvent,
    Function? cancelPressEvent,Color? okButtonColor,Color? cancelButtonColor,
    String? cancelButtonName, String? okButtonName}) {
    Get.bottomSheet(
        isDismissible: true,
        elevation: 20.0,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              //Divider(thickness: 4,indent: 150,endIndent: 150,height:25 ),
              if(title!=null)
                Text(title,style:const TextStyle(
                  fontSize: 18,fontWeight: FontWeight.bold,
                ),),
              const SizedBox(height: 18,),
              Text(textAlign: TextAlign.center,style: const TextStyle(
                  letterSpacing: 1,fontSize: 16,color:Colors.black
              ),
                  subTitle),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(onPressed: (){
                      Get.back();
                      if(cancelPressEvent!=null){
                        cancelPressEvent();
                      }
                    },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(160,42),
                        elevation: 0,textStyle:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,letterSpacing: 1),
                        backgroundColor:cancelButtonColor?? AppColor.circleIndicator,
                        // Colors.grey.shade100,
                        //padding:EdgeInsets.symmetric(horizontal: 50,vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),

                      ), child: Text(cancelButtonName??"Cancel",style: TextStyle(
                        color:cancelButtonColor??Colors.white,
                      ),),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: ElevatedButton(onPressed: (){
                      okPressEvent();
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:AppColor.circleIndicator,
                        fixedSize: const Size(160,42),
                        elevation: 0,textStyle:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,letterSpacing: 1,),
                        //padding:EdgeInsets.symmetric(horizontal: 50,vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),

                      ), child: Text(okButtonName??"Ok",style: TextStyle(color: okButtonColor!=null?Colors.white:null),),
                    ),
                  ),
                ],
              )

            ],
          ),
        )
    );
  }

  static void showCustomDialog({required BuildContext context, required Widget content}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true, // Allows closing by tapping outside
      barrierLabel: "CustomDialog", // Optional label
      barrierColor: Colors.black54, // Background overlay color
      transitionDuration: const Duration(milliseconds: 300), // Duration of the animation
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Center( // Ensures the dialog is centered
          child: Material(
            color: Colors.transparent, // Makes the dialog background transparent
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  // width: MediaQuery.sizeOf(context).width,
                  margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add margin for responsiveness
                  decoration: BoxDecoration(
                    color: AppColor.gray, // Replace with your background color
                    image: const DecorationImage(
                      image: AssetImage("assets/blacknet.png"),
                      fit: BoxFit.cover,
                      opacity: 0.9, // Adjust opacity
                    ),
                    borderRadius: BorderRadius.circular(16.0), // Rounded corners
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4), // Subtle shadow
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: content,
                    ),
                  ),
                ),
                // Cross Button
                Positioned(
                  top: -50, // Position slightly above the dialog
                  right: 15,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(), // Close dialog on tap
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        // Combines fade and scale animations
        final fadeIn = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
        return FadeTransition(
          opacity: fadeIn,
          child: ScaleTransition(
            scale: fadeIn,
            child: child,
          ),
        );
      },
    );
  }

  static void showCustomBottomSheet({
    required BuildContext context,
    required Widget content,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: AppColor.gray,
                  image: const DecorationImage(
                    image: AssetImage("assets/net.png"),
                    fit: BoxFit.cover,
                    opacity: 0.9, // Adjust opacity
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ), // Rounded corners for top
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, -4), // Subtle shadow at the top
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: content,
                ),
              ),
              // Close Button
              Positioned(
                top: -50,
                right: 15,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }





  static Future<void> showConfirmationDialog( {
    required BuildContext context,
    required Future<bool> Function() onConfirmed,
    VoidCallback? onCancelled,
    String initialMessage = "ARE YOU SURE?",
    String confirmButtonText = "Yes, Remove",
    String cancelButtonText = "No, Go Back",
    String? successMessage,
    String? failureMessage,
    String? loadingMessage,
    bool showCancelButton = true,
    Color? confirmButtonColor,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true, // Prevent dismiss on touch outside while processing
      builder: (BuildContext context) {
        return ConfirmationDialog(
          onConfirmed: onConfirmed,
          onCancelled: onCancelled,
          initialMessage: initialMessage,
          confirmButtonText: confirmButtonText,
          cancelButtonText: cancelButtonText,
          successMessage: successMessage,
          failureMessage: failureMessage,
          showCancelButton: showCancelButton,
          confirmButtonColor: confirmButtonColor,
          loadingMessage: loadingMessage,
        );
      },
    );
  }
  static bool _isDialogVisible = false; // Track dialog visibility

  static void showLoading(BuildContext context, {String message = "Loading..."}) {
    if (_isDialogVisible) return; // Prevent multiple dialogs from being shown

    _isDialogVisible = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: [
            // Blurred background
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.3), // Semi-transparent overlay
              ),
            ),
            Center(
              child: Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15, width: 15, child: CircularProgressIndicator(strokeWidth: 2.0)),
                      const SizedBox(width: 20),
                      Flexible(child: Text(message, style: const TextStyle(fontSize: 12))),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static void hideLoading() {
    if (_isDialogVisible) {
      _isDialogVisible = false;
      try {
        // Use `Navigator.of` safely and dismiss the dialog
        Navigator.of(navigatorKey.currentContext!, rootNavigator: true).pop();
      } catch (e) {
        print("Error while hiding dialog: $e");
      }
    }
  }
}

class ConfirmationDialog extends StatefulWidget {
  final Future<bool> Function() onConfirmed;
  final VoidCallback? onCancelled;
  final String initialMessage;
  final String confirmButtonText;
  final String cancelButtonText;
  final String? successMessage;
  final String? failureMessage;
  final String? loadingMessage;
  final bool showCancelButton;
  final Color? confirmButtonColor;

  ConfirmationDialog({
    required this.onConfirmed,
    this.onCancelled,
    this.initialMessage = "ARE YOU SURE?",
    this.confirmButtonText = "Yes, Remove",
    this.cancelButtonText = "No, Go Back",
    this.successMessage,
    this.failureMessage,
    this.loadingMessage,
    this.showCancelButton = true,
    this.confirmButtonColor,
  });

  @override
  State<ConfirmationDialog> createState() => ConfirmationDialogState();
}

  @override
  ConfirmationDialogState createState() => ConfirmationDialogState();


class ConfirmationDialogState extends State<ConfirmationDialog> {
  final DashBoardController dashBoardController = Get.put(DashBoardController());

  String message = "";
  bool isProcessing = false;
  RxString location = ''.obs;
  bool isManualSelection = false;
  RxString isEnable = "".obs;
  RxString longitude = "".obs;
  late LocationDataModel locationData;


  @override
  void initState() {
    super.initState();
    message = widget.initialMessage;
    locationPlace();
  }
  void startProcessing() async {
    setState(() {
      isProcessing = true;
      message = widget.loadingMessage ?? "Processing...";
    });
    bool success = await widget.onConfirmed();
    setState(() {
      message = success
          ? widget.successMessage ?? "Action completed successfully!"
          : widget.failureMessage ?? "Action failed.";
      isProcessing = false;
    });
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void updateLocation(String newLocation) {
    location.value = newLocation;
    dashBoardController.locationController.value.text = newLocation;
    dashBoardController.update();
  }
  //
  void saveLocation() {
    String newLocation = dashBoardController.locationController.value.text.trim();
    if (newLocation.isNotEmpty) {
      updateLocation(newLocation);
      print("Location updated to: $newLocation");
    } else {
      print("Please enter a valid location.");
    }
  }


locationPlace(){
    print("Address "+dashBoardController.locationController.value.text.toString());
}

  @override
  Widget build(BuildContext context) {
    RxDouble containerHeight = 380.0.obs;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Obx(() {
          return Column(
            children: [
              Flexible(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeInOut,
                    height: containerHeight.value,
                    width: MediaQuery.of(context).size.width,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            opacity: 9,
                            image: AssetImage("assets/net.png"),
                            fit: BoxFit.cover,
                          ),
                          color: AppColor.gray,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                        ),
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 10),
                              Lottie.asset(
                                "assets/location.lottie",
                                fit: BoxFit.contain,
                                height: 80,
                                width: 80,
                                decoder: customDecoder
                              ),
                              const SizedBox(height: 5),
                              Text(
                                message,
                                style: MyTextTheme.m,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                            GooglePlaceAutoCompleteTextField(
                              inputDecoration: InputDecoration(
                                border: InputBorder.none,
                               hintText: "Enter an address",
                                hintStyle: MyTextTheme.greyN,
                              ),
                              textStyle: MyTextTheme.locationT,
                              textEditingController: dashBoardController.locationController.value,
                              googleAPIKey: constantGoogleKey,
                              boxDecoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1
                                ),
                              ),
                              debounceTime: 800,
                              countries: ["in","fr"],
                              isLatLngRequired:true,
                              getPlaceDetailWithLatLng: (Prediction prediction) {
                                // this method will return latlng with place detail
                                print("placeDetails" + prediction.lng.toString());
                                locationData = LocationDataModel(
                                    latitude: prediction.lat.toString(),
                                    longitude: prediction.lng.toString(),
                                    address: prediction.description);
                                 longitude.value = prediction.toString();
                              },
                              itemClick: (Prediction prediction) {
                                dashBoardController.locationController.value.text=prediction.description!;
                                dashBoardController.locationController.value.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description!.length));
                                // String selectedLocation = prediction.description!;
                                // print("Location saved: $selectedLocation");
                                // if (prediction.lat != null && prediction.lng != null) {
                                //  String latitude = prediction.lat!;
                                //  String longitude = prediction.lng!;
                                //  print("Location Coordinates: Lat: $latitude, Lng: $longitude");
                                //  }
                                //  Navigator.pop(context);
                                isManualSelection = true;
                                  },
                              itemBuilder: (context, index, Prediction prediction) {
                                return
                                  Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.location_on),
                                        const SizedBox(width: 7),
                                        Expanded(
                                          child: Text("${prediction.description ?? ""}"),
                                        ),
                                      ],
                                    ),
                                  );
                              },
                              seperatedBuilder: const Divider(color: Colors.grey,
                              ),
                              isCrossBtnShown: true,
                              containerHorizontalPadding: 10,
                              placeType: PlaceType.geocode,
                            ),

                              const SizedBox(height: 20),
                              if (widget.showCancelButton && !isProcessing)
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    widget.onCancelled?.call();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    widget.cancelButtonText,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    // fixedSize: Size(Get.height,20),
                                    backgroundColor: widget.confirmButtonColor ?? Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        color: Colors.grey
                                      )
                                    ),
                                  ),
                                  onPressed: isProcessing
                                      ? null
                                      : () {
                                    startProcessing();
                                    dashBoardController.locationController.value.clear();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.location_on, color: Colors.grey),
                                      const SizedBox(width: 10),
                                      Text(
                                        widget.confirmButtonText,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              MyButton(
                                height: 50,
                                borderRadius: 10,
                                title: "Save",
                                color: longitude.value.isNotEmpty
                                    ? AppColor.circleIndicator
                                    : AppColor.greyColor,
                                onPressed: () {
                                  String newLocation = dashBoardController.locationController.value.text.trim();
                                 // if (newLocation.isNotEmpty && isManualSelection)
                                     if ( isManualSelection)
                                    {
                                      Get.back();
                                    dashBoardController.updateLocation(locationData);
                                    // updateLocation(newLocation);

                                  } null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
// class ConfirmationDialogState extends State<ConfirmationDialog> {
//   final DashBoardController dashBoardController = Get.put(DashBoardController());
//
//   String message = "";
//   bool isProcessing = false;
//   RxString location = ''.obs;
//   TextEditingController locationController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     message = widget.initialMessage;
//   }
//
//   void startProcessing() async {
//     setState(() {
//       isProcessing = true;
//       message =widget.loadingMessage?? "Processing...";
//     });
//
//     bool success = await widget.onConfirmed();
//
//     setState(() {
//       message = success
//           ? widget.successMessage ?? "Action completed successfully!"
//           : widget.failureMessage ?? "Action failed.";
//       isProcessing = false;
//     });
//
//     // Delay before closing the dialog so the user can see the result
//     await Future.delayed(const Duration(seconds: 2));
//     if (mounted) {
//       Navigator.of(context).pop();
//     }
//   }
//   void updateLocation(String newLocation){
//     location.value = newLocation;
//   }
//   void saveLocation() {
//     String newLocation = locationController.text.trim();
//     if (newLocation.isNotEmpty) {
//       updateLocation(newLocation);
//       print("Location updated to: $newLocation");
//     } else {
//       print("Please enter a valid location.");
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     RxDouble containerHeight = 380.0.obs;
//     print(containerHeight);
//      return  GestureDetector(
//        onTap: () {
//          Navigator.of(context).pop();
//        },
//        child: Scaffold(
//          backgroundColor: Colors.transparent,
//          body: Obx((){
//            return   Column(
//              children: [
//                Flexible(
//                  child: Align(
//                    alignment: Alignment.bottomCenter,
//                    child: AnimatedContainer(
//                      duration: const Duration(milliseconds: 1000),
//                      curve: Curves.easeInOut,
//                      height: containerHeight.value,
//                      width: MediaQuery.of(context).size.width,
//                      child: GestureDetector(
//                        onTap: (){},
//                        child: Container(
//                          decoration: BoxDecoration(
//                            image: const DecorationImage(
//                              opacity: 9,
//                              image: AssetImage("assets/net.png"),
//                              fit: BoxFit.cover,
//                            ),
//                            color: AppColor.gray,
//                            borderRadius: const BorderRadius.only(
//                              topLeft: Radius.circular(30),
//                              topRight: Radius.circular(30),
//                            ),
//                          ),
//                          padding: const EdgeInsets.all(20.0),
//                          child: Column(
//                            children: <Widget>[
//                              SizedBox(height: 10,),
//                              Lottie.asset("assets/location.lottie",
//                                  decoder: customDecoder,fit: BoxFit.contain,
//                              height: 100,
//                              width: 100),
//                              const SizedBox(height: 5),
//                              Text(
//                                message,style: MyTextTheme.m,
//                                textAlign: TextAlign.center,
//                              ),
//                              SizedBox(height: 20,),
//                              TextField(
//                                controller: locationController,
//                                cursorColor: AppColor.circleIndicator,
//                                decoration: InputDecoration(
//                                  hintText: "Enter an address",
//                                  suffixIcon: Icon(Icons.search,size: 30,),
//                                  hintStyle: MyTextTheme.mediumCustomGCN,
//                                  fillColor: Colors.white.withOpacity(0.1),
//                                  filled: true,
//                                  border: OutlineInputBorder(
//                                    borderRadius: BorderRadius.circular(10),
//                                    borderSide: const BorderSide(
//                                      color: Colors.white,
//                                    ),
//                                  ),
//                                  enabledBorder: OutlineInputBorder(
//                                    borderRadius: BorderRadius.circular(10),
//                                    borderSide: const BorderSide(
//                                      color: Colors.white,
//                                      width: 1,
//                                    ),
//                                  ),
//                                  focusedBorder: OutlineInputBorder(
//                                    borderRadius: BorderRadius.circular(10),
//                                    borderSide: const BorderSide(
//                                      color: Colors.white,
//                                      width: 1,
//                                    ),
//                                  ),
//                                ),
//                                style: const TextStyle(
//                                  color: Colors.white,
//                                ),
//                              ),
//                              SizedBox(height: 20,),
//                              Row(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                children: [
//                                  if (widget.showCancelButton && !isProcessing)
//                                    ElevatedButton(
//                                      style: ElevatedButton.styleFrom(
//                                        backgroundColor: Colors.orange,
//                                        shape: RoundedRectangleBorder(
//                                          borderRadius: BorderRadius.circular(10),
//                                        ),
//                                      ),
//                                      onPressed: () {
//                                        if (widget.onCancelled != null) {
//                                          widget.onCancelled!();
//                                        }
//                                        Navigator.of(context).pop();
//                                      },
//                                      child: Text(
//                                        widget.cancelButtonText,
//                                        style: const TextStyle(color: Colors.white),
//                                      ),
//                                    ),
//                                  SizedBox(height: 40,),
//                                  ElevatedButton(
//                                    style: ElevatedButton.styleFrom(
//                                        backgroundColor:
//                                        widget.confirmButtonColor ?? Colors.grey,
//                                        shape: RoundedRectangleBorder(
//                                          borderRadius: BorderRadius.circular(9),
//                                        ),
//                                        fixedSize: Size(320, 15),
//                                        side: BorderSide(
//                                            color: Colors.white,
//                                            width: 0
//                                        )
//                                    ),
//                                    onPressed: isProcessing ? null : startProcessing,
//                                    child:  Row(
//                                      children: [
//                                        Icon(Icons.location_on_sharp,color: Colors.grey,),
//                                        Padding(
//                                          padding: const EdgeInsets.all(8.0),
//                                          child: Text(
//                                            widget.confirmButtonText,
//                                            style: const TextStyle(color: Colors.white),
//                                          ),
//                                        ),
//                                        SizedBox(width: 50,),
//
//                                        Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,)
//                                      ],),
//                                  ),
//
//                                ],),
//                          MyButton(
//                          height: 50,
//                          borderRadius: 10,
//                          title: "Save",
//                          color: AppColor.circleIndicator,
//                          onPressed: () {
//                            saveLocation();
//                            Get.back();
//
//                          },
//                        ),
//                              ],
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//              ],
//            );
//          },
//               )
//
//        ),
//      );
//    }
// }