import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:namaz_reminders/DashBoard/timepickerpopup.dart';
import 'package:namaz_reminders/Routes/approutes.dart';
import 'package:namaz_reminders/UpcomingPrayers/upcomingView.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:namaz_reminders/DashBoard/dashboardController.dart';
import 'package:namaz_reminders/Drawer/DrawerView.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';
import '../Leaderboard/leaderboardDataModal.dart';

import '../LocationSelectionPage/locationPageView.dart';

class DashBoardView extends GetView<DashBoardController> {
  const DashBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    final DateController dateController = Get.put(DateController());
    final DashBoardController dashboardController = Get.put(DashBoardController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 35,
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
        title: Text("Prayer O'Clock", style: MyTextTheme.largeBCN),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset("assets/location.png"),
                const SizedBox(width: 4),
                Text(
                  dashboardController.location.value,
                  style: const TextStyle(color: Colors.black),
                ),
                 InkWell(
                   onTap: (){
                     Get.toNamed(AppRoutes.profileRoute);
                   },
                   child: CircleAvatar(
                    backgroundImage: NetworkImage("http://182.156.200.177:8011${controller.userData.getUserData!.picture}"),),
                 )
              ],
            ),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: GetBuilder(
          init: dashboardController,
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: dashboardController.isGifVisible
                  ? Image.asset(
                "assets/popup_Default.gif",
              )
                  :
              Column(
                children: [
                  Divider(
                    color: AppColor.greyLight,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/iconcalen.png", width: 15, height: 24),
                          ),
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
                            Obx(
                                  () => Text(
                                dashboardController.islamicDate.value,
                                style: const TextStyle(fontSize: 12, color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Obx(() {
                      double completionPercentage = controller.calculateCompletionPercentage();

                      return CircularPercentIndicator(
                        animateFromLastPercent: true,
                        circularStrokeCap: CircularStrokeCap.round,
                        animation: true,
                        animationDuration: 1200,
                        radius: 140,
                        lineWidth: 40,
                        percent: completionPercentage,
                        progressColor: AppColor.circleIndicator,
                        backgroundColor: Colors.grey.shade300,
                        // center: Text(
                        //   '${(completionPercentage * 100).toStringAsFixed(1)}%',
                        //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        // ),
                      );
                    }),
                    Positioned(
                      child: Obx(() {
                        double completionPercentage = controller.calculateCompletionPercentage();
                        // Circle center and radius
                        double radius = 100;
                        // Radius of the circle (adjust based on CircularPercentIndicator radius)
                        double angle = 2 * pi * completionPercentage;
                        // Convert percentage to radians

                        // Calculate x and y positions based on angle
                        double x = radius * cos(angle);
                        double y = radius * sin(angle);

                        return Positioned(
                          left: radius + x - 120,
                          // Offset to center the crown on the circle
                          top: radius - y - 100,
                          // Offset to center the crown on the circle
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child:     Lottie.asset("assets/Crown.lottie",
                                decoder: customDecoder, height: 1000),
                             ),

                        );
                      }),
                    ),


                    // Adding the GIF/Image inside the circular indicator
                    // Positioned(
                    //   left: 5,
                    //   bottom: 80,
                    //   child:
                    //   Lottie.asset("assets/Crown.lottie",
                    //        decoder: customDecoder, height: 50),
                    // ),

                    Positioned(
                      top: 70,
                      child: Obx(() {
                        // Check if there's a current prayer, if not, show the next prayer
                        if (dashboardController.currentPrayer.value.isEmpty) {
                          // Show next prayer message with blinking effect
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 50,),
                                BlinkingTextWidget(
                                  text: "${dashboardController.nextPrayer.value} starts at ${dashboardController.nextPrayerStartTime.value}",
                                  style: MyTextTheme.mustard,
                                ),
                              ],
                            ),
                          );
                        } else {
                          // Show the current prayer timings if available
                          return Column(
                            children: [
                              Text(
                                '${dashboardController.currentPrayerStartTime.value} - ${dashboardController.currentPrayerEndTime.value}',
                                style: MyTextTheme.smallBCn,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                dashboardController.remainingTime.value,
                                style: MyTextTheme.largeCustomBCB,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Left for ${dashboardController.currentPrayer.value} Prayer",
                                style: MyTextTheme.greyNormal,
                              ),
                            ],
                          );
                        }
                      }),
                    ),

                    // Conditionally show the "Mark as Prayer" button
                    Positioned(
                      bottom: 80,
                      child: Obx(() {
                        DateTime now = DateTime.now();
                        DateTime nextPrayerTime;

                        try {
                          nextPrayerTime = DateFormat('hh:mm a').parse(dashboardController.nextPrayerStartTime.value);
                          nextPrayerTime = DateTime(now.year, now.month, now.day, nextPrayerTime.hour, nextPrayerTime.minute);
                        } catch (e) {
                          nextPrayerTime = DateTime.now().subtract(const Duration(days: 1)); // Default to a past time if parsing fails
                        }

                        bool isBeforeNextPrayer = now.isBefore(nextPrayerTime);

                        return isBeforeNextPrayer
                            ? const SizedBox.shrink() // Hide the button
                            : InkWell(
                          child: Text("Mark as Prayer", style: MyTextTheme.mustardN),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return  const TimePicker();
                              },
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),


                const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                        color: AppColor.leaderboard,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap:(){
                                    Get.toNamed(AppRoutes.leaderboardRoute);
                                  },
                                    child: Text("LEADERBOARD", style: MyTextTheme.mediumGCB)),
                                SvgPicture.asset("assets/open.svg")
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                Image.asset("assets/person.png"),
                                const SizedBox(width: 5),
                                Text(
                                  '${dashboardController.rank.value}th',
                                  style: MyTextTheme.largeCustomBCB,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  'Out of ${dashboardController.totalPeers.value} people in peers',
                                  style: MyTextTheme.smallGCN,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(3.14159),
                                      child: LinearPercentIndicator(
                                        width: 290,
                                        barRadius: const Radius.circular(2),
                                        percent: 1,
                                        progressColor: AppColor.circleIndicator,
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: dashboardController.avatars.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(dashboardController.avatars[index]),
                                    radius: 15.0,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GetBuilder(
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
                                                child: SvgPicture.asset("assets/close.svg"),
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
                                              print("ddddddddd "+dashboardController.nextPrayer.value.toString());
                                              // // Determine if the current item is highlighted (active)
                                              // bool isHighlighted = dashboardController.nextPrayer.value ==
                                              //      dashboardController.prayerNames[index];
                                              bool isHighlighted = false;
                                              if(dashboardController.nextPrayer.value.isEmpty){
                                                int currentPrayerIndex = dashboardController.prayerNames.indexOf(dashboardController.currentPrayer.value);
                                                int nextPrayerIndex = (currentPrayerIndex + 1) % dashboardController.prayerNames.length;
                                                 isHighlighted = nextPrayerIndex == index;
                                              }
                                              else{
                                                 isHighlighted = dashboardController.nextPrayer.value == dashboardController.prayerNames[index];
                                              }
                                              return Transform.scale(
                                                scale: isHighlighted ? 1.1 : 1.0,  // Scale up the active item
                                                child: Opacity(
                                                  opacity: isHighlighted ? 1.0 : 0.5,  // Reduce opacity of inactive items
                                                  child: Container(
                                                    width: 80,
                                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: const AssetImage('assets/vector.png'),
                                                        colorFilter: isHighlighted
                                                            ? null
                                                            : ColorFilter.mode(
                                                          Colors.grey.withOpacity(0.3),
                                                          BlendMode.srcATop,
                                                        ),
                                                      ),
                                                      borderRadius: BorderRadius.circular(10),
                                                      // border: Border.all(
                                                      //   color: isHighlighted ? Colors.orangeAccent : Colors.transparent,
                                                      //   width: 2,
                                                      // ),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const SizedBox(height: 20),
                                                        Text(
                                                          dashboardController.prayerNames[index].toUpperCase(),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: isHighlighted ? 14 : 14,
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
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}

class BlinkingTextWidget extends StatefulWidget {
  final String text;
  final TextStyle style;

  const BlinkingTextWidget({required this.text, required this.style, Key? key}) : super(key: key);

  @override
  _BlinkingTextWidgetState createState() => _BlinkingTextWidgetState();
}

class _BlinkingTextWidgetState extends State<BlinkingTextWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller.drive(
        Tween(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.easeInOut)),
      ),
      child: Text(
        widget.text,
        style: widget.style,
      ),
    );
  }
}


