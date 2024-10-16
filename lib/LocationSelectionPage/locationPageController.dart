import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:namaz_reminders/DataModels/LoginResponse.dart';
import 'package:namaz_reminders/Routes/approutes.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import '../Services/firebase_services.dart';
import '../Services/user_data.dart';
import 'locationPageDataModal.dart';

class LocationPageController extends GetxController {
 final Rx<TextEditingController> phoneController = TextEditingController().obs;
 final Rx<TextEditingController> nameC = TextEditingController().obs;
 final Rx<TextEditingController> usernameC = TextEditingController().obs;
 final Rx<TextEditingController> mobileNoC = TextEditingController().obs;
 final Rx<TextEditingController> timesOfPrayerC = TextEditingController().obs;
 final Rx<TextEditingController> schoolOfThoughtC = TextEditingController().obs;
 RxList<CalculationMethod> calculationMethods = <CalculationMethod>[].obs;

 RxBool isBottomSheetExpanded = false.obs;
 RxBool isPhoneNumberValid = false.obs;
 RxBool showSecondContainer = false.obs;
 RxBool isOtpFilled = false.obs;
 RxBool isOtpVerified = false.obs;
 RxBool showThirdContainer = false.obs;
 RxBool showFourthContainer = false.obs;
 RxDouble containerHeight = 300.0.obs;
 var calculationMethod = <CalculationMethod>[].obs;
 var keyCalculationMethods = <CalculationDataModal>[].obs;
 var otherCalculationMethods = <CalculationMethod>[].obs;

 var selectedMethod = ''.obs; // To store the selected method

 var selectedCalculationMethod = ''.obs;
 RxInt step = 0.obs;
 var selectedGender = "".obs;
 var selectedFiqh = ''.obs;
 var selectedPrayer = "".obs;
  RxMap loginUserResponse={}.obs;
  UserData userData = UserData();


  void updateGender(String gender) {
    selectedGender.value = gender;
  }
 void updateLoginResponse(data) {
    loginUserResponse.value = data;
    update();
  }

  void updateFiqh(fiqh) {
    selectedFiqh.value = fiqh;
  }

  void updatePrayer(String pray) {
    selectedPrayer.value = pray;
  }

