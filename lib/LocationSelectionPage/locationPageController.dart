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
 RxBool showFourthContainer = false.obs;
 RxDouble containerHeight = 400.0.obs;
 RxInt step = 0.obs;
 var selectedGender = "Male".obs;
 void updateGender(String gender){
  selectedGender.value=gender;
 }


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
 void toggleFourthContainer() {
  showFourthContainer.value = !showFourthContainer.value;
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

 dynamicHeightAllocation(){
  step.value = step.value +1;
  print(" STEP VALUE ${step.value}");
  if(step.value == 1){
   containerHeight.value = 350;
  }
  else if(step.value==2){
   containerHeight.value=  400;
  }
   else if(step.value==3){
   containerHeight.value=250;
  }
   else if(step.value==4){
    containerHeight.value=300;
  }
  update();
 }

 @override
 void onClose() {
  _timer.cancel();
  super.onClose();
 }


}
