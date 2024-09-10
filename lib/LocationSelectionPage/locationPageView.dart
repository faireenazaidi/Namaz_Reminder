import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:namaz_reminders/LocationSelectionPage/locationPageController.dart';

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
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: 10,
                image: AssetImage("assets/mecca.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Animated container sliding up from the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: const Duration(seconds:1),
              curve: Curves.easeInOut,
              height: controller.isBottomSheetExpanded.value ? 400 : 0,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  opacity: 9,
                    image: AssetImage("assets/net.png")
                ),
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child:  Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 50,),
                            Text("Login/Signup", style: MyTextTheme.largeWCB),
                            Text("Enter your phone number to send the OTP", style: MyTextTheme.mustardS),
                            SizedBox(height: 30,),
                            IntlPhoneField(
                controller: controller.phoneController.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.local_phone_outlined,color: Colors.white,),
                  hintText: "Enter Phone Number",
                  filled: true,
                  fillColor:  Colors.grey.withOpacity(0.1),
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
                // dropdownTextStyle: Colors.blue,
                showCountryFlag: false,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),

                onChanged: (phone) {
                  print(phone.completeNumber);
                },
                            ),
                SizedBox(height: 20,),
                MyButton(
                height: 60,
                 borderRadius: 10,
                 elevation: 2,
                  title: "Send OTP",
                  color: AppColor.greyColor,
                   onPressed: () {

          },
        ),
                            SizedBox(height: 20,),
                                    InkWell(
          onTap: () {
            controller.signInWithGoogle();
            // Get.toNamed(AppRoutes.locationPageRoute);
            // Call the sign-in method
            print("Jjjjjjjjjjjjjjjjjj");
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color:  Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.packageGray),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/googleLogo.png"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Log in with Google", style: MyTextTheme.smallGCN,),
                ),
              ],
            ),
          ),
        ),
                            SizedBox(height: 10,)
                          ],
                        ),
              ),



            ),
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
