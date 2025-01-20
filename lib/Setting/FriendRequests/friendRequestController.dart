import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../AppManager/dialogs.dart';
import '../../AppManager/toast.dart';
import '../../DataModels/LoginResponse.dart';
import '../../Services/ApiService/api_service.dart';
import '../../Services/user_data.dart';
import '../../Widget/no_internet.dart';
import '../../main.dart';
class RequestController extends GetxController {
  UserData userData = UserData();
  ApiService apiService = ApiService();
  // var selectedIndex = Rx<int?>(null);
  var selectedIndex = 0.obs;
  var isLoading = false.obs; // Observable to track loading state

  @override
  void onInit() async {
    super.onInit();
    await registerUser(isFirst: true);
    selectedIndex.value =
    userData.getUserData!.frAllow! == 2 ? 1 : userData.getUserData!.frAllow!;
  }

  void selectItem(int index) async {
    selectedIndex.value = index;
    await registerUser();
  }



  Future<void> registerUser({bool isFirst = false}) async {
    // Map fr_allow values properly based on selectedIndex
    int? frAllowValue;
    if (!isFirst) {
      frAllowValue = selectedIndex.value == 0
          ? 0
          : 1; // Explicit mapping
    }

    // Construct request body
    var body = {
      "user_id": userData.getUserData?.id.toString(),
      "username": userData.getUserData?.username.toString(),
      "name": userData.getUserData?.name,
      "mobile_no": userData.getUserData?.mobileNo,
      "gender": userData.getUserData?.gender,
      "fiqh": userData.getUserData!.fiqh,
      "times_of_prayer": userData.getUserData!.timesOfPrayer,
      "school_of_thought": userData.getUserData?.methodId,
      "method_name": userData.getUserData?.methodName,
      "method_id": userData.getUserData?.methodId,
      "email": userData.getUserData?.email,
    };

    if (!isFirst) {
      body["fr_allow"] = frAllowValue.toString();
    }

    print("Registration body: $body");

    try {
      isLoading.value = true; // Show loading state
      var request = await apiService.putRequest('update-user/', body);
      print("API response: $request");

      // Update local user data
      final data = request;
      final userModel = UserModel.fromJson(data['user']);
      await userData.addUserData(userModel);
      print("Updated UserData: ${userData.getUserData?.toJson()}");

      if (!isFirst) {
        showToast(msg: 'Settings Updated', bgColor: Colors.black);
      }
    } catch (e) {
      print("Error updating user: $e");
      print('$e');
      final context = navigatorKey.currentContext!;
      Dialogs.showCustomBottomSheet(context: context,
        content: NoInternet(message: '$e',
            onRetry: (){registerUser(isFirst: true);
            selectedIndex.value =
            userData.getUserData!.frAllow! == 2 ? 1 : userData.getUserData!.frAllow!;}),);
    } finally {
      isLoading.value = false; // Hide loading state
    }
  }
}

// class RequestController extends GetxController {
//   UserData userData = UserData();
//   ApiService apiService = ApiService();
//   var selectedIndex = Rx<int?>(null);
//
//   @override
//   void onInit() async{
//     await registerUser(isFirst: true);
//     selectedIndex.value = userData.getUserData!.frAllow! ==2?1:userData.getUserData!.frAllow!;
//
//
//     super.onInit();
//   }
//
//   void selectItem(int index) {
//     selectedIndex.value = index;
//     registerUser();
//   }
//
//
//   registerUser({bool isFirst=false}) async {
//
//     var body =isFirst? {
//       "user_id": userData.getUserData?.id.toString(),
//       "username": userData.getUserData?.username.toString(),
//       "name": userData.getUserData?.name,
//       "mobile_no": userData.getUserData?.mobileNo,
//       "gender": userData.getUserData?.gender,
//       "fiqh": userData.getUserData!.fiqh,
//       "times_of_prayer":userData.getUserData!.timesOfPrayer,
//       "school_of_thought": userData.getUserData?.methodId,
//       "method_name":userData.getUserData?.methodName,
//       "method_id":userData.getUserData?.methodId,
//       "email":userData.getUserData?.email,
//       "fr_allow": selectedIndex.value == 1 ? 2 : selectedIndex.value,
//
//     }:
//     {
//       "user_id": userData.getUserData?.id.toString(),
//       "username": userData.getUserData?.username.toString(),
//       "name": userData.getUserData?.name,
//       "mobile_no": userData.getUserData?.mobileNo,
//       "gender": userData.getUserData?.gender,
//       "fiqh": userData.getUserData!.fiqh,
//       "times_of_prayer":userData.getUserData!.timesOfPrayer,
//       "school_of_thought": userData.getUserData?.methodId,
//       "method_name":userData.getUserData?.methodName,
//       "method_id":userData.getUserData?.methodId,
//       "email":userData.getUserData?.email,
//       // "fr_allow":selectedIndex.value==1?2:selectedIndex.value,
//
//     };
//     print("registration body $body");
//     var request  = await apiService.putRequest('update-user/',body,);
//     print("request $apiService");
//     final data = request;
//     print("registration data $data");
//     final userModel = UserModel.fromJson(data['user']);
//     await userData.addUserData(userModel);
//     print("userData ${userData.getUserData?.toJson()}");
//     if(!isFirst){
//       showToast(msg: 'Settings Updated',bgColor: Colors.black);
//     }
//   }
// }
