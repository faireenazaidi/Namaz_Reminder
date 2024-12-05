// ElevatedButton(
//   onPressed: (){
//     AlertDialogue().show(
//       context,
//       newWidget: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 50,),
//             Text("Login/Signup", style: MyTextTheme.largeWCB),
//             Text("Enter your phone number to send the OTP", style: MyTextTheme.mustardS),
//             Lottie.asset("assets/otp.lottie",
//               decoder: customDecoder,)
//           ],
//         ),
//
//         const SizedBox(
//           height: 30,
//         ),
//         IntlPhoneField(
//           controller: controller.phoneController.value,
//           decoration: InputDecoration(
//             prefixIcon: const Icon(Icons.local_phone_outlined,color: Colors.white,),
//             hintText: "Enter Phone Number",
//             filled: true,
//             fillColor:  Colors.grey.withOpacity(0.1),
//             counterText: "",
//             border: const OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10.0)),
//               borderSide: BorderSide(color: Colors.white),
//             ),
//             enabledBorder: const OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10.0)),
//               borderSide: BorderSide(color: Colors.white),
//             ),
//             focusedBorder: const OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10.0)),
//               borderSide: BorderSide(color: Colors.white),
//             ),
//           ),
//           initialCountryCode: 'IN',
//          // dropdownTextStyle: Colors.blue,
//           showCountryFlag: false,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//           ),
//
//           onChanged: (phone) {
//             print(phone.completeNumber);
//           },
//         ),
//         const SizedBox(height: 30,),
//         MyButton(
//           height: 60,
//           borderRadius: 10,
//           elevation: 2,
//           title: "Send OTP",
//           color: AppColor.greyColor,
//           onPressed: () {
//
//           },
//         ),
//         const SizedBox(height: 30,),
//         InkWell(
//           onTap: () {
//             // controller.signInWithGoogle();
//             // Get.toNamed(AppRoutes.locationPageRoute);
//             Get.back();
//             Verifying(context);
//             // Call the sign-in method
//             print("Jjjjjjjjjjjjjjjjjj");
//           },
//           child: Container(
//             height: 50,
//             decoration: BoxDecoration(
//               color:  Colors.grey.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: AppColor.packageGray),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset("assets/googleLogo.png"),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text("Log in with Google", style: MyTextTheme.smallGCN,),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: 50,)
//
//       ],
//     );
//
//   }, child: const Text("click"),
// ),
// Verifying(context){
//   AlertDialogue().show(
//       context,
//       newWidget: [
//         Row(
//           children: [
//             Text("Verifying Your Account",style: MyTextTheme.largeWCB,)
//           ],
//         ),
//         Row(
//           children: [
//             Expanded(
//                 child: Text("Please enter the 6 digit verfication code send to",style: MyTextTheme.mustardS,)
//             ),
//           ],
//         ),
//         const SizedBox(height: 50,),
//         OtpTextField(
//           focusedBorderColor: Colors.orange,
//           numberOfFields: 6,
//           borderColor: const Color(0xFF512DA8),
//           showFieldAsBox: true,
//           onCodeChanged: (String code) {
//           },
//           onSubmit: (String verificationCode){
//             showDialog(
//                 context: context,
//                 builder: (context){
//                   return AlertDialog(
//                     title: const Text("Verification Code"),
//                     content: Text('Code entered is $verificationCode'),
//                   );
//                 }
//             );
//           }, // end onSubmit
//         ),
//         const SizedBox(height: 20,),
//         Text("Didn't receive an OTP?",style: MyTextTheme.smallWCN,),
//         RichText(
//           text: TextSpan(
//             children: [
//               TextSpan(text: "Resend OTP  ", style: MyTextTheme.mediumBCb),
//               TextSpan(text: "in  ", style: MyTextTheme.smallBCN),
//               WidgetSpan(
//                 child: Icon(
//                   Icons.timer_outlined,
//                   size: 15,
//                   color: AppColor.buttonColor,
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//       ]
//   );
// }
///////////
// Future<bool> checkInviteStatus(int receiverId) async {
//   var headers = {'Content-Type': 'application/json'};
//   var url = 'http://182.156.200.177:8011/adhanapi/receivers/$receiverId/';
//
//   var response = await http.get(Uri.parse(url), headers: headers);
//
//   if (response.statusCode == 200) {
//     var data = jsonDecode(response.body);
//     isInvited.value = data['invited'] == true;
//     return isInvited.value;
//   } else {
//     print("Error checking invite status: ${response.statusCode}");
//     return false;
//   }
// }
// List invitedFriendList = [];
// List<RegisteredUserDataModal> get getInvitedFriendList=>
//     List<RegisteredUserDataModal>.from(
//         invitedFriendList.map((element) =>
//             RegisteredUserDataModal.fromJson(element)).toList());
//
// set updateInvitedFriendList(List val) {
//   invitedFriendList= val;
//   update();
// }
// Center(
// child:  registeredData.userId.toString() ==
// controller.getInvitedFriendList.any((invited) =>
// invited.userId.toString() == registeredData.userId.toString())
// ? Text("Invited")
//     : Text("Invite"))

