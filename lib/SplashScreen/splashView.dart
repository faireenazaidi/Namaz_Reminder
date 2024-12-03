import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/SplashScreen/splashController.dart';
import '../Widget/appColor.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplashController splashController = Get.find();
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
