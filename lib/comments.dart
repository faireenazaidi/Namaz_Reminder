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
