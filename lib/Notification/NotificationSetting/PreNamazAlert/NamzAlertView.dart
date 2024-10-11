import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Routes/approutes.dart';
import '../../../Widget/appColor.dart';
import '../../../Widget/text_theme.dart';
import 'NamazAlertController.dart';

class NamazAlertView extends GetView<NamazAlertController>{
  Widget build(BuildContext context) {
    final NamazAlertController namazAlertController = Get.put(NamazAlertController());


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
            Get.toNamed(AppRoutes.notifications);
          },
          child: const Icon(Icons.arrow_back_ios_new,),
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
                    namazAlertController.selectItem(i);
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
                              style: namazAlertController.selectedIndex.value == i
                                  ? MyTextTheme.mediumB2.copyWith(fontWeight: FontWeight.bold)
                                  : MyTextTheme.mediumB2,
                            );
                          }),
                          Obx(() {
                            return namazAlertController.selectedIndex.value == i
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


