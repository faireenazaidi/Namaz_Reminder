import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:namaz_reminders/Leaderboard/LeaderBoardController.dart';
import '../AppManager/dialogs.dart';
import '../DashBoard/timepickerpopup.dart';
import '../Drawer/drawerController.dart';
import '../Widget/appColor.dart';
import '../Widget/text_theme.dart';

class MissedPrayersView extends GetView<LeaderBoardController>{
  const MissedPrayersView({super.key});

  @override
  Widget build(BuildContext context) {
    // LeaderBoardController controller = Get.put(LeaderBoardController());
    // final DateController dateController = Get.put(DateController());
    final CustomDrawerController customDrawerController = Get.find<CustomDrawerController>();

    // TODO: implement build
    return Scaffold(
        backgroundColor: AppColor.cream,
        body: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                title: Text("Missed Prayers", style: MyTextTheme.mediumBCD),
                centerTitle: true,
                pinned: true,
                expandedHeight: 300.0,
                backgroundColor: AppColor.cream,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  // child: InkWell(
                  //   onTap: () async {
                  //     Get.back();
                  //     await customDrawerController.missedPrayersCount.value.toString();
                  //   },
                  //   child: const Icon(
                  //       Icons.arrow_back_ios_new, color: Colors.black),
                  // ),
                  child: InkWell(
                    onTap: ()  {
                      Get.back();
                    },
                    child: const Icon(
                        Icons.arrow_back_ios_new, color: Colors.black),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background image
                      SvgPicture.asset(
                          "assets/jali.svg",
                          fit: BoxFit.cover,
                          color: AppColor.greyDark
                      ),
                      // Overlay with content
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 80),
                            Obx(() =>
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.updateSelectedDate(
                                            DateTime.now());
                                        controller.updateSelectedTab = 'Daily';
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: controller.selectedTab.value ==
                                              'Daily'
                                              ? Colors.white60
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                              20),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),

                                        child: Column(
                                          children: [
                                            Container(
                                              height: 4,
                                              width: 28,
                                              decoration: BoxDecoration(
                                                  color: controller.selectedTab
                                                      .value == 'Daily'
                                                      ? AppColor.circleIndicator
                                                      : Colors.transparent,
                                                  borderRadius: BorderRadius
                                                      .circular(5)
                                              ),
                                            ),
                                            Text(
                                              'Daily',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: controller
                                                    .selectedTab.value ==
                                                    'Daily'
                                                    ? FontWeight.w500
                                                    : FontWeight.normal,
                                                color: controller
                                                    .getSelectedTab == 'Daily'
                                                    ? Colors.black
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () {
                                        controller.updateSelectedDate(
                                            DateTime.now().subtract(Duration(days: 1)));
                                        controller.updateSelectedTab = 'Weekly';
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: controller.getSelectedTab ==
                                              'Weekly'
                                              ? Colors.white60
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                              20),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 4,
                                              width: 28,
                                              decoration: BoxDecoration(
                                                  color: controller.selectedTab
                                                      .value == 'Daily'
                                                      ? Colors.transparent
                                                      : AppColor
                                                      .circleIndicator,
                                                  borderRadius: BorderRadius
                                                      .circular(5)
                                              ),
                                            ),
                                            Text(
                                              'Weekly',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: controller
                                                    .selectedTab.value ==
                                                    'Daily'
                                                    ? FontWeight.normal
                                                    : FontWeight.w500,
                                                color: controller
                                                    .getSelectedTab == 'Weekly'
                                                    ? Colors.black
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            const SizedBox(height: 60),
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                if(controller.getSelectedTab == 'Weekly'){
                                  DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: controller.getSelectedTab ==
                                        'Daily'
                                        ? controller.selectedDate.value
                                        : DateTime.now().subtract(
                                        Duration(days: 1)),
                                    firstDate: DateTime(2020),
                                    lastDate: controller.getSelectedTab == 'Daily'
                                        ? DateTime.now()
                                        : DateTime.now().subtract(
                                        Duration(days: 1)),
                                  );
                                  if (picked != null) {
                                    controller.updateSelectedDate(picked);
                                    print("sssssssssss${controller.selectedDate}");
                                    // controller.updateIslamicDateBasedOnOption(date: picked);
                                    String formattedDate = DateFormat(
                                        'dd-MM-yyyy').format(picked);
                                    if (controller.getSelectedTab == 'Daily') {
                                      controller.leaderboard(formattedDate);
                                    } else {
                                      controller.weeklyApi(formattedDate);
                                    }
                                  }
                                }

                              },
                              child:
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      "assets/calendar3.svg", height: 15),
                                  const SizedBox(width: 5),
                                  Obx(() =>
                                  controller
                                      .getSelectedTab == 'Daily'? Row(
                                        children: [
                                          Text(
                                            DateFormat('EEE, d MMMM yyyy').format(controller.selectedDate.value),
                                            style: const TextStyle(fontSize: 12,
                                                color: Colors.black),
                                          ),
                                          Container(
                                            width: 1,
                                            height: 15,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                          ),
                                          Obx(() =>
                                              Text(
                                                controller.islamicDate.value,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              )),
                                        ],
                                      ):
                                  Text(
                                    " ${DateFormat('EEE, d MMMM yyyy').format(controller.selectedDate.value)} - ${DateFormat('EEE, d MMMM yyyy').format(controller.selectedDate.value.subtract(const Duration(days: 6)))} ",
                                    style: const TextStyle(fontSize: 12,
                                        color: Colors.black),
                                  )
                            )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                             Center(
                              child: Obx(() {
                                  return Text(
                                    controller.getSelectedTab == 'Daily'?"TODAY'S TIMELINE":"Weekly TIMELINE",
                                    style: const TextStyle(color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  );
                                }
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColor.circleIndicator,
                                  child: const Text("F"),
                                ),
                                const SizedBox(width: 5),
                                CircleAvatar(
                                  backgroundColor: AppColor.circleIndicator,
                                  child: const Text("D"),
                                ),
                                const SizedBox(width: 5),
                                CircleAvatar(
                                  backgroundColor: AppColor.circleIndicator,
                                  child: const Text("A"),
                                ),
                                const SizedBox(width: 5),
                                CircleAvatar(
                                  backgroundColor: AppColor.circleIndicator,
                                  child: const Text("M"),
                                ),
                                const SizedBox(width: 5),
                                CircleAvatar(
                                  backgroundColor: AppColor.circleIndicator,
                                  child: const Text("I"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() {
                if (controller.selectedTab.value == 'Daily') {
                  return SliverList(
                      delegate: SliverChildListDelegate([Container(
                        height: Get.height*0.62,
                        decoration:  BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(50.0),
                            ),
                            color: Theme.of(context).scaffoldBackgroundColor,

                            ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Container(
                                  width: 100,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      color: AppColor.packageGray,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Obx(() {
                                          return controller.getLeaderboardList
                                              .value != null ?
                                          Expanded(
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: controller
                                                  .getLeaderboardList.value!
                                                  .records.length,
                                              itemBuilder: (context, index) {
                                                var isMissedPrayers = controller
                                                    .getLeaderboardList.value!
                                                    .records[index]
                                                    .userTimestamp == null;
                                                final prayerStartTime = controller
                                                    .dashboardController
                                                    .getExtractedData[0].timings
                                                    ?.fajr ?? "00:00";
                                                final shouldShowDash = controller
                                                    .currentTime.compareTo(
                                                    prayerStartTime) < 0;
                                                return Visibility(
                                                  visible: controller
                                                      .getLeaderboardList.value!
                                                      .records[index]
                                                      .prayerName == "Fajr",
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(8.0),
                                                        child: shouldShowDash
                                                            ?  CircleAvatar(
                                                            radius: 20,
                                                            backgroundColor: Colors
                                                                .white70,
                                                            child: CircleAvatar(
                                                                radius: 22,
                                                                backgroundColor: Colors
                                                                    .transparent,
                                                                child: Container(
                                                              height: 3,
                                                              width: 12,
                                                              decoration: BoxDecoration(
                                                                  color: Colors.grey[400],
                                                                  borderRadius: BorderRadius.circular(10)
                                                              ),
                                                            ),
                                                                // child: Text('-')
                                                            ))
                                                            : !isMissedPrayers
                                                            ? CircleAvatar(
                                                          radius: 20.8,
                                                          backgroundColor: Colors
                                                              .yellowAccent,
                                                          child: CircleAvatar(
                                                            backgroundColor: Colors.white,
                                                            child: controller
                                                                .getLeaderboardList
                                                                .value!
                                                                .records[index]
                                                                .user.picture !=
                                                                null
                                                                ?
                                                            CircleAvatar(
                                                              radius: 22,
                                                              // Radius of the circular image
                                                              backgroundImage: NetworkImage(
                                                                "http://182.156.200.177:8011${controller
                                                                    .getLeaderboardList
                                                                    .value!
                                                                    .records[index]
                                                                    .user
                                                                    .picture}", // Replace with your image URL
                                                              ),
                                                            )
                                                                :
                                                             Icon(
                                                              Icons.person,
                                                              color: AppColor.circleIndicator,
                                                              size: 30,),
                                                            // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                                          ),
                                                        )
                                                            :
                                                        InkWell(
                                                          onTap: () async {
                                                            if (controller
                                                                .userData
                                                                .getUserData!.id
                                                                .toString() ==
                                                                controller
                                                                    .getLeaderboardList
                                                                    .value!
                                                                    .records[index]
                                                                    .user.id
                                                                    .toString()) {
                                                              Dialogs.showLoading(context);
                                                              // Parse the string into a DateTime object
                                                              DateTime parsedDate = DateTime.parse(controller
                                                                  .getLeaderboardList
                                                                  .value!
                                                                  .records[index].date);

                                                              // Format the date in 'dd-MM-yyyy' format
                                                              String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
                                                              DateTime? prayerTime = await Future
                                                                  .delayed(
                                                                  Duration
                                                                      .zero, () {
                                                                return controller
                                                                    .getPrayerTime(
                                                                  controller
                                                                      .dashboardController
                                                                      .calendarData,
                                                                  formattedDate,
                                                                  controller
                                                                      .getLeaderboardList
                                                                      .value!
                                                                      .records[index].prayerName,
                                                                );
                                                              });
                                                              // DateTime? prayerTime = controller.getPrayerTime(controller.dashboardController.calendarData,date,record.prayerName);
                                                              print(
                                                                  "prayerTime ${controller
                                                                      .getLeaderboardList
                                                                      .value!
                                                                      .records[index].date}");
                                                              print(
                                                                  "prayerTime $prayerTime");
                                                              // Hide loading only if the context is still mounted
                                                              if (context
                                                                  .mounted) {
                                                                WidgetsBinding
                                                                    .instance
                                                                    .addPostFrameCallback((
                                                                    _) {
                                                                  Dialogs
                                                                      .hideLoading();
                                                                  showDialog(
                                                                    context: context,
                                                                    builder: (
                                                                        BuildContext context) {
                                                                      return TimePicker(
                                                                        date: formattedDate,
                                                                        prayerNames: controller
                                                                            .getLeaderboardList
                                                                            .value!
                                                                            .records[index].prayerName,
                                                                        isFromMissed: true,
                                                                        missedPrayerTime: prayerTime,
                                                                        missedCallBack: () =>
                                                                            controller
                                                                                .leaderboard(
                                                                                controller
                                                                                    .getFormattedDate()),);
                                                                    },
                                                                  );
                                                                });
                                                              }
                                                              // showDialog(
                                                              //   context: context,
                                                              //   builder: (
                                                              //       BuildContext context) {
                                                              //     return TimePicker(
                                                              //       isFromMissed: true,
                                                              //       missedCallBack: () =>
                                                              //           controller
                                                              //               .leaderboard(
                                                              //               controller
                                                              //                   .getFormattedDate()),);
                                                              //   },
                                                              // );
                                                            }
                                                          },
                                                          child: ColorFiltered(
                                                            colorFilter: const ColorFilter
                                                                .matrix(
                                                              <double>[
                                                                0.2126,
                                                                0.7152,
                                                                0.0722,
                                                                0,
                                                                0,
                                                                // Red channel coefficients
                                                                0.2126,
                                                                0.7152,
                                                                0.0722,
                                                                0,
                                                                0,
                                                                // Green channel coefficients
                                                                0.2126,
                                                                0.7152,
                                                                0.0722,
                                                                0,
                                                                0,
                                                                // Blue channel coefficients
                                                                0,
                                                                0,
                                                                0,
                                                                1,
                                                                0,
                                                                // Alpha channel
                                                              ],
                                                            ),
                                                            child: CircleAvatar(
                                                                child: controller
                                                                    .getLeaderboardList
                                                                    .value!
                                                                    .records[index]
                                                                    .user.name
                                                                    .isNotEmpty
                                                                    ? controller
                                                                    .getLeaderboardList
                                                                    .value!
                                                                    .records[index]
                                                                    .user
                                                                    .picture !=
                                                                    null
                                                                    ? CircleAvatar(
                                                                  radius: 24,
                                                                  // Radius of the circular image
                                                                  backgroundImage: NetworkImage(
                                                                    "http://182.156.200.177:8011${controller
                                                                        .getLeaderboardList
                                                                        .value!
                                                                        .records[index]
                                                                        .user
                                                                        .picture}", // Replace with your image URL
                                                                  ),
                                                                )
                                                                    : const Icon(
                                                                  Icons.person,
                                                                  color: Colors
                                                                      .grey,
                                                                  size: 30,)
                                                                    : const Text(
                                                                  '-',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black45),)
                                                              // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      if(!shouldShowDash)
                                                        controller
                                                            .getLeaderboardList
                                                            .value!
                                                            .records[index].user
                                                            .id.toString() ==
                                                            controller.userData
                                                                .getUserData!.id
                                                            ? const Text('You',
                                                          style: TextStyle(
                                                              fontSize: 10),)
                                                            :
                                                        Text(controller
                                                            .getLeaderboardList
                                                            .value!
                                                            .records[index].user
                                                            .name.split(' ')[0],
                                                          style: const TextStyle(
                                                              fontSize: 10),)
                                                      else
                                                        const Text('',
                                                          style: TextStyle(
                                                              fontSize: 10),)
                                                    ],
                                                  ),
                                                );
                                              },),
                                          ) : const SizedBox();
                                        }),

                                        Obx(() {
                                          return controller.getLeaderboardList
                                              .value != null ? Expanded(
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemCount: controller
                                                  .getLeaderboardList.value!
                                                  .records.length,
                                              itemBuilder: (context, index) {
                                                var isMissedPrayers = controller
                                                    .getLeaderboardList.value!
                                                    .records[index]
                                                    .userTimestamp == null;
                                                final prayerStartTime = controller
                                                    .dashboardController
                                                    .getExtractedData[0].timings
                                                    ?.dhuhr ?? "00:00";

                                                // Compare current time with prayer start time
                                                final shouldShowDash = controller
                                                    .currentTime.compareTo(
                                                    prayerStartTime) < 0;
                                                return Visibility(
                                                  visible: controller
                                                      .getLeaderboardList.value!
                                                      .records[index]
                                                      .prayerName == "Dhuhr",
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(8.0),
                                                        child: shouldShowDash
                                                            ?  CircleAvatar(
                                                            radius: 20,
                                                            backgroundColor: Colors
                                                                .white70,
                                                            child: CircleAvatar(
                                                                radius: 22,
                                                                backgroundColor: Colors
                                                                    .transparent,
                                                                child:  Container(
                                                                  height: 3,
                                                                  width: 12,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors.grey[400],
                                                                      borderRadius: BorderRadius.circular(10)
                                                                  ),
                                                                )
                                                                //Text('-')
                                                            ))
                                                            : !isMissedPrayers
                                                            ? CircleAvatar(
                                                          radius: 20.8,
                                                          backgroundColor: Colors.yellowAccent,
                                                          child: CircleAvatar(
                                                            backgroundColor: Colors.white,
                                                              child: controller
                                                                  .getLeaderboardList
                                                                  .value!
                                                                  .records[index]
                                                                  .user
                                                                  .picture !=
                                                                  null
                                                                  ? CircleAvatar(
                                                                radius: 22,
                                                                // Radius of the circular image
                                                                backgroundImage: NetworkImage(
                                                                  "http://182.156.200.177:8011${controller
                                                                      .getLeaderboardList
                                                                      .value!
                                                                      .records[index]
                                                                      .user
                                                                      .picture}", // Replace with your image URL
                                                                ),
                                                              )
                                                                  : Icon(
                                                                Icons.person,
                                                                color: AppColor.circleIndicator,
                                                                size: 30,),
                                                            // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                                          ),
                                                        )
                                                            :
                                                        InkWell(
                                                          onTap: () async {
                                                            if (controller
                                                                .userData
                                                                .getUserData!.id
                                                                .toString() ==
                                                                controller
                                                                    .getLeaderboardList
                                                                    .value!
                                                                    .records[index]
                                                                    .user.id
                                                                    .toString()) {
                                                              Dialogs.showLoading(context);
                                                              // Parse the string into a DateTime object
                                                              DateTime parsedDate = DateTime.parse(controller
                                                                  .getLeaderboardList
                                                                  .value!
                                                                  .records[index].date);

                                                              // Format the date in 'dd-MM-yyyy' format
                                                              String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
                                                              DateTime? prayerTime = await Future
                                                                  .delayed(
                                                                  Duration
                                                                      .zero, () {
                                                                return controller
                                                                    .getPrayerTime(
                                                                  controller
                                                                      .dashboardController
                                                                      .calendarData,
                                                                  formattedDate,
                                                                  controller
                                                                      .getLeaderboardList
                                                                      .value!
                                                                      .records[index].prayerName,
                                                                );
                                                              });
                                                              // DateTime? prayerTime = controller.getPrayerTime(controller.dashboardController.calendarData,date,record.prayerName);
                                                              print(
                                                                  "prayerTime ${controller
                                                                      .getLeaderboardList
                                                                      .value!
                                                                      .records[index].date}");
                                                              print(
                                                                  "prayerTime $prayerTime");
                                                              // Hide loading only if the context is still mounted
                                                              if (context
                                                                  .mounted) {
                                                                WidgetsBinding
                                                                    .instance
                                                                    .addPostFrameCallback((
                                                                    _) {
                                                                  Dialogs
                                                                      .hideLoading();
                                                                  showDialog(
                                                                    context: context,
                                                                    builder: (
                                                                        BuildContext context) {
                                                                      return TimePicker(
                                                                        date: formattedDate,
                                                                        prayerNames: controller
                                                                            .getLeaderboardList
                                                                            .value!
                                                                            .records[index].prayerName,
                                                                        isFromMissed: true,
                                                                        missedPrayerTime: prayerTime,
                                                                        missedCallBack: () =>
                                                                            controller
                                                                                .leaderboard(
                                                                                controller
                                                                                    .getFormattedDate()),);
                                                                    },
                                                                  );
                                                                });
                                                              }
                                                              // showDialog(
                                                              //   context: context,
                                                              //   builder: (
                                                              //       BuildContext context) {
                                                              //     return TimePicker(
                                                              //       isFromMissed: true,
                                                              //       missedCallBack: () =>
                                                              //           controller
                                                              //               .leaderboard(
                                                              //               controller
                                                              //                   .getFormattedDate()),);
                                                              //   },
                                                              // );
                                                            }
                                                          },
                                                          child: ColorFiltered(
                                                            colorFilter: const ColorFilter
                                                                .matrix(
                                                              <double>[
                                                                0.2126,
                                                                0.7152,
                                                                0.0722,
                                                                0,
                                                                0,
                                                                // Red channel coefficients
                                                                0.2126,
                                                                0.7152,
                                                                0.0722,
                                                                0,
                                                                0,
                                                                // Green channel coefficients
                                                                0.2126,
                                                                0.7152,
                                                                0.0722,
                                                                0,
                                                                0,
                                                                // Blue channel coefficients
                                                                0,
                                                                0,
                                                                0,
                                                                1,
                                                                0,
                                                                // Alpha channel
                                                              ],
                                                            ),
                                                            child: CircleAvatar(
                                                                child: controller
                                                                    .getLeaderboardList
                                                                    .value!
                                                                    .records[index]
                                                                    .user.name
                                                                    .isNotEmpty
                                                                    ? controller
                                                                    .getLeaderboardList
                                                                    .value!
                                                                    .records[index]
                                                                    .user
                                                                    .picture !=
                                                                    null
                                                                    ? CircleAvatar(
                                                                  radius: 24,
                                                                  // Radius of the circular image
                                                                  backgroundImage: NetworkImage(
                                                                    "http://182.156.200.177:8011${controller
                                                                        .getLeaderboardList
                                                                        .value!
                                                                        .records[index]
                                                                        .user
                                                                        .picture}", // Replace with your image URL
                                                                  ),
                                                                )
                                                                    : const Icon(
                                                                  Icons.person,
                                                                  color: Colors
                                                                      .grey,
                                                                  size: 30,)
                                                                    : CircleAvatar(
                                                                    radius: 22,
                                                                    backgroundColor: Colors
                                                                        .transparent,
                                                                    child: Text(
                                                                      '-',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black45),))
                                                              // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      if(!shouldShowDash)
                                                        controller
                                                            .getLeaderboardList
                                                            .value!
                                                            .records[index].user
                                                            .id.toString() ==
                                                            controller.userData
                                                                .getUserData!.id
                                                            ? const Text('You',
                                                          style: TextStyle(
                                                              fontSize: 10),)
                                                            :
                                                        Text(controller
                                                            .getLeaderboardList
                                                            .value!
                                                            .records[index].user
                                                            .name.split(' ')[0],
                                                          style: const TextStyle(
                                                              fontSize: 10),)
                                                      else
                                                        const Text('',
                                                          style: TextStyle(
                                                              fontSize: 10),)
                                                    ],
                                                  ),
                                                );
                                              },),
                                          ) : const SizedBox();
                                        }),


                                        Obx(() {
                                          return controller.getLeaderboardList
                                              .value != null ? Expanded(
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: controller
                                                  .getLeaderboardList.value!
                                                  .records.length,
                                              itemBuilder: (context, index) {
                                                var isMissedPrayers = controller
                                                    .getLeaderboardList.value!
                                                    .records[index]
                                                    .userTimestamp == null;
                                                final prayerStartTime = controller
                                                    .dashboardController
                                                    .getExtractedData[0].timings
                                                    ?.asr ?? "00:00";

                                                // Compare current time with prayer start time
                                                final shouldShowDash = controller
                                                    .currentTime.compareTo(
                                                    prayerStartTime) < 0;
                                                return Visibility(
                                                  visible: controller
                                                      .getLeaderboardList.value!
                                                      .records[index]
                                                      .prayerName == "Asr",
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(8.0),
                                                        child: shouldShowDash
                                                            ?  CircleAvatar(
                                                            radius: 20,
                                                            backgroundColor: Colors
                                                                .white70,
                                                            child: CircleAvatar(
                                                                radius: 22,
                                                                backgroundColor: Colors
                                                                    .transparent,
                                                              child: Container(
                                                                height: 3,
                                                                width: 12,
                                                                decoration: BoxDecoration(
                                                                    color: Colors.grey[400],
                                                                    borderRadius: BorderRadius.circular(10)
                                                                ),
                                                              )
                                                                // child: Text(
                                                                //     '-')
                                                                  ))
                                                            : !isMissedPrayers
                                                            ? CircleAvatar(
                                                          radius: 20.8,
                                                          backgroundColor: Colors.yellowAccent,
                                                          child: CircleAvatar(
                                                            backgroundColor: Colors.white,
                                                              child: controller
                                                                  .getLeaderboardList
                                                                  .value!
                                                                  .records[index]
                                                                  .user
                                                                  .picture !=
                                                                  null
                                                                  ? CircleAvatar(
                                                                radius: 22,
                                                                // Radius of the circular image
                                                                backgroundImage: NetworkImage(
                                                                  "http://182.156.200.177:8011${controller
                                                                      .getLeaderboardList
                                                                      .value!
                                                                      .records[index]
                                                                      .user
                                                                      .picture}", // Replace with your image URL
                                                                ),
                                                              )
                                                                  : Icon(
                                                                Icons.person,
                                                                color: AppColor.circleIndicator,
                                                                size: 30,),
                                                            // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                                          ),
                                                        )
                                                            :
                                                        InkWell(
                                                          onTap: () async {
                                                            if (controller
                                                                .userData
                                                                .getUserData!.id
                                                                .toString() ==
                                                                controller
                                                                    .getLeaderboardList
                                                                    .value!
                                                                    .records[index]
                                                                    .user.id
                                                                    .toString()) {
                                                              Dialogs.showLoading(context);
                                                              // Parse the string into a DateTime object
                                                              DateTime parsedDate = DateTime.parse(controller
                                                                  .getLeaderboardList
                                                                  .value!
                                                                  .records[index].date);

                                                              // Format the date in 'dd-MM-yyyy' format
                                                              String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
                                                              DateTime? prayerTime = await Future
                                                                  .delayed(
                                                                  Duration
                                                                      .zero, () {
                                                                return controller
                                                                    .getPrayerTime(
                                                                  controller
                                                                      .dashboardController
                                                                      .calendarData,
                                                                  formattedDate,
                                                                  controller
                                                                      .getLeaderboardList
                                                                      .value!
                                                                      .records[index].prayerName,
                                                                );
                                                              });
                                                              // DateTime? prayerTime = controller.getPrayerTime(controller.dashboardController.calendarData,date,record.prayerName);
                                                              print(
                                                                  "prayerTime ${controller
                                                                      .getLeaderboardList
                                                                      .value!
                                                                      .records[index].date}");
                                                              print(
                                                                  "prayerTime $prayerTime");
                                                              // Hide loading only if the context is still mounted
                                                              if (context
                                                                  .mounted) {
                                                                WidgetsBinding
                                                                    .instance
                                                                    .addPostFrameCallback((
                                                                    _) {
                                                                  Dialogs
                                                                      .hideLoading();
                                                                  showDialog(
                                                                    context: context,
                                                                    builder: (
                                                                        BuildContext context) {
                                                                      return TimePicker(
                                                                        date: formattedDate,
                                                                        prayerNames: controller
                                                                            .getLeaderboardList
                                                                            .value!
                                                                            .records[index].prayerName,
                                                                        isFromMissed: true,
                                                                        missedPrayerTime: prayerTime,
                                                                        missedCallBack: () =>
                                                                            controller
                                                                                .leaderboard(
                                                                                controller
                                                                                    .getFormattedDate()),);
                                                                    },
                                                                  );
                                                                });
                                                              }
                                                              // showDialog(
                                                              //   context: context,
                                                              //   builder: (
                                                              //       BuildContext context) {
                                                              //     return TimePicker(
                                                              //       isFromMissed: true,
                                                              //       missedCallBack: () =>
                                                              //           controller
                                                              //               .leaderboard(
                                                              //               controller
                                                              //                   .getFormattedDate()),);
                                                              //   },
                                                              // );

                                                            }
                                                          },
                                                          child: ColorFiltered(
                                                            colorFilter: const ColorFilter
                                                                .matrix(
                                                              <double>[
                                                                0.2126,
                                                                0.7152,
                                                                0.0722,
                                                                0,
                                                                0,
                                                                // Red channel coefficients
                                                                0.2126,
                                                                0.7152,
                                                                0.0722,
                                                                0,
                                                                0,
                                                                // Green channel coefficients
                                                                0.2126,
                                                                0.7152,
                                                                0.0722,
                                                                0,
                                                                0,
                                                                // Blue channel coefficients
                                                                0,
                                                                0,
                                                                0,
                                                                1,
                                                                0,
                                                                // Alpha channel
                                                              ],
                                                            ),
                                                            child: CircleAvatar(
                                                                child: controller
                                                                    .getLeaderboardList
                                                                    .value!
                                                                    .records[index]
                                                                    .user.name
                                                                    .isNotEmpty
                                                                    ? controller
                                                                    .getLeaderboardList
                                                                    .value!
                                                                    .records[index]
                                                                    .user
                                                                    .picture !=
                                                                    null
                                                                    ? CircleAvatar(
                                                                  radius: 24,
                                                                  // Radius of the circular image
                                                                  backgroundImage: NetworkImage(
                                                                    "http://182.156.200.177:8011${controller
                                                                        .getLeaderboardList
                                                                        .value!
                                                                        .records[index]
                                                                        .user
                                                                        .picture}", // Replace with your image URL
                                                                  ),
                                                                )
                                                                    : const Icon(
                                                                  Icons.person,
                                                                  color: Colors
                                                                      .grey,
                                                                  size: 30,)
                                                                    : Text('-',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black45),)
                                                              // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      if(!shouldShowDash)
                                                        controller
                                                            .getLeaderboardList
                                                            .value!
                                                            .records[index].user
                                                            .id.toString() ==
                                                            controller.userData
                                                                .getUserData!.id
                                                            ? const Text('You',
                                                          style: TextStyle(
                                                              fontSize: 10),)
                                                            :
                                                        Text(controller
                                                            .getLeaderboardList
                                                            .value!
                                                            .records[index].user
                                                            .name.split(' ')[0],
                                                          style: const TextStyle(
                                                              fontSize: 10),)
                                                      else
                                                        const Text('',
                                                          style: TextStyle(
                                                              fontSize: 10),)
                                                    ],
                                                  ),
                                                );
                                              },),
                                          ) : const SizedBox();
                                        }),

                                        Obx(() {
                                          return controller.getLeaderboardList
                                              .value != null ? Expanded(
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: controller
                                                  .getLeaderboardList.value!
                                                  .records.length,
                                              itemBuilder: (context, index) {
                                                var isMissedPrayers = controller
                                                    .getLeaderboardList.value!
                                                    .records[index]
                                                    .userTimestamp == null;
                                                final prayerStartTime = controller
                                                    .dashboardController
                                                    .getExtractedData[0].timings
                                                    ?.maghrib ?? "00:00";

                                                // Compare current time with prayer start time
                                                final shouldShowDash = controller
                                                    .currentTime.compareTo(
                                                    prayerStartTime) < 0;
                                                return Visibility(
                                                  visible: controller
                                                      .getLeaderboardList.value!
                                                      .records[index]
                                                      .prayerName == "Maghrib",
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                          padding: const EdgeInsets
                                                              .all(8.0),
                                                          child: shouldShowDash
                                                              ?  CircleAvatar(
                                                              radius: 20,
                                                              backgroundColor: Colors
                                                                  .white70,
                                                              child: CircleAvatar(
                                                                  radius: 22,
                                                                  backgroundColor: Colors
                                                                      .transparent,
                                                                  child: CircleAvatar(
                                                                      radius: 22,
                                                                      backgroundColor: Colors
                                                                          .transparent,
                                                                      child: Container(
                                                                        height: 3,
                                                                        width: 12,
                                                                        decoration: BoxDecoration(
                                                                            color: Colors.grey[400],
                                                                            borderRadius: BorderRadius.circular(10)
                                                                        ),
                                                                      )
                                                                      // child: Text(
                                                                      //     '-')
                                                                  )))
                                                              : !isMissedPrayers
                                                              ? CircleAvatar(
                                                            radius: 20.8,
                                                            backgroundColor: Colors
                                                                .yellowAccent,
                                                            child: CircleAvatar(
                                                              backgroundColor: Colors.white,
                                                                child: controller
                                                                    .getLeaderboardList
                                                                    .value!
                                                                    .records[index]
                                                                    .user
                                                                    .picture !=
                                                                    null
                                                                    ? CircleAvatar(
                                                                  radius: 22,
                                                                  // Radius of the circular image
                                                                  backgroundImage: NetworkImage(
                                                                    "http://182.156.200.177:8011${controller
                                                                        .getLeaderboardList
                                                                        .value!
                                                                        .records[index]
                                                                        .user
                                                                        .picture}", // Replace with your image URL
                                                                  ),
                                                                )
                                                                    : Icon(
                                                                  Icons.person,
                                                                  color: AppColor.circleIndicator,
                                                                  size: 30,),
                                                              // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                                            ),
                                                          )
                                                              :
                                                          InkWell(
                                                            onTap: () async {
                                                              if (controller
                                                                  .userData
                                                                  .getUserData!
                                                                  .id
                                                                  .toString() ==
                                                                  controller
                                                                      .getLeaderboardList
                                                                      .value!
                                                                      .records[index]
                                                                      .user.id
                                                                      .toString()) {
                                                                Dialogs.showLoading(context);
                                                                // Parse the string into a DateTime object
                                                                DateTime parsedDate = DateTime.parse(controller
                                                                    .getLeaderboardList
                                                                    .value!
                                                                    .records[index].date);

                                                                // Format the date in 'dd-MM-yyyy' format
                                                                String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
                                                                DateTime? prayerTime = await Future
                                                                    .delayed(
                                                                    Duration
                                                                        .zero, () {
                                                                  return controller
                                                                      .getPrayerTime(
                                                                    controller
                                                                        .dashboardController
                                                                        .calendarData,
                                                                    formattedDate,
                                                                    controller
                                                                        .getLeaderboardList
                                                                        .value!
                                                                        .records[index].prayerName,
                                                                  );
                                                                });
                                                                // DateTime? prayerTime = controller.getPrayerTime(controller.dashboardController.calendarData,date,record.prayerName);
                                                                print(
                                                                    "prayerTime ${controller
                                                                        .getLeaderboardList
                                                                        .value!
                                                                        .records[index].date}");
                                                                print(
                                                                    "prayerTime $prayerTime");
                                                                // Hide loading only if the context is still mounted
                                                                if (context
                                                                    .mounted) {
                                                                  WidgetsBinding
                                                                      .instance
                                                                      .addPostFrameCallback((
                                                                      _) {
                                                                    Dialogs
                                                                        .hideLoading();
                                                                    showDialog(
                                                                      context: context,
                                                                      builder: (
                                                                          BuildContext context) {
                                                                        return TimePicker(
                                                                          date: formattedDate,
                                                                          prayerNames: controller
                                                                              .getLeaderboardList
                                                                              .value!
                                                                              .records[index].prayerName,
                                                                          isFromMissed: true,
                                                                          missedPrayerTime: prayerTime,
                                                                          missedCallBack: () =>
                                                                              controller
                                                                                  .leaderboard(
                                                                                  controller
                                                                                      .getFormattedDate()),);
                                                                      },
                                                                    );
                                                                  });
                                                                }
                                                                // showDialog(
                                                                //   context: context,
                                                                //   builder: (
                                                                //       BuildContext context) {
                                                                //     return TimePicker(
                                                                //       isFromMissed: true,
                                                                //       missedCallBack: () =>
                                                                //           controller
                                                                //               .leaderboard(
                                                                //               controller
                                                                //                   .getFormattedDate()),);
                                                                //   },
                                                                // );
                                                              }
                                                            },
                                                            child: ColorFiltered(
                                                              colorFilter: const ColorFilter
                                                                  .matrix(
                                                                <double>[
                                                                  0.2126,
                                                                  0.7152,
                                                                  0.0722,
                                                                  0,
                                                                  0,
                                                                  // Red channel coefficients
                                                                  0.2126,
                                                                  0.7152,
                                                                  0.0722,
                                                                  0,
                                                                  0,
                                                                  // Green channel coefficients
                                                                  0.2126,
                                                                  0.7152,
                                                                  0.0722,
                                                                  0,
                                                                  0,
                                                                  // Blue channel coefficients
                                                                  0,
                                                                  0,
                                                                  0,
                                                                  1,
                                                                  0,
                                                                  // Alpha channel
                                                                ],
                                                              ),
                                                              child: CircleAvatar(
                                                                  child: controller
                                                                      .getLeaderboardList
                                                                      .value!
                                                                      .records[index]
                                                                      .user.name
                                                                      .isNotEmpty
                                                                      ? controller
                                                                      .getLeaderboardList
                                                                      .value!
                                                                      .records[index]
                                                                      .user
                                                                      .picture !=
                                                                      null
                                                                      ? CircleAvatar(
                                                                    radius: 24,
                                                                    // Radius of the circular image
                                                                    backgroundImage: NetworkImage(
                                                                      "http://182.156.200.177:8011${controller
                                                                          .getLeaderboardList
                                                                          .value!
                                                                          .records[index]
                                                                          .user
                                                                          .picture}", // Replace with your image URL
                                                                    ),
                                                                  )
                                                                      : const Icon(
                                                                    Icons
                                                                        .person,
                                                                    color: Colors
                                                                        .grey,
                                                                    size: 30,)
                                                                      : const Text(
                                                                    '-',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black45),)
                                                                // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                                              ),
                                                            ),
                                                          )),
                                                      if(!shouldShowDash)
                                                        controller
                                                            .getLeaderboardList
                                                            .value!
                                                            .records[index].user
                                                            .id.toString() ==
                                                            controller.userData
                                                                .getUserData!.id
                                                            ? const Text('You',
                                                          style: TextStyle(
                                                              fontSize: 10),)
                                                            :
                                                        Text(controller
                                                            .getLeaderboardList
                                                            .value!
                                                            .records[index].user
                                                            .name.split(' ')[0],
                                                          style: const TextStyle(
                                                              fontSize: 10),)
                                                      else
                                                        const Text('',
                                                          style: TextStyle(
                                                              fontSize: 10),)
                                                    ],
                                                  ),
                                                );
                                              },),
                                          ) : const SizedBox();
                                        }),

                                        Obx(() {
                                          return controller.getLeaderboardList
                                              .value != null ? Expanded(
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: controller
                                                  .getLeaderboardList.value!
                                                  .records.length,
                                              itemBuilder: (context, index) {
                                                var isMissedPrayers = controller
                                                    .getLeaderboardList.value!
                                                    .records[index]
                                                    .userTimestamp == null;
                                                // final record = controller.getLeaderboardList.value!.records[index];
                                                // final prayerName = record.prayerName;
                                                final prayerStartTime = controller
                                                    .dashboardController
                                                    .getExtractedData[0].timings
                                                    ?.isha ?? "00:00";

                                                // Compare current time with prayer start time
                                                final shouldShowDash = controller
                                                    .currentTime.compareTo(
                                                    prayerStartTime) < 0;
                                                return Visibility(
                                                  visible: controller
                                                      .getLeaderboardList.value!
                                                      .records[index]
                                                      .prayerName == "Isha",
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(8.0),
                                                        child: shouldShowDash
                                                            ?  CircleAvatar(
                                                            radius: 20,
                                                            backgroundColor: Colors
                                                                .white70,
                                                            child: CircleAvatar(
                                                                radius: 22,
                                                                backgroundColor: Colors
                                                                    .transparent,
                                                                child: Container(
                                                                  height: 3,
                                                                  width: 12,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors.grey[400],
                                                                      borderRadius: BorderRadius.circular(10)
                                                                  ),
                                                                )
                                                                // child: Text(
                                                                //     '-')
                                                            ))
                                                            : !isMissedPrayers
                                                            ? CircleAvatar(
                                                          radius: 20.8,
                                                          backgroundColor: Colors
                                                              .yellowAccent,
                                                          child: CircleAvatar(
                                                            backgroundColor: Colors.white,
                                                              child: controller
                                                                  .getLeaderboardList
                                                                  .value!
                                                                  .records[index]
                                                                  .user
                                                                  .picture !=
                                                                  null
                                                                  ? CircleAvatar(
                                                                radius: 22,
                                                                // Radius of the circular image
                                                                backgroundImage: NetworkImage(
                                                                  "http://182.156.200.177:8011${controller
                                                                      .getLeaderboardList
                                                                      .value!
                                                                      .records[index]
                                                                      .user
                                                                      .picture}", // Replace with your image URL
                                                                ),
                                                              )
                                                                  : Icon(
                                                                Icons.person,
                                                                color: AppColor.circleIndicator,
                                                                size: 30,),
                                                            // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                                          ),
                                                        )
                                                            :
                                                        InkWell(
                                                          onTap: () async {
                                                            if (controller
                                                                .userData
                                                                .getUserData!.id
                                                                .toString() ==
                                                                controller
                                                                    .getLeaderboardList
                                                                    .value!
                                                                    .records[index]
                                                                    .user.id
                                                                    .toString()) {
                                                              Dialogs.showLoading(context);
                                                              // Parse the string into a DateTime object
                                                              DateTime parsedDate = DateTime.parse(controller
                                                                  .getLeaderboardList
                                                                  .value!
                                                                  .records[index].date);

                                                              // Format the date in 'dd-MM-yyyy' format
                                                              String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
                                                              DateTime? prayerTime = await Future
                                                                  .delayed(
                                                                  Duration
                                                                      .zero, () {
                                                                return controller
                                                                    .getPrayerTime(
                                                                  controller
                                                                      .dashboardController
                                                                      .calendarData,
                                                                  formattedDate,
                                                                  controller
                                                                      .getLeaderboardList
                                                                      .value!
                                                                      .records[index].prayerName,
                                                                );
                                                              });
                                                              // DateTime? prayerTime = controller.getPrayerTime(controller.dashboardController.calendarData,date,record.prayerName);
                                                              print(
                                                                  "prayerTime ${controller
                                                                      .getLeaderboardList
                                                                      .value!
                                                                      .records[index].date}");
                                                              print(
                                                                  "prayerTime $prayerTime");
                                                              // Hide loading only if the context is still mounted
                                                              if (context
                                                                  .mounted) {
                                                                WidgetsBinding
                                                                    .instance
                                                                    .addPostFrameCallback((
                                                                    _) {
                                                                  Dialogs
                                                                      .hideLoading();
                                                                  showDialog(
                                                                    context: context,
                                                                    builder: (
                                                                        BuildContext context) {
                                                                      return TimePicker(
                                                                        date: formattedDate,
                                                                        prayerNames: controller
                                                                            .getLeaderboardList
                                                                            .value!
                                                                            .records[index].prayerName,
                                                                        isFromMissed: true,
                                                                        missedPrayerTime: prayerTime,
                                                                        missedCallBack: () =>
                                                                            controller
                                                                                .leaderboard(
                                                                                controller
                                                                                    .getFormattedDate()),);
                                                                    },
                                                                  );
                                                                });
                                                              }
                                                              // showDialog(
                                                              //   context: context,
                                                              //   builder: (
                                                              //       BuildContext context) {
                                                              //     return TimePicker(
                                                              //       isFromMissed: true,
                                                              //       missedCallBack: () =>
                                                              //           controller
                                                              //               .leaderboard(
                                                              //               controller
                                                              //                   .getFormattedDate()),);
                                                              //   },
                                                              // );
                                                            }
                                                          },
                                                          child: ColorFiltered(
                                                            colorFilter: const ColorFilter
                                                                .matrix(
                                                              <double>[
                                                                0.2126,
                                                                0.7152,
                                                                0.0722,
                                                                0,
                                                                0,
                                                                // Red channel coefficients
                                                                0.2126,
                                                                0.7152,
                                                                0.0722,
                                                                0,
                                                                0,
                                                                // Green channel coefficients
                                                                0.2126,
                                                                0.7152,
                                                                0.0722,
                                                                0,
                                                                0,
                                                                // Blue channel coefficients
                                                                0,
                                                                0,
                                                                0,
                                                                1,
                                                                0,
                                                                // Alpha channel
                                                              ],
                                                            ),
                                                            child: CircleAvatar(
                                                                child: controller
                                                                    .getLeaderboardList
                                                                    .value!
                                                                    .records[index]
                                                                    .user.name
                                                                    .isNotEmpty
                                                                    ? controller
                                                                    .getLeaderboardList
                                                                    .value!
                                                                    .records[index]
                                                                    .user
                                                                    .picture !=
                                                                    null
                                                                    ? CircleAvatar(
                                                                  radius: 24,
                                                                  // Radius of the circular image
                                                                  backgroundImage: NetworkImage(
                                                                    "http://182.156.200.177:8011${controller
                                                                        .getLeaderboardList
                                                                        .value!
                                                                        .records[index]
                                                                        .user
                                                                        .picture}", // Replace with your image URL
                                                                  ),
                                                                )
                                                                    :
                                                                const Icon(
                                                                  Icons.person,
                                                                  color: Colors
                                                                      .grey,
                                                                  size: 30,)
                                                                    :
                                                                const Text('-', style: TextStyle(color: Colors.black45),)
                                                              // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      if(!shouldShowDash)
                                                        controller
                                                            .getLeaderboardList
                                                            .value!
                                                            .records[index].user
                                                            .id.toString() ==
                                                            controller.userData
                                                                .getUserData!.id
                                                            ? const Text('You',
                                                          style: TextStyle(
                                                              fontSize: 10),)
                                                            :
                                                        Text(controller
                                                            .getLeaderboardList
                                                            .value!
                                                            .records[index].user
                                                            .name.split(' ')[0],
                                                          style: const TextStyle(
                                                              fontSize: 10),)
                                                      else
                                                        const Text('',
                                                          style: TextStyle(
                                                              fontSize: 10),)
                                                    ],
                                                  ),
                                                );
                                              },),
                                          ) : const SizedBox();
                                        }),

                                      ],
                                    ),
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ),
                      ]));
                }
                else if (controller.selectedTab.value == 'Weekly') {
                  return SliverList(
                      delegate: SliverChildListDelegate([
                        Container(
                          height: Get.height,
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(50.0),
                              ),
                              color: Theme.of(context).scaffoldBackgroundColor,

                              ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                8.0, 8.0, 8.0, 80),
                            child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Container(
                                    width: 100,
                                    height: 8,
                                    decoration: BoxDecoration(
                                        color: AppColor.packageGray,
                                        borderRadius: BorderRadius.circular(10)
                                    ),

                                  ),
                                  Obx(() {
                                    return Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemCount: controller.weeklyMissedPrayer
                                            .keys.length,
                                        itemBuilder: (context, index) {
                                          final date = controller
                                              .weeklyMissedPrayer.keys
                                              .elementAt(index);

                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              SizedBox(height: 10),
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                    8.0),
                                                child: Text(
                                                  date,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .bold),
                                                ),
                                              ),

                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceAround,
                                                children: controller.prayers
                                                    .map((prayer) {
                                                  return Expanded(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          controller
                                                              .prayerShortNames[prayer]!,
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight
                                                                  .bold),
                                                        ),
                                                        // Display user prayer info under each prayer
                                                        ...controller
                                                            .weeklyMissedPrayer[date]!
                                                            .where((record) =>
                                                        record.prayerName ==
                                                            prayer)
                                                            .map((record) {
                                                          return record
                                                              .userTimestamp !=
                                                              null
                                                              ? Padding(
                                                            padding: const EdgeInsets
                                                                .only(
                                                                bottom: 5.0),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                      .all(5),
                                                                  padding: const EdgeInsets
                                                                      .all(1),
                                                                  // Padding around the circular image
                                                                  decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border
                                                                        .all(
                                                                      color: Colors
                                                                          .yellow,
                                                                    ), // Yellow border
                                                                  ),
                                                                  child: record
                                                                      .user
                                                                      .picture !=
                                                                      null
                                                                      ? Column(
                                                                    children: [
                                                                      CircleAvatar(
                                                                        radius: 20,
                                                                        // Radius of the circular image
                                                                        backgroundImage: NetworkImage(
                                                                          "http://182.156.200.177:8011${record
                                                                              .user
                                                                              .picture}", // Replace with your image URL
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                      : Padding(
                                                                    padding: const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .person,
                                                                      color: AppColor
                                                                          .circleIndicator,
                                                                      size: 20,
                                                                    ),
                                                                  ),
                                                                ),
                                                                record.user.id
                                                                    .toString() ==
                                                                    controller
                                                                        .userData
                                                                        .getUserData!
                                                                        .id
                                                                    ? const Text(
                                                                  'You',
                                                                  style: TextStyle(
                                                                      fontSize: 10),)
                                                                    :
                                                                Text(record.user
                                                                    .name.split(
                                                                    ' ')[0],
                                                                  style: const TextStyle(
                                                                      fontSize: 10),)
                                                              ],
                                                            ),
                                                          )
                                                              : InkWell(
                                                            onTap: () async {
                                                              print(
                                                                  "dateT $date");
                                                              print(
                                                                  "isThisMonth ${record
                                                                      .prayerName}");
                                                              if (controller
                                                                  .userData
                                                                  .getUserData!
                                                                  .id
                                                                  .toString() ==
                                                                  record.user.id
                                                                      .toString()) {
                                                                bool isThisMonth = controller
                                                                    .isCurrentMonth(
                                                                    date);
                                                                print(
                                                                    "isThisMonth $isThisMonth");
                                                                if (isThisMonth) {
                                                                  Dialogs
                                                                      .showLoading(
                                                                      context,
                                                                      message: 'Please wait, Getting Prayer Time');
                                                                  // Use await to make getPrayerTime asynchronous
                                                                  DateTime? prayerTime = await Future
                                                                      .delayed(
                                                                      Duration
                                                                          .zero, () {
                                                                    return controller
                                                                        .getPrayerTime(
                                                                      controller
                                                                          .dashboardController
                                                                          .calendarData,
                                                                      date,
                                                                      record
                                                                          .prayerName,
                                                                    );
                                                                  });
                                                                  // DateTime? prayerTime = controller.getPrayerTime(controller.dashboardController.calendarData,date,record.prayerName);
                                                                  print(
                                                                      "prayerTime $prayerTime");
                                                                  String startTime = DateFormat("hh:mm a").format(prayerTime!);

                                                                  print(startTime);
                                                                  // Hide loading only if the context is still mounted
                                                                  if (context
                                                                      .mounted) {
                                                                    WidgetsBinding
                                                                        .instance
                                                                        .addPostFrameCallback((
                                                                        _) {
                                                                      Dialogs
                                                                          .hideLoading();
                                                                      showDialog(
                                                                        context: context,
                                                                        builder: (
                                                                            BuildContext context) {
                                                                          return TimePicker(
                                                                            date: date,
                                                                            prayerNames: record.prayerName,
                                                                            isFromMissed: true,
                                                                            missedPrayerTime: prayerTime,
                                                                            startTime: startTime,
                                                                            missedCallBack: () {
                                                                              controller.updateSelectedDate(DateFormat("dd-MM-yyyy").parse(date));
                                                                              return controller
                                                                                    .weeklyApi(
                                                                                    date);

                                                                            },);
                                                                        },
                                                                      );
                                                                    });
                                                                  }
                                                                }
                                                                else {
                                                                  controller
                                                                      .hitPrayerTimeByDate(
                                                                      date,
                                                                      record.prayerName,
                                                                      context);

                                                                }
                                                              }
                                                            },
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  bottom: 5.0),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .all(5),
                                                                    padding: const EdgeInsets
                                                                        .all(1),
                                                                    // Padding around the circular image
                                                                    decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border: Border
                                                                          .all(
                                                                        color: Colors
                                                                            .grey,
                                                                      ), // Grey border
                                                                    ),
                                                                    child: record
                                                                        .user
                                                                        .picture !=
                                                                        null
                                                                        ? ColorFiltered(
                                                                      colorFilter: const ColorFilter
                                                                          .matrix(
                                                                        <
                                                                            double>[
                                                                          0.2126,
                                                                          0.7152,
                                                                          0.0722,
                                                                          0,
                                                                          0,
                                                                          // Red channel coefficients
                                                                          0.2126,
                                                                          0.7152,
                                                                          0.0722,
                                                                          0,
                                                                          0,
                                                                          // Green channel coefficients
                                                                          0.2126,
                                                                          0.7152,
                                                                          0.0722,
                                                                          0,
                                                                          0,
                                                                          // Blue channel coefficients
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          1,
                                                                          0,
                                                                          // Alpha channel
                                                                        ],
                                                                      ),
                                                                      child: CircleAvatar(
                                                                        radius: 20,
                                                                        // Radius of the circular image
                                                                        backgroundImage: NetworkImage(
                                                                          "http://182.156.200.177:8011${record
                                                                              .user
                                                                              .picture}", // Replace with your image URL
                                                                        ),
                                                                      ),
                                                                    )
                                                                        : const Padding(
                                                                      padding: EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child: Icon(
                                                                        Icons
                                                                            .person,
                                                                        color: Colors
                                                                            .grey,
                                                                        size: 20,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  record.user.id
                                                                      .toString() ==
                                                                      controller
                                                                          .userData
                                                                          .getUserData!
                                                                          .id
                                                                      ? Text(
                                                                    'You',
                                                                    style: TextStyle(
                                                                        fontSize: 10),)
                                                                      :
                                                                  Text(
                                                                    record.user
                                                                        .name
                                                                        .split(
                                                                        ' ')[0],
                                                                    style: const TextStyle(
                                                                        fontSize: 10),
                                                                    overflow: TextOverflow.ellipsis,
                                                                  )

                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                      ],
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                              Divider(),
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  ),
                                  SizedBox(height: Get.height / 3,)
                                ]
                            ),
                          ),
                        )
                      ])
                  );
                }
                else {
                  return SliverToBoxAdapter(child: SizedBox.shrink());
                }

                // Obx(() {
                //   return ;
                // },),

              }
              )

            ]
        )
    );
  }
}