// registeredData.userId.toString() == controller.getInvitedFriendList[index].userId.toString()?Text("Invited"):Text("Invite"),


// Expanded(
// child: ListView.builder(
// shrinkWrap: true,
// itemCount: controller.getRegisteredUserList.length,
// itemBuilder: (context, index) {
// RegisteredUserDataModal registeredData = controller.getRegisteredUserList[index];
// print("?????????"+registeredData.name.toString());
//
// // Assuming you have the registered user ID stored in a variable
// final int registeredUserId = controller.currentUserId; // replace with your actual variable
//
// // Check if the current registeredData userId matches the registeredUserId
// if (registeredData.userId == registeredUserId) {
// return Container(); // Return an empty container to hide this item
// }
//
// return Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// CircleAvatar(
// backgroundColor: Colors.grey,
// radius: 20,
// child: Icon(Icons.person, color: Colors.white),
// ),
// Padding(
// padding: const EdgeInsets.only(left: 12.0, top: 12),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// capitalizeFirstLetter(registeredData.name.toString()),
// style: MyTextTheme.mediumGCB.copyWith(
// fontSize: 16,
// color: Colors.black,
// fontWeight: FontWeight.bold,
// ),
// ),
// Text(
// registeredData.mobileNo.toString(),
// style: MyTextTheme.mediumGCB.copyWith(fontSize: 14),
// ),
// ],
// ),
// ),
// ],
// ),
// InkWell(
// onTap: () async {
// await controller.sendFriendRequest(registeredData);
// },
// child: Container(
// height: 30,
// width: 80,
// decoration: BoxDecoration(
// border: Border.all(color: AppColor.white),
// borderRadius: BorderRadius.circular(10),
// color: AppColor.circleIndicator,
// ),
// child: Center(
// child: Text(
// "Invite",
// style: TextStyle(color: Colors.white),
// ),
// ),
// ),
// )
// ],
// );
// },
// ),
// )


