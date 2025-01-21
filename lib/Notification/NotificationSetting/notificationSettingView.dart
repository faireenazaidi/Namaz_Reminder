import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../AppManager/toast.dart';
import '../../Widget/appColor.dart';
import '../../Widget/text_theme.dart';
import 'PreNamazAlert/NamzAlertView.dart';
import 'notificationSettingController.dart';


class NotificationSetting extends StatelessWidget {
  final NotificationSettingController notificationSettingsController = Get.put(NotificationSettingController());

   NotificationSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text('Notification Settings', style: MyTextTheme.mediumBCD.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color)),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Divider(
              height: 1.0,
              color: AppColor.packageGray,
            ),
          ),
          leading: InkWell(
            onTap: () {
              Get.back();
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
                title:  Text('Pause all', style:MyTextTheme.smallGCN.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color,),),
                subtitle: Text('Temporarily pause notifications', style: MyTextTheme.smallGCN.copyWith(color: Theme.of(context).textTheme.titleSmall?.color,fontSize: 13)),
                value: notificationSettingsController.pauseAll.value,
                onChanged: (value) {
                  print("value $value");
                  notificationSettingsController.pauseAll.value = value;
                  if (value) {
                    notificationSettingsController.friendRequests.value = false;
                    notificationSettingsController.friendNamazPrayed.value = false;
                  }
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
              //Notify for request//
              // Obx(() => SwitchListTile(
              //   activeTrackColor: AppColor.circleIndicator,
              //   title:  Text('Friend requests',style:MyTextTheme.smallGCN.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color,),),
              //   subtitle: Text('Notify when someone sends you a joining request',
              //       style: MyTextTheme.smallGCN.copyWith(color: Theme.of(context).textTheme.titleSmall?.color,fontSize: 13 )),
              //   value: notificationSettingsController.friendRequests.value,
              //   onChanged: (value) {
              //     notificationSettingsController.friendRequests.value = value;
              //     notificationSettingsController.registerUser();
              //     showToast(msg: 'Settings Updated',bgColor: Colors.black);
              //   },
              // )
             // ),
              Obx(() => SwitchListTile(
                activeTrackColor: AppColor.circleIndicator,
                title: Text(
                  'Friend requests',
                  style: MyTextTheme.smallGCN.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color,),
                ),
                subtitle: Text(
                  'Notify when someone sends you a joining request',
                  style: MyTextTheme.smallGCN.copyWith(color: Theme.of(context).textTheme.titleSmall?.color, fontSize: 13),
                ),
                value: notificationSettingsController.friendRequests.value,
                onChanged: (value) {
                  if (!notificationSettingsController.pauseAll.value) {
                    notificationSettingsController.friendRequests.value = value;
                    notificationSettingsController.registerUser ();
                    showToast(msg: 'Settings Updated', bgColor: Colors.black);
                  }
                },
              )),


              SizedBox(height: 5,),

              //Prayed Namaz//
              Obx(() => SwitchListTile(
                activeTrackColor: AppColor.circleIndicator,
                title: Text('Friend Namaz Prayed',style:MyTextTheme.smallGCN.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color,),),
                subtitle:  Text('Notify when someone mark prayer in your peers.',
                    style: MyTextTheme.smallGCN.copyWith(color: Theme.of(context).textTheme.titleSmall?.color,fontSize: 13 )),
                value: notificationSettingsController.friendNamazPrayed.value,
                onChanged: (value) {
               if (!notificationSettingsController.pauseAll.value) {
                 notificationSettingsController.friendNamazPrayed.value = value;
                 notificationSettingsController.registerUser();
                 showToast(msg: 'Settings Updated', bgColor: Colors.black);
               }
                },
              )
              ),
              SizedBox(height: 5,),
              //Namaz Alert//
                 ListTile(
                  title:  Text('Pre Namaz Alert',style:MyTextTheme.smallGCN.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color,),),
                  subtitle: Obx(() {
                      return Text(notificationSettingsController.preNamazAlertName.value,
                          style: MyTextTheme.smallGCN.copyWith(color: Theme.of(context).textTheme.titleSmall?.color ));
                    }
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
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

