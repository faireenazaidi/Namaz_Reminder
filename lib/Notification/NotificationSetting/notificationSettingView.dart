import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Notification/NotificationSetting/PreNamazAlert/NamzAlertView.dart';
import 'package:namaz_reminders/UpcomingPrayers/upcomingView.dart';
import '../../Routes/approutes.dart';
import '../../Widget/appColor.dart';
import '../../Widget/text_theme.dart';
import 'NotificationSound/notificationSound.dart';
import 'notificationSettingController.dart';


class NotificationSetting extends StatelessWidget {
  final NotificationSettingController notificationSettingsController = Get.put(NotificationSettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Notification Settings', style: MyTextTheme.mediumBCD),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Divider(
            height: 1.0,
            color: AppColor.packageGray,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.notifications);
          },
          child: Icon(Icons.arrow_back_ios_new,size: 20,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Notification Sound//
            ListTile(
              title: Text('Notification Sound',style: MyTextTheme.medium2,),
              subtitle: Text('Default (Classic)',style: MyTextTheme.smallGCN,),
              trailing:Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black),
              onTap: () {
                Get.to(() => NotificationSound());
              },
            ),
            SizedBox(height: 5,),
            //Upcoming Prayers//
            ListTile(
              title: Text('Upcoming Prayers',style: MyTextTheme.medium2,),
              subtitle: Text('Default (Call to Prayer)',style: MyTextTheme.smallGCN,),
              trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black),
              onTap: () {
                Get.to (()=> Upcoming());

              },
            ),
            SizedBox(height: 5,),
            //PAUse//
            Obx(() => SwitchListTile(
              activeTrackColor: AppColor.circleIndicator,
              title: Text('Pause all',style: MyTextTheme.medium2,),
              subtitle: Text('Temporarily pause notifications',style: MyTextTheme.smallGCN,),
              value: notificationSettingsController.pauseAll.value,
              onChanged: (value) {
                print("value $value");
                notificationSettingsController.pauseAll.value = value;
                notificationSettingsController.registerUser();
              },
            )
            ),

            SizedBox(height: 5,),

            //Quiet Mode//
            Obx(() => SwitchListTile(
              activeTrackColor: AppColor.circleIndicator,
              title: Text('Quiet mode',style: MyTextTheme.medium2,),
              subtitle: Text('Automatically mute notifications at night or whenever you need to focus.',style: MyTextTheme.smallGCN,),
              value: notificationSettingsController.quietMode.value,
              onChanged: (value) {
                notificationSettingsController.quietMode.value = value;
                notificationSettingsController.registerUser();
              },
            )
            ),

            SizedBox(height: 5,),

            //Requests//
            Obx(() => SwitchListTile(
              activeTrackColor: AppColor.circleIndicator,              title: Text('Friend requests',style: MyTextTheme.medium2,),
              subtitle: Text('Notify when someone sends you a joining request',style: MyTextTheme.smallGCN,),
              value: notificationSettingsController.friendRequests.value,
              onChanged: (value) {
                notificationSettingsController.friendRequests.value = value;
                notificationSettingsController.registerUser();
              },
            )
            ),

            SizedBox(height: 5,),

            //Prayed Namaz//
            Obx(() => SwitchListTile(
              activeTrackColor: AppColor.circleIndicator,
              title: Text('Friend Namaz Prayed',style: MyTextTheme.medium2,),
              value: notificationSettingsController.friendNamazPrayed.value,
              onChanged: (value) {
                notificationSettingsController.friendNamazPrayed.value = value;
                notificationSettingsController.registerUser();
              },
            )
            ),

            SizedBox(height: 5,),

            //Namaz Alert//
            ListTile(
              title: Text('Pre Namaz Alert',style: MyTextTheme.medium2,),
              subtitle: Text('15 min ago',style: MyTextTheme.smallGCN,),
              trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black),
              onTap: () {
              Get.to(()=>NamazAlertView());
              },
            ),
          ],
        ),
      ),
    );
  }
}