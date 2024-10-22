import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Setting/HijriDate/hijriController.dart';
import 'package:namaz_reminders/Setting/SettingController.dart';
import 'package:namaz_reminders/Setting/SettingView.dart';
import '../../DashBoard/dashboardController.dart';
import '../../Routes/approutes.dart';
import '../../Widget/appColor.dart';
import '../../Widget/text_theme.dart';

class HijriDateView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    final HijriController hijriController = Get.put(HijriController());
    final DashBoardController dashboardController = Get.put(DashBoardController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Hijri Date Adjustment', style: MyTextTheme.mediumBCD),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Divider(
            height: 1.5,
            color: AppColor.packageGray,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.to(
                  () => SettingView(),
              transition: Transition.rightToLeft,
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
          child: const Icon(Icons.arrow_back_ios_new, size: 20),
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
                    hijriController.selectItem(i); // Update selection in HijriController
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
                              _getOptionText(i),
                              style: hijriController.selectedIndex.value == i
                                  ? MyTextTheme.mediumB2.copyWith(fontWeight: FontWeight.bold)
                                  : MyTextTheme.mediumB2,
                            );
                          }),
                          Obx(() {
                            return hijriController.selectedIndex.value == i
                                ? Icon(Icons.check, color: Colors.green)
                                : SizedBox();
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              // Displaying the updated Hijri date from DashboardController
              // Obx(
              //       () => Text(
              //     dashboardController.islamicDate.value, // Show updated Islamic date
              //     style: const TextStyle(fontSize: 12, color: Colors.black),
              //     overflow: TextOverflow.ellipsis,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // This method returns different texts for the options
  String _getOptionText(int index) {
    switch (index) {
      case 0:
        return "Two days ago";
      case 1:
        return "One day ago";
      case 2:
        return "None";
      case 3:
        return "One day ahead";
      case 4:
        return "Two days ahead";
      default:
        return "";
    }
  }
}

