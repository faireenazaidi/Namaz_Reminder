import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:namaz_reminders/Services/ApiService/api_service.dart';
import 'package:namaz_reminders/Services/user_data.dart';

import '../AppManager/toast.dart';

class FeedbackController extends GetxController{

  UserData userData = UserData();
  ApiService apiService = ApiService();

  var email = ''.obs;
  var rating = 0.obs;
  var comment = ''.obs;

  // Check if form is valid
  bool get isFormValid => rating.value > 0;

  void setEmail(String value) {
    email.value = value;
  }

  void setRating(int value) {
    rating.value = value;
  }

  void setComment(String value) {
    comment.value = value;
  }

  void submitFeedback() {
    if (rating!='0') {
      // Handle feedback submission logic here
      registerUser();
    }
  }

  registerUser() async {
    var body ={
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
      "feedback_stars":rating.value,
      "feedback_msg":comment.value,
      "feedback_mail":email.value,

    };
    print("registration body $body");
    var request  = await apiService.putRequest('update-user/',body,);
    print("request $apiService");
    final data = request;
    print("registration data $data");
    // Map<String,dynamic> temp = data['user'];
    // temp['quitMode'] = quietMode.value;
    // final userModel = UserModel.fromJson(data['user']);
    // await userData.addUserData(userModel);
    print("userData ${userData.getUserData?.toJson()}");
    showToast(msg: 'feedback submitted',bgColor: Colors.black);


  }
}

