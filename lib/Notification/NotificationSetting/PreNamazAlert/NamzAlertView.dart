import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Drawer/drawerController.dart';
import '../../../Widget/appColor.dart';
import '../../../Widget/text_theme.dart';
import '../notificationSettingController.dart';

class NamazAlertView extends GetView<NotificationSettingController>{
  @override
  Widget build(BuildContext context) {
    final CustomDrawerController customDrawerController = Get.find<CustomDrawerController>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text('Pre Namaz Alert', style: MyTextTheme.mediumBCD.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Divider(
            height: 1.5,
            color: customDrawerController.isDarkMode == true? AppColor.scaffBg:AppColor.packageGray,
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
                child: const Icon(Icons.arrow_back_ios_new,size: 20,)),
          ),
        ),
      ),
     body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder<NotificationSettingController>(
                id: 'alert',
                  builder: (_) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.preNamazAlertList.length,
                        itemBuilder: (context, index) {
                          // Get the current day mapping
                          var day = controller.preNamazAlertList[index];
                          return
                              ListTile(
                                title: Text(
                                  day['name'],
                                  style: TextStyle(
                                    color: customDrawerController.isDarkMode == true
                                  ? (controller.preNamazAlertId == day['id']
                                  ? Colors.white
                                      : AppColor.greyColor)
                                      : AppColor.black,


                                  fontWeight: controller.preNamazAlertId == day['id']
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                                  ),
                                ),
                                trailing: controller.preNamazAlertId == day['id']
                                    ? const Icon(Icons.check, color: Colors.green)
                                    : null,
                                onTap: () {
                                  controller.updateSelectedId(day['id']);
                                  // namazAlertController.selectItem(day['id']);
                                },
                              );
                        });
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}



