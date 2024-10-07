import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:namaz_reminders/Notification/Setting/settingController.dart';
import '../../Routes/approutes.dart';
import '../../Widget/appColor.dart';
import '../../Widget/text_theme.dart';

class SettingView extends GetView<SettingController> {
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
           Get.toNamed(AppRoutes.notifications);
         },
         child: Icon(Icons.arrow_back_ios_new),
       ),
     ),
     body: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(
         children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               children: [
                 Text("Push Notifications", style: MyTextTheme.greyNormal.copyWith(color: AppColor.textDarkGrey,fontSize: 14)),
               ],
             ),
           )

         ],
       ),
     ),
   );
  }
}