import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  // Method to get the current position (latitude and longitude)
  Future<Position?> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        // If permission is denied, return null
        return null;
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return position;
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }

  // Method to reverse geocode the position (convert coordinates to address)
  Future<String> getAddressFromCoordinates(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      // return "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      return "${place.locality}";
    } catch (e) {
      print("Error getting address: $e");
      return "Unknown";
    }
  }
}