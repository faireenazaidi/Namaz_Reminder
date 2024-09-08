import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../DashBoard/dashboardController.dart';

class TimeWidget extends StatelessWidget {
  final DashBoardController dashboardController = Get.find<DashBoardController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Islamic Date
        Obx(() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            dashboardController.islamicDate.value,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        )),

        // Prayer Times List
        Expanded(
          child: Obx(() {
            if (dashboardController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: dashboardController.prayerTimes.length,
              itemBuilder: (context, index) {
                return Obx(() {
                  bool isCurrentPrayer = dashboardController.currentPrayerIndex.value == index;

                  return ListTile(
                    leading: Icon(Icons.access_time, color: isCurrentPrayer ? Colors.green : Colors.grey),
                    title: Text(
                      dashboardController.prayerNames[index],
                      style: TextStyle(
                        fontWeight: isCurrentPrayer ? FontWeight.bold : FontWeight.normal,
                        color: isCurrentPrayer ? Colors.green : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      dashboardController.prayerTimes[index],
                      style: TextStyle(
                        fontWeight: isCurrentPrayer ? FontWeight.bold : FontWeight.normal,
                        color: isCurrentPrayer ? Colors.green : Colors.black,
                      ),
                    ),
                    tileColor: isCurrentPrayer ? Colors.green.withOpacity(0.1) : Colors.transparent,
                  );
                });
              },
            );
          }),
        ),
      ],
    );
  }
}
