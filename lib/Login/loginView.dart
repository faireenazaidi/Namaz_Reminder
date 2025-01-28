import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Login/loginController.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';
import '../Widget/myButton.dart';
import '../Widget/primary_text_field.dart';

class LoginView extends GetView<LoginController> {
  final TextEditingController usernameController = TextEditingController();
  final LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 440,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image2.png"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Login/Signup", style: MyTextTheme.largeBCB),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Enter your email to send the OTP",
                        style: TextStyle(color: Colors.grey[500], fontSize: 10),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  PrimaryTextField(
                    prefixIcon: Icon(Icons.email_outlined, color: AppColor.color),
                    hintText: "Enter your email",
                    labelText: "Email",
                    backgroundColor: Colors.white,
                    borderColor: AppColor.color,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Please enter an email';
                      }
                      final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!regex.hasMatch(value)) {
                        return '*Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  MyButton(
                    borderRadius: 10,
                    elevation: 2,
                    title: "Send OTP",
                    color: AppColor.black,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      controller.signInWithGoogle();
                      // Get.toNamed(AppRoutes.locationPageRoute);
                      // Call the sign-in method
                      print("Jjjjjjjjjjjjjjjjjj");
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColor.packageGray),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/googleLogo.png"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Log in with Google", style: MyTextTheme.smallGCN),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
