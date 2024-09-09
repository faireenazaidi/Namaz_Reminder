import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/LocationSelectionPage/locationPageController.dart';

class LocationPage extends GetView<LocationPageController> {
  @override
  Widget build(BuildContext context) {
    // Triggering the bottom sheet when the widget is first built
    Future.microtask(() => showFirstBottomSheet(context));

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/macca.jpeg',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  void showFirstBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // To allow full height modal
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            color: Colors.black,
          ),
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20.0),
              Text(
                'Select Location',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter an address',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context); // Close the first modal
                  showSecondBottomSheet(context); // Open the second modal
                },
                icon: Icon(Icons.my_location),
                label: Text('Use Current Location'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Background color
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showSecondBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // To allow full height modal
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            color: Colors.black,
          ),
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20.0),
              Text(
                'Select Your School Of Thought',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: 20.0),
              RadioListTile(
                title: Text(
                  'Islamic Society of North America',
                  style: TextStyle(color: Colors.white),
                ),
                value: 1,
                groupValue: 1, // Replace with your state management
                onChanged: (value) {},
              ),
              RadioListTile(
                title: Text(
                  'Umm Al-Qura University, Makkah',
                  style: TextStyle(color: Colors.white),
                ),
                value: 2,
                groupValue: 1, // Replace with your state management
                onChanged: (value) {},
              ),
              RadioListTile(
                title: Text(
                  'Institute of Geophysics. University of Tehran',
                  style: TextStyle(color: Colors.white),
                ),
                value: 3,
                groupValue: 1, // Replace with your state management
                onChanged: (value) {},
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    child: Text('Select other'),
                    value: 'other',
                  ),
                ],
                onChanged: (value) {},
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the second modal
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber, // Background color
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
