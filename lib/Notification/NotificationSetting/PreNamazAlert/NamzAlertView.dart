import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Widget/appColor.dart';
import '../../../Widget/text_theme.dart';
import '../notificationSettingController.dart';
import 'NamazAlertController.dart';

class NamazAlertView extends GetView<NotificationSettingController>{
  @override
  Widget build(BuildContext context) {



    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('Pre Namaz Alert', style: MyTextTheme.mediumBCD),
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
              Get.back();          },
            child: const Icon(Icons.arrow_back_ios_new,size: 20,),
          ),
        ),
        // body: Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: SingleChildScrollView(
        //     child: Column(
        //       children: [
        //         SizedBox(height: 5),
        //         for (int i = 0; i < 5; i++)
        //           GestureDetector(
        //             onTap: () {
        //               namazAlertController.selectItem(i);
        //             },
        //             child: Padding(
        //               padding: const EdgeInsets.symmetric(vertical: 12.0),
        //               child: Container(
        //                 width: double.infinity,
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Obx(() {
        //                       return Text(
        //                         _getOptionText(i), // Get the appropriate text
        //                         style: namazAlertController.selectedId.value == i
        //                             ? MyTextTheme.mediumB2.copyWith(fontWeight: FontWeight.bold)
        //                             : MyTextTheme.mediumB2,
        //                       );
        //                     }),
        //                     Obx(() {
        //                       return namazAlertController.selectedId.value == i
        //                           ? Icon(Icons.check, color: Colors.green)
        //                           : SizedBox();
        //                     }),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //       ],
        //     ),
        //   ),
        // ),
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
// This method can return different texts for options
String _getOptionText(int index) {
  switch (index) {
    case 0:
      return "15 minutes ago";
    case 1:
      return "10 minutes ago";
    case 2:
      return "5 minutes ago";
    case 3:
      return "No Alert";
    default:
      return "";
  }
}


