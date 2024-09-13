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