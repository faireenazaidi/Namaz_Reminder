import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Notification/NotificationSetting/notificationSettingView.dart';
import 'package:namaz_reminders/Setting/FriendRequests/friendRequestView.dart';
import 'package:namaz_reminders/Setting/HijriDate/hijriDate.dart';
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
