import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

// class LocationServices{
//
//   /// Determine the current position of the device.
//   ///
//   /// When the location services are not enabled or permissions
//   /// are denied the `Future` will return an error.
//   Future<Position> determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition();
//   }
// }

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
  //
  // // Method to get coordinates from a user-provided address (forward geocoding)
  // Future<Location?> getCoordinatesFromAddress(String address) async {
  //   try {
  //     List<Location> locations = await locationFromAddress(address);
  //     if (locations.isNotEmpty) {
  //       return locations[0];  // Return the first matched location
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     print("Error getting coordinates from address: $e");
  //     return null;
  //   }
  // }
}