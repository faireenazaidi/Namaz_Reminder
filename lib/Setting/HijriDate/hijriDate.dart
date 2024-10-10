import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Setting/HijriDate/hijriController.dart';
import 'package:namaz_reminders/Setting/SettingController.dart';
import '../../Routes/approutes.dart';
import '../../Widget/appColor.dart';
import '../../Widget/text_theme.dart';

class HijriDateView extends GetView<SettingController>{
  @override
  Widget build(BuildContext context) {
    final HijriController hijriController = Get.put(HijriController());


    // TODO: implement build
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
             SizedBox(height: 5),
             for (int i = 0; i < 5; i++)
               GestureDetector(
                 onTap: () {
                   hijriController.selectItem(i);
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


