import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:namaz_reminders/UpcomingPrayers/upcomingController.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';

import '../DashBoard/dashboardController.dart';
import '../Leaderboard/leaderboardDataModal.dart';
import '../Widget/Date.dart';
import '../Widget/ReusableUI.dart';
import '../Widget/appColor.dart';

class Upcoming extends GetView<UpcomingController>
{
  @override
  Widget build(BuildContext context) {
    final DashBoardController dashboardController = Get.put(DashBoardController());

    return Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(
       title: Text("Upcoming Prayers",style: MyTextTheme.mediumBCD,),
       titleSpacing: 0,
       elevation: 0,
       backgroundColor: Colors.white,
       leading: InkWell(
         onTap: (){
           Get.back();
         },
        child:  Icon(Icons.arrow_back_ios,size: 20,)),
       actions: [
         Row(
           children: [
             Image.asset("assets/location.png"),
             const SizedBox(width: 4),
             const Text("Lucknow", style: TextStyle(color: Colors.black)),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Icon(Icons.settings_outlined,size: 20,color: Colors.grey,),
             )
           ],
         )
       ],
       ),
     body: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(
         children: [
            Divider(
             color: AppColor.greyLight,
             thickness: 1,
           ),
           DateTimeWidget(),

           const SizedBox(height: 15,),
           PrayerTimesWidget(),
         const SizedBox(height: 15,),



         ]
       ),
     ),

   );
  }

}
class DateTimeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DateController dateController = Get.find<DateController>();
    final DashBoardController dashboardController = Get.find<DashBoardController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          child: Image.asset("assets/iconcalen.png", width: 24, height: 24),
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: dateController.selectedDate.value,
              firstDate: DateTime(2020),
              lastDate: DateTime(2025),
            );
            if (picked != null) {
              dateController.updateSelectedDate(picked);
            }
          },
        ),
        Expanded(
          child: Obx(() => Row(
            children: [
              Expanded(
                child: Text(
                  DateFormat('EEEE, d MMMM yyyy').format(dateController.selectedDate.value),
                  style: const TextStyle(fontSize: 10, color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                width: 1.5,
                height: 15,
                color: Colors.grey,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              ),
              Expanded(
                child: Obx(
                      () => Text(
                    dashboardController.islamicDate.value,
                    style: const TextStyle(fontSize: 10, color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          )),
        ),
      ],
    );
  }
}