// Row(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Container(
// width: 35,
// height: 40,
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// image: registeredData.picture != null && registeredData.picture!.isNotEmpty
// ? DecorationImage(
// image: AssetImage(registeredData.picture!),
// fit: BoxFit.cover,
// )
//     : null,
// color: registeredData.picture == null || registeredData.picture!.isEmpty
// ? Colors.orange
//     : null,
// ),
// child: registeredData.picture == null || registeredData.picture!.isEmpty
// ? Icon(Icons.person, size: 20, color: Colors.white)
//     : null,
// ),
// Padding(
// padding: const EdgeInsets.only(left: 12.0, top: 12),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// capitalizeFirstLetter(registeredData.name.toString()),
// style: MyTextTheme.mediumGCB.copyWith(
// fontSize: 16,
// color: Colors.black,
// fontWeight: FontWeight.bold,
// ),
// ),
// Text(
// registeredData.mobileNo.toString(),
// style: MyTextTheme.mediumGCB.copyWith(
// fontSize: 14,
// ),
// ),
// ],
// ),
// ),
// ],
// ),
//8858336436
//
// Expanded(
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: ListView.builder(
// itemCount: dashboardController.upcomingPrayerTimes.length,
// itemBuilder: (context, index) {
// String prayerName = dashboardController.upcomingPrayers[index];
// String startTime24 = dashboardController.upcomingPrayerDuration[prayerName]?['start'] ?? 'N/A';
// String endTime24 = dashboardController.upcomingPrayerDuration[prayerName]?['end'] ?? 'N/A';
// String startTime12 = dashboardController.convertTo12HourFormat(startTime24);
// String endTime12 = dashboardController.convertTo12HourFormat(endTime24);
// return Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// decoration: BoxDecoration(
// color: AppColor.leaderboard,
// borderRadius: BorderRadius.circular(10),
// ),
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(prayerName, style: MyTextTheme.medium),
// SizedBox(height: 5),
// Row(
// children: [
// Expanded(
// child: Text('Starts at', style: MyTextTheme.smallGCN),
// ),
// Text('Ends at', style: MyTextTheme.smallGCN),
// ],
// ),
// Row(
// children: [
// Expanded(
// child: Text(
// startTime12,
// style: MyTextTheme.mediumBCD,
// ),
// ),
// Text(
// endTime12,
// style: MyTextTheme.mediumBCD,
// ),
// ],
// ),
// ],
// ),
// ),
// ),
// );
// },
// ),
// ),
// ),
// child: ListView.builder(
// itemCount: dashboardController.upcomingPrayerTimes.length,
// itemBuilder: (context, index) {
// if (index == 0) {
// String nextPrayer = dashboardController.nextPrayer.value;
// String startTime24 = dashboardController.upcomingPrayerDuration[nextPrayer]?['start'] ?? 'N/A';
// String endTime24 = dashboardController.upcomingPrayerDuration[nextPrayer]?['end'] ?? 'N/A';
// String startTime12 = dashboardController.convertTo12HourFormat(startTime24);
// String endTime12 = dashboardController.convertTo12HourFormat(endTime24);
// return Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// decoration: BoxDecoration(
// color: AppColor.lmustard,
// borderRadius: BorderRadius.circular(10),
// ),
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(nextPrayer, style: MyTextTheme.medium),
// SizedBox(height: 10),
// Container(
// width: double.infinity,
// padding: const EdgeInsets.all(8.0),
// decoration: BoxDecoration(
// color: AppColor.packageGray,
// borderRadius: BorderRadius.circular(15),
// ),
// child: Row(
// children: [
// const Icon(Icons.timer_outlined),
// SizedBox(width: 5),
// Text('starts in'),
// SizedBox(width: 5),
// Obx(() {
// return Text(
// dashboardController.remainingTime.value,
// style: MyTextTheme.smallGCN,
// );
// }),
// Spacer(),
// InkWell(
// onTap: () {
// dashboardController.toggle();
// },
// child: Obx(() {
// return SvgPicture.asset(
// dashboardController.isMute.value ? 'assets/mute.svg' : 'assets/sound.svg',
// height: 20,
// );
// }),
// ),
// ],
// ),
// ),
// SizedBox(height: 5),
// Row(
// children: [
// Expanded(
// child: Text('Starts at', style: MyTextTheme.smallGCN),
// ),
// Text('Ends at', style: MyTextTheme.smallGCN),
// ],
// ),
// Row(
// children: [
// Expanded(
// child: Text(
// startTime12,
// style: MyTextTheme.mediumBCD,
// ),
// ),
// Text(
// endTime12,
// style: MyTextTheme.mediumBCD,
// ),
// ],
// ),
// ],
// ),
// ),
// ),
// );
// }
//
// int prayerIndex = index - 1;
// String prayerName = dashboardController.upcomingPrayers[prayerIndex];
//
// if (prayerName == dashboardController.nextPrayer.value) {
// return SizedBox.shrink();
// }
//
// String startTime24 = dashboardController.upcomingPrayerDuration[prayerName]?['start'] ?? 'N/A';
// String endTime24 = dashboardController.upcomingPrayerDuration[prayerName]?['end'] ?? 'N/A';
// String startTime12 = dashboardController.convertTo12HourFormat(startTime24);
// String endTime12 = dashboardController.convertTo12HourFormat(endTime24);
//
// return Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// decoration: BoxDecoration(
// color: AppColor.leaderboard,
// borderRadius: BorderRadius.circular(10),
// ),
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(prayerName, style: MyTextTheme.medium),
// SizedBox(height: 5),
// Row(
// children: [
// Expanded(
// child: Text('Starts at', style: MyTextTheme.smallGCN),
// ),
// Text('Ends at', style: MyTextTheme.smallGCN),
// ],
// ),
// Row(
// children: [
// Expanded(
// child: Text(
// startTime12,
// style: MyTextTheme.mediumBCD,
// ),
// ),
// Text(
// endTime12,
// style: MyTextTheme.mediumBCD,
// ),
// ],
// ),
// ],
// ),
// ),
// ),
// );
// },
// ),
//////////////Profile View/////////////////////////////////
// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:namaz_reminders/Profile/profileController.dart';
// import 'package:namaz_reminders/Widget/myButton.dart';
// import 'package:namaz_reminders/Widget/text_theme.dart';
// import 'package:namaz_reminders/Widget/MyRank/myweeklyrank.dart';
// import '../AppManager/image_and_video_picker.dart';
// import '../AppManager/toast.dart';
// import '../DataModels/LoginResponse.dart';
// import '../Leaderboard/LeaderBoardController.dart';
// import '../Widget/MyRank/myRankController.dart';
// import '../Widget/appColor.dart';
//
// class ProfileView extends GetView<ProfileController> {
//   final ProfileController controller = Get.put(ProfileController());
//   final LeaderBoardController leaderBoardController = Get.put(
//       LeaderBoardController());
//   final MyRankController myRankController = Get.put(MyRankController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: Text('Edit Profile', style: MyTextTheme.mediumBCD,),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(1.0),
//           child: Divider(
//               height: 1.0,
//               color: AppColor.packageGray
//           ),
//         ),
//         leading: InkWell(
//             onTap: () {
//               Get.back();
//             },
//             child: Icon(Icons.arrow_back_ios_new, size: 20,)),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GetBuilder(
//               init: controller,
//               builder: (_) {
//                 return Column(
//                   children: [
//                     SizedBox(height: 15,),
//                     Stack(
//                         children: [ InkWell(
//                           onTap: () {
//                             _showImagePickerMenu(context);
//                           },
//                           child: Container(
//                             width: 110,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                 color: AppColor.circleIndicator,
//                                 width: 2.0,
//                               ),
//                             ),
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 50,
//                                   backgroundImage: controller.profilePhoto.isNotEmpty
//                                       ? FileImage(File(controller.profilePhoto)) // Use FileImage for local files
//                                       : controller.userData.getUserData!.picture.isNotEmpty
//                                       ? NetworkImage("http://182.156.200.177:8011${controller.userData.getUserData!.picture}")
//                                       : null, // Default to null if no profile photo is set
//                                   backgroundColor: controller.profilePhoto.isEmpty && controller.userData.getUserData!.picture.isEmpty
//                                       ? AppColor.packageGray
//                                       : Colors.transparent,
//                                   child: controller.profilePhoto.isEmpty && controller.userData.getUserData!.picture.isEmpty
//                                       ? Icon(Icons.person, size: 50, color: AppColor.circleIndicator)
//                                       : null, // Show icon only if no image is available
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                           Positioned(
//                             bottom: 0,
//                             right: 0,
//                             child: InkWell(
//                               onTap: () {
//                                 _showImagePickerMenu(context);
//                               },
//                               child: Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     // Background color of the icon
//                                     shape: BoxShape.circle,
//                                     border: Border.all(
//                                       color: AppColor.greyColor,
//                                       width: 1.0,
//                                     ),
//                                   ),
//                                   padding: EdgeInsets.all(6),
//                                   child: SvgPicture.asset("assets/cam.svg")
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             bottom: 65,
//                             left: 70,
//                             child: Stack(
//                               children: [
//                                 SvgPicture.asset(
//                                   myRankController.rank == 1 ? 'assets/Gold.svg'
//                                       : myRankController.rank == 2
//                                       ? 'assets/silver.svg'
//                                       :
//                                   myRankController.rank == 3
//                                       ? 'assets/Bronze.svg'
//                                       : 'assets/other.svg', height: 40,),
//                                 Positioned(
//                                   right: 16,
//                                   top: 11,
//                                   child: Column(
//                                     children: [
//                                       Center(
//                                         child: MyRank(
//                                           rankedFriends: leaderBoardController
//                                               .weeklyRanked,
//                                           textSize: 16,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ]
//                     ),
//                     SizedBox(height: 20),
//                     Padding(
//                       padding: const EdgeInsets.all(7.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Full Name", style: MyTextTheme.mediumGCB,),
//                           TextFormField(
//                             controller: controller.nameC,
//                             cursorColor: AppColor.circleIndicator,
//                             decoration: InputDecoration(
//                               hintText: "Enter your full name",
//                               hintStyle: MyTextTheme.mediumCustomGCN,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(
//                                   color: AppColor.packageGray,
//                                 ),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(
//                                   color: AppColor.packageGray,
//                                   width: 1,
//                                 ),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: const BorderSide(
//                                   color: Colors.grey,
//                                   width: 1,
//                                 ),
//                               ),
//                             ),
//                             style: const TextStyle(
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(7.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("User Name", style: MyTextTheme.mediumGCB,),
//                           TextFormField(
//                             controller: controller.userNameC,
//                             enabled: false,
//                             cursorColor: AppColor.circleIndicator,
//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: AppColor.leaderboard,
//                               hintText: "User name",
//                               hintStyle: MyTextTheme.mediumCustomGCN,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(
//                                   color: AppColor.packageGray,
//                                 ),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(
//                                   color: AppColor.packageGray,
//                                   width: 1,
//                                 ),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: const BorderSide(
//                                   color: Colors.grey,
//                                   width: 1,
//                                 ),
//                               ),
//                             ),
//                             style: const TextStyle(
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text("Gender",
//                             style: MyTextTheme.mediumGCB,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Row(
//                         children: [
//                           Radio<String>(
//                             value: "0",
//                             activeColor: AppColor.circleIndicator,
//                             groupValue: controller.genderC.text,
//                             onChanged: (String? value) {
//                               controller.updateGender(value!);
//                             },
//                           ),
//                           Text("Male",
//                             style: MyTextTheme.mediumGCB,
//                           ),
//                           const SizedBox(width: 50,),
//
//                           Radio(
//                             value: "1",
//                             activeColor: AppColor.circleIndicator,
//                             groupValue: controller.genderC.text,
//                             onChanged: (String? value) {
//                               print(value);
//                               controller.updateGender(value!);
//                             },
//                           ),
//                           InkWell(
//                               onTap: () {
//                               },
//                               child: Text("Female",
//                                 style: MyTextTheme.mediumGCB,
//                               ))
//                         ]
//                     ),
//
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Phone Number", style: MyTextTheme.mediumGCB,),
//                           TextField(
//                             controller: controller.phoneC,
//                             cursorColor: AppColor.circleIndicator,
//                             readOnly: true,
//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: AppColor.leaderboard,
//                               hintText: "Enter your phone number",
//                               hintStyle: MyTextTheme.mediumCustomGCN,
//                               prefixIcon: SvgPicture.asset(
//                                 "assets/call.svg", fit: BoxFit.scaleDown,),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(
//                                   color: AppColor.packageGray,
//                                 ),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(
//                                   color: AppColor.packageGray,
//                                   width: 1,
//                                 ),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(
//                                   color: AppColor.packageGray,
//                                   width: 1,
//                                 ),
//                               ),
//                             ),
//                             style: const TextStyle(
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Email", style: MyTextTheme.mediumGCB,),
//                           TextField(
//                             controller: controller.mailC,
//                             cursorColor: AppColor.circleIndicator,
//                             decoration: InputDecoration(
//                               hintText: "Enter your email",
//                               hintStyle: MyTextTheme.mediumCustomGCN,
//                               prefixIcon: Icon(
//                                 Icons.email_outlined, color: AppColor.greyColor,
//                                 size: 20,),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(
//                                   color: AppColor.packageGray,
//                                   width: 1,
//                                 ),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: const BorderSide(
//                                   color: Colors.grey,
//                                   width: 1,
//                                 ),
//                               ),
//                             ),
//                             style: const TextStyle(
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("School of Thought",
//                               style: MyTextTheme.mediumGCB),
//                           Container(
//                             padding: EdgeInsets.symmetric(horizontal: 10.0),
//                             decoration: BoxDecoration(
//                               border: Border.all(color: AppColor.packageGray,),
//                               // Border color
//                               borderRadius: BorderRadius.circular(
//                                   10.0),
//                             ),
//                             child: DropdownButton<String>(
//                               dropdownColor: Colors.white,
//                               value: controller.schoolOFThought['id']
//                                   .toString(),
//                               isExpanded: true,
//                               underline: SizedBox(),
//                               // Removes default underline
//                               hint: Text(
//                                 "Select an institute",
//                                 style: MyTextTheme.mediumCustomGCN,
//                               ),
//                               menuMaxHeight: MediaQuery
//                                   .of(context)
//                                   .size
//                                   .height * 0.50,
//                               // itemHeight: 40.0,
//                               items: controller.calculationList.map<
//                                   DropdownMenuItem<String>>((value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value['id'].toString(),
//                                   // Use 'id' as the value
//                                   child: Text(value['name'].toString(),
//                                       style: const TextStyle(color: Colors.grey,
//                                           fontSize: 14)),
//                                 );
//                               }).toList(),
//                               onChanged: (value) {
//                                 controller.selectSchool(value.toString());
//                                 print("Selected value: $value");
//                               },
//                             ),
//                           ),
//                           if (controller.schoolOFThought['id'].toString() ==
//                               '7' || controller.schoolOFThought['id']
//                               .toString() == '0')
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const SizedBox(height: 10,),
//                                 Text("Times of Prayer",
//                                   style: MyTextTheme.mediumGCB,),
//                                 Row(
//                                     children: [
//                                       Obx(() =>
//                                           Radio<String>(
//                                             value: "3",
//                                             activeColor: AppColor
//                                                 .circleIndicator,
//                                             groupValue: controller
//                                                 .selectedPrayer.value,
//                                             onChanged: (String? value) {
//                                               controller.selectedPrayer(value!);
//                                             },
//                                           )),
//                                       Text("3",
//                                         style: MyTextTheme.mediumGCB,
//                                       ),
//                                       const SizedBox(width: 130,),
//                                       Obx(() =>
//                                           Radio(
//                                             value: "5",
//                                             activeColor: AppColor
//                                                 .circleIndicator,
//                                             groupValue: controller
//                                                 .selectedPrayer.value,
//                                             onChanged: (String? value) {
//                                               controller.selectedPrayer(value!);
//                                             },
//                                           )),
//                                       InkWell(
//                                           onTap: () {
//                                           },
//                                           child: Text("5",
//                                             style: MyTextTheme.mediumGCB,
//                                           ))
//                                     ]
//                                 ),
//                               ],
//                             ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 20,),
//                     MyButton(
//                       borderRadius: 10,
//                       onPressed: () {
//                         if (controller.nameC.text.isEmpty) {
//                           Get.snackbar(
//                             'Error',
//                             'Please enter your name',
//                             snackPosition: SnackPosition.TOP,
//                             backgroundColor: Colors.black,
//                             colorText: Colors.white,
//                           );
//                         }
//                         else {
//                           controller
//                               .registerUser(); // Call the registerUser method from the controller
//                         }
//                       },
//                       title: 'Update', // Button label
//                       color: AppColor.circleIndicator, // Button color
//                     ),
//
//                     SizedBox(height: 10,)
//                   ],
//                 );
//               }
//           ),
//         ),
//       ),
//     );
//   }
//
// // Method to open camera or gallery
// //   Future<void> _showImagePickerMenu(BuildContext context) async {
// //     showModalBottomSheet(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return SafeArea(
// //           child: Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: Wrap(
// //               children: [
// //                 ListTile(
// //                   leading: Icon(Icons.photo_camera,),
// //                   title: Text('Take a picture'),
// //                   onTap: () async {
// //                     Navigator.of(context).pop(); // Close the menu
// //                     final file =await MyImagePicker.pickImage(isFromCam: true);
// //                     print("file $file");
// //                     controller.updateProfilePhoto(file);
// //                     var headers = {
// //                       'Cookie': 'csrftoken=yQZryaCTtTmYrYdjA6ZZSxgbPfJJlNft'
// //                     };
// //                     var request = http.MultipartRequest('PUT', Uri.parse('http://182.156.200.177:8011/adhanapi/update-user/'));
// //                     request.fields.addAll({
// //                       'user_id': controller.userData.getUserData!.id.toString()
// //                     });
// //                     request.files.add(await http.MultipartFile.fromPath('picture', controller.profilePhoto));
// //                     request.headers.addAll(headers);
// //
// //                     http.StreamedResponse response = await request.send();
// //
// //                     if (response.statusCode == 200) {
// //                       // print(await response.stream.bytesToString());
// //                       final data = await response.stream.bytesToString();
// //                       final myData =await jsonDecode(data);
// //                       final userModel = UserModel.fromJson(myData['user']);
// //                       await controller.userData.addUserData(userModel);
// //                       showToast(msg: 'Photo Updated');
// //                     }
// //                     else {
// //                       print(response.reasonPhrase);
// //                     }
// //                     // final pickedFile = await _picker.pickImage(source: ImageSource.camera);
// //                     // setState(() {
// //                     //   _imageFile = pickedFile;
// //                     // });
// //                   },
// //                 ),
// //                 ListTile(
// //                   leading: Icon(Icons.photo_library,),
// //                   title: Text('Choose from gallery'),
// //                   onTap: () async {
// //                     print("UISer"+controller.userData.getUserData!.id.toString());
// //                     Navigator.of(context).pop(); // Close the menu
// //                     final file = await MyImagePicker.pickImage(isFromCam: false);
// //                     controller.updateProfilePhoto(file);
// //                     var headers = {
// //                       'Cookie': 'csrftoken=yQZryaCTtTmYrYdjA6ZZSxgbPfJJlNft'
// //                     };
// //                     var request = http.MultipartRequest('PUT', Uri.parse('http://182.156.200.177:8011/adhanapi/update-user/'));
// //                     request.fields.addAll({
// //                       'user_id': controller.userData.getUserData!.id.toString()
// //                     });
// //                     request.files.add(await http.MultipartFile.fromPath('picture', controller.profilePhoto));
// //                     request.headers.addAll(headers);
// //
// //                     http.StreamedResponse response = await request.send();
// //
// //                     if (response.statusCode == 200) {
// //                       final data =await (response.stream.bytesToString());
// //                      final myData =await jsonDecode(data);
// //                       final userModel = UserModel.fromJson(myData['user']);
// //                       await controller.userData.addUserData(userModel);
// //                       showToast(msg: 'Photo Updated');
// //                     }
// //                     else {
// //                       print("Response"+response.reasonPhrase.toString());
// //                     }
// //                     // final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
// //                     // setState(() {
// //                     //   _imageFile = pickedFile;
// //                     // });
// //                   },
// //                 ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
//   Future<void> _showImagePickerMenu(BuildContext context) async {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Wrap(
//               children: [
//                 ListTile(
//                   leading: Icon(Icons.photo_camera),
//                   title: Text('Take a picture'),
//                   onTap: () async {
//                     Navigator.of(context).pop();
//                     final file = await MyImagePicker.pickImage(isFromCam: true);
//                     if (file != null) {
//                       await _updateProfilePhoto(file);
//                     }
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.photo_library),
//                   title: Text('Choose from gallery'),
//                   onTap: () async {
//                     Navigator.of(context).pop();
//                     final file = await MyImagePicker.pickImage(
//                         isFromCam: false);
//                     if (file != null) {
//                       await _updateProfilePhoto(file);
//                     }
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.delete, color: Colors.red),
//                   title: Text('Remove image'),
//                   enabled: controller.userData.getUserData!.picture.isNotEmpty,
//                   onTap: controller.userData.getUserData!.picture.isNotEmpty
//                       ? () async {
//                     Navigator.of(context).pop();
//                     await _removeProfilePhoto();
//                   }
//                       : null,
//                 ),
//
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> _updateProfilePhoto(String filePath) async {
//     controller.updateProfilePhoto(filePath);
//
//
//     var headers = {
//       'Cookie': 'csrftoken=yQZryaCTtTmYrYdjA6ZZSxgbPfJJlNft',
//     };
//     var request = http.MultipartRequest(
//       'PUT',
//       Uri.parse('http://182.156.200.177:8011/adhanapi/update-user/'),
//     );
//
//     request.fields['user_id'] = controller.userData.getUserData!.id.toString();
//     request.files.add(await http.MultipartFile.fromPath('picture', filePath));
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       final data = await response.stream.bytesToString();
//       final myData = jsonDecode(data);
//       final userModel = UserModel.fromJson(myData['user']);
//       await controller.userData.addUserData(userModel);
//       showToast(msg: 'Photo Updated',bgColor: Colors.black);
//     } else {
//       print("Error: ${response.reasonPhrase}");
//     }
//   }
//   Future<void> _removeProfilePhoto() async {
//     var headers = {
//       'Cookie': 'csrftoken=yQZryaCTtTmYrYdjA6ZZSxgbPfJJlNft',
//     };
//     var request = http.MultipartRequest(
//       'PUT',
//       Uri.parse('http://182.156.200.177:8011/adhanapi/update-user/'),
//     );
//     request.fields['user_id'] = controller.userData.getUserData!.id.toString();
//     request.fields['picture'] = '';
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       final data = await response.stream.bytesToString();
//       final myData = jsonDecode(data);
//       final userModel = UserModel.fromJson(myData['user']);
//       await controller.userData.addUserData(userModel);
//       controller.update();
//       showToast(msg: 'Photo Removed');
//       _updateProfilePhoto("");
//     }
//     else
//     {
//       print("Error: ${response.reasonPhrase}");
//     }
//   }
// }
