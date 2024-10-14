import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Setting/SettingController.dart';
import '../../Routes/approutes.dart';
import '../../Widget/appColor.dart';
import '../../Widget/text_theme.dart';
import 'AppLangController.dart';

class AppLangView extends GetView<SettingController>{
  @override
  Widget build(BuildContext context) {
    final AppLangController appLangController = Get.put(AppLangController());


    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('App Language', style: MyTextTheme.mediumBCD),
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
              Get.toNamed(AppRoutes.settingRoute);
            },
            child: const Icon(Icons.arrow_back_ios_new,),
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              for (int i = 0; i < 5; i++)
                GestureDetector(
                  onTap: () {
                    appLangController.selectItem(i);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          return Text(
                            _getOptionText(i), // Get the appropriate text for each row
                            style: appLangController.selectedIndex.value == i
                                ? MyTextTheme.mediumB2.copyWith(fontWeight: FontWeight.bold)
                                : MyTextTheme.mediumB2,
                          );
                        }),
                        Obx(() {
                          return appLangController.selectedIndex.value == i
                              ? Icon(Icons.check, color: Colors.green) // Show checkmark if selected
                              : SizedBox(); // Empty widget if not selected
                        }),
                      ],
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
      return "English";
    case 1:
      return "हिन्दी";
    case 2:
      return "اُردو";
    default:
      return "";
  }
}


