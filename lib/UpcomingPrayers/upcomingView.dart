import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:namaz_reminders/UpcomingPrayers/upcomingController.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';
import '../DashBoard/dashboardController.dart';
import '../Routes/approutes.dart';
import '../Widget/Date.dart';
import '../Widget/appColor.dart';

class Upcoming extends GetView<UpcomingController> {
  @override
  Widget build(BuildContext context) {
    final DashBoardController dashboardController = Get.find<DashBoardController>();

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
              Image.asset("assets/location.png"),
              const SizedBox(width: 4),
              const Text("Lucknow", style: TextStyle(color: Colors.black)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.settings_outlined, size: 20, color: Colors.grey),
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

                // Added Expanded widget with Row for date and Islamic date
                Row(
                  children: [
                    Text(
                      DateFormat('EEEE, d MMM yyyy').format(DateTime.now()), // Always shows current date
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
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

                const SizedBox(height: 15),
                Container(
                  height: 200,
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
                              child: SvgPicture.asset("assets/close.svg"),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 50, // Adjust as necessary
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: dashboardController.prayerNames.length,
                          itemBuilder: (context, index) {
                            // Determine if the current item is highlighted (active)
                            bool isHighlighted = dashboardController.currentPrayer.value ==
                                dashboardController.prayerNames[index];
                            return Transform.scale(
                              scale: isHighlighted ? 1.2 : 1.0, // Scale up the active item
                              child: Opacity(
                                opacity: isHighlighted ? 1.0 : 0.5, // Reduce opacity of inactive items
                                child: Container(
                                  width: 80,
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: const AssetImage('assets/vector.png'),
                                      colorFilter: isHighlighted
                                          ? null
                                          : ColorFilter.mode(
                                        Colors.grey.withOpacity(0.2),
                                        BlendMode.srcATop,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 20),
                                      Text(
                                        dashboardController.prayerNames[index].toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: isHighlighted ? 14 : 14, // Increase font size for active prayer
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        dashboardController.getPrayerTimes.isEmpty
                                            ? "Loading"
                                            : dashboardController.getPrayerTimes[index].toString(),
                                        style: isHighlighted
                                            ? MyTextTheme.mediumBCN // Highlighted prayer time style
                                            : MyTextTheme.smallGCN, // Normal style for others
                                      ),
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
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView.builder(
                itemCount: dashboardController.prayerNames.length,
                itemBuilder: (context, index) {
                  String prayerName = dashboardController.prayerNames[index];
                  String startTime24 = dashboardController.prayerDuration[prayerName]?['start'] ?? 'N/A';
                  String endTime24 = dashboardController.prayerDuration[prayerName]?['end'] ?? 'N/A';

                  // Convert times to 12-hour format
                  String startTime12 = dashboardController.convertTo12HourFormat(startTime24);
                  String endTime12 = dashboardController.convertTo12HourFormat(endTime24);

                  return ListTile(
                    title: Text(
                      prayerName,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Start at:',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'End at:',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                startTime12,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                endTime12,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
