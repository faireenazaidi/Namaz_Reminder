import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../AppManager/toast.dart';
import '../../Widget/appColor.dart';
import '../../Widget/text_theme.dart';
import 'PreNamazAlert/NamzAlertView.dart';
import 'notificationSettingController.dart';


class NotificationSetting extends StatelessWidget {
  final NotificationSettingController notificationSettingsController = Get.put(NotificationSettingController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              Get.back(

              );
            },
            child: Icon(Icons.arrow_back_ios_new,size: 20,),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => SwitchListTile(
                activeTrackColor: AppColor.circleIndicator,
                title: const Text('Pause all',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400)),
                subtitle: Text('Temporarily pause notifications',style: MyTextTheme.subtitle,),
                value: notificationSettingsController.pauseAll.value,
                onChanged: (value) {
                  print("value $value");
                  notificationSettingsController.pauseAll.value = value;
                  notificationSettingsController.registerUser();
                  showToast(msg: 'Settings Updated',bgColor: Colors.black);
                },
              )
              ),

              SizedBox(height: 5,),

              //Quiet Mode//
              // Obx(() => SwitchListTile(
              //   activeTrackColor: AppColor.circleIndicator,
              //   title: Text('Quiet mode',style: MyTextTheme.medium2,),
              //   subtitle: Text('Automatically mute notifications at night or whenever you need to focus.',style: MyTextTheme.smallGCN,),
              //   value: notificationSettingsController.quietMode.value,
              //   onChanged: (value) {
              //     notificationSettingsController.quietMode.value = value;
              //     notificationSettingsController.registerUser();
              //     showToast(msg: 'Settings Updated',bgColor: Colors.black);
              //
              //   },
              // )
              // ),

              SizedBox(height: 5,),

              //who sends friend request


              //Notify for request//
              Obx(() => SwitchListTile(
                activeTrackColor: AppColor.circleIndicator,
                title: const Text('Friend requests',style:  TextStyle(color: Colors.black,fontWeight: FontWeight.w400)),
                subtitle: Text('Notify when someone sends you a joining request',style: MyTextTheme.subtitle,),
                value: notificationSettingsController.friendRequests.value,
                onChanged: (value) {
                  notificationSettingsController.friendRequests.value = value;
                  notificationSettingsController.registerUser();
                  showToast(msg: 'Settings Updated',bgColor: Colors.black);

                },
              )
              ),

              SizedBox(height: 5,),

              //Prayed Namaz//
              Obx(() => SwitchListTile(
                activeTrackColor: AppColor.circleIndicator,
                title: Text('Friend Namaz Prayed',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400)),
                subtitle:  Text('Notify when someone mark prayer in your peers.',style: MyTextTheme.subtitle,),
                value: notificationSettingsController.friendNamazPrayed.value,
                onChanged: (value) {
                  notificationSettingsController.friendNamazPrayed.value = value;
                  notificationSettingsController.registerUser();
                  showToast(msg: 'Settings Updated',bgColor: Colors.black);

                },
              )
              ),

              SizedBox(height: 5,),

              //Namaz Alert//
                 ListTile(
                  title: const Text('Pre Namaz Alert',style:TextStyle(color: Colors.black,fontWeight: FontWeight.w400)),
                  subtitle: Obx(() {
                      return Text('${notificationSettingsController.preNamazAlertName.value}',style: MyTextTheme.subtitle,);
                    }
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
                  onTap: () {
                  Get.to(()=>NamazAlertView());
                  },
                ),

            ],
          ),
        ),
      ),
    );
  }
}