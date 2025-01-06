import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Services/ApiService/api_service.dart';
import 'package:namaz_reminders/Services/user_data.dart';
import '../AppManager/dialogs.dart';
import '../AppManager/toast.dart';
import '../Widget/no_internet.dart';
import '../main.dart';

class FeedbackController extends GetxController{

  UserData userData = UserData();
  ApiService apiService = ApiService();

  var email = ''.obs;
  var rating = 0.obs;
  var comment = ''.obs;
  TextEditingController commentController = TextEditingController();
  TextEditingController emailController = TextEditingController();
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
      registerUser();
    }
  }

  registerUser() async {
    try{
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
    print("userData ${userData.getUserData?.toJson()}");
    showToast(msg: 'Feedback Submitted',bgColor: Colors.black);
    clearForm();
  }
  catch(e){
    print('$e');
    final context = navigatorKey.currentContext!;
    Dialogs.showCustomBottomSheet(context: context,
      content: NoInternet(message: '$e',
          onRetry: (){}),);
  }

  }
  void clearForm() {
    email.value = '';
    rating.value = 0;
    comment.value = '';
    commentController.clear();
    emailController.clear();
  }

  @override
  void onClose() {
    commentController.dispose();
    emailController.dispose();
    super.onClose();
  }
}



