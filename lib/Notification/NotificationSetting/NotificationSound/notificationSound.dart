import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Notification/NotificationSetting/notificationSettingView.dart';
import '../../../Widget/appColor.dart';
import '../../../Widget/text_theme.dart';
import 'notificationSoundController.dart';

class NotificationSound extends GetView<NotificationSoundController>{
  Widget build(BuildContext context) {
    final NotificationSoundController notificationSoundController = Get.put(NotificationSoundController());


    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Notification Sound', style: MyTextTheme.mediumBCD),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Divider(
            height: 1.5,
            color: AppColor.packageGray,
          ),
        ),
        leading: InkWell(
          onTap: () {
            // Get.back();
            Get.to(()=>NotificationSetting());
          },
          child: const Icon(Icons.arrow_back_ios_new,size: 20,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5),
              for (int i = 0; i < 5; i++)
                GestureDetector(
                  onTap: () {
                    notificationSoundController.selectItem(i);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            return Text(
                              _getOptionText(i), // Get the appropriate text
                              style: notificationSoundController.selectedIndex.value == i
                                  ? MyTextTheme.mediumB2.copyWith(fontWeight: FontWeight.bold)
                                  : MyTextTheme.mediumB2,
                            );
                          }),
                          Obx(() {
                            return notificationSoundController.selectedIndex.value == i
                                ? Icon(Icons.check, color: Colors.green)
                                : SizedBox();
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),


    );
  }

}
// This method can return different texts for options
String _getOptionText(int index) {
  switch (index) {
    case 0:
      return "Call to Prayer";
    case 1:
      return "Classic";
    case 2:
      return "Beap";
    case 3:
      return "Beep Beep";
    default:
      return "";
  }
}


