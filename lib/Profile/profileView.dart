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
import '../AppManager/toast.dart';
import '../DataModels/LoginResponse.dart';
import '../Leaderboard/LeaderBoardController.dart';
import '../Leaderboard/leaderboardView.dart';
import '../Widget/appColor.dart';

class ProfileView extends GetView<ProfileController> {
  final ProfileController controller = Get.put(ProfileController());
  final LeaderBoardController leaderBoardController = Get.put(
      LeaderBoardController());
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
            // Get.to(
            //       () => DashBoardView(),
            //   transition: Transition.rightToLeft,
            //   duration: Duration(milliseconds: 550),
            //   curve: Curves.ease,
            // );
          },
            child: Icon(Icons.arrow_back_ios_new,size: 20,)),
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
                              backgroundImage:controller.profilePhoto.isNotEmpty?Image.file(File(controller.profilePhoto)).image:
                              NetworkImage("http://182.156.200.177:8011${controller.userData.getUserData!.picture}",),
                              backgroundColor: controller.userData.getUserData!.picture.isEmpty
                                  ? AppColor.packageGray
                                  : Colors.transparent,
                              child: controller.userData.getUserData!.picture.isEmpty
                                  ?  Icon(Icons.person, size: 50, color: AppColor.circleIndicator )
                                  : null,
                            ),
                            // CircleAvatar(
                            //   radius: 30,
                            //   backgroundImage: customDrawerController.userData.getUserData!.picture.isNotEmpty
                            //       ? NetworkImage("http://182.156.200.177:8011${customDrawerController.userData.getUserData!.picture}")
                            //       : null,
                            //   backgroundColor: customDrawerController.userData.getUserData!.picture.isEmpty
                            //       ? AppColor.circleIndicator
                            //       : Colors.transparent,
                            //   child: customDrawerController.userData.getUserData!.picture.isEmpty
                            //       ? const Icon(Icons.person, size: 25, color: Colors.white)
                            //       : null,
                            // ),

                          ],
                        ),
                      ),
                    ),
                      // Positioned(
                      //   bottom: 0,
                      //   right: 0,
                      //   child: InkWell(
                      //     onTap: () {
                      //       _showImagePickerMenu(context);
                      //     },
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //         color: Colors.white, // Background color of the icon
                      //         shape: BoxShape.circle,
                      //         border: Border.all(
                      //           color: AppColor.greyColor,
                      //           width: 1.0,
                      //         ),
                      //       ),
                      //       padding: EdgeInsets.all(6),
                      //       child: SvgPicture.asset("assets/cam.svg")
                      //     ),
                      //   ),
                      // ),
                      Positioned(
                        bottom: 60,
                        right: 2,
                        child: Stack(
                          children: [
                            SvgPicture.asset(
                              "assets/other-star.svg",
                              height: 40,
                              width: 40,
                            ),
                          ],
                        ),
                      ),
                    ]
                  ),

                  SizedBox(height: 20),
                  // Padding(
                  //   padding: const EdgeInsets.all(7.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text("User Name",style: MyTextTheme.mediumGCB,),
                  //       TextField(
                  //          controller: controller.userNameC,
                  //         cursorColor: AppColor.circleIndicator,
                  //         decoration: InputDecoration(
                  //           hintText: "Enter your user name",
                  //           hintStyle: MyTextTheme.mediumCustomGCN,
                  //           // prefixIcon: Image.asset("asset/profile.png"),
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //             borderSide:  BorderSide(
                  //               color: Colors.black,
                  //             ),
                  //           ),
                  //           enabledBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //             borderSide: const BorderSide(
                  //               color: Colors.grey,
                  //               width: 1,
                  //             ),
                  //           ),
                  //           focusedBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //             borderSide: const BorderSide(
                  //               color: Colors.grey,
                  //               width: 1,
                  //             ),
                  //           ),
                  //         ),
                  //         style: const TextStyle(
                  //           color: Colors.grey,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Full Name",style: MyTextTheme.mediumGCB,),
                        // TextFormField(
                        //  controller: controller.nameC,
                        //   cursorColor: AppColor.circleIndicator,
                        //   decoration: InputDecoration(
                        //     hintText: "Enter your full name",
                        //     hintStyle: MyTextTheme.mediumCustomGCN,
                        //     // prefixIcon: Image.asset("asset/profile.png"),
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide:  BorderSide(
                        //         color: AppColor.packageGray,
                        //       ),
                        //     ),
                        //     enabledBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide:  BorderSide(
                        //         color: AppColor.packageGray,
                        //         width: 1,
                        //       ),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide: const BorderSide(
                        //         color: Colors.grey,
                        //         width: 1,
                        //       ),
                        //     ),
                        //   ),
                        //   style: const TextStyle(
                        //     color: Colors.grey,
                        //   ),
                        // ),
                        TextFormField(
                          controller: controller.nameC,
                          cursorColor: AppColor.circleIndicator,
                          decoration: InputDecoration(
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
                          // Add the validator here

                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("User Name",style: MyTextTheme.mediumGCB,),
                        // TextFormField(
                        //  controller: controller.nameC,
                        //   cursorColor: AppColor.circleIndicator,
                        //   decoration: InputDecoration(
                        //     hintText: "Enter your full name",
                        //     hintStyle: MyTextTheme.mediumCustomGCN,
                        //     // prefixIcon: Image.asset("asset/profile.png"),
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide:  BorderSide(
                        //         color: AppColor.packageGray,
                        //       ),
                        //     ),
                        //     enabledBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide:  BorderSide(
                        //         color: AppColor.packageGray,
                        //         width: 1,
                        //       ),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide: const BorderSide(
                        //         color: Colors.grey,
                        //         width: 1,
                        //       ),
                        //     ),
                        //   ),
                        //   style: const TextStyle(
                        //     color: Colors.grey,
                        //   ),
                        // ),
                        TextFormField(
                          controller: controller.userNameC,
                          enabled: false,
                          // readOnly: true,
                          cursorColor: AppColor.circleIndicator,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColor.leaderboard,
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
                              borderSide: BorderSide(
                                color: AppColor.packageGray,
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
                          // Add the validator here

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
                        const SizedBox(width: 50,),

                            Radio(
                              value: "1",
                              activeColor: AppColor.circleIndicator,
                              groupValue:  controller.genderC.text,
                              onChanged: (String? value){
                                print(value);
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
                            prefixIcon: SvgPicture.asset("assets/call.svg",fit: BoxFit.scaleDown,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:  BorderSide(
                                color: AppColor.packageGray,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:  BorderSide(
                                color: AppColor.packageGray,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:  BorderSide(
                                color: AppColor.packageGray,
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
                            // filled: true,
                            // fillColor: AppColor.leaderboard,
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
                              borderSide:  BorderSide(
                                color: AppColor.packageGray,
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
                        Text("School of Thought", style: MyTextTheme.mediumGCB),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(  color: AppColor.packageGray,), // Border color
                            borderRadius: BorderRadius.circular(10.0), // Circular border radius
                          ),
                          child: DropdownButton<String>(
                            dropdownColor: Colors.white,
                            value: controller.schoolOFThought['id'].toString(),
                            isExpanded: true, // Ensures the dropdown takes the full width
                            underline: SizedBox(), // Removes default underline
                            hint: Text(
                              "Select an institute",
                              style: MyTextTheme.mediumCustomGCN,
                            ),
                            menuMaxHeight: MediaQuery.of(context).size.height * 0.50,
                            // itemHeight: 40.0,
                            items: controller.calculationList.map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value['id'].toString(), // Use 'id' as the value
                                child: Text(value['name'].toString(), style: TextStyle(color: Colors.grey,fontSize: 14)), // Display the name
                              );
                            }).toList(),
                            onChanged: (value) {
                             controller.selectSchool(value.toString());
                              print("Selected value: $value");
                            },
                          ),


                          // child:   MyCustomSD(
                        //     listToSearch:controller.calculationList,
                        //     valFrom: 'name',
                        //     onChanged: (value) {
                        //       if(value!=null){
                        //         print("method values $value");
                        //
                        //         // controller.updateCalId = value['id'];
                        //         // print("GetMethodId: ${controller.getCalId.toString()}");
                        //         print(value);
                        //       }
                        //
                        //     },),



                        ),

                        // Conditionally display the radio buttons if id == 7
                        if (controller.schoolOFThought['id'].toString() == '7'||controller.schoolOFThought['id'].toString() == '0')
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10,),
                              Text("Times of Prayer",style:  MyTextTheme.mediumGCB,),
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
                                      style: MyTextTheme.mediumGCB,
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
                                          style: MyTextTheme.mediumGCB,
                                        ))
                                  ]
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),



                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Column(
                  //     children: [
                  //       DropdownMenu<Map<String,dynamic>>(
                  //         textStyle: const TextStyle(
                  //           color: Colors.grey
                  //         ),
                  //         menuHeight: 150,
                  //         initialSelection: {"key": "MWL", "id": 3, "name": "Muslim World League"},
                  //         width: double.infinity,
                  //         // initialSelection: selectedValue,
                  //         onSelected: (value) {
                  //           print("value $value");
                  //             // selectedValue = value;
                  //
                  //           // if (widget.onSelected != null) {
                  //           //   widget.onSelected!(value);
                  //           // }
                  //         },
                  //         dropdownMenuEntries: controller.calculationList.map<DropdownMenuEntry<Map<String,dynamic>>>((value) {
                  //           return DropdownMenuEntry<Map<String,dynamic>>(
                  //             value: value,
                  //             label: value['name'].toString(),
                  //           );
                  //         }).toList(),
                  //       ),

                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 20,),
                  // MyButton(
                  //   borderRadius: BorderRadius.circular(10),
                  //   onPressed: (){
                  //
                  //   controller.registerUser();
                  // }, title: 'Update',color: AppColor.circleIndicator,),
                  // MyButton(
                  //   borderRadius:10,
                  //   onPressed: () {
                  //     controller.registerUser(); // Call the registerUser method from the controller
                  //   },
                  //   title: 'Update', // Button label
                  //   color: AppColor.circleIndicator, // Button color
                  // ),
                  MyButton(
                    borderRadius: 10,
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
                        controller.registerUser(); // Call the registerUser method from the controller
                      }
                    },
                    title: 'Update', // Button label
                    color: AppColor.circleIndicator, // Button color
                  ),

                  SizedBox(height: 10,)

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
                    print("file $file");
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
                      // print(await response.stream.bytesToString());
                      final data = await response.stream.bytesToString();
                      final myData =await jsonDecode(data);
                      final userModel = UserModel.fromJson(myData['user']);
                      await controller.userData.addUserData(userModel);
                      showToast(msg: 'Photo Updated');
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
                      showToast(msg: 'Photo Updated');
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