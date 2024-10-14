import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Services/ApiService/api_service.dart';

import '../../AppManager/toast.dart';
import '../../DataModels/LoginResponse.dart';
import '../../Services/user_data.dart';

class NotificationSettingController extends GetxController {
  UserData userData = UserData();
  ApiService apiService = ApiService();

  @override
  void onInit() {
    print("userData ${userData.getUserData?.toJson()}");
    pauseAll.value = userData.getUserData!.pauseAll!;
    quietMode.value = userData.getUserData!.quitMode!;
    friendRequests.value = userData.getUserData!.friendRequest!;
    friendNamazPrayed.value = userData.getUserData!.friendPrayed!;
    super.onInit();
  }

  var pauseAll = false.obs;
  var quietMode = false.obs;
  var friendRequests = false.obs;
  var friendNamazPrayed = false.obs;


  registerUser() async {

      var body = {
        "user_id": userData.getUserData?.id.toString(),
        "username": userData.getUserData?.username.toString(),
        "name": userData.getUserData?.name,
        "mobile_no": userData.getUserData?.mobileNo,
        "gender": userData.getUserData?.gender,
        "fiqh": userData.getUserData!.fiqh,
        "times_of_prayer":userData.getUserData!.timesOfPrayer,
        "school_of_thought": userData.getUserData?.methodId,
        "method_name":userData.getUserData?.methodName,
        "method_id":userData.getUserData?.methodId,
        "email":userData.getUserData?.email,
        "notification_on":pauseAll.value,
        "fr_noti":friendRequests.value,
        "fn_mark_noti":friendNamazPrayed.value,

      };
      print("registration body $body");
      var request  = await apiService.putRequest('update-user/',body,);
      print("request $apiService");
      final data = request;
      print("registration data $data");
      Map<String,dynamic> temp = data['user'];
      temp['quitMode'] = quietMode.value;
        final userModel = UserModel.fromJson(temp);
        await userData.addUserData(userModel);
      print("userData ${userData.getUserData?.toJson()}");
        showToast(msg: 'Profile Updated',bgColor: Colors.black);


  }
}
