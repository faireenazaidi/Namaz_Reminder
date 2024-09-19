import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{

  var userName = ''.obs;
  var fullName = ''.obs;
  var phoneNumber = ''.obs;
  var email = ''.obs;
  var selectedGender = "".obs;

  void updateGender(String gender) {
    selectedGender.value = gender;
  }
  void updateUserName(String value) => userName.value = value;
  void updateFullName(String value) => fullName.value = value;
  void updatePhoneNumber(String value) => phoneNumber.value = value;
  void updateEmail(String value) => email.value = value;


  }
