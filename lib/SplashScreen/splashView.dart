import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/DataModels/CalendarDataModel.dart';
import 'package:namaz_reminders/SplashScreen/splashController.dart';

import '../LocationSelectionPage/locationPageView.dart';
import '../Login/loginView.dart';
import '../Widget/appColor.dart';

class SplashScreen extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    // Handle navigation in the controller or use a Timer here if needed
    // Future.delayed(Duration(seconds: 3), () {
    //   Get.off(() => LocationPage(), transition: Transition.circularReveal);
    // });

    return Scaffold(
      backgroundColor: AppColor.gray,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/net.png"),
                fit: BoxFit.cover
              )
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/mosque.png"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
