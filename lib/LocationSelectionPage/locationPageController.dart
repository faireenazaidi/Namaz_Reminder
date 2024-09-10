import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';


class LocationPageController extends GetxController {
 var latitude = 0.0.obs;
 var longitude = 0.0.obs;
 var selectedSchoolOfThought = 1.obs; // To track selected school of thought






 // Method to update the user's location
 void updateLocation(double lat, double lon) {
  latitude.value = lat;
  longitude.value = lon;
  print("Latitude: $latitude");
  print("Longitude: $longitude");
 }

 // Method to get the current location
 Future<void> getCurrentLocation() async {
  try {
   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
   if (!serviceEnabled) {
    throw 'Location services are disabled. Please enable them.';
   }

   LocationPermission permission = await Geolocator.checkPermission();
   if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
     throw 'Location permissions are denied. Please grant them.';
    }
   }

   if (permission == LocationPermission.deniedForever) {
    throw 'Location permissions are permanently denied.';
   }

   Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.best,
   );
   updateLocation(position.latitude, position.longitude);
  } catch (e) {
   throw 'Error fetching location: $e';
  }
 }
 // Method to handle selection of the school of thought
 void selectSchoolOfThought(int value) {
  selectedSchoolOfThought.value = value;
 }
}