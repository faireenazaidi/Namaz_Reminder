import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:namaz_reminders/LocationSelectionPage/locationPageController.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../Widget/appColor.dart';
import '../Widget/myButton.dart';
import '../Widget/textField.dart';
import '../Widget/text_theme.dart';


class LocationPage extends GetView<LocationPageController> {
  LocationPage({super.key});
  final LocationPageController controller = Get.put(LocationPageController());
  final TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            height: 600,
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: 10,
                image: AssetImage("assets/mecca.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Obx(() {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                height: controller.containerHeight.value,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    opacity: 9,
                    image: AssetImage("assets/net.png"),
                  ),
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: controller.step.value == 0?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      Text("Login/Signup", style: MyTextTheme.largeWCB),
                      Text("Enter your phone number to send the OTP", style: MyTextTheme.mustardS),
                      SizedBox(height: 30),
                      IntlPhoneField(
                        cursorColor: Colors.grey,
                        controller: controller.phoneController.value,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.local_phone_outlined,
                            color: Colors.white,
                          ),
                          prefix: SizedBox(width: 10),
                          hintText: "Enter  your phone number",
                          hintStyle: MyTextTheme.mediumCustomGCN,
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          counterText: "",
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        initialCountryCode: 'IN',
                        dropdownIconPosition: IconPosition.trailing,
                        dropdownTextStyle: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                        showCountryFlag: false,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                      ),
                      SizedBox(height: 20),
                      MyButton(
                        height: 60,
                        borderRadius: 10,
                        elevation: 2,
                        title: "Send OTP",
                        color: controller.isPhoneNumberValid.value
                            ? Colors.yellow
                            : AppColor.greyColor,
                        onPressed: () async{
                          controller.dynamicHeightAllocation();
                          print("Send OTP");
                        },
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          controller.toggleSecondContainer();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColor.packageGray),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/googleLogo.png"),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Log in with Google", style: MyTextTheme.smallWCB),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ):
                  controller.step.value == 1?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      if (!controller.isOtpVerified.value) ...[
                        Text("Verifying Your Account", style: MyTextTheme.largeWCB),
                        Text("Please enter the 6 digit verification code sent to", style: MyTextTheme.mustardS),
                        SizedBox(height: 40),
                        OtpTextField(
                          autoFocus: false,
                          focusedBorderColor: Colors.white,
                          numberOfFields: 6,
                          borderColor: const Color(0xFF512DA8),
                          borderWidth: 1.0,
                          showFieldAsBox: true,
                          fieldWidth: 45,
                          borderRadius: BorderRadius.circular(10),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          showCursor: false,
                          fieldHeight: 45,
                          textStyle: TextStyle(color: Colors.white),
                          onCodeChanged: ( String code) {
                            controller.isOtpFilled.value = code.length == 6;
                            if (controller.isOtpFilled.value) {
                              controller.verifyOtp(code);
                            }
                          },
                          onSubmit: (String verificationCode){
                           controller.dynamicHeightAllocation();

                          }, // end onSubmit

                        ),
                        const SizedBox(height: 20),
                        Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (controller.isOtpFilled.value) ...[
                                Text("Verifying Your OTP...", style: MyTextTheme.largeWCB),
                                SizedBox(height: 10),
                              ],
                              Text("Didn't receive an OTP?", style: MyTextTheme.smallWCN),
                              SizedBox(height: 10),
                              Obx(() {
                                final seconds = controller.secondsLeft.value;
                                final minutes = seconds ~/ 60;
                                final remainingSeconds = seconds % 60;
                                final formattedTime = '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';

                                return RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(text: "Resend OTP ", style: MyTextTheme.mediumBCb),
                                      TextSpan(text: "in ", style: MyTextTheme.smallWCN),
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.timer_outlined,
                                          size: 15,
                                          color: AppColor.circleIndicator,
                                        ),
                                      ),
                                      TextSpan(text: " $formattedTime", style: MyTextTheme.mustardSN),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          );
                        }
                        ),
                      ] else ...[
                        Center(
                          child: Text("OTP Verifying Successfully", style: MyTextTheme.largeWCB),
                        ),
                      ],
                    ],
                  ):
                  controller.step.value == 2?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30,),
                      Text("Setup your Account", style: MyTextTheme.largeWCB),
                  Text("Enter your name", style: MyTextTheme.mustardS),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("First Name",style: MyTextTheme.mediumWCN,),
                        ),
                        TextField(
                          cursorColor: AppColor.circleIndicator,
                          decoration: InputDecoration(
                            hintText: "Enter your first name",
                            hintStyle: MyTextTheme.mediumCustomGCN,
                            prefixIcon: Image.asset("assets/profile.png"),
                            fillColor: Colors.white.withOpacity(0.1),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Last Name",style: MyTextTheme.mediumWCN,),
                        ),
                      TextField(
                        cursorColor: AppColor.circleIndicator,
                        decoration: InputDecoration(
                          hintText: "Enter your first name",
                          hintStyle: MyTextTheme.mediumCustomGCN,
                          prefixIcon: Image.asset("assets/profile.png"),
                          fillColor: Colors.white.withOpacity(0.1),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    SizedBox(height: 30,),
                    MyButton(
                      height: 60,
                      borderRadius: 10,
                      elevation: 2,
                      title: "Next",
                      color: controller.isPhoneNumberValid.value
                          ? Colors.yellow
                          : AppColor.greyColor,
                      onPressed: () {
                        controller.dynamicHeightAllocation();
                        print("aaaaaaaaaaaaaaaaa");
                      },
                    ),
                        SizedBox(height: 10,)
                    ],
                  ):
                  controller.step.value == 3?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30,),
                          Text("Setup your Account", style: MyTextTheme.largeWCB),
                          Text("Select your gender", style: MyTextTheme.mustardS),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                             Obx(()=>
                    Radio<String>(
                    value:"Male",
                  activeColor: AppColor.circleIndicator,
                  groupValue: controller.selectedGender.value,
                  onChanged: (String? value){
                      controller.updateGender(value!);
                  },
                )),
                              Text("Male",style: MyTextTheme.mediumWCN,),
                              SizedBox(width: 100,),
                              Obx(()=>
                                  Radio(
                                      value: "Female",
                                    activeColor: AppColor.circleIndicator,
                                      groupValue:  controller.selectedGender.value,
                                      onChanged: (String? value){
                                        controller.updateGender(value!);
                                      },
                              )),
                              Text("Female",style: MyTextTheme.mediumWCN,)
                            ]
                          )
                        ]

                      ):

                      Column(
                        children: [

                        ],
                      )
                ),

              );
            }),
          ),


         // First animated container sliding up from the bottom
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Obx(() {
//               return AnimatedContainer(
//                 duration: const Duration(seconds: 1),
//                 curve: Curves.easeInOut,
//                 height: controller.isBottomSheetExpanded.value ? 400 : 0,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     opacity: 9,
//                     image: AssetImage("assets/net.png"),
//                   ),
//                   color: Colors.black,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(9.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 50),
//                       Text("Login/Signup", style: MyTextTheme.largeWCB),
//                       Text("Enter your phone number to send the OTP", style: MyTextTheme.mustardS),
//                       SizedBox(height: 30),
//                       IntlPhoneField(
//                         cursorColor: Colors.grey,
//                         controller: controller.phoneController.value,
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(
//                             Icons.local_phone_outlined,
//                             color: Colors.white,
//                           ),
//                           prefix: SizedBox(width: 10),
//                           hintText: "Enter  your phone number",
//                           hintStyle: MyTextTheme.mediumCustomGCN,
//                           filled: true,
//                           fillColor: Colors.grey.withOpacity(0.1),
//                           counterText: "",
//                           border: const OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                             borderSide: BorderSide(color: Colors.white),
//                           ),
//                           enabledBorder: const OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                             borderSide: BorderSide(color: Colors.white),
//                           ),
//                           focusedBorder: const OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                             borderSide: BorderSide(color: Colors.white),
//                           ),
//                         ),
//                         initialCountryCode: 'IN',
//                         dropdownIconPosition: IconPosition.trailing,
//                         dropdownTextStyle: const TextStyle(
//                           color: Colors.grey,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         showCountryFlag: false,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                         ),
//                         onChanged: (phone) {
//                           print(phone.completeNumber);
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       Obx(() {
//                         return MyButton(
//                           height: 60,
//                           borderRadius: 10,
//                           elevation: 2,
//                           title: "Send OTP",
//                           color: controller.isPhoneNumberValid.value
//                               ? Colors.yellow
//                               : AppColor.greyColor,
//                           onPressed: () {
//                             print("Send OTP");
//                           },
//                         );
//                       }),
//                       SizedBox(height: 20),
//                       InkWell(
//                         onTap: () {
//                           controller.toggleSecondContainer();
//                         },
//                         child: Container(
//                           height: 50,
//                           decoration: BoxDecoration(
//                             color: Colors.grey.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(color: AppColor.packageGray),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Image.asset("assets/googleLogo.png"),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text("Log in with Google", style: MyTextTheme.smallWCB),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//           ),
//           // Second animated container
//           Obx(() {
//             return Align(
//               alignment: Alignment.bottomCenter,
//               child: AnimatedContainer(
//                 duration: const Duration(seconds: 1),
//                 curve: Curves.easeInOut,
//                 height: controller.showSecondContainer.value ? 400 : 0,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   image: DecorationImage(image: AssetImage('assets/blacknet.png')),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 50),
//                       if (!controller.isOtpVerified.value) ...[
//                         Text("Verifying Your Account", style: MyTextTheme.largeWCB),
//                         Text("Please enter the 6 digit verification code sent to", style: MyTextTheme.mustardS),
//                         SizedBox(height: 40),
//                         OtpTextField(
//                           autoFocus: false,
//
//                           focusedBorderColor: Colors.white,
//                           numberOfFields: 6,
//                           borderColor: const Color(0xFF512DA8),
//                           borderWidth: 1.0,
//                           showFieldAsBox: true,
//                           fieldWidth: 45,
//                           borderRadius: BorderRadius.circular(10),
//                           filled: true,
//                           fillColor: Colors.grey.withOpacity(0.1),
//                           showCursor: false,
//                           fieldHeight: 45,
//                           textStyle: TextStyle(color: Colors.white),
//                           onCodeChanged: ( String code) {
//                             controller.isOtpFilled.value = code.length == 6;
//                             if (controller.isOtpFilled.value) {
//                               controller.verifyOtp(code);
//                             }
//                           },
//                           onSubmit: (String verificationCode){
//                             controller.toggleThirdContainer();
//
//                           }, // end onSubmit
//
//                         ),
//
//                         const SizedBox(height: 20),
//                         Obx(() {
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               if (controller.isOtpFilled.value) ...[
//                                 Text("Verifying Your OTP...", style: MyTextTheme.largeWCB),
//                                 SizedBox(height: 10),
//                               ],
//                               Text("Didn't receive an OTP?", style: MyTextTheme.smallWCN),
//                               SizedBox(height: 10),
//                               Obx(() {
//                                 final seconds = controller.secondsLeft.value;
//                                 final minutes = seconds ~/ 60;
//                                 final remainingSeconds = seconds % 60;
//                                 final formattedTime = '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
//
//                                 return RichText(
//                                   text: TextSpan(
//                                     children: [
//                                       TextSpan(text: "Resend OTP ", style: MyTextTheme.mediumBCb),
//                                       TextSpan(text: "in ", style: MyTextTheme.smallWCN),
//                                       WidgetSpan(
//                                         child: Icon(
//                                           Icons.timer_outlined,
//                                           size: 15,
//                                           color: AppColor.circleIndicator,
//                                         ),
//                                       ),
//                                       TextSpan(text: " $formattedTime", style: MyTextTheme.mustardSN),
//                                     ],
//                                   ),
//                                 );
//                               }),
//                             ],
//                           );
//                         }
//                         ),
//                       ] else ...[
//                         Center(
//                           child: Text("OTP Verifying Successfully", style: MyTextTheme.largeWCB),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }),
// // Third animated container
//           Obx(() {
//             return Align(
//               alignment: Alignment.bottomCenter,
//               child: AnimatedContainer(
//                 duration: const Duration(seconds: 1),
//                 curve: Curves.easeInOut,
//                 height: controller.showThirdContainer.value ? 400 : 0,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage("assets/blacknet.png")),
//                   color: Colors.black,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                       const SizedBox(height: 30),
//                   Text("Setup your Account", style: MyTextTheme.largeWCB),
//                   Text("Enter your name", style: MyTextTheme.mustardS),
//                         SizedBox(height: 20,),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text("First Name",style: MyTextTheme.mediumWCN,),
//                         ),
//                         TextField(
//                           decoration: InputDecoration(
//                             hintText: "Enter your first name",
//                             hintStyle: MyTextTheme.mediumCustomGCN,
//                             prefixIcon: Image.asset("assets/profile.png"),
//                             fillColor: Colors.white.withOpacity(0.1),
//                             filled: true,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                 color: Colors.white,
//                               ),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                 color: Colors.white,
//                                 width: 2,
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                 color: Colors.white,
//                                 width: 2,
//                               ),
//                             ),
//                           ),
//                           style: const TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text("Last Name",style: MyTextTheme.mediumWCN,),
//                         ),
//                         TextField(
//                           decoration: InputDecoration(
//                             prefixIcon: Image.asset("assets/profile.png"),
//                             hintText: "Enter your last name",
//                             hintStyle: MyTextTheme.mediumCustomGCN,
//                             fillColor: Colors.white.withOpacity(0.1),
//                             filled: true,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                 color: Colors.white,
//                               ),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                 color: Colors.white,
//                                 width: 2,
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                 color: Colors.white,
//                                 width: 2,
//                               ),
//                             ),
//                           ),
//                           style: const TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                     SizedBox(height: 20,),
//                     MyButton(
//                       height: 60,
//                       borderRadius: 10,
//                       elevation: 2,
//                       title: "Send OTP",
//                       color: controller.isPhoneNumberValid.value
//                           ? Colors.yellow
//                           : AppColor.greyColor,
//                       onPressed: () {
//                         controller.toggleFourthContainer();
//                         print("Send OTP");
//                       },
//                     ),
//                         SizedBox(height: 10,)
//
//
//
//                       ]
//                                 ),
//                 ),
//             ));
//           }),
//           Obx(() {
//             return Align(
//                 alignment: Alignment.bottomCenter,
//                 child: AnimatedContainer(
//                   duration: const Duration(seconds: 1),
//                   curve: Curves.easeInOut,
//                   height: controller.showFourthContainer.value ? 400 : 0,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage("assets/blacknet.png")),
//                     color: Colors.black,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(height: 30),
//                           Text("Setup your Account", style: MyTextTheme.largeWCB),
//                           Text("Select your gender", style: MyTextTheme.mustardS),
//                           SizedBox(height: 20,),
//
//
//
//
//
//                         ]
//                     ),
//                   ),
//                 ));
//           }),


        ],
      ),
    );
  }
}



Future<LottieComposition?> customDecoder(List<int> bytes) {
  return LottieComposition.decodeZip(bytes, filePicker: (files) {
    return files.firstWhereOrNull(
            (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'));
  });
}

