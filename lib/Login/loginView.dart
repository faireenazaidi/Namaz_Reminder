import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Login/loginController.dart';
import 'package:namaz_reminders/Routes/approutes.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';

class LoginView extends GetView<LoginController>{

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
       body: Column(
         children: [
           Container(
             height: 440,
             decoration: const BoxDecoration(
               image: DecorationImage(
                 image: AssetImage("assets/image2.png"),
                 fit: BoxFit.fitWidth,
               )
             ),
           ),

           SizedBox(height: 10,),
           Padding(
             padding:  EdgeInsets.all( 13.0),
             child: Column(
               children: [
                 Row(
                   children: [
                     Text("Login/Signup",style: MyTextTheme.largeBCB,),
                   ],
                 ),
                 Row(
                   children: [  Text("Enter your email to send the OTP",style: TextStyle(color: Colors.grey[500],fontSize: 10),)],
                 ),
                 SizedBox(height: 20,),
                 InkWell(
                   onTap: (){
                     Get.toNamed(AppRoutes.dashboardRoute);
                   },
                   child: Container(
                     height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColor.packageGray,
                      )
                    ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Image.asset("assets/googleLogo.png"),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text("Log in with Google",style: MyTextTheme.smallGCN,),
                         )
                       ],
                     ),
                   ),
                 )
               ],
             ),
           ),
           // SizedBox(height: 8,),
         ],
       ),


      ),
    );
  }

}