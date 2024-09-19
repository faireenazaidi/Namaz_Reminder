import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:namaz_reminders/LocationSelectionPage/locationPageController.dart';
import 'package:namaz_reminders/Routes/approutes.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../AppManager/toast.dart';
import '../DashBoard/dashboardView.dart';
import '../Widget/appColor.dart';
import '../Widget/myButton.dart';
import '../Widget/myCustomeSd.dart';
import '../Widget/radio_menu.dart';
import '../Widget/textField.dart';
import '../Widget/text_theme.dart';


class LocationPage extends GetView<LocationPageController> {
  const LocationPage({super.key});
  // final LocationPageController controller = Get.put(LocationPageController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            height: 650,
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
                decoration:  BoxDecoration(
                  image: const DecorationImage(
                    opacity: 9,
                    image: AssetImage("assets/net.png"),
                    fit: BoxFit.cover
                  ),
                  color:AppColor.gray,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: controller.step.value == 0?
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Login/Signup", style: MyTextTheme.largeWCB),
                              Text("Enter your phone number to send the OTP",
                                  style: MyTextTheme.mustardS),
                            ],
                          ),
                          Lottie.asset("assets/login.lottie",
                              decoder: customDecoder, height: 80),
                        ],
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text("Login/Signup", style: MyTextTheme.largeWCB),
                      //     Row(
                      //       children: [
                      //         Text("Enter your phone number to send the OTP",
                      //             style: MyTextTheme.mustardS),
                      //         SizedBox(width: 20), // This space is only between the text and the Lottie animation
                      //         Column(
                      //           crossAxisAlignment: CrossAxisAlignment.end,
                      //           children: [
                      //             Lottie.asset("assets/login.lottie",
                      //                 decoder: customDecoder, height: 80),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),




                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IntlPhoneField(
                          cursorColor: Colors.grey,
                          controller: controller.phoneController.value,
                          decoration: InputDecoration(
                            // Use Row in prefixIcon to combine phone icon and a space
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min, // Ensures it takes the minimum width necessary
                                children: [
                                  Icon(
                                    Icons.local_phone_outlined, // Phone icon
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8), // Spacing between icon and the rest of the field
                                ],
                              ),
                            ),
                            hintText: "Enter your phone number",
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
                      ),

                      const SizedBox(height: 20),
                      MyButton(
                        height: 60,
                        borderRadius: 10,
                        elevation: 2,
                        title: "Send OTP",
                        color: controller.isPhoneNumberValid.value
                            ? AppColor.circleIndicator
                            : AppColor.greyColor,
                        onPressed: () async {
                          if(controller.isPhoneNumberValid.value){
                           await controller.login(controller.phoneController.value.text);
                           print("Send OTP");
                           controller.dynamicHeightAllocation();
                          }else{
                            print("Invalid phone number");
                            Get.snackbar('Error', 'Please enter a valid phone number',
                                  snackPosition: SnackPosition.BOTTOM);
                          }


                          // if (controller.isPhoneNumberValid.value) {
                          //   // Proceed with signing in if the phone number is valid
                          //   await controller.signInWithPhoneNumber();
                          //   controller.dynamicHeightAllocation();
                          //   print("Send OTP");
                          // } else {
                          //   // If the phone number is invalid or null, show an error or prevent navigation
                          //   print("Invalid phone number");
                          //   Get.snackbar('Error', 'Please enter a valid phone number',
                          //       snackPosition: SnackPosition.TOP);
                          // }
                        },
                      ),

                      const SizedBox(height: 10,),
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                              indent: 50,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "or",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                              endIndent: 50,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          showToast(msg: 'Coming Soon');
                          // controller.toggleSecondContainer();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border:
                            Border.all(color: AppColor.packageGray),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/googleLogo.png"),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Log in with Google",
                                    style: MyTextTheme.smallWCB),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ):
                controller.step.value == 1?
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      if (!controller.isOtpVerified.value) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(controller.otp.toString(),style: TextStyle(color: Colors.white),),
                                Text("Verifying Your Account",
                                    style: MyTextTheme.largeWCB),
                                Text(
                                               "Please enter the 6 digit verification code",
                                              style: MyTextTheme.mustardS),
                              ],
                            ),
                            Lottie.asset("assets/otp.lottie",
                                decoder: customDecoder, height: 90),
                          ],
                        ),
                        // Column(
                        //   children: [
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text("Verifying Your Account",
                        //             style: MyTextTheme.largeWCB),
                        //         Lottie.asset("assets/otp.lottie",
                        //             decoder: customDecoder, height: 80),
                        //       ],
                        //     ),
                        //
                        //     Row(
                        //       children: [
                        //         Text(
                        //             "Please enter the 6 digit verification code",
                        //             style: MyTextTheme.mustardS),
                        //       ],
                        //     ),
                        //   ],
                        // ),




                        const SizedBox(height: 30),
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
                          textStyle: const TextStyle(color: Colors.white),
                          onCodeChanged: (String code) {
                            // controller.isOtpFilled.value =
                            //     code.length == 6;
                            // if (controller.isOtpFilled.value) {
                            //   controller.verifyOtp(code);
                            // }
                          },
                          onSubmit: (String verificationOTPCode) {
                            // controller.otpVerifiedWithPhoneNumber(verificationOTPCode);
                          controller.otpVerification(verificationOTPCode);


                          }, // end onSubmit
                        ),
                        const SizedBox(height: 20),
                        Obx(() {
                          return Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              if (controller.isOtpFilled.value) ...[
                                Text("Verifying Your OTP...",
                                    style: MyTextTheme.largeWCB),
                                const SizedBox(height: 10),
                              ],
                              Text("Didn't receive an OTP?",
                                  style: MyTextTheme.smallWCN),
                              const SizedBox(height: 10),
                              Obx(() {
                                final seconds =
                                    controller.secondsLeft.value;
                                final minutes = seconds ~/ 60;
                                final remainingSeconds =
                                    seconds % 60;
                                final formattedTime =
                                    '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';

                                return RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "Resend OTP ",
                                          style: MyTextTheme
                                              .mediumBCb),
                                      TextSpan(
                                          text: "in ",
                                          style:
                                          MyTextTheme.smallWCN),
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.timer_outlined,
                                          size: 15,
                                          color: AppColor
                                              .circleIndicator,
                                        ),
                                      ),
                                      TextSpan(
                                          text: " $formattedTime",
                                          style: MyTextTheme
                                              .mustardSN),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          );
                        }),
                      ] else ...[
                        Center(
                          child: Text("OTP Verifying Successfully",
                              style: MyTextTheme.largeWCB),
                        ),
                      ],
                    ],
                  ),
                ):
                controller.step.value == 2?
                // Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       SizedBox(height: 30,),
                //       Text("Setup your Account", style: MyTextTheme.largeWCB),
                //       Text("Select your gender", style: MyTextTheme.mustardS),
                //       SizedBox(height: 20,),
                //       Row(
                //           children: [
                //             Obx(()=>
                //                 Radio<String>(
                //                   value:"Male",
                //                   activeColor: AppColor.circleIndicator,
                //                   groupValue: controller.selectedGender.value,
                //                   onChanged: (String? value){
                //                     controller.updateGender(value!);
                //                   },
                //                 )),
                //             Text("Male",style: MyTextTheme.mediumWCN,),
                //             SizedBox(width: 100,),
                //             Obx(()=>
                //                 Radio(
                //                   value: "Female",
                //                   activeColor: AppColor.circleIndicator,
                //                   groupValue:  controller.selectedGender.value,
                //                   onChanged: (String? value){
                //                     controller.updateGender(value!);
                //                   },
                //                 )),
                //             InkWell(
                //                 onTap:(){
                //                   controller.dynamicHeightAllocation();
                //                 },
                //                 child: Text("Female",style: MyTextTheme.mediumWCN,))
                //           ]
                //       )
                //     ]
                //
                // ):
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Setup your Account",
                                  style: MyTextTheme.largeWCB),
                              Text("Help us get to know you better",
                                  style: MyTextTheme.mustardS
                              ),
                            ],
                          ),
                          Lottie.asset("assets/profile.lottie",
                              decoder: customDecoder, height: 80),
                        ],
                      ),
                      const SizedBox(height: 20,),




                      Text("Name",
                        style: MyTextTheme.mediumWCN,
                      ),
                      TextField(
                        controller: controller.nameC.value,
                        cursorColor: AppColor.circleIndicator,
                        decoration: InputDecoration(
                          hintText: "Enter your name",
                          hintStyle: MyTextTheme.mediumCustomGCN,
                          // prefixIcon: Image.asset("asset/profile.png"),
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
                        child: Text("Gender",
                          style: MyTextTheme.mediumWCN,
                        ),
                      ),
                      Row(
                          children: [
                            Obx(()=>
                                Radio<String>(
                                  value:"0",
                                  activeColor: AppColor.circleIndicator,
                                  groupValue: controller.selectedGender.value,
                                  onChanged: (String? value){
                                    controller.updateGender(value!);
                                  },
                                )),
                            Text("Male",
                              style: MyTextTheme.mediumWCN,
                            ),
                            const SizedBox(width: 100,),
                            Obx(()=>
                                Radio(
                                  value: "1",
                                  activeColor: AppColor.circleIndicator,
                                  groupValue:  controller.selectedGender.value,
                                  onChanged: (String? value){
                                    controller.updateGender(value!);
                                  },
                                )),
                            InkWell(
                                onTap:(){
                                  // Get.toNamed(AppRoutes.dashboardRoute);
                                },
                                child: Text("Female",
                                  style: MyTextTheme.mediumWCN,
                                ))
                          ]
                      ),

                      const SizedBox(height: 30,),
                      MyButton(
                        height: 50,
                        borderRadius: 10,
                        title: "Next",
                        color: AppColor.circleIndicator,
                        onPressed: () {
                          // Check if both name and gender are filled
                          if (controller.nameC.value.text.isNotEmpty && controller.selectedGender.value.isNotEmpty) {
                            // Proceed with navigation or other logic
                            controller.dynamicHeightAllocation();
                            print("Navigate to the next screen");
                          } else {
                            // Show an error message if either name or gender is not selected
                            Get.snackbar('Error', 'Please enter your name and select a gender',
                                snackPosition: SnackPosition.TOP);
                            print("Name or gender is missing");
                          }
                        },
                      ),
                      const SizedBox(height: 10,)
                    ],
                  ),
                ):
                controller.step.value == 3?

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Setup your Account",
                                    style: MyTextTheme.largeWCB),
                                Text("Select your School of Thought",
                                    style: MyTextTheme.mustardS
                                ),
                              ],
                            ),
                            Lottie.asset("assets/Salah.lottie",
                                decoder: customDecoder, height: 100),
                          ],
                        ),

                        const SizedBox(height: 20,),
                        Text('Fiqh',style: MyTextTheme.mediumWCN,),
                        const SizedBox(height: 10,),
                        Row(
                            children: [
                              Obx(()=>
                                  Radio<String>(
                                    value:'0',
                                    activeColor: AppColor.circleIndicator,
                                    groupValue: controller.selectedFiqh.value,
                                    onChanged: (value){
                                      print(value);
                                      controller.selectedFiqh(value!);
                                    },
                                  )),
                              Text("Shia",
                                style: MyTextTheme.mediumWCN,
                              ),
                              const SizedBox(width: 100,),
                              Obx(()=>
                                  Radio(
                                    value: '1',
                                    activeColor: AppColor.circleIndicator,
                                    groupValue:  controller.selectedFiqh.value,
                                    onChanged: (value){
                                      controller.selectedFiqh(value!);
                                    },
                                  )),
                              InkWell(
                                  onTap:(){
                                    // Get.toNamed(AppRoutes.dashboardRoute);
                                  },
                                  child: Text("Sunni",
                                    style: MyTextTheme.mediumWCN,
                                  ))
                            ]
                        ),
                        const SizedBox(height: 10,),
                        Text('Times of Prayer',style:  MyTextTheme.mediumWCN,),
                        const SizedBox(height: 10,),
                        Row(
                            children: [
                              Obx(()=>
                                  Radio<String>(
                                    value:"3",
                                    activeColor: AppColor.circleIndicator,
                                    groupValue: controller.selectedPrayer.value,
                                    onChanged: (String? value){
                                      controller.selectedPrayer(value!);
                                    },
                                  )),
                              Text("3",
                                style: MyTextTheme.mediumWCN,
                              ),
                              const SizedBox(width: 130,),
                              Obx(()=>
                                  Radio(
                                    value: "5",
                                    activeColor: AppColor.circleIndicator,
                                    groupValue:  controller.selectedPrayer.value,
                                    onChanged: (String? value){
                                      controller.selectedPrayer(value!);
                                    },
                                  )),
                              InkWell(
                                  onTap:(){
                                    // Get.toNamed(AppRoutes.dashboardRoute);
                                  },
                                  child: Text("5",
                                    style: MyTextTheme.mediumWCN,
                                  ))
                            ]
                        ),
                        const SizedBox(height: 20,),
                        MyButton(
                          height: 50,
                          borderRadius: 10,
                          title: "Next",
                          color: AppColor.circleIndicator,
                          onPressed: () {
                            // Validate Fiqh and Prayer Time selection
                            if (controller.selectedFiqh.value.isNotEmpty && controller.selectedPrayer.value.isNotEmpty) {
                              // Proceed if both values are selected
                              // controller.calculationMethode();
                              controller.dynamicHeightAllocation();
                              print("Navigate to the next screen");
                            } else {
                              // Show error if either Fiqh or Prayer Time is not selected
                              Get.snackbar('Error', 'Please select your Fiqh and Times of Prayer',
                                  snackPosition: SnackPosition.TOP);
                              print("Fiqh or Prayer Time is not selected");
                            }
                          },
                        ),

                      ]

                  ),
                ):


                controller.step.value == 4?

                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    child: GetBuilder(
                      init: LocationPageController(),
                      builder: (_) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Setup your Account",
                                        style: MyTextTheme.largeWCB),
                                    Text("Select your Calculation Method",
                                        style: MyTextTheme.mustardS
                                    ),
                                  ],
                                ),
                                Lottie.asset("assets/though.lottie",
                                    decoder: customDecoder, height: 100),
                              ],
                            ),
                            // Obx(() {
                            //   if (controller.calculationMethods.isEmpty) {
                            //     return Center(child: CircularProgressIndicator());
                            //   } else {
                            //     // Split methods into two lists
                            //     final radioMethods = controller.calculationMethods.take(3).toList();
                            //     final dropdownMethods = controller.calculationMethods.skip(3).toList();
                            //
                            //     return Column(
                            //       children: [
                            //         // Display first three methods as radio buttons
                            //         Column(
                            //           children: radioMethods.map((method) {
                            //             return RadioListTile<String>(
                            //               title: Text(method.name),
                            //               value: method.id,
                            //               groupValue: controller.selectedCalculationMethod.value,
                            //               onChanged: (value) {
                            //                 controller.selectedCalculationMethod.value = value!;
                            //               },
                            //             );
                            //           }).toList(),
                            //         ),
                            //         // Display remaining methods in a dropdown
                            //         if (dropdownMethods.isNotEmpty)
                            //           DropdownButton<String>(
                            //             hint: Text('Select a calculation method'),
                            //             value: controller.selectedCalculationMethod.value.isEmpty
                            //                 ? null
                            //                 : controller.selectedCalculationMethod.value,
                            //             onChanged: (String? newValue) {
                            //               controller.selectedCalculationMethod.value = newValue!;
                            //             },
                            //             items: dropdownMethods.map((method) {
                            //               return DropdownMenuItem<String>(
                            //                 value: method.id,
                            //                 child: Text(method.name),
                            //               );
                            //             }).toList(),
                            //           ),
                            //
                            //       ],
                            //     );
                            //   }
                            // }),

                            Container(
                              height: 200,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.getCalculationList.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  print("Checkdata${controller.getCalculationList.length}");
                                  return
                                    Visibility(
                                      visible: controller.getCalculationList[index].id==2|| controller.getCalculationList[index].id==4|| controller.getCalculationList[index].id==7,
                                      child: RadioListTile(
                                        title: Text(controller.getCalculationList[index].name.toString(),style: const TextStyle(color: Colors.white),),
                                        value: controller.getCalculationList[index].id,
                                        groupValue: controller.selectMethod['id'],
                                        onChanged: (value) {
                                          if(value!=null){
                                            print("check method id ${controller.calculationList[index]}");
                                             controller.updateSelectMethod(controller.calculationList[index]);
                                          }
                                          // print("object${controller.calculationList[index]['isChecked']}");
                                          // for(int i=0;i<controller.getCalculationList.length;i++){
                                          //   if(i==index){
                                          //     if(controller.calculationList[index]['isChecked']==0){
                                          //       controller.calculationList[index]['isChecked'] = 1;
                                          //     }else{
                                          //       controller.calculationList[index]['isChecked'] = 0;
                                          //     }
                                          //   }else{
                                          //     controller.calculationList[index]['isChecked'] = 0;
                                          //   }
                                          // }

                                          print("object1"+controller.calculationList[index]['isChecked'].toString());
                                          }),
                                    );

                                },),
                            ),
                            const SizedBox(height: 20,),
                            MyCustomSD(
                              listToSearch:controller.calculationList,
                              valFrom: 'name',
                              onChanged: (value) {
                                if(value!=null){
                                  print("method values $value");
                                  controller.updateSelectMethod(value);
                                  // controller.updateCalId = value['id'];
                                  // print("GetMethodId: ${controller.getCalId.toString()}");
                                  print(value);
                                }

                              },),






                            // Obx(() {
                            //   return Row(
                            //     children: controller.keyCalculationMethods.map((method) {
                            //       print('hhh:$method');
                            //       return RadioListTile(
                            //         title: Text(method.name!),
                            //         value: method.id,
                            //         groupValue: controller.selectedMethod.value,
                            //         onChanged: (value) {
                            //           print("method value ${value}");
                            //           //controller.selectedMethod.value = value;
                            //         },
                            //       );
                            //     }).toList(),
                            //   );
                            // }),
                            // Obx(() {
                            //   return DropdownButton<String>(
                            //     value: controller.selectedMethod.value,
                            //     items: controller.otherCalculationMethods.map((method) {
                            //       return DropdownMenuItem(
                            //         value: method.id,
                            //         child: Text(method.name),
                            //       );
                            //     }).toList(),
                            //     onChanged: (value) {
                            //       controller.selectedMethod.value = value!;
                            //     },
                            //   );
                            // }),
                            SizedBox(
                              height: 20,
                            ),


                            MyButton(
                              height: 50,
                              borderRadius: 10,
                              // elevation: 2,
                              title: "Next",
                              color: AppColor.circleIndicator,
                              //color:controller.nameC.value.text.toString().isEmpty?AppColor.greyColor:AppColor.circleIndicator,
                              // color: controller.name.value
                              //     ? AppColor.circleIndicator
                              //     : AppColor.greyColor,
                              onPressed: ()  async {
                                if(controller.selectMethod.isNotEmpty){
                                  await controller.registerUser();
                                }
                              },
                            ),

                          ]

                        );
                      }
                    ),
                  ),
                ):
                    const Column(

                    )

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

