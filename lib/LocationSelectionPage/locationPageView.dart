// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:namaz_reminders/LocationSelectionPage/locationPageController.dart';
//
// class LocationPage extends GetView<LocationPageController> {
//   @override
//   Widget build(BuildContext context) {
//
//     // Triggering the bottom sheet when the widget is first built
//     Future.microtask(() => showFirstBottomSheet(context));
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset(
//               'assets/macca.jpeg',
//               fit: BoxFit.cover,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void showFirstBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true, // To allow full height modal
//       backgroundColor: Colors.transparent,
//       builder: (BuildContext context) {
//         return Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20.0),
//               topRight: Radius.circular(20.0),
//             ),
//             color: Colors.black,
//           ),
//           padding: EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(height: 20.0),
//               Text(
//                 'Select Location',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24.0,
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Enter an address',
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10.0),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   // Get the current location and update the controller
//                   _getCurrentLocation().then((position) {
//                     controller.latitude = position.latitude as RxDouble;
//                     controller.longitude = position.longitude as RxDouble;
//                     Navigator.pop(context); // Close the first modal
//                     showSecondBottomSheet(context); // Open the second modal
//                   });
//                 },
//                 icon: Icon(Icons.my_location),
//                 label: Text('Use Current Location'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.black, // Background color
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void showSecondBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true, // To allow full height modal
//       backgroundColor: Colors.transparent,
//       builder: (BuildContext context) {
//         return Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20.0),
//               topRight: Radius.circular(20.0),
//             ),
//             color: Colors.black,
//           ),
//           padding: EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(height: 20.0),
//               Text(
//                 'Select Your School Of Thought',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24.0,
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               RadioListTile(
//                 title: Text(
//                   'Islamic Society of North America',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 value: 1,
//                 groupValue: 1, // Replace with your state management
//                 onChanged: (value) {},
//               ),
//               RadioListTile(
//                 title: Text(
//                   'Umm Al-Qura University, Makkah',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 value: 2,
//                 groupValue: 1, // Replace with your state management
//                 onChanged: (value) {},
//               ),
//               RadioListTile(
//                 title: Text(
//                   'Institute of Geophysics. University of Tehran',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 value: 3,
//                 groupValue: 1, // Replace with your state management
//                 onChanged: (value) {},
//               ),
//               DropdownButtonFormField(
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//                 items: [
//                   DropdownMenuItem(
//                     child: Text('Select other'),
//                     value: 'other',
//                   ),
//                 ],
//                 onChanged: (value) {},
//               ),
//               SizedBox(height: 20.0),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context); // Close the second modal
//                 },
//                 child: Text('Submit'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.amber, // Background color
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   // Function to get the current location
//   Future<Position> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled, so prompt the user to enable them
//       return Future.error('Location services are disabled.');
//     }
//
//     // Get permission to access location
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, so show an error message
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, so show an error message
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     // Get the current location
//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.best);
//   }
// }