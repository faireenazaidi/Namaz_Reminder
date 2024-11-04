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
    final UpcomingController upcomingController = Get.put(UpcomingController());


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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 20,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              // child: ListView.builder(
                              //   scrollDirection: Axis.horizontal,
                              //   controller: dashboardController.scrollController,
                              //   itemCount: dashboardController.prayerNames.length,
                              //   itemBuilder: (context, index) {
                              //     bool isHighlighted = false;
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
                              //       } else {
                              //         isHighlighted = dashboardController.nextPrayer.value ==
                              //             dashboardController.prayerNames[index];
                              //       }
                              //     }
                              //     print(dashboardController.nextPrayer);
                              //
                              //     return Transform.scale(
                              //       scale: isHighlighted ? 1.1 : 1.0,
                              //       child: Opacity(
                              //         opacity: isHighlighted ? 1.0 : 0.6,
                              //         child: Container(
                              //           width: 80,
                              //           margin: const EdgeInsets.symmetric(horizontal: 8),
                              //           child: Stack(
                              //             children: [
                              //               SvgPicture.asset("assets/Vec.svg"),
                              //               Column(
                              //                 mainAxisAlignment: MainAxisAlignment.center,
                              //                 children: [
                              //                   Text(
                              //                     dashboardController.prayerNames[index].toUpperCase(),
                              //                     style: TextStyle(
                              //                       color: Colors.white,
                              //                       fontSize: isHighlighted ? 13 : 13,
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
                                      isPassedPrayer = index < nextPrayerIndex;
                                    } else {
                                      isHighlighted = dashboardController.nextPrayer.value ==
                                          dashboardController.prayerNames[index];
                                      isPassedPrayer = dashboardController.prayerNames.indexOf(dashboardController.nextPrayer.value) > index;
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
                                            SvgPicture.asset(
                                              "assets/Vec.svg",
                                              colorFilter: isPassedPrayer
                                                  ? const ColorFilter.matrix(<double>[
                                                0.2126, 0.7152, 0.072, 0, 0,
                                                0.2126, 0.7152, 0.0722, 0, 0,
                                                0.2126, 0.7152, 0.0722, 0, 0,
                                                0, 0, 0, 1, 0,
                                              ]
                                              )
                                                  : null,
                                            ),

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
                  // child: ListView.builder(
                  //   itemCount: dashboardController.upcomingPrayerTimes.length,
                  //   itemBuilder: (context, index) {
                  //     String prayerName = dashboardController.upcomingPrayers[index];
                  //     String startTime24 = dashboardController.upcomingPrayerDuration[prayerName]?['start'] ?? 'N/A';
                  //     String endTime24 = dashboardController.upcomingPrayerDuration[prayerName]?['end'] ?? 'N/A';
                  //     String startTime12 = dashboardController.convertTo12HourFormat(startTime24);
                  //     String endTime12 = dashboardController.convertTo12HourFormat(endTime24);
                  //     // Determine if this prayer is the next one
                  //     bool isNextPrayer = (prayerName == dashboardController.nextPrayer.value);
                  //     print("Next :${dashboardController.nextPrayer.value}");
                  //     return Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //           color: isNextPrayer ? AppColor.highlight : AppColor.leaderboard,
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text( prayerName,style: MyTextTheme.medium),
                  //               SizedBox(height: 5),
                  //               Row(
                  //                 children: [
                  //                   Expanded(
                  //                     child: Text('Starts at', style: MyTextTheme.smallGCN),
                  //                   ),
                  //                   Text('Ends at', style: MyTextTheme.smallGCN),
                  //                 ],
                  //               ),
                  //               Row(
                  //                 children: [
                  //                   Expanded(
                  //                     child: Text(
                  //                       startTime12,
                  //                       style: MyTextTheme.mediumBCD,
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     endTime12,
                  //                     style: MyTextTheme.mediumBCD,
                  //                   ),
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                  // child: Obx(() {
                  //   return ListView.builder(
                  //     itemCount: dashboardController.upcomingPrayers.length,
                  //     itemBuilder: (context, index) {
                  //       String prayerName = dashboardController.upcomingPrayers[index];
                  //       String startTime24 = dashboardController.upcomingPrayerDuration[prayerName]?['start'] ?? 'N/A';
                  //       String endTime24 = dashboardController.upcomingPrayerDuration[prayerName]?['end'] ?? 'N/A';
                  //       String startTime12 = dashboardController.convertTo12HourFormat(startTime24);
                  //       String endTime12 = dashboardController.convertTo12HourFormat(endTime24);
                  //
                  //       bool isNextPrayer = (prayerName == dashboardController.nextPrayer.value);
                  //
                  //       return Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             color: isNextPrayer ? AppColor.highlight : AppColor.leaderboard,
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(prayerName, style: MyTextTheme.medium),
                  //                 SizedBox(height: 5),
                  //                 Row(
                  //                   children: [
                  //                     Expanded(
                  //                       child: Text('Starts at', style: MyTextTheme.smallGCN),
                  //                     ),
                  //                     Text('Ends at', style: MyTextTheme.smallGCN),
                  //                   ],
                  //                 ),
                  //                 Row(
                  //                   children: [
                  //                     Expanded(
                  //                       child: Text(startTime12, style: MyTextTheme.mediumBCD),
                  //                     ),
                  //                     Text(endTime12, style: MyTextTheme.mediumBCD),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   );
                  // }),

                  // child: ListView.builder(
                  //   itemCount: dashboardController.upcomingPrayerTimes.length,
                  //   itemBuilder: (context, index) {
                  //     if (index == 0) {
                  //       String nextPrayer = dashboardController.nextPrayer.value;
                  //       String startTime24 = dashboardController.upcomingPrayerDuration[nextPrayer]?['start'] ?? 'N/A';
                  //       String endTime24 = dashboardController.upcomingPrayerDuration[nextPrayer]?['end'] ?? 'N/A';
                  //       String startTime12 = dashboardController.convertTo12HourFormat(startTime24);
                  //       String endTime12 = dashboardController.convertTo12HourFormat(endTime24);
                  //
                  //       return Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             color: AppColor.lmustard,
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(controller.nextPrayerName.value,style: MyTextTheme.medium
                  //
                  //                 ),
                  //                 // Text(nextPrayer, style: MyTextTheme.medium),
                  //                 SizedBox(height: 10),
                  //                 Container(
                  //                   width: double.infinity,
                  //                   padding: const EdgeInsets.all(8.0),
                  //                   decoration: BoxDecoration(
                  //                     color: AppColor.packageGray,
                  //                     borderRadius: BorderRadius.circular(15),
                  //                   ),
                  //                   child: Row(
                  //                     children: [
                  //                       const Icon(Icons.timer_outlined),
                  //                       SizedBox(width: 5),
                  //                       Text('starts in'),
                  //                       SizedBox(width: 5),
                  //                       Obx(() {
                  //                         return Text(
                  //                           dashboardController.remainingTime.value,
                  //                           style: MyTextTheme.smallGCN,
                  //                         );
                  //                       }),
                  //                       Spacer(),
                  //                       InkWell(
                  //                         onTap: () {
                  //                           dashboardController.toggle();
                  //                         },
                  //                         child: Obx(() {
                  //                           return SvgPicture.asset(
                  //                             dashboardController.isMute.value ? 'assets/mute.svg' : 'assets/sound.svg',
                  //                             height: 20,
                  //                           );
                  //                         }),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 SizedBox(height: 5),
                  //                 Row(
                  //                   children: [
                  //                     Expanded(
                  //                       child: Text('Starts at', style: MyTextTheme.smallGCN),
                  //                     ),
                  //                     Text('Ends at', style: MyTextTheme.smallGCN),
                  //                   ],
                  //                 ),
                  //                 Row(
                  //                   children: [
                  //                     Expanded(
                  //                       child: Text(controller.upcomingPrayerStartTime.value,style: MyTextTheme.mediumBCD)
                  //                     ),
                  //
                  //                     Text(controller.upcomingPrayerEndTime.value,style: MyTextTheme.mediumBCD)
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     }
                  //     int prayerIndex = index - 0;
                  //     String prayerName = dashboardController.upcomingPrayers[prayerIndex];
                  //     String startTime24 = dashboardController.upcomingPrayerDuration[prayerName]?['start'] ?? 'N/A';
                  //     String endTime24 = dashboardController.upcomingPrayerDuration[prayerName]?['end'] ?? 'N/A';
                  //     String startTime12 = dashboardController.convertTo12HourFormat(startTime24);
                  //     String endTime12 = dashboardController.convertTo12HourFormat(endTime24);
                  //
                  //     return Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //           color: AppColor.leaderboard,
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(prayerName, style: MyTextTheme.medium),
                  //               SizedBox(height: 5),
                  //               Row(
                  //                 children: [
                  //                   Expanded(
                  //                     child: Text('Starts at', style: MyTextTheme.smallGCN),
                  //                   ),
                  //                   Text('Ends at', style: MyTextTheme.smallGCN),
                  //                 ],
                  //               ),
                  //               Row(
                  //                 children: [
                  //                   Expanded(
                  //                     child: Text(
                  //                       startTime12,
                  //                       style: MyTextTheme.mediumBCD,
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     endTime12,
                  //                     style: MyTextTheme.mediumBCD,
                  //                   ),
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                  child:ListView.builder(
                    itemCount: dashboardController.upcomingPrayerTimes.length,
                    itemBuilder: (context, index) {
                      // For the first item (next prayer)
                      if (index == 0) {
                        String nextPrayer = dashboardController.nextPrayer.value;
                        String startTime24 = dashboardController.upcomingPrayerDuration[nextPrayer]?['start'] ?? 'N/A';
                        String endTime24 = dashboardController.upcomingPrayerDuration[nextPrayer]?['end'] ?? 'N/A';
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
                                      Text(controller.nextPrayerName.value, style: MyTextTheme.medium),
                                      InkWell(
                                        onTap: (){},
                                          child: Icon(Icons.more_horiz))
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
                                        Obx(() {
                                          return Text(
                                            dashboardController.remainingTime.value,
                                            style: MyTextTheme.smallGCN,
                                          );
                                        }),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            dashboardController.toggle();
                                          },
                                          child: Obx(() {
                                            return SvgPicture.asset(
                                              dashboardController.isMute.value ? 'assets/mute.svg' : 'assets/sound.svg',
                                              height: 20,
                                            );
                                          }),
                                        ),
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
                                      Expanded(child: Text(controller.upcomingPrayerStartTime.value, style: MyTextTheme.mediumBCD)),
                                      Text(controller.upcomingPrayerEndTime.value, style: MyTextTheme.mediumBCD),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }

                      // For the rest of the items in the list
                      int prayerIndex = index - 0;
                      String prayerName = dashboardController.upcomingPrayers[prayerIndex];
                      String startTime24 = dashboardController.upcomingPrayerDuration[prayerName]?['start'] ?? 'N/A';
                      String endTime24 = dashboardController.upcomingPrayerDuration[prayerName]?['end'] ?? 'N/A';
                      String startTime12 = dashboardController.convertTo12HourFormat(startTime24);
                      String endTime12 = dashboardController.convertTo12HourFormat(endTime24);

                      // Check if the prayer is "Sunset," "Sunrise," or "Zawal" and display additional text
                      bool isSpecialPrayer = prayerName == 'Sunset' || prayerName == 'Sunrise' || prayerName == 'Zawal';
                      String specialText = isSpecialPrayer ? "Prohibited to pray." : "";

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
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(prayerName, style: MyTextTheme.medium),
                                //     InkWell(
                                //       onTap: (){
                                //         dashboardController.tog();
                                //       },
                                //       child: Obx(() {
                                //         return SvgPicture.asset(
                                //           dashboardController.isMuted.value ? 'assets/mute.svg' : 'assets/sound.svg',
                                //           height: 20,
                                //         );
                                //       }),
                                //     ),
                                //   ],
                                // ),
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(prayerName, style: MyTextTheme.medium),
                                InkWell(
                                  onTap: () {
                                    dashboardController.toggleMute(prayerName); // Pass the prayer name
                                  },
                                  child: Obx(() {
                                    // Use the mute state from the prayerMuteStates map
                                    return SvgPicture.asset(
                                      dashboardController.prayerMuteStates[prayerName] == true
                                          ? 'assets/mute.svg'
                                          : 'assets/sound.svg',
                                      height: 20,
                                    );
                                  }),
                                ),
                              ],
                            ),

                                if (isSpecialPrayer) ...[
                                  SizedBox(height: 5),
                                  Text(
                                    specialText,
                                    style: MyTextTheme.red, // Customize this text style as needed
                                  ),
                                ],
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
                  )


                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