  RxInt secondsLeft = 60.obs;
   Timer? _timer;
  bool isTimerRunning = true;
 int start = 250; // Timer starts from 5 minutes (300 seconds)
 void startTimer() {
   _timer?.cancel(); // Cancel previous timer if any
     start = 250; // Reset the timer to 5 minutes (300 seconds)
     isTimerRunning = true;
     update(['otp']);
   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
       if (start > 0) {
         start--;
       } else {
         _timer?.cancel(); // Stop the timer when it reaches 0
           isTimerRunning = false; // Set timer running state to false
         update(['otp']);

       }
       update(['otp']);
   });
 }

 // Helper function to format seconds into MM:SS format
 String formatTime(int seconds) {
   int minutes = seconds ~/ 60;
   int remainingSeconds = seconds % 60;
   return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
 }


 void resendOtp() {
   login(phoneController.value.text); // Call the sendOtp method
   // startTimer(); // Start the timer after sending OTP
 }

  @override
  void onInit() {
    super.onInit();
    precacheImage(const AssetImage("assets/mecca.jpg"), Get.context!);
    calculationMethode();
    Future.delayed(const Duration(milliseconds: 300), () {
      isBottomSheetExpanded.value = true;
    });
    phoneController.value.addListener(() {
      validatePhoneNumber(phoneController.value.text);
    });

    // fetchCalculationMethods();
  }

  void validatePhoneNumber(String phoneNumber) {
    isPhoneNumberValid.value = phoneNumber.length >= 10;
  }

  void toggleSecondContainer() {
    showSecondContainer.value = !showSecondContainer.value;
  }

  void toggleThirdContainer() {
    showThirdContainer.value = !showThirdContainer.value;
  }

  void toggleFourthContainer() {
    showFourthContainer.value = !showFourthContainer.value;
  }

  void verifyOtp(String code) {
    if (code.length == 6) {
      isOtpVerified.value = true;
      showThirdContainer.value = true;
    }
  }

  dynamicHeightAllocation() {
    step.value = step.value + 1;
    print("STEP VALUE ${step.value}");
    if (step.value == 1) {
      containerHeight.value = 300;
    } else if (step.value == 2) {
      containerHeight.value = 400;
    } else if (step.value == 3) {
      containerHeight.value = 500;
    } else if (step.value == 4) {
      containerHeight.value = 300;
    }
    update();
  }

  @override
  void onClose() {
    _timer!.cancel();
    super.onClose();
  }


 calculationMethode() async {
    print("calculation method running");
  var request = http.Request(
      'GET', Uri.parse('http://182.156.200.177:8011/adhanapi/methods/'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
   // print(await response.stream.bytesToString());
   var data = jsonDecode(await response.stream.bytesToString());

   updateCalculationList = data;
   print("getData${getCalculationList.toList()}");
   checkData();

  }
  else {
   print(response.reasonPhrase);
  }
 }
 RxInt  isChecked=0.obs;
 List calculationList = [];
 List<CalculationDataModal> get getCalculationList => List<CalculationDataModal>.from(
     calculationList.map((element)=>CalculationDataModal.fromJson(element))
 );
 set updateCalculationList(List val){
  calculationList = val;
  update();
 }

 List<CalculationDataModal> keyMethods = [];

 checkData(){
  // Separate the key methods (ISNA, Makkah, Tehran) from others
  keyMethods = getCalculationList.where((method) {
   return method.id!.toString() == "2" ||
       method.id!.toString() == "5" ||
       method.id!.toString() == "7";
  }).toList();


  List<CalculationMethod> otherMethods = calculationMethods.value.where((method) {
   return !keyMethods.contains(method);
  }).toList();

  keyCalculationMethods.value = keyMethods;
  otherCalculationMethods.value = otherMethods;

  print("@@@@@@@@ ${keyMethods.map((e)=>e.name).toList()}");
  print(keyCalculationMethods.value.toString());

 }

Map selectMethod = {}.obs;
 void updateSelectMethod(val){
   selectMethod = val;
   update();
 }

 RxInt calId = 0.obs;
 RxInt get getCalId => calId;
 set updateCalId(int val){
  calId.value = val;
  update();
 }
  ///login

  var otp = '';

  var response = {};
  login(String phoneNumber) async {
    startTimer();
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {"mobile_no": phoneNumber};
    http.Response request = await http.post(Uri.parse('http://182.156.200.177:8011/adhanapi/login/'), body: jsonEncode(body), headers: headers);
    print("@@@ REQUEST DATA ${request.body}");
    response = jsonDecode(request.body);
    print("ffff ${response['is_registered']}");
    otp = response['response_data']['otp'].toString();
  }

  /// Otp verification

  otpVerification(verificationOTPCode) async {
    var body = {"mobile_no": phoneController.value.text.toString().trim(), "otp": verificationOTPCode.toString().trim(),
      'token':FirebaseMessagingService().getToken()};

    print("phoneNumber ${phoneController.value.text}");
    print("phoneNumber______________ ${body}");

    http.Response request = await http.post(Uri.parse('http://182.156.200.177:8011/adhanapi/verify/'), body: body, );
    print("verify otp api data ${request.body}");


    otpData = jsonDecode(request.body);
    if (otpData['response_code'].toString() == "1") {
      final userModel = UserModel.fromJson(otpData['response_data']['user']);
      if(otpData['response_data']['detail'].toString()!='Invalid or expired OTP'){
        if(response['response_data']['is_registered'].toString()=='0'){
          dynamicHeightAllocation();
          await userData.addUserData(userModel);
        }else{
          if(otpData['response_data']['user']['name']==null||otpData['response_data']['user']['name']==''){
            dynamicHeightAllocation();
            await userData.addUserData(userModel);
          }
          else{
            await userData.addUserData(userModel);
            // step.value = 0;
            print("USERDATA: ${userData.getUserData!.mobileNo.toString()}");
            // updateLoginResponse(jsonDecode(otpData['response_data']['user']));
            Get.offAllNamed(AppRoutes.dashboardRoute);
          }
        }
      }
      print("USERDATA: ${userData.getUserData!.mobileNo.toString()}");



    } else {
      print("ddddd ${otpData['detail']}");
      Get.snackbar('Error!', 'Invalid OTP',
          colorText: Colors.white, backgroundColor: Get.theme.colorScheme.error, snackPosition: SnackPosition.BOTTOM);
    }
  }

 var otpData = {};

  /// Method to register use

  registerUser() async {
   Map<String,String> headers = {
    'Content-Type': 'application/json'
   };
   Map<String,dynamic> body = {
     "user_id": userData.getUserData?.id.toString(),
    "username": "${usernameC.value.text.toString().toLowerCase().trim()}${phoneController.value.text.toString().substring(phoneController.value.text.toString().length - 3)}",
    "name": nameC.value.text.toString(),
    "mobile_no": phoneController.value.text.toString(),
    "gender": selectedGender.value.toString(),
    // "fiqh": (selectedFiqh.value).toString(),
    "fiqh": selectMethod['id'].toString()=='7'?'0':'1', //0 for shia 1 for sunni
    "times_of_prayer":selectMethod['id'].toString()=='7'? selectedPrayer.value:'5',
     "school_of_thought": selectMethod['id'].toString(),
     "method_name":selectMethod['name'].toString(),
     "method_id":selectMethod['id'].toString()
   };
   print("registration body $body");
   http.Response request  = await http.put(Uri.parse('http://182.156.200.177:8011/adhanapi/update-user/'),body:jsonEncode(body), headers:headers);
   final data = jsonDecode(request.body);
   print("registration data $data");
   if(request.statusCode==200){
     final userModel = UserModel.fromJson(data['user']);
     await userData.addUserData(userModel);
     // step.value=0;
     Get.offAllNamed(AppRoutes.dashboardRoute);
     print("USERDATA: ${userData.getUserData!.mobileNo.toString()}");
   }
   else{

   }
   print("user register data ${request.body}");
  }

 ///Firebase.
 static final FirebaseAuth _auth = FirebaseAuth.instance;
 // UserData userData = UserData();
 // User? user = _auth.currentUser;
 RxString otpVerificationId = "".obs;
 List<UserDetailsDataModal> userDetailsList = [];

 ///for sending otp to number
 Future<void> signInWithPhoneNumber() async {
  Future.delayed(const Duration(seconds: 1), () async {
   try {
    verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {}
    codeAutoRetrievalTimeout(String verificationId) async {}
    verificationFailed(FirebaseAuthException e) async {
     if (e.code == 'invalid-phone-number') {
      debugPrint('The provided phone number is not valid.');
     }
     debugPrint("Check Internet Connection Properly");
     debugPrint(e.toString());
    }

    codeSent(String verificationId, int? forceResendingToken) async =>
        otpVerificationId.value = verificationId;
    String number = "+91 ${phoneController.value.text.toString()}";
    await _auth.verifyPhoneNumber(
     phoneNumber: number,
     timeout: const Duration(seconds: 60),
     verificationCompleted: verificationCompleted,
     verificationFailed: verificationFailed,
     codeSent: codeSent,
     codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
     // forceResendingToken: forceResendingToken,
    );
   } catch (e) {
    debugPrint(e.toString());
   }
  });
 }

 /// for otp verification
 Future<void> otpVerifiedWithPhoneNumber(verificationOTPCode) async {
  final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: otpVerificationId.value, smsCode: verificationOTPCode);
  final UserCredential userCredential =
  await _auth.signInWithCredential(credential);

  ///Get firebase user details

  }
}

class CalculationMethod {
  final String id;
  final String name;

  CalculationMethod({required this.id, required this.name});

  factory CalculationMethod.fromJson(Map<String, dynamic> json) {
    return CalculationMethod(
      id: json['id'].toString(),
      name: json['name'],
    );
  }
}
