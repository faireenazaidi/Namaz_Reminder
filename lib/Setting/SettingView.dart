import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Notification/NotificationSetting/notificationSettingView.dart';
import 'package:namaz_reminders/Setting/FriendRequests/friendRequestView.dart';
import 'package:namaz_reminders/Setting/HijriDate/hijriDate.dart';
import '../DashBoard/dashboardView.dart';
import '../Routes/approutes.dart';
import '../Widget/appColor.dart';
import '../Widget/text_theme.dart';
import 'Privacy&Security/privacyView.dart';
import 'SettingController.dart';

class SettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      init: SettingController(),
      builder: (controller) {
        return Scaffold(
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
                // Get.to(
                //       () => DashBoardView(),
                //   transition: Transition.leftToRight,
                //   duration: Duration(milliseconds: 500),
                //   curve: Curves.ease,
                // );
              },
              child: const Icon(Icons.arrow_back_ios_new,size: 20,),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: 10,),
                // Search Bar
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColor.searchbarColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    cursorColor: AppColor.circleIndicator,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search for a setting..",
                      hintStyle: MyTextTheme.mediumCustomGCN,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:  BorderSide(color:AppColor.packageGray,
                            width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey,
                            width: 1),
                      ),
                    ),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 10),
                // Settings List
                Expanded(
                  child: ListView(
                    children: [
                      buildSettingItem(
                        title: 'Hijri Date Adjustment',
                        subtitle: 'One day ahead',
                        onTap: () {
                          Get.to(
                                () => HijriDateView(),
                            transition: Transition.leftToRight,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );

                        },
                        imagePath:"assets/hijri.svg"
                      ),

                      // buildSettingItem(
                      //   title: 'Prayer Time Setting',
                      //   subtitle: '5 times',
                      //   onTap: () {
                      //     Get.to(() => PrayTimeView());
                      //   },
                      //     imagePath:"assets/prayertime.svg"
                      // ),
                      buildSettingItem(
                        title: 'Notifications',
                        subtitle: '',
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
                      // buildSettingItem(
                      //   title: 'App Language',
                      //   subtitle: 'English',
                      //   onTap: () {
                      //     Get.to(() => AppLangView());
                      //   },
                      //     imagePath:"assets/language.svg"
                      // ),
                      buildSettingItem(
                        title: 'Privacy & Security',
                        subtitle: '',
                        onTap: () {
                          Get.to(() => PrivacyView(),
                            transition: Transition.leftToRight,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,);
                        },
                          imagePath:"assets/privacy.svg"
                      ),

                    ],
                  ),
                ),
              ],
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
          trailing: SizedBox(
            width: 5,
              child: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black)),
          onTap: onTap,
        ),
      ],
    );
  }
}
