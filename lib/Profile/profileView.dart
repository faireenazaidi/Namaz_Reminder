import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Profile/profileController.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';

import '../Widget/appColor.dart';

class ProfileView extends GetView<ProfileController> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Edit Profile',style: MyTextTheme.mediumBCD,),
        bottom:  PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            height: 1.0,
            color: AppColor.packageGray
          ),
        ),
        leading: InkWell(
          onTap: (){
            Get.back();
          },
            child: Icon(Icons.arrow_back_ios_new)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Obx(() => controller.profileImage.value ?? FlutterLogo(size: 120)),
              SizedBox(height: 15,),
              Stack(
                children: [ Container(
                  width: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColor.circleIndicator,
                      width: 2.0,
                    ),
                  ),
                  child:  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      "https://media.istockphoto.com/id/1409155424/photo/head-shot-portrait-of-millennial-handsome-30s-man.webp?a=1&b=1&s=612x612&w=0&k=20&c=Q5Zz9w0FulC0CtH-VCL8UX2SjT7tanu5sHNqCA96iVw=",
                    ),
                  ),
                ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        // Add functionality to pick an image from gallery here
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Background color of the icon
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColor.packageGray,
                            width: 1.0,
                          ),
                        ),
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
          ]
              ),

              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("User Name",style: MyTextTheme.mediumGCB,),
                    TextField(
                      // controller: controller.nameC.value,
                      cursorColor: AppColor.circleIndicator,
                      decoration: InputDecoration(
                        hintText: "Enter your user name",
                        hintStyle: MyTextTheme.mediumCustomGCN,
                        // prefixIcon: Image.asset("asset/profile.png"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:  BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Full Name",style: MyTextTheme.mediumGCB,),
                    TextField(
                      // controller: controller.nameC.value,
                      cursorColor: AppColor.circleIndicator,
                      decoration: InputDecoration(
                        hintText: "Enter your full name",
                        hintStyle: MyTextTheme.mediumCustomGCN,
                        // prefixIcon: Image.asset("asset/profile.png"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:  BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Gender",
                      style: MyTextTheme.mediumGCB,
                    ),
                  ],
                ),
              ),
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
                    Text("Male",
                      style: MyTextTheme.mediumGCB,
                    ),
                    const SizedBox(width: 100,),
                    Obx(()=>
                        Radio(
                          value: "Female",
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
                          style: MyTextTheme.mediumGCB,
                        ))
                  ]
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Phone Number",style: MyTextTheme.mediumGCB,),
                    TextField(
                      // controller: controller.nameC.value,
                      cursorColor: AppColor.circleIndicator,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColor.leaderboard,
                        hintText: "Enter your phone number",
                        hintStyle: MyTextTheme.mediumCustomGCN,
                        prefixIcon: SvgPicture.asset("assets/icon.svg",fit: BoxFit.scaleDown,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:  BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email",style: MyTextTheme.mediumGCB,),
                    TextField(
                      // controller: controller.nameC.value,
                      cursorColor: AppColor.circleIndicator,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColor.leaderboard,
                        hintText: "Enter your email",
                        hintStyle: MyTextTheme.mediumCustomGCN,
                        prefixIcon: Icon(Icons.email_outlined,color: AppColor.greyColor,size: 20,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:  BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),



              // ElevatedButton(
              //   onPressed: () => controller.pickImage(),
              //   child: Text('Pick Profile Image'),
              // ),
            ],
          ),
        ),
      ),
    );
  }


}