import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Profile/profileController.dart';
import 'package:namaz_reminders/Widget/myButton.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';
import 'package:namaz_reminders/Widget/MyRank/myweeklyrank.dart';
import '../DashBoard/dashboardController.dart';
import '../Drawer/drawerController.dart';
import '../Leaderboard/LeaderBoardController.dart';
import '../Widget/MyRank/myRankController.dart';
import '../Widget/appColor.dart';

class ProfileView extends GetView<ProfileController> {
  final ProfileController controller = Get.put(ProfileController());
  final LeaderBoardController leaderBoardController = Get.put(
      LeaderBoardController());
  final MyRankController myRankController = Get.put(MyRankController());
  final DashBoardController dashboardController = Get.put(DashBoardController());
  final CustomDrawerController customDrawerController = Get.find<CustomDrawerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text('Edit Profile',style: MyTextTheme.mediumBCD.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color)),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
              height: 1.0,
            color:customDrawerController.isDarkMode == true? AppColor.scaffBg:AppColor.packageGray,
          ),
        ),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
          child: Transform.scale(
            scale:
            MediaQuery.of(context).size.width <360 ? 0.6: 0.7,
            child:   CircleAvatar(
                radius: 12,
                backgroundColor: customDrawerController.isDarkMode == false ? AppColor.cardbg: Colors.white12,
                child: const Icon(Icons.arrow_back_ios_new,size: 20,)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (controller.nameC.text.isEmpty) {
                Get.snackbar(
                  'Error',
                  'Please enter your name',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.black,
                  colorText: Colors.white,
                );
              }
              else {
                controller
                    .registerUser();
              }
            },
            child: Text("Save", style: MyTextTheme.mustard),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8,right: 8,top: 5),
          child: GetBuilder(
            init: controller,
              builder: (_) {
                return Column(
                  children: [
                    SizedBox(height: 10,),
                    Stack(
                        children: [ InkWell(
                          onTap: () {
                            controller.showImagePickerMenu(context);
                          },
                          child: Container(
                            width: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColor.color,
                                width: 2.0,
                              ),
                            ),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: controller.profilePhoto.isNotEmpty
                                      ? FileImage(File(controller.profilePhoto))
                                      : controller.userData.getUserData!.picture.isNotEmpty
                                      ? NetworkImage("http://182.156.200.177:8011${controller.userData.getUserData!.picture}")
                                      : null,
                                  backgroundColor: controller.profilePhoto.isEmpty && controller.userData.getUserData!.picture.isEmpty
                                      ? AppColor.packageGray
                                      : Colors.transparent,
                                  child: controller.profilePhoto.isEmpty && controller.userData.getUserData!.picture.isEmpty
                                      ? Icon(Icons.person, size: 50, color: AppColor.color)
                                      : null,
                                )
                              ],
                            ),
                          ),
                        ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                controller.showImagePickerMenu(context);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    // Background color of the icon
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColor.greyColor,
                                      width: 1.0,
                                    ),
                                  ),
                                  padding: EdgeInsets.all(6),
                                  child: SvgPicture.asset("assets/cam.svg",color:Theme.of(context).iconTheme.color,)
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 65,
                            left: 70,
                            child: Stack(
                              children: [
                                SvgPicture.asset(
                                  myRankController.rank == 1 ? 'assets/Gold.svg'
                                      : myRankController.rank == 2
                                      ? 'assets/silver.svg'
                                      :
                                  myRankController.rank == 3
                                      ? 'assets/Bronze.svg'
                                      : 'assets/other.svg', height: 40,),
                                Positioned(
                                  right: 16,
                                  top: 11,
                                  child: Column(
                                    children: [
                                      Center(
                                        child: MyRank(
                                          rankedFriends: dashboardController
                                              .weeklyRanked,
                                          textSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Full Name", style: MyTextTheme.mediumGCB,),
                          SizedBox(height: 5,),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: customDrawerController.isDarkMode == false?
                                  [AppColor.cardbg, AppColor.cardbg]:
                                  [Colors.transparent, Colors.white10],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,

                                )
                            ),
                            child: TextFormField(
                              controller: controller.nameC,
                              cursorColor: AppColor.color,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                //customDrawerController.isDarkMode == false ? AppColor.cardbg: Colors.white12,
                                hintText: "Enter your full name",
                                hintStyle: MyTextTheme.mediumCustomGCN,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColor.packageGray,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColor.packageGray,
                                    width: 0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0,
                                  ),
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("User Name", style: MyTextTheme.mediumGCB,),
                          SizedBox(height: 5,),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: customDrawerController.isDarkMode == false?
                                  [AppColor.cardbg, AppColor.cardbg]:
                                  [Colors.transparent, Colors.white10],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,

                                )
                            ),
                            child: TextFormField(
                              controller: controller.userNameC,
                              cursorColor: AppColor.color,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                //customDrawerController.isDarkMode == false ? AppColor.cardbg: Colors.white12,
                                hintText: "User name",
                                hintStyle: MyTextTheme.mediumCustomGCN,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColor.packageGray,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0,
                                  ),
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
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
                          Radio<String>(
                            value: "0",
                            activeColor: AppColor.color,
                            groupValue: controller.genderC.text,
                            onChanged: (String? value) {
                              controller.updateGender(value!);
                            },
                          ),
                          Text("Male",
                            style: MyTextTheme.mediumGCB,
                          ),
                          const SizedBox(width: 50,),
        
                          Radio(
                            value: "1",
                            activeColor: AppColor.color,
                            groupValue: controller.genderC.text,
                            onChanged: (String? value) {
                              print(value);
                              controller.updateGender(value!);
                            },
                          ),
                          InkWell(
                              onTap: () {
                              },
                              child: Text("Female",
                                style: MyTextTheme.mediumGCB,
                              ))
                        ]
                    ),
        
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Phone Number", style: MyTextTheme.mediumGCB,),
                          SizedBox(height: 5,),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: customDrawerController.isDarkMode == false?
                                  [AppColor.cardbg, AppColor.cardbg]:
                                  [Colors.transparent, Colors.white10],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,

                                )
                            ),
                            child: TextField(
                              controller: controller.phoneC,
                              cursorColor: AppColor.color,
                              readOnly: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                //customDrawerController.isDarkMode == false ? AppColor.cardbg: Colors.white12,
                                hintText: "Enter your phone number",
                                hintStyle: MyTextTheme.mediumCustomGCN,
                                prefixIcon: SvgPicture.asset(
                                  "assets/call.svg", fit: BoxFit.scaleDown,color:Theme.of(context).iconTheme.color,),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColor.packageGray,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColor.packageGray,
                                    width: 0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColor.packageGray,
                                    width: 0,
                                  ),
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email", style: MyTextTheme.mediumGCB,),
                          SizedBox(height: 5,),

                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: customDrawerController.isDarkMode == false?
                                  [AppColor.cardbg, AppColor.cardbg]:
                                  [Colors.transparent, Colors.white10],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,

                                )
                            ),
                            child: TextField(
                              controller: controller.mailC,
                              cursorColor: AppColor.color,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                //customDrawerController.isDarkMode == false ? AppColor.cardbg: Colors.white12,
                                hintText: "Enter your email",
                                hintStyle: MyTextTheme.mediumCustomGCN,
                                prefixIcon:
                                SvgPicture.asset(
                                  "assets/Email.svg", fit: BoxFit.scaleDown,color:Theme.of(context).iconTheme.color,),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColor.packageGray,
                                    width: 0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0,
                                  ),
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("School of Thought",
                              style: MyTextTheme.mediumGCB),
                          SizedBox(height: 5,),

                          Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    colors: customDrawerController.isDarkMode == false?
                                    [AppColor.cardbg, AppColor.cardbg]:
                                    [Colors.transparent, Colors.white10],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,

                                  ),

                              border: Border.all(color: AppColor.packageGray,width: 0),
                            ),
                            child: DropdownButton<String>(
                              dropdownColor: Colors.white,
                              value: controller.schoolOFThought['id']
                                  .toString(),
                              isExpanded: true,
                              underline: SizedBox(),
                              // Removes default underline
                              hint: Text(
                                "Select an institute",
                                style: MyTextTheme.mediumCustomGCN,
                              ),
                              menuMaxHeight: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.50,
                              // itemHeight: 40.0,
                              items: controller.calculationList.map<
                                  DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem<String>(
                                  value: value['id'].toString(),
                                  // Use 'id' as the value
                                  child: Text(value['name'].toString(),
                                      style: const TextStyle(color: Colors.grey,
                                          fontSize: 14)),
                                );
                              }).toList(),
                              onChanged: (value) {
                                controller.selectSchool(value.toString());
                                print("Selected value: $value");
                              },
                            ),
                          ),
                          // if (controller.schoolOFThought['id'].toString() ==
                          //     '7' || controller.schoolOFThought['id']
                          //     .toString() == '0')
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     const SizedBox(height: 10,),
                            //     Text("Times of Prayer",
                            //       style: MyTextTheme.mediumGCB,),
                            //     Row(
                            //         children: [
                            //           Obx(() =>
                            //               Radio<String>(
                            //                 value: "3",
                            //                 activeColor: AppColor
                            //                     .color,
                            //                 groupValue: controller
                            //                     .selectedPrayer.value,
                            //                 onChanged: (String? value) {
                            //                   controller.selectedPrayer(value!);
                            //                 },
                            //               )),
                            //           Text("3",
                            //             style: MyTextTheme.mediumGCB,
                            //           ),
                            //           const SizedBox(width: 130,),
                            //           Obx(() =>
                            //               Radio(
                            //                 value: "5",
                            //                 activeColor: AppColor
                            //                     .color,
                            //                 groupValue: controller
                            //                     .selectedPrayer.value,
                            //                 onChanged: (String? value) {
                            //                   controller.selectedPrayer(value!);
                            //                 },
                            //               )),
                            //           InkWell(
                            //               onTap: () {
                            //               },
                            //               child: Text("5",
                            //                 style: MyTextTheme.mediumGCB,
                            //               ))
                            //         ]
                            //     ),
                            //   ],
                            // ),
                        ],
                      ),
                    ),
                    // const SizedBox(height: 5,),
                    // MyButton(
                    //   borderRadius: 10,
                    //   onPressed: () {
                    //     if (controller.nameC.text.isEmpty) {
                    //       Get.snackbar(
                    //         'Error',
                    //         'Please enter your name',
                    //         snackPosition: SnackPosition.TOP,
                    //         backgroundColor: Colors.black,
                    //         colorText: Colors.white,
                    //       );
                    //     }
                    //     else {
                    //       controller
                    //           .registerUser();
                    //     }
                    //   },
                    //   title: 'Update',
                    //   color: AppColor.color,
                    // ),
        

                  ],
                );
              }
          ),
        ),
      ),
    );
  }
}