
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:namaz_reminders/LocationSelectionPage/locationPageController.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../Widget/appColor.dart';
import '../Widget/myButton.dart';
import '../Widget/text_theme.dart';


class LocationPage extends GetView<LocationPageController> {
  const LocationPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Icon(Icons.abc,color: Colors.red,),
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
          Obx(
                  () {
                return Visibility(
                  visible: controller.step.value > 0,
                  child: Positioned(
                    top: 40,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white,),
                      onPressed: () {
                        controller.dynamicHeightAllocation(isBack: true);
                        // controller.step.value--;

                      },
                    ),
                  ),
                );
              }
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
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Login/Signup", style: MyTextTheme.largeWCB),
                                  Text("Enter your phone number to send the OTP",
                                      style: MyTextTheme.mustardS),
                                ],
                              ),
                            ),
                            Lottie.asset("assets/login.lottie",
                                decoder: customDecoder, height: 90),
                          ],
                        ),

                        const SizedBox(height: 10),
                        IntlPhoneField(
                          cursorColor: Colors.grey,
                          controller: controller.phoneController.value,
                          decoration: InputDecoration(
                            // Use Row in prefixIcon to combine phone icon and a space
                            prefixIcon: Icon(Icons.abc),
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
                          onCountryChanged: (val){
                            print("country change ${val.maxLength}");
                            controller.numberMaxLength.value=val.maxLength;
                          },
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                        ),
                        const SizedBox(height: 20),
                        MyButton(
                          height: 80,
                          borderRadius: 10,
                          elevation: 2,
                          title: "Send OTP",
                          color: controller.isPhoneNumberValid.value
                              ? AppColor.circleIndicator
                              : AppColor.greyColor,
                          onPressed: () async {
                            if(controller.isPhoneNumberValid.value){
                              controller.dynamicHeightAllocation();
                              await controller.login(controller.phoneController.value.text);
                              print("Send OTP");
                            }else
                            {
                              print("Invalid phone number");

                              Get.snackbar('Error', 'Please enter a valid phone number',
                                  snackPosition: SnackPosition.TOP,colorText: Colors.white,backgroundColor: Colors.black);
                            }

                          },
                        ),

                      ],
                    ),
                  ):

                  controller.step.value == 1?
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        if (!controller.isOtpVerified.value) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    SizedBox(height: 5,),
                                    Text("Verifying Your Account",
                                        style: MyTextTheme.largeWCB),
                                    SizedBox(height: 5,),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Enter the 6-digit verification code sent to the number ending in the last 4 digits ', // Default text
                                        style: MyTextTheme.mustardS, // Default style
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: controller.phoneController.value.text.substring(6),
                                            style: MyTextTheme.smallWCB,
                                          ),

                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              // Lottie.asset("assets/otp.lottie",
                              //     decoder: customDecoder, height: 90),
                            ],
                          ),

                          const SizedBox(height: 30),
                          PinCodeTextField(
                            autoDismissKeyboard: true, //for otp auto fill//
                            // autofillHints: [AutofillHints.oneTimeCode],
                            length: 6,
                            keyboardType: TextInputType.number,
                            autoFocus: false,
                            cursorColor: AppColor.circleIndicator,
                            animationType: AnimationType.scale,
                            showCursor: true,
                            pinTheme: PinTheme(
                              activeBorderWidth: 0,
                              selectedBorderWidth: 0,
                              inactiveBorderWidth: 0,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(10),
                              fieldHeight: 45,
                              fieldWidth: 45,
                              activeColor: Colors.white,
                              inactiveColor:Colors.white,
                              selectedColor: Colors.white,
                              selectedFillColor: Colors.grey.withOpacity(0.1),
                              inactiveFillColor: Colors.grey.withOpacity(0.1),
                              activeFillColor: Colors.grey.withOpacity(0.1),
                            ),
                            textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.normal),
                            enableActiveFill: true,
                            onChanged: (code) {
                            },
                            onCompleted: (verificationOTPCode) {
                              print("Completed OTP: $verificationOTPCode");
                              controller.otpVerification(verificationOTPCode,context); // Uncomment if using a controller
                            }, appContext: context,
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

                                  return GetBuilder<LocationPageController>(
                                      id: 'otp',
                                      builder: (_) {
                                        return InkWell(
                                          onTap: (){
                                            if(controller.isTimerRunning){

                                            }
                                            else{
                                              controller.resendOtp();
                                            }
                                          },
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                    text: "Resend OTP ",
                                                    style:controller.isTimerRunning? MyTextTheme
                                                        .mediumBCb:MyTextTheme.mustardB),
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
                                                    text: controller.formatTime(controller.start),
                                                    style: MyTextTheme
                                                        .mustardSN),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
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
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Setup your Account",
                                    style: MyTextTheme.largeWCB),
                                Text("Help us get to know you better",
                                    style: MyTextTheme.mustardB
                                ),
                              ],
                            ),
                            Lottie.asset("assets/profile.lottie",
                                decoder: customDecoder, height: 90),
                          ],
                        ),
                        const SizedBox(height: 10,),

                        Text("Name",
                          style: MyTextTheme.mediumWCN,
                        ),
                        SizedBox(height: 5,),
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
                              SizedBox(width: 50,),
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

                        const SizedBox(height: 10,),
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
                              Get.snackbar('Error', 'Please enter your name and select a gender',
                                  snackPosition: SnackPosition.TOP,colorText: Colors.white,backgroundColor: Colors.black);
                              print("Name or gender is missing");
                            }
                          },
                        ),
                      ],
                    ),
                  ):
                  controller.step.value == 3?
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
                                              style: MyTextTheme.mustardB
                                          ),
                                        ],
                                      ),
                                      Lottie.asset("assets/though.lottie",
                                          decoder: customDecoder, height: 110),
                                    ],
                                  ),
                                  Container(
                                    height: 250,
                                    child: ListView.builder(
                                      physics: AlwaysScrollableScrollPhysics(
                                          parent: BouncingScrollPhysics()
                                      ),
                                      itemCount: controller.getCalculationList.length,
                                      shrinkWrap: true,padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        print("Checkdata${controller.getCalculationList.length}");
                                        return
                                          RadioListTile(
                                              activeColor: AppColor.circleIndicator,
                                              title: Text(controller.getCalculationList[index].name.toString(),style: const TextStyle(color: Colors.white),),
                                              value: controller.getCalculationList[index].id,
                                              groupValue: controller.selectMethod['id'],
                                              onChanged: (value) {
                                                if(value!=null){
                                                  print("check method id ${controller.calculationList[index]}");
                                                  controller.updateSelectMethod(controller.calculationList[index]);
                                                }
                                                print("object1"+controller.calculationList[index]['isChecked'].toString());
                                              });

                                      },),
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),

                                  MyButton(
                                    height: 50,
                                    borderRadius: 10,
                                    title: "Next",
                                    color: AppColor.circleIndicator,
                                    onPressed: ()  async {
                                      print("#### ${controller.selectMethod['id']}");
                                      if(controller.selectMethod.isNotEmpty){
                                        if(controller.selectMethod['id'].toString()!='7' && controller.selectMethod['id'].toString()!='0'){
                                          await controller.registerUser();
                                        }
                                        else{
                                          controller.dynamicHeightAllocation();
                                        }
                                      }
                                      else{

                                        Get.snackbar('Error', 'Please select your Calculation Method',
                                            snackPosition: SnackPosition.TOP,colorText: Colors.white,backgroundColor: Colors.black);

                                      }
                                    },
                                  ),

                                ]

                            );
                          }
                      ),
                    ),
                  ):

                  controller.step.value == 4 && (controller.selectMethod['id'] == 7 || controller.selectMethod['id'] == 0)?
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
                                  Text("Select your Times of Prayer",
                                      style: MyTextTheme.mustardS
                                  ),
                                ],
                              ),
                              Lottie.asset("assets/Salah.lottie",
                                  decoder: customDecoder, height: 100),
                            ],
                          ),

                          const SizedBox(height: 20,),
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
                            title: "Submit",
                            color: AppColor.circleIndicator,
                            onPressed: () async {
                              // Validate Fiqh and Prayer Time selection
                              if (controller.selectedPrayer.value.isNotEmpty) {
                                await controller.registerUser();
                                // Proceed if both values are selected
                                // controller.calculationMethode();

                                print("Navigate to the next screen");
                              } else {
                                // Show error if either Fiqh or Prayer Time is not selected
                                Get.snackbar('Error', 'Please select your School of Thought',
                                    snackPosition: SnackPosition.TOP,colorText: Colors.white,backgroundColor: Colors.black);
                                print("Fiqh or Prayer Time is not selected");
                              }
                            },
                          ),
                          SizedBox(height: 5,)

                        ]

                    ),
                  ):
                  Column()

              );
            }),
          ),
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
