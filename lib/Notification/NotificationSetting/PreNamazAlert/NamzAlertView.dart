import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Widget/appColor.dart';
import '../../../Widget/text_theme.dart';
import '../notificationSettingController.dart';

class NamazAlertView extends GetView<NotificationSettingController>{
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text('Pre Namaz Alert', style: MyTextTheme.mediumBCD.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color)),
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
       body:  Padding(
          padding: const EdgeInsets.all(16.0),
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
                                      fontWeight: controller.preNamazAlertId == day['id']
                                          ? FontWeight.bold
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
      ),
    );
  }
}



