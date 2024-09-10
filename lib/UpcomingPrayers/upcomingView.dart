import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:namaz_reminders/UpcomingPrayers/upcomingController.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';

import '../DashBoard/dashboardController.dart';
import '../Leaderboard/leaderboardDataModal.dart';
import '../Routes/approutes.dart';
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

            Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/jalih.png")
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.upcomingRoute);
                            },
                            child: Text("UPCOMING PRAYERS", style: MyTextTheme.mediumWCB),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => Upcoming());
                              },
                              child:SvgPicture.asset("assets/close.svg"),
                            ),
                          ),
                        ],
                      ),
                      // Positioned block to properly contain ListView.builder
                      Positioned(
                        top: 50,  // Adjust as necessary
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: dashboardController.prayerNames.length,
                          itemBuilder: (context, index) {
                            // Determine if the current item is highlighted (active)
                            bool isHighlighted = dashboardController.currentPrayerIndex.value ==
                                dashboardController.prayerNames[index];

                            return Transform.scale(
                              scale: isHighlighted ? 1.2 : 1.0,  // Scale up the active item
                              child: Opacity(
                                opacity: isHighlighted ? 1.0 : 0.5,  // Reduce opacity of inactive items
                                child: Container(
                                  width: 80,
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: const AssetImage('assets/vector.png'),
                                      colorFilter: isHighlighted
                                          ? null  // No color filter for highlighted item (original image color)
                                          : ColorFilter.mode(
                                        Colors.grey.withOpacity(0.6),
                                        BlendMode.srcATop,
                                      ),  // Apply color filter for non-highlighted items
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: isHighlighted ? Colors.orangeAccent : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 20),
                                      Text(
                                        dashboardController.prayerNames[index].toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: isHighlighted ? 16 : 14,  // Increase font size for active prayer
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        dashboardController.getPrayerTimes.isEmpty
                                            ? "Loading"
                                            : dashboardController.getPrayerTimes[index].toString(),
                                        style: isHighlighted
                                            ? MyTextTheme.largeCustomBCB  // Highlighted prayer time style
                                            : MyTextTheme.smallGCN,  // Normal style for others
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                    ],
                  ),

                ),


              ],
            ),
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