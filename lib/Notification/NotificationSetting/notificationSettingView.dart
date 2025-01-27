import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../AppManager/toast.dart';
import '../../Drawer/drawerController.dart';
import '../../Widget/appColor.dart';
import '../../Widget/text_theme.dart';
import 'PreNamazAlert/NamzAlertView.dart';
import 'notificationSettingController.dart';


class NotificationSetting extends StatelessWidget {
  final NotificationSettingController notificationSettingsController = Get.put(NotificationSettingController());
  final CustomDrawerController customDrawerController = Get.put(CustomDrawerController());

   NotificationSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text('Notification Settings', style: MyTextTheme.mediumBCD.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Divider(
            height: 1.5,
            color: customDrawerController.isDarkMode == true? Colors.black:AppColor.packageGray,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Transform.scale(
            scale:
            MediaQuery.of(context).size.width <360 ? 0.6: 0.7,
            child:   CircleAvatar(
                radius: 12,
                backgroundColor: customDrawerController.isDarkMode == false ? AppColor.cardbg: Colors.white12,
                //Theme.of(context).colorScheme.primary.withOpacity(0), // Example using primary color with adjusted opacity.
                child: const Icon(Icons.arrow_back_ios_new,size: 20,)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => SwitchListTile(
              thumbIcon: WidgetStateProperty.all(
                const Icon(Icons.circle, color: Colors.white),
              ),
              activeTrackColor: AppColor.circleIndicator,
              activeColor: AppColor.white,
              inactiveTrackColor:  customDrawerController.isDarkMode == false ? AppColor.switchin: Colors.white12,
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
              inactiveThumbColor: Colors.white,
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
              thumbIcon: WidgetStateProperty.all(
                const Icon(Icons.circle, color: Colors.white),
              ),
              activeTrackColor: AppColor.circleIndicator,
              activeColor: AppColor.white,
              inactiveTrackColor:  customDrawerController.isDarkMode == false ? AppColor.switchin: Colors.white12,
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
              inactiveThumbColor: Colors.white,
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
              thumbIcon: WidgetStateProperty.all(
                const Icon(Icons.circle, color: Colors.white),
              ),
              activeTrackColor: AppColor.circleIndicator,
              activeColor: AppColor.white,
              inactiveTrackColor:  customDrawerController.isDarkMode == false ? AppColor.switchin: Colors.white12,
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
              inactiveThumbColor: Colors.white,
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
                trailing:  Icon(Icons.arrow_forward_ios, size: 20, color:Theme.of(context).textTheme.titleSmall?.color,),

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

