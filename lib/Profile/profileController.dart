import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../DataModels/LoginResponse.dart';
import '../Services/user_data.dart';

class ProfileController extends GetxController{
  UserData userData = UserData();
  TextEditingController userNameC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController genderC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController mailC = TextEditingController();
  @override
  void onInit() {
    print(userData.getUserData?.toJson());
    userNameC.text=userData.getUserData!.username;
    nameC.text=userData.getUserData!.name;
    genderC.text=userData.getUserData!.gender;
    phoneC.text=userData.getUserData!.mobileNo;
    mailC.text=userData.getUserData!.email;
    super.onInit();
  }

  registerUser() async {
    if(userNameC.text.isNotEmpty&&nameC.text.isNotEmpty&&genderC.text.isNotEmpty&&mailC.text.isNotEmpty){
      Map<String,String> headers = {
        'Content-Type': 'application/json'
      };
      Map<String,dynamic> body = {
        "user_id": userData.getUserData?.id.toString(),
        "username": userNameC.text,
        "name": nameC.text.toString(),
        "mobile_no": phoneC.text.toString(),
        "gender": genderC.text,
        "fiqh": userData.getUserData!.fiqh,
        "times_of_prayer": userData.getUserData!.timesOfPrayer,
        "school_of_thought": userData.getUserData!.methodId,
        "method_name":userData.getUserData!.methodName,
        "method_id":userData.getUserData!.methodId,
        "email":mailC.text
      };
      print("registration body $body");
      http.Response request  = await http.put(Uri.parse('http://182.156.200.177:8011/adhanapi/update-user/'),body:jsonEncode(body), headers:headers);
      final data = jsonDecode(request.body);
      print("registration data $data");
      if(request.statusCode==200){
        final userModel = UserModel.fromJson(data['user']);
        await userData.addUserData(userModel);
      }
      else{

      }
    }
  }

  var userName = ''.obs;
  var fullName = ''.obs;
  var phoneNumber = ''.obs;
  var email = ''.obs;
  var selectedGender = "".obs;
  var profilePhoto = '';
  void updateProfilePhoto(val){
    profilePhoto=val;
    update();
  }

  void updateGender(String gender) {
    selectedGender.value = gender;
  }
  void updateUserName(String value) => userName.value = value;
  void updateFullName(String value) => fullName.value = value;
  void updatePhoneNumber(String value) => phoneNumber.value = value;
  void updateEmail(String value) => email.value = value;


  }
