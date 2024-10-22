import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Setting/SettingController.dart';
import 'package:namaz_reminders/Setting/SettingView.dart';
import '../../Routes/approutes.dart';
import '../../Widget/appColor.dart';
import '../../Widget/text_theme.dart';
import 'friendRequestController.dart';

class RequestView extends GetView<SettingController>{
  @override
  Widget build(BuildContext context) {
    final RequestController requestController = Get.put(RequestController());


    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('Friend Request', style: MyTextTheme.mediumBCD),
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
              // Get.to(
              //       () => SettingView(),
              //   transition: Transition.rightToLeft,
              //   duration: Duration(milliseconds: 500),
              //   curve: Curves.ease,
              // );
            },
            child: const Icon(Icons.arrow_back_ios_new,size: 20,),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                for (int i = 0; i < 3; i++)
                  GestureDetector(
                    onTap: () {
                      requestController.selectItem(i);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            return Text(
                              _getOptionText(i), // Get the appropriate text
                              style: requestController.selectedIndex.value == i
                                  ? MyTextTheme.mediumB2.copyWith(fontWeight: FontWeight.bold)
                                  : MyTextTheme.mediumB2,
                            );
                          }),
                          Obx(() {
                            return requestController.selectedIndex.value == i
                                ? Icon(Icons.check, color: Colors.green)
                                : SizedBox();
                          }),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        )
    );
  }

}
// This method can return different texts for options
String _getOptionText(int index) {
  switch (index) {
    case 0:
      return "Everyone";
    case 1:
      return "No one";
    default:
      return "";
  }
}


