import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/SplashScreen/splashController.dart';
import '../Widget/appColor.dart';

class SplashScreen extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    // Handle navigation in the controller or use a Timer here if needed
    // Future.delayed(Duration(seconds: 3), () {
    //   Get.off(() => LocationPage(), transition: Transition.circularReveal);
    // });
    FocusScope.of(context).unfocus();
    return GestureDetector(
      onTap: (){
      FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.gray,
        body: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                "assets/jali.svg",
                fit: BoxFit.cover,
              ),
            ),

            // Center widget or title
            Center(
              child: SvgPicture.asset(
                "assets/title.svg",
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      )
    );
  }
}
