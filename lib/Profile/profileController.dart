import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../AppManager/image_and_video_picker.dart';
import '../AppManager/toast.dart';
import '../DataModels/LoginResponse.dart';
import '../LocationSelectionPage/locationPageDataModal.dart';
import '../Routes/approutes.dart';
import '../Services/user_data.dart';

class ProfileController extends GetxController{
  UserData userData = UserData();
  TextEditingController userNameC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController genderC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController mailC = TextEditingController();
  TextEditingController searchC = TextEditingController();
  var selectedPrayer = "".obs;
  Map<String,dynamic> schoolOFThought = {};
  void selectSchool(String value){
    schoolOFThought['id'] = value;
    schoolOFThought['name']=calculationList.firstWhere((e){return e['id'].toString()==value;})['name'];
    print(schoolOFThought);
    update();
  }


  @override
  void onInit() {
    calculationMethode();
    print(userData.getUserData?.toJson());
    userNameC.text=userData.getUserData!.username;
    nameC.text=userData.getUserData!.name;
    genderC.text=userData.getUserData!.gender;
    phoneC.text=userData.getUserData!.mobileNo;
    mailC.text=userData.getUserData!.email;
    userNameC.text=userData.getUserData!.username;
    schoolOFThought['name']=userData.getUserData!.methodName;
    schoolOFThought['id']=userData.getUserData!.methodId;
    selectedPrayer.value=userData.getUserData!.timesOfPrayer;
    print("schoolOFThought $schoolOFThought");
    super.onInit();
  }

  registerUser() async {
    if(nameC.text.isNotEmpty&&genderC.text.isNotEmpty){
      Map<String,String> headers = {
        'Content-Type': 'application/json'
      };
      Map<String,dynamic> body = {
        "user_id": userData.getUserData?.id.toString(),
        "username": userData.getUserData?.username.toString(),
        "name": nameC.text.toString(),
        "mobile_no": phoneC.text.toString(),
        "gender": genderC.text,
        "fiqh": schoolOFThought['id'].toString()=='7'||schoolOFThought['id'].toString()=='0'?'0':'1', //0 for shia 1 for sunni,
        "times_of_prayer":selectedPrayer.value==""? userData.getUserData!.timesOfPrayer:selectedPrayer.value,
        "school_of_thought": schoolOFThought['id'],
        "method_name":schoolOFThought['name'],
        "method_id":schoolOFThought['id'],
        "email":mailC.text.isEmpty?"":mailC.text,
        "notification_on":userData.getUserData!.pauseAll!,
        "fr_noti":userData.getUserData!.friendRequest!,
        "fn_mark_noti":userData.getUserData!.friendPrayed!,

      };
      print("registration body $body");
      http.Response request  = await http.put(Uri.parse('http://182.156.200.177:8011/adhanapi/update-user/'),body:jsonEncode(body), headers:headers);
      final data = jsonDecode(request.body);
      print("registration data $data");
      if(request.statusCode==200){
        final userModel = UserModel.fromJson(data['user']);
        await userData.addUserData(userModel);
        await userData.clearPrayerTimings();
        showToast(msg: 'Profile Updated',bgColor: Colors.black);
        Get.offAllNamed(AppRoutes.dashboardRoute);
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
  var selectedMethod = ''.obs;
  void updateProfilePhoto(val){
    profilePhoto=val;
    update();
  }

  void updateGender(String gender) {
    genderC.text = gender;
    update();
  }

  List calculationList = [];
  List<CalculationDataModal> get getCalculationList => List<CalculationDataModal>.from(
      calculationList.map((element)=>CalculationDataModal.fromJson(element))
  );
  set updateCalculationList(List val){
    calculationList = val;
    print("calculationList $calculationList");
    update();
  }

  Future<void> calculationMethode() async {
    print("calculation method running");
    var request = http.Request(
        'GET', Uri.parse('http://182.156.200.177:8011/adhanapi/methods/'));
    http.StreamedResponse response = await request.send();
    print("statusCode ${response.statusCode}");
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var data = jsonDecode(await response.stream.bytesToString());
      updateCalculationList = data;
      print("getData${getCalculationList.toList()}");


    }
    else {
      print(response.reasonPhrase);
    }
  }

  void updateUserName(String value) => userName.value = value;
  void updateFullName(String value) => fullName.value = value;
  void updatePhoneNumber(String value) => phoneNumber.value = value;
  void updateEmail(String value) => email.value = value;

  Future<void> showImagePickerMenu(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Take a picture'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final file = await MyImagePicker.pickImage(isFromCam: true);
                    if (file != null) {
                      await _updateProfilePhoto(file);
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Choose from gallery'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final file = await MyImagePicker.pickImage(
                        isFromCam: false);
                    if (file != null) {
                      await _updateProfilePhoto(file);
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete, color: Colors.red),
                  title: Text('Remove image'),
                  enabled: userData.getUserData!.picture.isNotEmpty,
                  onTap: userData.getUserData!.picture.isNotEmpty
                      ? () async {
                    Navigator.of(context).pop();
                    await _removeProfilePhoto();
                  }
                      : null,
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _updateProfilePhoto(String filePath) async {
    updateProfilePhoto(filePath);


    var headers = {
      'Cookie': 'csrftoken=yQZryaCTtTmYrYdjA6ZZSxgbPfJJlNft',
    };
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse('http://182.156.200.177:8011/adhanapi/update-user/'),
    );

    request.fields['user_id'] = userData.getUserData!.id.toString();
    request.files.add(await http.MultipartFile.fromPath('picture', filePath));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      final myData = jsonDecode(data);
      final userModel = UserModel.fromJson(myData['user']);
      await userData.addUserData(userModel);
      showToast(msg: 'Photo Updated',bgColor: Colors.black);
    } else {
      print("Error: ${response.reasonPhrase}");
    }
  }
  Future<void> _removeProfilePhoto() async {
    var headers = {
      'Cookie': 'csrftoken=yQZryaCTtTmYrYdjA6ZZSxgbPfJJlNft',
    };
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse('http://182.156.200.177:8011/adhanapi/update-user/'),
    );
    request.fields['user_id'] = userData.getUserData!.id.toString();
    request.fields['picture'] = '';
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      final myData = jsonDecode(data);
      final userModel = UserModel.fromJson(myData['user']);
      await userData.addUserData(userModel);
      update();
      showToast(msg: 'Photo Removed',bgColor: Colors.black);
      _updateProfilePhoto("");
    }
    else
    {
      print("Error: ${response.reasonPhrase}");
    }
  }

  }
