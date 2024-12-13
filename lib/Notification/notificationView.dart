import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Notification/notificationController.dart';
import '../DashBoard/dashboardView.dart';
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
            // Get.to(
            //       () => DashBoardView(),
            //   transition: Transition.leftToRight,
            //   duration: Duration(milliseconds: 500),
            //   curve: Curves.ease,
            // );
          },
          child: Icon(Icons.arrow_back_ios_new,size: 20,),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.to(() => NotificationSetting (),
                transition: Transition.rightToLeft,
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,);

            },
            child:SvgPicture.asset(
                "assets/set.svg",height: 25,color: AppColor.greyDark,
            ),
          ),
        ],
      ),
    );
  }

}