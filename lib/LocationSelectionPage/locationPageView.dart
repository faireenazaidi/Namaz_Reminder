import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/LocationSelectionPage/locationPageController.dart';
import '../Widget/popUp.dart';

class LocationPage extends GetView<LocationPageController> {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger the AlertDialogue when the page is loaded
      AlertDialogue().show(
        context,
        newWidget: [


        ],
      );


    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
           opacity: 10,

            image: AssetImage("assets/mecca.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
