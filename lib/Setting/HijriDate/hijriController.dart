import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../AppManager/dialogs.dart';
import '../../AppManager/toast.dart';
import '../../DashBoard/dashboardController.dart';
import '../../DataModels/LoginResponse.dart';
import '../../Services/ApiService/api_service.dart';
import '../../Services/user_data.dart';
import '../../Widget/no_internet.dart';
import '../../main.dart';
//
// class HijriController extends GetxController {
//   UserData userData = UserData();
//   ApiService apiService = ApiService();
//   var selectedIndex = 0.obs;
//
//   @override
//   void onInit() async{
//     await registerUser(isFirst: true);
//     updateSelectedId(userData.getUserData!.hijriAdj!);
//     selectItem(selectedId!);
//     super.onInit();
//   }
//   int? selectedId;
//   void updateSelectedId(int id){
//     selectedId = id;
//     update();
//   }
//   List<Map<String, dynamic>> hijriDateAdjustment = [
//     {"id": 4, "name": "Two Day Ago"},
//     {"id": 3, "name": "One Day Ago"},
//     {"id": 0, "name": "None"},
//     {"id": 1, "name": "One Day Ahead"},
//     {"id": 2, "name": "Two Day Ahead"},
//   ];
//
//
//
//   void selectItem(int id) {
//     // selectedIndex.value = index;
//     updateSelectedId(id);
//     // Get DashBoardController and update Islamic date
//     final DashBoardController dashboardController = Get.find<DashBoardController>();
//     dashboardController.updateIslamicDateBasedOnOption(id); // Update Hijri date in DashboardController
//   }
//
//   String getCurrentSubtitle() {
//     final selectedAdjustment = hijriDateAdjustment.firstWhere(
//           (element) => element['id'] == selectedId,
//       orElse: () => {'name': 'None'},
//     );
//     return selectedAdjustment['name'];
//   }
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
//       "hijri_adj":selectedId,
//
//     };
//     print("registration body $body");
//     var request  = await apiService.putRequest('update-user/',body,);
//     print("request $apiService");
//     final data = request;
//     print("registration data $data");
//     // Map<String,dynamic> temp = data['user'];
//     // temp['quitMode'] = quietMode.value;
//     final userModel = UserModel.fromJson(data['user']);
//     await userData.addUserData(userModel);
//     print("userData ${userData.getUserData?.toJson()}");
//     if(!isFirst){
//       showToast(msg: 'Settings Updated',bgColor: Colors.black);
//     }
//   }
// }
class HijriController extends GetxController {
  UserData userData = UserData();
  ApiService apiService = ApiService();
  var selectedId = 0.obs;

  @override
  void onInit() async {
    await registerUser(isFirst: true);
    updateSelectedId(userData.getUserData?.hijriAdj ?? 0);
    selectItem(selectedId.value);
    super.onInit();
  }

  List<Map<String, dynamic>> hijriDateAdjustment = [
    {"id": 4, "name": "Two Day Ago"},
    {"id": 3, "name": "One Day Ago"},
    {"id": 0, "name": "None"},
    {"id": 1, "name": "One Day Ahead"},
    {"id": 2, "name": "Two Day Ahead"},
  ];

  void updateSelectedId(int id) {
    selectedId.value = id; // Update reactive variable
  }

  void selectItem(int id) {
    updateSelectedId(id);

    // Update Islamic date in DashBoardController
    final DashBoardController dashboardController = Get.find<DashBoardController>();
    dashboardController.updateIslamicDateBasedOnOption(id);
  }

  String getCurrentSubtitle() {
    final selectedAdjustment = hijriDateAdjustment.firstWhere(
          (element) => element['id'] == selectedId.value, // Use reactive variable
      orElse: () => {'name': 'None'},
    );
    return selectedAdjustment['name'];
  }

  Future<void> registerUser({bool isFirst = false}) async {
    var body = isFirst
        ? {
      "user_id": userData.getUserData?.id.toString(),
      "username": userData.getUserData?.username.toString(),
      "name": userData.getUserData?.name,
      "mobile_no": userData.getUserData?.mobileNo,
      "gender": userData.getUserData?.gender,
      "fiqh": userData.getUserData?.fiqh,
      "times_of_prayer": userData.getUserData?.timesOfPrayer,
      "school_of_thought": userData.getUserData?.methodId,
      "method_name": userData.getUserData?.methodName,
      "method_id": userData.getUserData?.methodId,
      "email": userData.getUserData?.email,
    }
        : {
      "user_id": userData.getUserData?.id.toString(),
      "username": userData.getUserData?.username.toString(),
      "name": userData.getUserData?.name,
      "mobile_no": userData.getUserData?.mobileNo,
      "gender": userData.getUserData?.gender,
      "fiqh": userData.getUserData?.fiqh,
      "times_of_prayer": userData.getUserData?.timesOfPrayer,
      "school_of_thought": userData.getUserData?.methodId,
      "method_name": userData.getUserData?.methodName,
      "method_id": userData.getUserData?.methodId,
      "email": userData.getUserData?.email,
      "hijri_adj": selectedId.value,
    };

    try {
      var request = await apiService.putRequest('update-user/', body);
      final data = request;

      final userModel = UserModel.fromJson(data['user']);
      await userData.addUserData(userModel);

      if (!isFirst) {
        showToast(msg: 'Settings Updated', bgColor: Colors.black);
      }
    } catch (e) {
      print("Error in registration: $e");
      print('$e');
      final context = navigatorKey.currentContext!;
      Dialogs.showCustomBottomSheet(context: context,
        content: NoInternet(message: '$e',
            onRetry: (){registerUser(isFirst: true);
            updateSelectedId(userData.getUserData?.hijriAdj ?? 0);
            selectItem(selectedId.value);}),);
    }
  }
}
