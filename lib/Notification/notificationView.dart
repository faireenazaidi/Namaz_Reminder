import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Notification/notificationController.dart';
import '../Routes/approutes.dart';
import '../Widget/appColor.dart';
import '../Widget/text_theme.dart';
import 'NotificationSetting/notificationSettingView.dart';

class NotificationView extends GetView<NotificationController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Notifications', style: MyTextTheme.mediumBCD),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Divider(
            height: 1.0,
            color: AppColor.packageGray,
          ),
        ),
        leading: InkWell(
          onTap: () {
            // Get.back();
            Get.toNamed(AppRoutes.dashboardRoute);
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.to(() => NotificationSetting ());

            },
            child:SvgPicture.asset(
                "assets/set.svg",height: 25,color: AppColor.greyDark,
            ),
          ),
        ],
      ),
      body:   Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Today", style: MyTextTheme.greyNormal.copyWith(color: AppColor.textDarkGrey,fontSize: 14)),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount:3,
              itemBuilder: (context, index) {

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // Profile Picture
                     CircleAvatar(
                       radius: 20,
                       backgroundColor: AppColor.circleIndicator,
                       child: Icon(Icons.person,color: Colors.white,size: 20,),
                     ),

                    ],
                  ),
                );
              },
            ),
            Divider(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Yesterday", style: MyTextTheme.greyNormal.copyWith(color: AppColor.textDarkGrey,fontSize: 14)),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount:3,
              itemBuilder: (context, index) {

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // Profile Picture
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColor.circleIndicator,
                        child: Icon(Icons.person,color: Colors.white,size: 20,),
                      ),

                    ],
                  ),
                );
              },
            ),
            Divider(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Last 7 days", style: MyTextTheme.greyNormal.copyWith(color: AppColor.textDarkGrey,fontSize: 14)),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount:3,
              itemBuilder: (context, index) {

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // Profile Picture
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColor.circleIndicator,
                        child: Icon(Icons.person,color: Colors.white,size: 20,),
                      ),

                    ],
                  ),
                );
              },
            ),

          ],
        ),
      ),

    );
  }

}