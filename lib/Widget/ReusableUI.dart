import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';
import '../DashBoard/dashboardController.dart';
import '../Routes/approutes.dart';
import '../UpcomingPrayers/upcomingView.dart';

class PrayerTimesWidget extends StatelessWidget {
  final DashBoardController controller = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    return   GetBuilder(
      init: controller,
      builder: (_){
        return Column(
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
                          child: Image.asset("assets/close.png"),
                        ),
                      ),
                    ],
                  ),
                  // Positioned block to properly contain ListView.builder
                  Positioned(
                    top: 50,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.prayerNames.length,
                      itemBuilder: (context, index) {
                        // Determine if the current item is highlighted (active)
                        bool isHighlighted = controller.currentPrayerIndex.value ==
                            controller.prayerNames[index];

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
                                    controller.prayerNames[index].toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isHighlighted ? 16 : 14,  // Increase font size for active prayer
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Obx(() => Text(
                                    controller.getPrayerTimes.isEmpty
                                        ? "Loading"
                                        : controller.getPrayerTimes[index].toString(),
                                    style: isHighlighted
                                        ? MyTextTheme.largeCustomBCB  // Highlighted prayer time style
                                        : MyTextTheme.smallGCN,  // Normal style for others
                                  )),
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
        );
      },
    );
  }
}
