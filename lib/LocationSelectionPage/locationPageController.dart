import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LocationPageController extends GetxController {
 final Rx<TextEditingController> phoneController = TextEditingController().obs;
 RxBool isBottomSheetExpanded = false.obs;
 RxBool isPhoneNumberValid = false.obs;
 RxBool showSecondContainer = false.obs;
 RxBool isOtpFilled = false.obs;
 RxBool isOtpVerified = false.obs;
 RxBool showThirdContainer = false.obs;
 RxInt secondsLeft = 60.obs;
 late Timer _timer;

 @override
 void onInit() {
  super.onInit();
  Future.delayed(const Duration(milliseconds: 300), () {
   isBottomSheetExpanded.value = true;
  });
  phoneController.value.addListener(() {
   validatePhoneNumber(phoneController.value.text);
  });
  startTimer();
 }

 void validatePhoneNumber(String phoneNumber) {
  isPhoneNumberValid.value = phoneNumber.length >= 10;
 }

 void toggleSecondContainer() {
  showSecondContainer.value = !showSecondContainer.value;
 }
 void toggleThirdContainer() {
  showThirdContainer.value = !showThirdContainer.value;
 }

 void verifyOtp(String code) {
  if (code.length == 6) {
   isOtpVerified.value = true;
   showThirdContainer.value = true;
  }



 }

 void startTimer() {
  _timer = Timer.periodic(Duration(seconds: 1), (timer) {
   if (secondsLeft.value > 0) {
    secondsLeft.value--;
   } else {
    _timer.cancel();
   }
  });
 }

 @override
 void onClose() {
  _timer.cancel();
  super.onClose();
 }
}
