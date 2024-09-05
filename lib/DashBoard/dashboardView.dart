import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:namaz_reminders/DashBoard/dashboardController.dart';
import 'package:namaz_reminders/Drawer/DrawerView.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import 'package:namaz_reminders/Widget/calendar.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';

class DashBoardView extends GetView<DashBoardController> {
  const DashBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    final DashBoardController dashboardController = Get.put(DashBoardController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: Text("Bill Maroof", style: MyTextTheme.largeBCN),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset("assets/location.png"),
                const SizedBox(width: 4),
                const Text("Lucknow", style: TextStyle(color: Colors.black)),
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage("https://media.istockphoto.com/id/1409155424/photo/head-shot-portrait-of-millennial-handsome-30s-man.webp?a=1&b=1&s=612x612&w=0&k=20&c=Q5Zz9w0FulC0CtH-VCL8UX2SjT7tanu5sHNqCA96iVw="),
                )
              ],
            ),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Divider(
                color: AppColor.greyLight,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      child: Image.asset("assets/calendar3.png"),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: MyDateTimeField(
                                useFutureDate: true,
                                suffixIcon: Container(
                                  decoration: BoxDecoration(color: AppColor.buttonColor),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Icon(
                                      CupertinoIcons.calendar,
                                      color: Colors.indigoAccent,
                                    ),
                                  ),
                                ),
                                borderColor: AppColor.black,
                                initialValue: DateTime.now().toString(),
                                onChanged: (value) {
                                  // Handle date change
                                },
                              ),
                            );
                          },
                        );
                      },

                    ),
                    const SizedBox(width: 5),
                    const Text("Thursday,22 August 2024"),
                    Container(
                      height: 30,
                      child: VerticalDivider(
                        color: AppColor.borderGrey,
                        thickness: 1.5,
                        width: 15,
                        indent: 6,
                        endIndent: 6,
                      ),
                    ),
                     Text('${dashboardController.islamicDate}')

                  ],
                ),
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircularPercentIndicator(
                    animateFromLastPercent: true,
                    circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                    animationDuration: 1200,
                    radius: 130,
                    lineWidth: 30,
                    percent: 0.7,
                    progressColor: AppColor.circleIndicator,
                    backgroundColor: Colors.grey.shade300,
                  ),
                  const Positioned(
                    top: 70,
                    child: Text("12:24 PM - 4:55 PM"),
                  ),
                  Positioned(
                    top: 90,
                    child: Text("3h 48m 15s", style: MyTextTheme.largeCustomBCB),
                  ),
                  Positioned(
                    top: 120,
                    child: Text("Left for Zuhr Prayer", style: MyTextTheme.mediumGCB),
                  ),
                  Positioned(
                    bottom: 80,
                    child: InkWell(
                      child: Text("Mark as Prayer", style: MyTextTheme.mustard),
                      onTap: () {

                      },
                    ),
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
                        child: Text("LEADERBOARD", style: MyTextTheme.mediumGCB),
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
                            LinearPercentIndicator(
                              width: 290,
                              percent: 0.8,
                              progressColor: AppColor.circleIndicator,
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
              Column(
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/jalih.png")
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dashboardController.prayerNames.length,
                      itemBuilder: (context, index) {
                        bool isHighlighted = dashboardController.currentPrayerIndex.value ==
                            dashboardController.prayerNames[index];
                        return Container(
                          width: 90,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/vector.png'),
                            ),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isHighlighted
                                  ? Colors.orangeAccent
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 20,),
                              Text(
                                dashboardController.prayerNames[index].toUpperCase(),
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                              SizedBox(height: 8),


                            Text(
                              dashboardController.prayerTimes[index].toString(),
                              style: MyTextTheme.smallGCN,


                               )

                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
