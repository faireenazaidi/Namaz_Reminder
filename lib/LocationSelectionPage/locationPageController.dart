import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Routes/approutes.dart';


class LocationPageController extends GetxController {
 final Rx<TextEditingController> phoneController = TextEditingController().obs;
 RxBool isBottomSheetExpanded = false.obs;

 @override
 void onInit() {
  super.onInit();

  Future.delayed(const Duration(milliseconds: 300), () {
   isBottomSheetExpanded.value = true;
  });
 }

 final FirebaseAuth _auth = FirebaseAuth.instance;
 final GoogleSignIn _googleSignIn = GoogleSignIn();

 Future<User?> signInWithGoogle() async {
  try {
   final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();


   if (googleUser == null) {
    print('yessss');
    // The user canceled the sign-in
    return null;
   }
   print('nooo $googleUser');

   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

   final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
   );

   final UserCredential userCredential = await _auth.signInWithCredential(credential);
   final User? user = userCredential.user;


   if (user != null) {
    // User successfully signed in
    print("User Name: ${user.displayName}");
    print("User Email: ${user.email}");
    Get.toNamed(AppRoutes.dashboardRoute); // Navigate to dashboard after login
   }
   return user;
  } catch (e) {
   print('exception:$e.toString()');
   Get.snackbar("Error", "Failed to sign in with Google");
   return null;
  }
 }

 // void signOut() async {
 //  await _auth.signOut();
 //  await _googleSignIn.signOut();
 // }
 // var latitude = 0.0.obs;
 // var longitude = 0.0.obs;
 // var selectedSchoolOfThought = 1.obs; // To track selected school of thought
 //
 //
 // // Method to update the user's location
 // void updateLocation(double lat, double lon) {
 //  latitude.value = lat;
 //  longitude.value = lon;
 //  print("Latitude: $latitude");
 //  print("Longitude: $longitude");
 // }
 //
 // // Method to get the current location
 // Future<void> getCurrentLocation() async {
 //  try {
 //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
 //   if (!serviceEnabled) {
 //    throw 'Location services are disabled. Please enable them.';
 //   }
 //
 //   LocationPermission permission = await Geolocator.checkPermission();
 //   if (permission == LocationPermission.denied) {
 //    permission = await Geolocator.requestPermission();
 //    if (permission == LocationPermission.denied) {
 //     throw 'Location permissions are denied. Please grant them.';
 //    }
 //   }
 //
 //   if (permission == LocationPermission.deniedForever) {
 //    throw 'Location permissions are permanently denied.';
 //   }
 //
 //   Position position = await Geolocator.getCurrentPosition(
 //    desiredAccuracy: LocationAccuracy.best,
 //   );
 //   updateLocation(position.latitude, position.longitude);
 //  } catch (e) {
 //   throw 'Error fetching location: $e';
 //  }
 // }
 // // Method to handle selection of the school of thought
 // void selectSchoolOfThought(int value) {
 //  selectedSchoolOfThought.value = value;
 // }
}