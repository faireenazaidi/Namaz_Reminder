import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:namaz_reminders/Services/ApiService/api_service.dart';
import '../../DataModels/LoginResponse.dart';
import '../../Services/user_data.dart';
import '../../Setting/SettingController.dart';

class NotificationSettingController extends GetxController {

  UserData userData = UserData();
  ApiService apiService = ApiService();

  @override
  void onInit() async{
    print("userData ${userData.getUserData?.toJson()}");
    await registerUser(isFirst: true);
    pauseAll.value = userData.getUserData!.pauseAll!;
    quietMode.value = userData.getUserData!.quitMode!;
    friendRequests.value = userData.getUserData!.friendRequest!;
    friendNamazPrayed.value = userData.getUserData!.friendPrayed!;
    preNamazAlertId = userData.getUserData!.preNamazAlert!;
    preNamazAlertName.value=getCurrentSubtitle();
    print("############ ${quietMode.value}");
    super.onInit();
  }

  var pauseAll = false.obs;
  var quietMode = false.obs;
  var friendRequests = false.obs;
  var friendNamazPrayed = false.obs;
  String preNamazAlertId = '';
  RxString preNamazAlertName = ''.obs;


  registerUser({bool isFirst=false}) async {
  try {
    var body = isFirst ? {
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

    } :
    {
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
      "notification_off": pauseAll.value,
      "fr_noti": friendRequests.value,
      "fn_mark_noti": friendNamazPrayed.value,
      "quiet_mode": quietMode.value,
      "namaz_alert": preNamazAlertId
    };
    print("registration body $body");
    var request = await apiService.putRequest('update-user/', body,);
    print("request $apiService");
    final data = request;
    print("registration data $data");
    final userModel = UserModel.fromJson(data['user']);
    await userData.addUserData(userModel);
    print("userData ${userData.getUserData?.toJson()}");
  }
  catch(e){
    print('$e');

  }
  //updateScheduler();
  }

  void updateSelectedId(String id) {
    preNamazAlertId = id;
    update(['alert']);
    preNamazAlertName.value=getCurrentSubtitle();
    registerUser();
  }
  List<Map<String, dynamic>> preNamazAlertList = [
    {"id": '4', "name": "15 minutes ago"},
    {"id": '3', "name": "10 minutes ago"},
    {"id": '2', "name": "5 minutes ago"},
    {"id": '1', "name": "On Time Alert"},
    {"id": '0', "name": "No Alert"},
  ];
  String getCurrentSubtitle() {
    // Find the entry matching the current selectedId
    final selectedOption = preNamazAlertList.firstWhere(
          (option) => option['id'] == preNamazAlertId,
      orElse: () => {"id": null, "name": "No Alert"},
    );

    return selectedOption['name'];
  }

  Future<void> updateScheduler() async {
    String url = "http://182.156.200.177:8011/adhanapi/update-scheduler/${userData.getUserData?.id}/";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        print("Scheduler updated successfully: ${response.body}");
      } else {
        print(
            "Failed to update scheduler. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred while updating scheduler: $e");
    }
  }


}
