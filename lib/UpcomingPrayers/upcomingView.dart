import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:namaz_reminders/Setting/SettingView.dart';
import 'package:namaz_reminders/UpcomingPrayers/upcomingController.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';
import '../AppManager/dialogs.dart';
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
          onTap: () {
            dashboardController.fetchPrayerTime();
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios, size: 20),
        ),
        actions: [
          Row(
            children: [
              SvgPicture.asset("assets/loc.svg"),
              const SizedBox(width: 4),
              InkWell(
                onTap: () {
                  Dialogs.showConfirmationDialog(
                    context: context,
                    onConfirmed: () async {
                      return dashboardController.changeLocation();
                    },
                    showCancelButton: false,
                    initialMessage: 'Change Location',
                    confirmButtonText: 'Get Current Location',
                    confirmButtonColor: AppColor.buttonColor,
                    successMessage: dashboardController.address,
                    loadingMessage: 'Getting Current Location...',
                  );
                },
                child: Text(
                  dashboardController.address,
                  style: MyTextTheme.greyNormal,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Get.to(
                          () => SettingView(),
                      transition: Transition.rightToLeft,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                  child: SvgPicture.asset("assets/gear.svg"),
                ),
              ),
            ],
          ),
        ],
      ),
      body: GetBuilder(
        init: dashboardController,
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Divider(color: AppColor.greyLight, thickness: 1),
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
                                await dashboardController.fetchPrayerTime(specificDate: picked);
                              }
                            },
                          ),
                          Obx(() => Text(
                            DateFormat('EEE, d MMMM yyyy').format(dateController.selectedDate.value),
                            style: const TextStyle(fontSize: 12, color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          )),
                          Container(
                            width: 1,
                            height: 15,
                            color: Colors.grey,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
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
                            top: 50,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              controller: dashboardController.scrollController,
                              itemCount: dashboardController.prayerNames.length,
                              itemBuilder: (context, index) {
                                bool isHighlighted = false;

                                // Compare current date with selected date
                                bool isCurrentDate = DateFormat('yyyy-MM-dd').format(DateTime.now()) ==
                                    DateFormat('yyyy-MM-dd').format(dateController.selectedDate.value);

                                if (isCurrentDate) {
                                  if (dashboardController.nextPrayer.value.isEmpty) {
                                    int currentPrayerIndex =
                                    dashboardController.prayerNames.indexOf(dashboardController.currentPrayer.value);
                                    int nextPrayerIndex =
                                        (currentPrayerIndex + 1) % dashboardController.prayerNames.length;
                                    isHighlighted = nextPrayerIndex == index;
                                  } else {
                                    isHighlighted = dashboardController.nextPrayer.value ==
                                        dashboardController.prayerNames[index];
                                  }
                                }

                                return Transform.scale(
                                  scale: isHighlighted ? 1.1 : 1.0,
                                  child: Opacity(
                                    opacity: isHighlighted ? 1.0 : 0.6,
                                    child: Container(
                                      width: 80,
                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Stack(
                                        children: [
                                          SvgPicture.asset("assets/Vec.svg"),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
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
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            // child:   ListView.builder(
                            //     scrollDirection: Axis.horizontal,
                            //     controller: dashboardController.scrollController,
                            //     itemCount: dashboardController.prayerNames.where((prayer) {
                            //       // Exclude sunrise, sunset, and zawal from the list
                            //       return prayer != "Sunrise" && prayer != "Sunset" && prayer != "Zawal";
                            //     }).length,
                            //     itemBuilder: (context, index) {
                            //       // Get the filtered prayer name
                            //       String prayerName = dashboardController.prayerNames.where((prayer) {
                            //         return prayer != "Sunrise" && prayer != "Sunset" && prayer != "Zawal";
                            //       }).toList()[index];
                            //
                            //       bool isHighlighted = false;
                            //
                            //       // Compare current date with selected date
                            //       bool isCurrentDate = DateFormat('yyyy-MM-dd').format(DateTime.now()) ==
                            //           DateFormat('yyyy-MM-dd').format(dateController.selectedDate.value);
                            //
                            //       if (isCurrentDate) {
                            //         if (dashboardController.nextPrayer.value.isEmpty) {
                            //           int currentPrayerIndex =
                            //           dashboardController.prayerNames.indexOf(dashboardController.currentPrayer.value);
                            //           int nextPrayerIndex =
                            //               (currentPrayerIndex + 1) % dashboardController.prayerNames.length;
                            //           isHighlighted = nextPrayerIndex == index;
                            //         } else {
                            //           isHighlighted = dashboardController.nextPrayer.value == prayerName;
                            //         }
                            //       }
                            //
                            //       return Transform.scale(
                            //         scale: isHighlighted ? 1.1 : 1.0,
                            //         child: Opacity(
                            //           opacity: isHighlighted ? 1.0 : 0.6,
                            //           child: Container(
                            //             width: 80,
                            //             margin: const EdgeInsets.symmetric(horizontal: 8),
                            //             child: Stack(
                            //               children: [
                            //                 SvgPicture.asset("assets/Vec.svg"),
                            //                 Column(
                            //                   mainAxisAlignment: MainAxisAlignment.center,
                            //                   children: [
                            //                     Text(
                            //                       prayerName.toUpperCase(),
                            //                       style: TextStyle(
                            //                         color: Colors.white,
                            //                         fontSize: isHighlighted ? 13 : 13,
                            //                       ),
                            //                     ),
                            //                     const SizedBox(height: 8),
                            //                     Center(
                            //                       child: Text(
                            //                         dashboardController.getPrayerTimes.isEmpty
                            //                             ? "Loading"
                            //                             : dashboardController.getPrayerTimes[
                            //                         dashboardController.prayerNames.indexOf(prayerName)
                            //                         ].toString(),
                            //                         style: isHighlighted
                            //                             ? MyTextTheme.smallBCN
                            //                             : MyTextTheme.smallGCN,
                            //                       ),
                            //                     )
                            //                   ],
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //   )

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
                      String startTime24 = dashboardController.prayerDuration[prayerName]?['start'] ?? 'N/A';
                      String endTime24 = dashboardController.prayerDuration[prayerName]?['end'] ?? 'N/A';
                      String startTime12 = dashboardController.convertTo12HourFormat(startTime24);
                      String endTime12 = dashboardController.convertTo12HourFormat(endTime24);

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.leaderboard,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(prayerName, style: MyTextTheme.medium),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text('Starts at', style: MyTextTheme.smallGCN),
                                    ),
                                    Text('Ends at', style: MyTextTheme.smallGCN),
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
                      );
                    },
                  ),
                ),
              ),



            ],
          );
        },
      ),
    );
  }
}
