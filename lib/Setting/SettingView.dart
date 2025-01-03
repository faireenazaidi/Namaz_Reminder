import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Notification/NotificationSetting/notificationSettingView.dart';
import 'package:namaz_reminders/Setting/FriendRequests/friendRequestView.dart';
import 'package:namaz_reminders/Setting/HijriDate/hijriController.dart';
import 'package:namaz_reminders/Setting/HijriDate/hijriDate.dart';
import '../AppManager/dialogs.dart';
import '../AppManager/toast.dart';
import '../Widget/appColor.dart';
import '../Widget/text_theme.dart';
import 'Privacy&Security/privacyView.dart';
import 'SettingController.dart';

class SettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HijriController hijriController = Get.put(HijriController());
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
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  /// This Searchbar is temporarily hidden///
                  SizedBox(height: 10),
                  // Settings List
                  Expanded(
                    child: ListView(
                      children: [
                        // buildSettingItem(
                        //   title: 'Hijri Date Adjustment',
                        //   subtitle:hijriController.getCurrentSubtitle(),
                        //   onTap: () {
                        //     Get.to(
                        //           () => HijriDateView(),
                        //       transition: Transition.leftToRight,
                        //       duration: Duration(milliseconds: 500),
                        //       curve: Curves.ease,
                        //     );
                        //   },
                        //   imagePath:"assets/hijri.svg"
                        // ),
                        Obx(() => buildSettingItem(
                          title: 'Hijri Date Adjustment',
                          subtitle: hijriController.getCurrentSubtitle(),
                          onTap: () {
                            Get.to(
                                  () => HijriDateView(),
                              transition: Transition.leftToRight,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          imagePath: "assets/hijri.svg",
                        )
                        ),
                        buildSettingItem(
                          title: 'Notifications',
                          subtitle: 'Manage your notification preferences.',
                          onTap: () {
                            Get.to(() => NotificationSetting(),
                              transition: Transition.leftToRight,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,);
                          },
                            imagePath:"assets/notifi.svg"
                        ),
                        buildSettingItem(
                          title: 'Friend Request',
                          subtitle: 'Manage who can send you joining request',
                          onTap: () {
                            Get.to(() => RequestView(),
                              transition: Transition.leftToRight,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,);
                          },
                            imagePath:"assets/frndrqst.svg"
                        ),
                        buildSettingItem(
                          title: 'Privacy & Security',
                          subtitle: 'Manage your privacy and security settings.',
                          onTap: () {
                            Get.to(() => PrivacyView(),
                              transition: Transition.leftToRight,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,);
                          },
                            imagePath:"assets/privacy.svg"
                        ),
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

  Widget buildSettingItem({
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
}
