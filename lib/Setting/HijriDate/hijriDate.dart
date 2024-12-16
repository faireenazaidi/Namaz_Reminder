import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Setting/HijriDate/hijriController.dart';
import 'package:namaz_reminders/Setting/SettingController.dart';
import '../../DashBoard/dashboardController.dart';
import '../../Widget/appColor.dart';
import '../../Widget/text_theme.dart';

class HijriDateView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    final HijriController hijriController = Get.put(HijriController());
    final DashBoardController dashboardController = Get.put(DashBoardController());
    print("kkk");
    return SafeArea(
      child: Scaffold(
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
              Get.back(
                //     () => SettingView(),
                // transition: Transition.rightToLeft,
                // duration: Duration(milliseconds: 500),
                // curve: Curves.ease,
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
      GetBuilder<HijriController>(
        builder: (_) {
          return ListView.builder(
            shrinkWrap: true,
          itemCount: hijriController.hijriDateAdjustment.length,
          itemBuilder: (context, index) {
          // Get the current day mapping
          var day = hijriController.hijriDateAdjustment[index];
          return ListTile(
            title: Text(
              day['name'],
              style: TextStyle(
                fontWeight: hijriController.selectedId == day['id']
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            trailing: hijriController.selectedId == day['id']
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () {
              hijriController.updateSelectedId(day['id']);
              hijriController.registerUser();
              hijriController.selectItem(day['id']);
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


