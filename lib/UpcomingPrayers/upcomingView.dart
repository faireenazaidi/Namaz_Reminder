import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:namaz_reminders/Setting/SettingView.dart';
import 'package:namaz_reminders/UpcomingPrayers/upcomingController.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';
import '../DashBoard/dashboardController.dart';
import '../Leaderboard/leaderboardDataModal.dart';
import '../Widget/appColor.dart';
class Upcoming extends GetView<UpcomingController> {
  @override
  Widget build(BuildContext context) {
    final DashBoardController dashboardController = Get.find<DashBoardController>();
    final DateController dateController = Get.put(DateController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Upcoming Prayers", style: MyTextTheme.mediumBCD),
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, size: 20),
        ),
        actions: [
          Row(
            children: [
              SvgPicture.asset(
                  "assets/loc.svg"
              ),
              const SizedBox(width: 4),
              const Text("Lucknow", style: TextStyle(color: Colors.black)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:   InkWell(
                  onTap: (){
                    Get.to(() => SettingView(),
                      transition: Transition.rightToLeft,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,);
                  },
                  child: SvgPicture.asset(
                      "assets/gear.svg"
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Divider(
                  color: AppColor.greyLight,
                  thickness: 1,
                ),
                const SizedBox(height: 15),

                Center(
                  child: Row(
                    children: [
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset("assets/calendar3.svg"),
                        ),
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: dateController.selectedDate.value,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2025),
                          );
                          if (picked != null) {
                            dateController.updateSelectedDate(picked);
                            // await dashboardController.fetchPrayerTime(specificDate: picked);
                          }
                        },
                      ),
                      Obx(() => Text(
                        DateFormat('EEE, d MMMM yyyy').format(dateController.selectedDate.value), // Correctly displays the selected date
                        style: const TextStyle(fontSize: 12, color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      )),

                      Container(
                        width: 1, // Vertical divider width
                        height: 15, // Divider height
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 10), // Adjust spacing between texts and divider
                      ),
                      Expanded(
                        child: Obx(
                              () => Text(
                            dashboardController.islamicDate.value,
                            style: const TextStyle(fontSize: 12, color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/jalih.png"),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 50, // Adjust as necessary
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: dashboardController.scrollController,
                          // controller: dashboardController.scrollController,
                          itemCount: dashboardController.prayerNames.length,
                          itemBuilder: (context, index) {
                            // Determine if the current item is highlighted (active)
                            // bool isHighlighted = dashboardController.currentPrayer.value ==
                            //     dashboardController.prayerNames[index];
                            bool isHighlighted = false;
                            if(dashboardController.nextPrayer.value.isEmpty){
                              int currentPrayerIndex = dashboardController.prayerNames.indexOf(dashboardController.currentPrayer.value);
                              int nextPrayerIndex = (currentPrayerIndex + 1) % dashboardController.prayerNames.length;
                              isHighlighted = nextPrayerIndex == index;
                            }
                            else{
                              isHighlighted = dashboardController.nextPrayer.value == dashboardController.prayerNames[index];
                            }
                            // bool isHighlighted = dashboardController.nextPrayer.value == dashboardController.prayerNames[index];
                            return Transform.scale(
                              scale: isHighlighted ? 1.1 : 1.0,  // Scale up the active item
                              child: Opacity(
                                opacity: isHighlighted ? 1.0 : 0.6,  // Reduce opacity of inactive items
                                child: Container(
                                  width: 80,
                                  margin: const EdgeInsets.symmetric(horizontal: 8),

                                  child: Stack(
                                      children:[
                                        SvgPicture.asset("assets/Vec.svg"),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            // const SizedBox(height: 20),
                                            Text(
                                              dashboardController.prayerNames[index].toUpperCase(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: isHighlighted ? 13 : 13,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Center(
                                              child: Text(
                                                dashboardController.getPrayerTimes.isEmpty
                                                    ? "Loading"
                                                    : dashboardController.getPrayerTimes[index].toString(),
                                                style: isHighlighted
                                                    ? MyTextTheme.smallBCN
                                                    : MyTextTheme.smallGCN,
                                              ),
                                            )
                                          ],
                                        ),
                                      ]
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
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: dashboardController.prayerTimes.length,
                itemBuilder: (context, index) {
                  String prayerName = dashboardController.prayerNames[index];
                  Map<String, Map<String, String>> prayerTimes = dashboardController.getAllPrayerTimes();
                  String startTime24 = dashboardController.prayerDuration[prayerName]?['start'] ?? 'N/A';
                  String endTime24 = dashboardController.prayerDuration[prayerName]?['end'] ?? 'N/A';
                  // Convert times to 12-hour format
                  String startTime12 = dashboardController.convertTo12HourFormat(startTime24);
                  String endTime12 = dashboardController.convertTo12HourFormat(endTime24);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(

                      decoration: BoxDecoration(
                          color: AppColor.leaderboard,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  prayerName,
                                  style: MyTextTheme.medium
                              ),
                              SizedBox(height: 5,),
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Starts at',
                                      style: MyTextTheme.smallGCN
                                    ),
                                  ),
                                  Text(
                                    'Ends at',
                                      style: MyTextTheme.smallGCN
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      startTime12,
                                     style: MyTextTheme.mediumBCD,
                                    ),
                                  ),
                                  Text(
                                    endTime12,
                                    style: MyTextTheme.mediumBCD,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );

                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}




