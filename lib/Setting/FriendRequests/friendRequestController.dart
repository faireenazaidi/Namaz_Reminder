import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../AppManager/toast.dart';
import '../../DataModels/LoginResponse.dart';
import '../../Services/ApiService/api_service.dart';
import '../../Services/user_data.dart';

class RequestController extends GetxController {
  UserData userData = UserData();
  ApiService apiService = ApiService();
  var selectedIndex = Rx<int?>(null);

  @override
  void onInit() async{
    await registerUser(isFirst: true);
    selectedIndex.value = userData.getUserData!.frAllow! ==2?1:userData.getUserData!.frAllow!;
    super.onInit();
  }

  void selectItem(int index) {
    selectedIndex.value = index;
    registerUser();
  }

  registerUser({bool isFirst=false}) async {

    var body =isFirst? {
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

    }:
    {
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
      "fr_allow":selectedIndex.value==1?2:selectedIndex.value,

    };
    print("registration body $body");
    var request  = await apiService.putRequest('update-user/',body,);
    print("request $apiService");
    final data = request;
    print("registration data $data");
    // Map<String,dynamic> temp = data['user'];
    // temp['quitMode'] = quietMode.value;
    final userModel = UserModel.fromJson(data['user']);
    await userData.addUserData(userModel);
    print("userData ${userData.getUserData?.toJson()}");
    if(!isFirst){
      showToast(msg: 'settings Updated',bgColor: Colors.black);
    }



  }
}
