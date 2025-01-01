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
    final DashBoardController dashboardController =
    Get.find<DashBoardController>();
    final DateController dateController = Get.put(DateController());
    final UpcomingController upcomingController = Get.put(UpcomingController());

    ///----------Scroll the Highlighted prayer in centre--------///

    void scrollToCenter(int index) {
      double targetOffset = (index * 88) - (MediaQuery.of(context).size.width / 2) + 65;
      dashboardController.scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    //-----------------------------------//
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Upcoming Prayers",
              style: MyTextTheme.mediumBCD,
              overflow: TextOverflow.ellipsis,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/loc.svg"),
                  Text(
                    dashboardController.address.split(' ')[0].toString(),
                    style: MyTextTheme.greyNormal,
                  ),
                ],
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Divider(
            height: 1.5,
            color: AppColor.packageGray,
          ),
        ),
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios, size: 20),
        ),
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
                                await dashboardController.fetchPrayerTime(
                                    specificDate: picked);
                              }
                            },
                          ),
                          Obx(() => Text(
                            DateFormat('EEE, d MMMM yyyy')
                                .format(dateController.selectedDate.value),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
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
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black),
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 20,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              // child: PageView.builder(
                              //   controller: dashboardController.pageController,
                              //   itemCount: dashboardController.prayerNames.length,
                              //   itemBuilder: (context, index) {
                              //     bool isHighlighted = false;
                              //     bool isPassedPrayer = false;
                              //
                              //     // Compare current date with selected date
                              //     bool isCurrentDate = DateFormat('yyyy-MM-dd').format(DateTime.now()) ==
                              //         DateFormat('yyyy-MM-dd').format(dateController.selectedDate.value);
                              //
                              //     if (isCurrentDate) {
                              //       if (dashboardController.nextPrayer.value.isEmpty) {
                              //         int currentPrayerIndex =
                              //         dashboardController.prayerNames.indexOf(dashboardController.currentPrayer.value);
                              //         int nextPrayerIndex =
                              //             (currentPrayerIndex + 1) % dashboardController.prayerNames.length;
                              //         isHighlighted = nextPrayerIndex == index;
                              //         isPassedPrayer = index < nextPrayerIndex;
                              //       } else {
                              //         isHighlighted = dashboardController.nextPrayer.value ==
                              //             dashboardController.prayerNames[index];
                              //         isPassedPrayer = dashboardController.prayerNames.indexOf(dashboardController.nextPrayer.value) > index;
                              //       }
                              //     }
                              //
                              //     return Transform.scale(
                              //       scale: isHighlighted ? 1.1 : 1.0,
                              //       child: Opacity(
                              //         opacity: isHighlighted ? 1.0 : 0.6,
                              //         child: Container(
                              //           margin: const EdgeInsets.symmetric(horizontal: 8),
                              //           child: Stack(
                              //             children: [
                              //               SvgPicture.asset(
                              //                 "assets/Vec.svg",
                              //                 colorFilter: isPassedPrayer
                              //                     ? const ColorFilter.matrix(<double>[
                              //                   0.2126, 0.7152, 0.072, 0, 0,
                              //                   0.2126, 0.7152, 0.0722, 0, 0,
                              //                   0.2126, 0.7152, 0.0722, 0, 0,
                              //                   0, 0, 0, 1, 0,
                              //                 ])
                              //                     : null,
                              //               ),
                              //               Column(
                              //                 mainAxisAlignment: MainAxisAlignment.center,
                              //                 children: [
                              //                   Text(
                              //                     dashboardController.prayerNames[index].toUpperCase(),
                              //                     style: TextStyle(
                              //                       color: Colors.white,
                              //                       fontSize: isHighlighted ? 16 : 14,
                              //                     ),
                              //                   ),
                              //                   const SizedBox(height: 8),
                              //                   Center(
                              //                     child: Text(
                              //                       dashboardController.getPrayerTimes.isEmpty
                              //                           ? "Loading"
                              //                           : dashboardController.getPrayerTimes[index].toString(),
                              //                       style: isHighlighted
                              //                           ? MyTextTheme.smallBCN
                              //                           : MyTextTheme.smallGCN,
                              //                     ),
                              //                   )
                              //                 ],
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // ),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                controller: dashboardController.scrollController,
                                itemCount: dashboardController.prayerNames.length,
                                itemBuilder: (context, index) {
                                  bool isHighlighted = false;
                                  bool isPassedPrayer = false;

                                  bool isCurrentDate = DateFormat('yyyy-MM-dd')
                                      .format(DateTime.now()) ==
                                      DateFormat('yyyy-MM-dd').format(dateController.selectedDate.value);

                                  if (isCurrentDate) {
                                    if (dashboardController.nextPrayer.value.isEmpty) {
                                      int currentPrayerIndex = dashboardController.prayerNames.indexOf(dashboardController.currentPrayer.value);
                                      int nextPrayerIndex = (currentPrayerIndex + 1) % dashboardController.prayerNames.length;
                                      isHighlighted = nextPrayerIndex == index;
                                      isPassedPrayer = index < nextPrayerIndex;
                                    } else {
                                      isHighlighted = dashboardController.nextPrayer.value == dashboardController.prayerNames[index];
                                      isPassedPrayer = dashboardController.prayerNames.indexOf(dashboardController.nextPrayer.value) > index;
                                    }
                                  }

                                  if (isHighlighted) {
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      scrollToCenter(index);
                                    });
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
                                            SvgPicture.asset(
                                              "assets/Vec.svg",
                                              colorFilter: isPassedPrayer
                                                  ? const ColorFilter.matrix(<double>[
                                                0.2126, 0.7152, 0.072, 0, 0,
                                                0.2126, 0.7152, 0.0722, 0, 0,
                                                0.2126, 0.7152, 0.0722, 0, 0,
                                                0, 0, 0, 1, 0,
                                              ])
                                                  : null,
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  dashboardController.prayerNames[index].toUpperCase(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: isHighlighted ? 15 : 14,
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: dashboardController.upcomingPrayers.length,
                    itemBuilder: (context, index) {
                      var upcomingPrayers = dashboardController.upcomingPrayers;
                      var prayerDurations = dashboardController.upcomingPrayerDuration;
                      String currentTime = DateFormat('HH:mm').format(DateTime.now());
                      print("lengthhh");
                      print( dashboardController.upcomingPrayerDuration);
                      print(controller.prayerNames[1]);
                      String ishaEndTime = prayerDurations['Isha']?['start'] ?? '23:59';
                      List<Map<String, String>> prayerList = upcomingPrayers.map((prayer) {
                        String startTime = prayerDurations[prayer]?['start'] ?? 'N/A';
                        return {
                          'name': prayer,
                          'start': startTime,
                        };
                      }).where((prayer) {
                        bool isAfterIsha = currentTime.compareTo(ishaEndTime) > 0;
                        bool isNextDayPrayer = isAfterIsha && prayer['name'] == 'Fajr';
                        bool isRemainingTodayPrayer = !isAfterIsha && prayer['start']!.compareTo(currentTime) > 0;
                        //return isNextDayPrayer || isRemainingTodayPrayer;
                        return (isNextDayPrayer || isRemainingTodayPrayer) && prayer['name'] != controller.nextPrayer;
                      }).toList();

                      prayerList.sort((a, b) => a['start']!.compareTo(b['start']!));
                      if (prayerList.isEmpty) return SizedBox.shrink();

                      if (index == 0) {
                        return Obx(() {
                          // Separate Obx for handling observable variables only
                          String nextPrayer = prayerList[0]['name']!;
                          String startTime24 = prayerDurations[nextPrayer]?['start'] ?? 'N/A';
                          String endTime24 = prayerDurations[nextPrayer]?['end'] ?? 'N/A';
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      // Text(controller.nextPrayerName.value, style: MyTextTheme.medium),
                                      Text(controller.isGapPeriod.value?controller.currentPrayer.value:controller.nextPrayerName.value,style: MyTextTheme.medium),
                                       // Text(controller.isGapPeriod.value?controller.currentPrayer.value:controller.nextPrayerName.value, style: MyTextTheme.medium,),
                                        InkWell(
                                          onTap: () {},
                                          child: Icon(Icons.more_horiz),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: AppColor.packageGray,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.timer_outlined),
                                          SizedBox(width: 5),
                                          Text('starts in'),
                                          SizedBox(width: 5),
                                          Obx(() => Text(
                                            dashboardController.remainingTime.value,
                                            style: MyTextTheme.smallGCN,
                                          )),
                                          Spacer(),
                                          // InkWell(
                                          //   onTap: () {
                                          //     dashboardController.toggle('Asr');
                                          //   },
                                          //   child: Obx(() => SvgPicture.asset(
                                          //     dashboardController.isMute.value
                                          //         ? 'assets/mute.svg'
                                          //         : 'assets/sound.svg',
                                          //     height: 20,
                                          //   )),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Expanded(child: Text('Starts at', style: MyTextTheme.smallGCN)),
                                        Text('Ends at', style: MyTextTheme.smallGCN),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            //  controller.upcomingPrayerStartTime.value,
                                      controller.isGapPeriod.value?controller.currentPrayerStartTime.value:controller.upcomingPrayerStartTime.value,
                                              style: MyTextTheme.mediumBCD),
                                        ),
                                        Text(
                                           // controller.upcomingPrayerEndTime.value,
                                            controller.isGapPeriod.value?controller.currentPrayerEndTime.value:controller.upcomingPrayerEndTime.value,
                                            style: MyTextTheme.mediumBCD),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                      }

                      int prayerIndex = index - 1;
                      if (prayerIndex < prayerList.length) {
                        String prayerName = prayerList[prayerIndex]['name']!;
                        String startTime24 = prayerDurations[prayerName]?['start'] ?? 'N/A';
                        String endTime24 = prayerDurations[prayerName]?['end'] ?? 'N/A';
                        String startTime12 = dashboardController.convertTo12HourFormat(startTime24);
                        String endTime12 = dashboardController.convertTo12HourFormat(endTime24);
                        bool isSpecialPrayer = prayerName == 'Sunset' || prayerName == 'Sunrise' || prayerName == 'Zawal';
                        bool sun = prayerName == 'Sunset' || prayerName == 'Sunrise' ;

                        String specialText = isSpecialPrayer ? "Prohibited to pray" : "";
                        bool isHighlighted = (isSpecialPrayer && startTime24 == currentTime);

                        return Padding(
                            padding: EdgeInsets.all(8.0),
                            child:
                            controller.nextPrayerName != prayerName?
                            Container(
                              decoration: BoxDecoration(
                                color: isHighlighted ? AppColor.highlight : AppColor.leaderboard,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Text(prayerName, style: MyTextTheme.medium),
                                        // if (!isSpecialPrayer)
                                        //   InkWell(
                                        //     onTap: () {
                                        //       dashboardController.toggleMute(prayerName);
                                        //     },
                                        //     child: Obx(() => SvgPicture.asset(
                                        //       dashboardController.prayerMuteStates[prayerName] == true
                                        //           ? 'assets/mute.svg'
                                        //           : 'assets/sound.svg',
                                        //       height: 20,
                                        //     )),
                                        //   ),
                                      ],
                                    ),
                                    if (isSpecialPrayer) ...[
                                      SizedBox(height: 5),
                                      Text(specialText, style: MyTextTheme.red),
                                    ],
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Expanded(child: Text('Starts at', style: MyTextTheme.smallGCN)),
                                        if (!isSpecialPrayer) Text('Ends at', style: MyTextTheme.smallGCN),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(startTime12, style: MyTextTheme.mediumBCD),
                                        ),
                                        if (!isSpecialPrayer)
                                          Text(endTime12, style: MyTextTheme.mediumBCD),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ):
                           null
                        );
                      }
                      return SizedBox.shrink();
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

