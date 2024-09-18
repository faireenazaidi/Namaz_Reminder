import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
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
 RxDouble containerHeight = 400.0.obs;
 var calculationMethod = <CalculationMethod>[].obs; // All methods
 var keyCalculationMethods = <CalculationDataModal>[].obs; // Key methods (ISNA, Makkah, Tehran)
 var otherCalculationMethods = <CalculationMethod>[].obs; // Other methods

 var selectedMethod = ''.obs; // To store the selected method

 var selectedCalculationMethod = ''.obs;
 RxInt step = 0.obs;
 var selectedGender = "".obs;
 var selectedFiqh = "".obs;
 var selectedPrayer = "".obs;

 void updateGender(String gender) {
  selectedGender.value = gender;
 }

 void updateFiqh(String fiqh) {
  selectedFiqh.value = fiqh;
 }

 void updatePrayer(String pray) {
  selectedPrayer.value = pray;
 }

 RxInt secondsLeft = 60.obs;
 late Timer _timer;

 @override
 void onInit() {
  super.onInit();
   Future.delayed(const Duration(milliseconds: 300), () {
    isBottomSheetExpanded.value = true;
   });
  phoneController.value.addListener(() {
   validatePhoneNumber(phoneController.value.text);
  });
  startTimer();
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

 void startTimer() {
  _timer = Timer.periodic(Duration(seconds: 1), (timer) {
   if (secondsLeft.value > 0) {
    secondsLeft.value--;
   } else {
    _timer.cancel();
   }
  });
 }

 dynamicHeightAllocation() {
  step.value = step.value + 1;
  print("STEP VALUE ${step.value}");
  if (step.value == 1) {
   containerHeight.value = 300;
  } else if (step.value == 2) {
   containerHeight.value = 400;
  } else if (step.value == 3) {
   containerHeight.value = 400;
  } else if (step.value == 4) {
   containerHeight.value = 500;
  }
  update();
 }

 @override
 void onClose() {
  _timer.cancel();
  super.onClose();
 }


 calculationMethode() async {
  var request = http.Request(
      'GET', Uri.parse('http://172.16.58.162:8080/api/methods/'));


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


 RxInt calId = 0.obs;
 RxInt get getCalId => calId;
 set updateCalId(int val){
  calId.value = val;
  update();
 }





// fetchCalculationMethods() async {
//   final response = await http.get(Uri.parse('http://172.16.58.162:8080/api/methods/'));
//   // final response = await http.get(Uri.parse(''));
//   print('hhhhhhhhhhhhhhhhh $response');
//   if (response.statusCode == 200) {
//    final data = json.decode(response.body);
//    print('Status code: ${response.statusCode}');
//    print('Response body: ${response.body}');
//
//    // final data = json.decode(response.body);
//
//    final methodsList = data['data'] as Map<String, dynamic>;
//    print("'this:'$methodsList");
//    calculationMethods.value = methodsList.entries
//        .map((entry) => CalculationMethod(
//     id: entry.key,
//     name: entry.value['name'],
//    ))
//        .toList();
//   } else {
//    throw Exception('Failed to load calculation methods');
//   }
//  }




 // fetchCalculationMethods() async {
 //  final response = await http.get(Uri.parse('http://172.16.58.162:8080/api/methods/'));
 //  if (response.statusCode == 200) {
 //   final data = json.decode(response.body);
 //   final methodsList = data['data'] as Map<String, dynamic>;
 //
 //   calculationMethods.value = methodsList.entries
 //       .map((entry) => CalculationMethod(
 //    id: entry.key,
 //    name: entry.value['name'],
 //   ))
 //       .toList();
 //
 //   // Separate the key methods (ISNA, Makkah, Tehran) from others
 //   List<CalculationMethod> keyMethods = calculationMethods.value.where((method) {
 //    return method.name.contains('Islamic Society of North America') ||
 //        method.name.contains('Umm Al-Qura University, Makkah') ||
 //        method.name.contains('Institute of Geophysics, University of Tehran');
 //   }).toList();
 //
 //   List<CalculationMethod> otherMethods = calculationMethods.value.where((method) {
 //    return !keyMethods.contains(method);
 //   }).toList();
 //
 //   keyCalculationMethods.value = keyMethods;
 //   otherCalculationMethods.value = otherMethods;
 //
 //
 //  } else {
 //   throw Exception('Failed to load calculation methods');
 //  }
 // }


 /// Method to register use
 ///


  registerUser() async {
   Map<String,String> headers = {
    'Content-Type': 'application/json'
   };
   Map<String,dynamic> body = {
    "username": usernameC.value.toString(),
    "name": nameC.value.toString(),
    "mobile_no": phoneController.value.toString(),
    "gender": selectedGender.value.toString(),
    "fiqh": selectedFiqh.value.toString(),
    "times_of_prayer": timesOfPrayerC.value.toString(),
    "school_of_thought": schoolOfThoughtC.value.toString()
   };
   http.Response request  = await http.post(Uri.parse('http://172.16.58.162:8080/api/register/'),body:jsonEncode(body), headers:headers);
   print("@@@ REQUEST DATA ${request.body}");
  }



 ///Firebase.
 static final FirebaseAuth _auth = FirebaseAuth.instance;
 UserData userData = UserData();
 User? user = _auth.currentUser;
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
  final User? user = userCredential.user;

  if (user != null) {
   print("User UID: ${user.uid}");

   UserDetailsDataModal userDetails =
   UserDetailsDataModal.fromFirebaseUser(user);
   userData.addUserData(userDetails);
   userData.getUserData!.uid.toString();
   //
   // if (userCredential.additionalUserInfo!.isNewUser) {
   //   print("New user signed in.");
   //   // Handle new user (e.g., navigate to onboarding screen)
   // } else {
   //   print("Existing user signed in.");
   //   // Handle existing user (e.g., navigate to home screen)
   // }
  }

  // if (userCredential.additionalUserInfo!.isNewUser) {}
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
