import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/SplashScreen/splashController.dart';

import '../Login/loginView.dart';

class SplashScreen extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    // Handle navigation in the controller or use a Timer here if needed
    Future.delayed(Duration(seconds: 3), () {
      Get.off(() => LoginView(), transition: Transition.circularReveal);
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Image.asset("assets/whiteNet.png"),
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
