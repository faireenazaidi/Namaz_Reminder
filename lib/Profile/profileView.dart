import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Profile/profileController.dart';
import 'package:namaz_reminders/Widget/myButton.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';

import '../AppManager/image_and_video_picker.dart';
import '../DataModels/LoginResponse.dart';
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
          child: GetBuilder<ProfileController>(
            builder: (_) {
              return Column(
                children: [
                  // Obx(() => controller.profileImage.value ?? FlutterLogo(size: 120)),
                  SizedBox(height: 15,),
                  Stack(
                    children: [ InkWell(
                      onTap: (){
                        _showImagePickerMenu(context);
                      },
                      child: Container(
                        width: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColor.circleIndicator,
                            width: 2.0,
                          ),
                        ),
                        child:  Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:controller.userData.getUserData!.picture!=''? NetworkImage(
                                "http://182.156.200.177:8011${controller.userData.getUserData!.picture}",
                              ):Image.file(File(controller.profilePhoto)).image,
                            ),

                          ],
                        ),
                      ),
                    ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            _showImagePickerMenu(context);
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
                           controller: controller.userNameC,
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
                         controller: controller.nameC,
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
                            Radio<String>(
                              value:"0",
                              activeColor: AppColor.circleIndicator,
                              groupValue: controller.genderC.text,
                              onChanged: (String? value){
                                controller.updateGender(value!);
                              },
                            ),
                        Text("Male",
                          style: MyTextTheme.mediumGCB,
                        ),
                        const SizedBox(width: 100,),

                            Radio(
                              value: "1",
                              activeColor: AppColor.circleIndicator,
                              groupValue:  controller.genderC.text,
                              onChanged: (String? value){
                                controller.updateGender(value!);
                              },
                            ),
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
                          controller: controller.phoneC,
                          cursorColor: AppColor.circleIndicator,
                          readOnly: true,
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
                          controller: controller.mailC,
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
                  SizedBox(height: 20,),
                  MyButton(onPressed: (){
                    controller.registerUser();
                  }, title: 'Update',color: Colors.black,),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
// Method to open camera or gallery
  Future<void> _showImagePickerMenu(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Take a picture'),
                  onTap: () async {
                    Navigator.of(context).pop(); // Close the menu
                    final file =await MyImagePicker.pickImage(isFromCam: true);
                    controller.updateProfilePhoto(file);
                    var headers = {
                      'Cookie': 'csrftoken=yQZryaCTtTmYrYdjA6ZZSxgbPfJJlNft'
                    };
                    var request = http.MultipartRequest('PUT', Uri.parse('http://182.156.200.177:8011/adhanapi/update-user/'));
                    request.fields.addAll({
                      'user_id': controller.userData.getUserData!.id.toString()
                    });
                    request.files.add(await http.MultipartFile.fromPath('picture', controller.profilePhoto));
                    request.headers.addAll(headers);

                    http.StreamedResponse response = await request.send();

                    if (response.statusCode == 200) {
                      print(await response.stream.bytesToString());
                      final data =await (response.stream.bytesToString());
                      final myData =await jsonDecode(data);
                      final userModel = UserModel.fromJson(myData['user']);
                      await controller.userData.addUserData(userModel);
                    }
                    else {
                      print(response.reasonPhrase);
                    }
                    // final pickedFile = await _picker.pickImage(source: ImageSource.camera);
                    // setState(() {
                    //   _imageFile = pickedFile;
                    // });
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Choose from gallery'),
                  onTap: () async {
                    print("UISer"+controller.userData.getUserData!.id.toString());
                    Navigator.of(context).pop(); // Close the menu
                    final file = await MyImagePicker.pickImage(isFromCam: false);
                    controller.updateProfilePhoto(file);
                    var headers = {
                      'Cookie': 'csrftoken=yQZryaCTtTmYrYdjA6ZZSxgbPfJJlNft'
                    };
                    var request = http.MultipartRequest('PUT', Uri.parse('http://182.156.200.177:8011/adhanapi/update-user/'));
                    request.fields.addAll({
                      'user_id': controller.userData.getUserData!.id.toString()
                    });
                    request.files.add(await http.MultipartFile.fromPath('picture', controller.profilePhoto));
                    request.headers.addAll(headers);

                    http.StreamedResponse response = await request.send();

                    if (response.statusCode == 200) {
                      final data =await (response.stream.bytesToString());
                     final myData =await jsonDecode(data);
                      final userModel = UserModel.fromJson(myData['user']);
                      await controller.userData.addUserData(userModel);
                    }
                    else {
                      print("Response"+response.reasonPhrase.toString());
                    }
                    // final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                    // setState(() {
                    //   _imageFile = pickedFile;
                    // });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}