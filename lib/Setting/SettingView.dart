import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Notification/NotificationSetting/notificationSettingController.dart';
import 'package:namaz_reminders/Profile/profileController.dart';
import 'package:namaz_reminders/Setting/FriendRequests/friendRequestController.dart';
import 'package:namaz_reminders/Setting/HijriDate/hijriController.dart';
import 'package:namaz_reminders/Setting/Privacy&Security/PrivacyController.dart';
import '../AppManager/toast.dart';
import '../Notification/NotificationSetting/notificationSettingView.dart';
import '../Widget/appColor.dart';
import '../Widget/text_theme.dart';
import 'SettingController.dart';

class SettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SettingController settingController = Get.put(SettingController());
    final HijriController hijriController = Get.put(HijriController());
    final RequestController requestController = Get.put(RequestController());
    final PrivacyController privacyController = Get.put(PrivacyController());
    final NotificationSettingController notificationSettingController = Get.put(NotificationSettingController());
    final ProfileController profileController = Get.put(ProfileController());

    return GetBuilder<SettingController>(
      init: SettingController(),
      builder: (controller) {
        return SafeArea(
          top: true,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text('Settings', style: MyTextTheme.mediumBCD),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Divider(
                  height: 1.5,
                  color: AppColor.packageGray,
                ),
              ),
              leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(Icons.arrow_back_ios_new,size: 20,),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  /// This Searchbar is temporarily hidden///
                 // Padding(
                 //   padding: const EdgeInsets.all(8.0),
                 //   child: TextField(
                 //     cursorColor: AppColor.circleIndicator,
                 //     decoration: InputDecoration(
                 //       //prefixIcon:  Icon(Icons.search,),
                 //       hintText: "Search for a setting...",
                 //       hintStyle: MyTextTheme.searchbar,
                 //       filled: true,
                 //       fillColor: AppColor.searchbg,
                 //       border: OutlineInputBorder(
                 //         borderRadius: BorderRadius.circular(20),
                 //         borderSide: const BorderSide(color: Colors.black),
                 //       ),
                 //       enabledBorder: OutlineInputBorder(
                 //         borderRadius: BorderRadius.circular(10),
                 //         borderSide:  BorderSide(color:AppColor.search, width: 1),
                 //       ),
                 //       focusedBorder: OutlineInputBorder(
                 //         borderRadius: BorderRadius.circular(10),
                 //         borderSide: const BorderSide(color: Colors.grey, width: 1),
                 //       ),
                 //       suffixIcon: IconButton(
                 //         icon: const Icon(Icons.cancel, color: Colors.grey),
                 //         onPressed: () {
                 //
                 //         },
                 //       ),
                 //     ),
                 //     style: const TextStyle(color: Colors.grey),
                 //   ),
                 // ),

                  SizedBox(height: 10),
                  // Settings List
                  Expanded(
                    child: ListView(
                      children: [
                        // Obx(() => buildSettingItem(
                        //   title: 'Hijri Date Adjustment',
                        //   subtitle: hijriController.getCurrentSubtitle(),
                        //   onTap: () {
                        //     Dialogs.showCustomDialog(
                        //       context: context,
                        //       content: GetBuilder<HijriController>(
                        //         builder: (hijriController) {
                        //           return ListView.builder(
                        //             shrinkWrap: true,
                        //             itemCount: hijriController.hijriDateAdjustment.length,
                        //             itemBuilder: (context, index) {
                        //               var day = hijriController.hijriDateAdjustment[index];
                        //               return Obx(() => ListTile(
                        //                 title: Container(
                        //                   height: 30,
                        //                   decoration: BoxDecoration(
                        //                     borderRadius: BorderRadius.circular(12),
                        //                     color: hijriController.selectedId.value == day['id']
                        //                         ? AppColor.circleIndicator
                        //                         : Colors.white70,
                        //                   ),
                        //                   child: Center(
                        //                     child: Text(
                        //                       day['name'],
                        //                       style: TextStyle(
                        //                         fontWeight: hijriController.selectedId.value == day['id']
                        //                             ? FontWeight.bold
                        //                             : FontWeight.normal,
                        //                         color: hijriController.selectedId.value == day['id']
                        //                             ? Colors.white
                        //                             : Colors.black,
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 onTap: () {
                        //                   hijriController.updateSelectedId(day['id']);
                        //                   hijriController.registerUser();
                        //                   hijriController.selectItem(day['id']);
                        //                 },
                        //               ));
                        //             },
                        //           );
                        //         },
                        //       ),
                        //     );
                        //   },
                        //   imagePath: "assets/hijri.svg",
                        // )
                        ///HIJRI DATE ADJUSTMENT///
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/hijri.svg",height: 16,),
                                  SizedBox(width: 10,),
                                  Text("Hijri Date Adjustment"),
                                ],
                              ),

                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColor.searchbg,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    for (int i = 0; i < hijriController.hijriDateAdjustment.length; i++) ...[
                                      Expanded(
                                        child: Obx(() {
                                          bool isSelected = hijriController.selectedId.value == hijriController.hijriDateAdjustment[i]['id'];
                                          return InkWell(
                                            onTap: () {
                                              hijriController.updateSelectedId(hijriController.hijriDateAdjustment[i]['id']);
                                              hijriController.registerUser();
                                              hijriController.selectItem(hijriController.hijriDateAdjustment[i]['id']);
                                            },
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  height: 40,
                                                  child: Center(
                                                    child: Text(
                                                      hijriController.hijriDateAdjustment[i]['name'],
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                if (isSelected)
                                                   Positioned(
                                                    right: 5,
                                                    top: 10,
                                                    child: Icon(
                                                      Icons.check,
                                                      size: 18,
                                                      color: AppColor.check,
                                                      weight: 15,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                      if (i < hijriController.hijriDateAdjustment.length - 1)
                                        Container(
                                          width: 1,
                                          height: 40,
                                          color: AppColor.search
                                        ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        ///SELECTED PRAYER TIME///
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Row(
                        //         children: [
                        //           SvgPicture.asset("assets/hijri.svg",height: 16,),
                        //           SizedBox(width: 5,),
                        //           Text("Select Prayer Times"),
                        //         ],
                        //       ),
                        //       Container(
                        //         height: 50,
                        //         decoration: BoxDecoration(
                        //           color: AppColor.packageGray,
                        //           borderRadius: BorderRadius.circular(15),
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //           children: [
                        //             for (int i = 0; i < controller.prayerTime.length; i++) ...[
                        //               Expanded(
                        //                 child: Obx(() {
                        //                   bool isSelected = controller.selectedId.value == controller.prayerTime[i]['id'];
                        //                   return InkWell(
                        //                     onTap: () {
                        //                       controller.updateSelectedId(controller.prayerTime[i]['id']);
                        //                       controller.selectItem(controller.prayerTime[i]['id']);
                        //                     },
                        //                     child: Stack(
                        //                       alignment: Alignment.center,
                        //                       children: [
                        //                         Center(
                        //                           child: Text(
                        //                             controller.prayerTime[i]['name'],
                        //                             style: TextStyle(
                        //                               color: Colors.black,
                        //                               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        //                               fontSize: 14,
                        //                             ),
                        //                           ),
                        //                         ),
                        //                         if (isSelected)
                        //                           const Positioned(
                        //                             right: 30,
                        //                             top: 15,
                        //                             child: Icon(
                        //                               Icons.check,
                        //                               size: 18,
                        //                               color: Colors.green,
                        //                               weight: 6,
                        //                             ),
                        //                           ),
                        //                       ],
                        //                     ),
                        //                   );
                        //                 }),
                        //               ),
                        //               if (i < controller.prayerTime.length - 1)
                        //                 Container(
                        //                   width: 1,
                        //                   height: 40,
                        //                   color: Colors.grey,
                        //                 ),
                        //             ],
                        //           ],
                        //         ),
                        //         // child: Row(
                        //         //     children: [
                        //         //       Obx(() =>
                        //         //           Radio<String>(
                        //         //             value: "3",
                        //         //             activeColor: AppColor
                        //         //                 .circleIndicator,
                        //         //             groupValue: profileController
                        //         //                 .selectedPrayer.value,
                        //         //             onChanged: (String? value) {
                        //         //               profileController.selectedPrayer(value!);
                        //         //             },
                        //         //           )),
                        //         //       Text("3",
                        //         //         style: MyTextTheme.mediumGCB,
                        //         //       ),
                        //         //       const SizedBox(width: 130,),
                        //         //       Obx(() =>
                        //         //           Radio(
                        //         //             value: "5",
                        //         //             activeColor: AppColor
                        //         //                 .circleIndicator,
                        //         //             groupValue: profileController
                        //         //                 .selectedPrayer.value,
                        //         //             onChanged: (String? value) {
                        //         //               profileController.selectedPrayer(value!);
                        //         //             },
                        //         //           )),
                        //         //       InkWell(
                        //         //           onTap: () {
                        //         //           },
                        //         //           child: Text("5",
                        //         //             style: MyTextTheme.mediumGCB,
                        //         //           ))
                        //         //     ]
                        //         // ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // buildSettingItem(
                        //   title: 'Notifications',
                        //   subtitle: 'Manage your notification preferences.',
                        //   onTap: () {
                        //     Dialogs.showCustomDialog(
                        //       context: context,
                        //       content: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Obx(
                        //                 () => Column(
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 SwitchListTile(
                        //                   activeTrackColor: AppColor.circleIndicator,
                        //                   title: const Text(
                        //                     'Pause all',
                        //                     style: TextStyle(color: Colors.white),
                        //                   ),
                        //                   value: notificationSettingController.pauseAll.value,
                        //                   onChanged: (value) {
                        //                     print("value $value");
                        //                     notificationSettingController.pauseAll.value = value;
                        //                     notificationSettingController.registerUser();
                        //                     notificationSettingController.updateScheduler();
                        //                     showToast(msg: 'Settings Updated', bgColor: Colors.black);
                        //                   },
                        //                 ),
                        //                 Padding(
                        //                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        //                   child: Text(
                        //                     'Temporarily pause notifications',
                        //                     style: MyTextTheme.smallGCN,
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //
                        //           SizedBox(height: 5,),
                        //
                        //           //Requests//
                        //           Obx(() => Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               SwitchListTile(
                        //                 activeTrackColor: AppColor.circleIndicator,
                        //                 title: const Text('Friend requests',style: TextStyle(color: Colors.white)),
                        //                 //subtitle: Text('Notify when someone sends you a joining request',style: MyTextTheme.smallGCN,),
                        //                 value: notificationSettingController.friendRequests.value,
                        //                 onChanged: (value) {
                        //                   notificationSettingController.friendRequests.value = value;
                        //                   notificationSettingController.registerUser();
                        //                   showToast(msg: 'Settings Updated',bgColor: Colors.black);
                        //
                        //                 },
                        //               ),
                        //               Padding(
                        //                 padding: const EdgeInsets.only(left: 16.0),
                        //                 child: Text('Notify when someone sends you a joining request',style: MyTextTheme.smallGCN,),
                        //               ),
                        //             ],
                        //           )
                        //           ),
                        //           SizedBox(height: 5,),
                        //           //Prayed Namaz//
                        //           Obx(() => Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               SwitchListTile(
                        //                 activeTrackColor: AppColor.circleIndicator,
                        //                 title: Text('Friend namaz prayed',style: TextStyle(color: Colors.white),),
                        //                // subtitle:  Text('Get notified when your friend complete their prayers.',style: MyTextTheme.smallGCN,),
                        //                 value: notificationSettingController.friendNamazPrayed.value,
                        //                 onChanged: (value) {
                        //                   notificationSettingController.friendNamazPrayed.value = value;
                        //                   notificationSettingController.registerUser();
                        //                   showToast(msg: 'Settings Updated',bgColor: Colors.black);
                        //
                        //                 },
                        //               ),
                        //               Padding(
                        //                 padding: const EdgeInsets.only(left: 16.0),
                        //                 child: Text('Get notified when your friend complete their prayers.',style: MyTextTheme.smallGCN,),
                        //               ),
                        //             ],
                        //           )
                        //           ),
                        //         ],
                        //       ),
                        //     );
                        //   },
                        //     imagePath:"assets/notifi.svg"
                        // ),
                        ///Use Hour Format///
                        Obx(() {
                          return SwitchListTile(
                            activeTrackColor: AppColor.circleIndicator,
                            activeColor: AppColor.white,
                            title: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/Time.svg",
                                  height: 16,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Use 24 Hours Time Format',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                            value: notificationSettingController.timeFormat.value,
                            onChanged: (value) {
                              print("value $value");
                              notificationSettingController.timeFormat.value = value;
                              notificationSettingController.registerUser();
                              showToast(msg: 'Settings Updated',bgColor: Colors.black);
                            },
                          );
                        }),


                        ///Location ///
                        // Obx(() {
                //   return Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         SvgPicture.asset(
                //           "assets/privacy.svg",
                //           height: 16, // Adjust size as needed
                //         ),
                //         SizedBox(width: 10,),
                //
                //          Expanded(
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               const Text(
                //                 'Location',
                //                 style: TextStyle(
                //                   fontWeight: FontWeight.w400,
                //                   color: Colors.black,
                //                   fontSize: 14,
                //                 ),
                //               ),
                //               SizedBox(height: 4),
                //               Text(
                //                 "Allow location access to provide accurate data according to your location",
                //                 style: MyTextTheme.subtitle.copyWith(fontSize: 12),
                //               ),
                //             ],
                //           ),
                //         ),
                //         Switch(
                //           activeTrackColor: AppColor.circleIndicator,
                //           activeColor: AppColor.white,
                //           value: privacyController.location.value,
                //           onChanged: (value) {
                //             privacyController.toggleLocationAccess(value);
                //
                //           },
                //         ),
                //       ],
                //     ),
                //   );
                // }),
                        SizedBox(height: 15,),
                       ///Notifications///
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Get.to(() => NotificationSetting());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out elements
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset("assets/noti.svg"),
                                        SizedBox(width: 10,),

                                        const Text(
                                          "Notifications",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: Colors.black, )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15,),
                        //Friend Requests///
                        Obx(() {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/frndRequest.svg",
                                  height: 18, // Adjust size as needed
                                ),
                                SizedBox(width: 10,),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Allow everyone to send you friend request',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Manage who can send you joining request",
                                        style: MyTextTheme.subtitle.copyWith(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Switch(
                                  activeTrackColor: AppColor.circleIndicator,
                                  activeColor: AppColor.white,
                                  value: requestController.selectedIndex.value == 0,
                                  onChanged: (value) {
                                    requestController.selectItem(value ? 0 : 1);
                                  },
                                ),
                              ],
                            ),
                          );
                        }),
                        // buildSettingItem(
                        //     title: 'Notifications',
                        //     subtitle: 'Manage your notification preferences.',
                        //     onTap: () {
                        //       Dialogs.showCustomDialog(
                        //           context: context,
                        //           content: Column(
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 Obx(
                        //                       () => Column(
                        //                     crossAxisAlignment: CrossAxisAlignment.start,
                        //                     children: [
                        //                       SwitchListTile(
                        //                         activeTrackColor: AppColor.circleIndicator,
                        //                         title: const Text(
                        //                           'Pause all',
                        //                           style: TextStyle(color: Colors.white),
                        //                         ),
                        //                         value: notificationSettingController.pauseAll.value,
                        //                         onChanged: (value) {
                        //                           print("value $value");
                        //                           notificationSettingController.pauseAll.value = value;
                        //                           notificationSettingController.registerUser();
                        //                           notificationSettingController.updateScheduler();
                        //                           showToast(msg: 'Settings Updated', bgColor: Colors.black);
                        //                         },
                        //                       ),
                        //                       Padding(
                        //                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        //                         child: Text(
                        //                           'Temporarily pause notifications',
                        //                           style: MyTextTheme.smallGCN,
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ]
                        //           )
                        //       );
                        //     }),


        //                 buildSettingItem(
        //                   title: 'Notifications',
        //                   subtitle: 'Manage your notification preferences.',
        //                   onTap: () {
        //                     Dialogs.showCustomDialog(
        //                       context: context,
        //                       content: Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           Obx(
        //                                 () => Column(
        //                               crossAxisAlignment: CrossAxisAlignment.start,
        //                               children: [
        //                                 SwitchListTile(
        //                                   activeTrackColor: AppColor.circleIndicator,
        //                                   title: const Text(
        //                                     'Pause all',
        //                                     style: TextStyle(color: Colors.white),
        //                                   ),
        //                                   value: notificationSettingController.pauseAll.value,
        //                                   onChanged: (value) {
        //                                     print("value $value");
        //                                     notificationSettingController.pauseAll.value = value;
        //                                     notificationSettingController.registerUser();
        //                                     notificationSettingController.updateScheduler();
        //                                     showToast(msg: 'Settings Updated', bgColor: Colors.black);
        //                                   },
        //                                 ),
        //                                 Padding(
        //                                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //                                   child: Text(
        //                                     'Temporarily pause notifications',
        //                                     style: MyTextTheme.smallGCN,
        //                                   ),
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        // ]
        //                       )
        //                       );
        //                   }),



                        // buildSettingItem(
                        //   title: 'Friend Request',
                        //   subtitle: 'Manage who can send you joining request',
                        //   onTap: () {
                        //     // Dialogs.showCustomDialog(
                        //     //   context: context,
                        //     //   content:Padding(
                        //     //     padding: const EdgeInsets.all(16.0),
                        //     //     child: SingleChildScrollView(
                        //     //       child: Column(
                        //     //         children: [
                        //     //           SizedBox(height: 10),
                        //     //           for (int i = 0; i < 2; i++)
                        //     //             GestureDetector(
                        //     //               onTap: () {
                        //     //                 requestController.selectItem(i);
                        //     //               },
                        //     //               child: Padding(
                        //     //                 padding: const EdgeInsets.symmetric(vertical: 12.0),
                        //     //                 child: Row(
                        //     //                   mainAxisAlignment: MainAxisAlignment.center,
                        //     //                   children: [
                        //     //                     Obx(() {
                        //     //                       return Container(
                        //     //                         height: 30,
                        //     //                         width: 200,
                        //     //                         decoration: BoxDecoration(
                        //     //                           borderRadius: BorderRadius.circular(12),
                        //     //                           color: requestController.selectedIndex.value == i?
                        //     //                               AppColor.circleIndicator:Colors.white70
                        //     //                         ),
                        //     //                         child: Center(
                        //     //                           child: Text(
                        //     //                              getOptionText(i),
                        //     //
                        //     //                             style: TextStyle(
                        //     //                               fontWeight:  requestController.selectedIndex.value == i?
                        //     //                                   FontWeight.bold:
                        //     //                                   FontWeight.normal,
                        //     //                               color: requestController.selectedIndex.value == i?
                        //     //                                   Colors.white:
                        //     //                                   Colors.black
                        //     //                             )
                        //     //
                        //     //                           ),
                        //     //                         ),
                        //     //
                        //     //                       );
                        //     //                     }),
                        //     //                     // Obx(() {
                        //     //                     //   return requestController.selectedIndex.value == i
                        //     //                     //       ? Icon(Icons.check, color: Colors.green)
                        //     //                     //       : SizedBox();
                        //     //                     // }),
                        //     //                   ],
                        //     //                 ),
                        //     //               )
                        //     //             ),
                        //     //         ],
                        //     //       ),
                        //     //     ),
                        //     //   ),
                        //     // );
                        //     Get.to(() => RequestView());
                        //
                        //   },
                        //     imagePath:"assets/frndrqst.svg"
                        //
                        // ),

                        // Obx(()=> buildSettingItem(
                        //     title: 'Pre Namaz Alert',
                        //     subtitle: notificationSettingController.preNamazAlertName.value,
                        //     onTap: () {
                        //       Dialogs.showCustomDialog(
                        //         context: context,
                        //         content: Padding(
                        //           padding: const EdgeInsets.all(16.0),
                        //           child: SingleChildScrollView(
                        //             child: Column(
                        //               children: [
                        //                 GetBuilder<NotificationSettingController>(
                        //                     id: 'alert',
                        //                     builder: (_) {
                        //                       return ListView.builder(
                        //                           shrinkWrap: true,
                        //                           itemCount: notificationSettingController.preNamazAlertList.length,
                        //                           itemBuilder: (context, index) {
                        //                             // Get the current day mapping
                        //                             var day = notificationSettingController.preNamazAlertList[index];
                        //                             return
                        //                               ListTile(
                        //                                 title: Container(
                        //                                   height: 30,
                        //                                   decoration: BoxDecoration(
                        //                                     borderRadius: BorderRadius.circular(10),
                        //                                     color:  notificationSettingController.preNamazAlertId == day['id']?
                        //                                     AppColor.circleIndicator:Colors.white70,
                        //                                   ),
                        //                                   child: Center(
                        //                                     child: Text(
                        //                                       day['name'],
                        //                                       style: TextStyle(
                        //                                           fontWeight: notificationSettingController.preNamazAlertId == day['id']
                        //                                               ? FontWeight.bold
                        //                                               : FontWeight.normal,
                        //                                           color: notificationSettingController.preNamazAlertId == day['id']?
                        //                                           Colors.white:Colors.black
                        //                                       ),
                        //                                     ),
                        //                                   ),
                        //                                 ),
                        //                                 onTap: () {
                        //                                   notificationSettingController.updateSelectedId(day['id']);
                        //                                   notificationSettingController.updateScheduler();
                        //
                        //                                   // namazAlertController.selectItem(day['id']);
                        //                                 },
                        //                               );
                        //
                        //
                        //                           });
                        //                     }
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //     imagePath:"assets/notifi.svg"
                        // ),
                        // ),
                        //
                        // buildSettingItem(
                        //   title: 'Privacy & Security',
                        //   subtitle: 'Manage your privacy and security settings.',
                        //   onTap: () {
                        //     Dialogs.showCustomDialog(
                        //       context: context,
                        //       content : Padding(
                        //         padding: const EdgeInsets.all(12.0),
                        //         child: Obx(
                        //               () => Column(
                        //             mainAxisSize: MainAxisSize.min,
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               SwitchListTile(
                        //                 activeTrackColor: AppColor.circleIndicator,
                        //                 activeColor: AppColor.white,
                        //                 title: const Text(
                        //                   'Location',
                        //                   style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),
                        //                 ),
                        //                 value: privacyController.location.value,
                        //                 onChanged: (value) => privacyController.toggleLocationAccess(value),
                        //               ),
                        //               Padding(
                        //                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        //                 child: Text(
                        //                   'Allow location access to provide accurate data according to your location.',
                        //                   style: MyTextTheme.smallGCN,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //
                        //       ));
                        //
                        //   },
                        //     imagePath:"assets/privacy.svg"
                        // ),
                        //
                        //
                        //
                        // buildSettingItem(
                        //   title: 'Program Access & Permissions',
                        //   subtitle: 'Make sure permissions are enabled',
                        //   onTap: () {
                        //     Dialogs.showCustomDialog(context: context, content: Column(
                        //       children: [
                        //         Text('To get Prayer updates in home screen widgets without any problem, make sure that all the following are enabled.',
                        //         style: TextStyle(color: Colors.white60,fontSize: 10),textAlign: TextAlign.center,),
                        //         SizedBox(height: 20,),
                        //         TextButton(
                        //           onPressed: (){
                        //             Get.back();
                        //
                        //             const platform = MethodChannel('com.criteriontech.prayeroclock/update_widget');
                        //
                        //             Future<void> checkBatteryOptimizationStatus() async {
                        //               try {
                        //                 final bool? isDisabled = await platform.invokeMethod('disableBatteryOptimization');
                        //
                        //                 if (isDisabled == true) {
                        //                   print("Battery optimization is already disabled.");
                        //                   showToast(msg: 'Battery optimization is already disabled.');
                        //                 } else if (isDisabled == false) {
                        //                   print("Battery optimization request sent to settings.");
                        //                 } else {
                        //                   print("Battery optimization status is not applicable for this device.");
                        //                 }
                        //               } on PlatformException catch (e) {
                        //                 print("Failed to check battery optimization: ${e.message}");
                        //               }
                        //             }
                        //             checkBatteryOptimizationStatus();
                        //
                        //           },
                        //           child: Row(
                        //             children: [
                        //               Container(
                        //                 width: 25,
                        //                 height: 25,
                        //                 alignment: Alignment.center,
                        //                 decoration: const BoxDecoration(
                        //                   color: Colors.white70,
                        //                   shape: BoxShape.circle,
                        //                 ),
                        //                 child: const Text('1')
                        //               ),
                        //               SizedBox(width: 15,),
                        //               Expanded(
                        //                 child: Text('Disable Battery Optimization',style: TextStyle(
                        //                   color: Colors.white70
                        //                 ),),
                        //               ),
                        //               Icon(Icons.arrow_forward,color: Colors.white70,)
                        //             ],
                        //           ),
                        //         ),
                        //         SizedBox(height: 20,),
                        //         TextButton(
                        //           onPressed: (){
                        //             const platform = MethodChannel('com.criteriontech.prayeroclock/update_widget');
                        //             Future<void> enableAutostart() async {
                        //               try {
                        //                 final String? result = await platform.invokeMethod('enableAutostart');
                        //                 if (result == "success") {
                        //                   showToast(msg: 'Redirected to autostart settings.');
                        //                 }
                        //               } on PlatformException catch (e) {
                        //                 print("Failed to enable autostart: ${e.message}");
                        //                 showToast(msg: 'Failed to open autostart settings.');
                        //               }
                        //             }
                        //             enableAutostart();
                        //           },
                        //           child: Row(
                        //             children: [
                        //               Container(
                        //                   width: 25,
                        //                   height: 25,
                        //                   alignment: Alignment.center,
                        //                   decoration: const BoxDecoration(
                        //                     color: Colors.white70,
                        //                     shape: BoxShape.circle,
                        //                   ),
                        //                   child: const Text('2')
                        //               ),
                        //               SizedBox(width: 15,),
                        //               Expanded(
                        //                 child: Text('Enable Autostart',style: TextStyle(
                        //                     color: Colors.white70
                        //                 ),),
                        //               ),
                        //               Icon(Icons.arrow_forward,color: Colors.white70,)
                        //             ],
                        //           ),
                        //         ),
                        //       ],
                        //     ));
                        //   },
                        //     imagePath:"assets/privacy.svg"
                        // ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget buildSettingItem( {
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    String? imagePath,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              imagePath != null
                  ? SvgPicture.asset(
                imagePath,
                height: 22,
                width: 22,
              )
                  : Container(),
            ],
          ),
          title: Text(
            title,
            style: MyTextTheme.mediumB,
          ),
          subtitle: subtitle != null && subtitle.isNotEmpty
              ? Text(subtitle, style: TextStyle(color: Colors.grey,fontSize: 14))
              : null,
          trailing: const SizedBox(
            width: 5,
              child: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black)),
          onTap: onTap,
        ),
      ],
    );
  }

        String getOptionText(int index) {
      switch (index) {
        case 0:
          return "Everyone";
        case 1:
          return "None";
        default:
          return "";
      }
    }

}

