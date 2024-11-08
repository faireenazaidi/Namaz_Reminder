import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:namaz_reminders/DashBoard/renked_friend.dart';
import 'package:namaz_reminders/DashBoard/timepickerpopup.dart';
import 'package:namaz_reminders/Routes/approutes.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:namaz_reminders/DashBoard/dashboardController.dart';
import 'package:namaz_reminders/Drawer/DrawerView.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';
import '../AppManager/dialogs.dart';
import '../Leaderboard/leaderboardDataModal.dart';
import '../Leaderboard/leaderboardView.dart';

class DashBoardView extends GetView<DashBoardController> {
  const DashBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    // final DateController dateController = Get.put(DateController());
    // final DashBoardController dashboardController = Get.put(DashBoardController());
    // final List<RankedFriend> rankedFriends = [
    //   RankedFriend(id: 58, name: 'Baqar Naqvi', totalScore: 85.29, percentage: 17.058),
    //   RankedFriend(id: 4, name: 'Faheem', totalScore: 0.0, percentage: 60.0),
    //   RankedFriend(id: 6, name: 'Suhail', totalScore: 0.0, percentage: 75.0),
    //   // Add more friends here...
    // ];
    Future<LottieComposition?> customDecoder(List<int> bytes) {
      return LottieComposition.decodeZip(bytes, filePicker: (files) {
        return files.firstWhereOrNull(
                (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'));
      });
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Divider(
            height: 1.0,
            color: AppColor.packageGray,
          ),
        ),
        toolbarHeight: 55,
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
        title: Text("Prayer O'Clock", style: MyTextTheme.largeBN),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SvgPicture.asset(
                    "assets/loc.svg"
                ),
                const SizedBox(width: 4),
                GetBuilder<DashBoardController>(
                  id: 'add',
                  builder: (_) {
                    return InkWell(
                      onTap: (){
                        Dialogs.showConfirmationDialog(context: context, onConfirmed: ()async{
                         return controller.changeLocation();
                        },showCancelButton: false,
                        initialMessage: 'Change Location',confirmButtonText: 'Get Current Location',
                        confirmButtonColor: AppColor.buttonColor,
                        successMessage: controller.address,
                        loadingMessage: 'Getting Current Location...');
                      },
                      child: Text(
                         controller.address,
                        style: MyTextTheme.greyNormal,
                      ),
                    );
                  }
                ),
                 SizedBox(width: 8,),
                 InkWell(
                   onTap: (){
                     Get.toNamed(AppRoutes.leaderboardRoute,arguments: {'selectedTab': 'weekly'});

                   },
                   // child: CircleAvatar(
                   //  backgroundImage: NetworkImage("http://182.156.200.177:8011${controller.userData.getUserData!.picture}"),),
                   child:  Container(
                     width: 40,
                     height: 40,
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       image: controller.userData.getUserData!.picture.isNotEmpty
                           ? DecorationImage(
                         image: NetworkImage("http://182.156.200.177:8011${controller.userData.getUserData!.picture}"),
                         fit: BoxFit.cover,
                       )
                           : null,
                       color: controller.userData.getUserData!.picture.isEmpty
                           ? AppColor.circleIndicator
                           : null,
                     ),
                     child: controller.userData.getUserData!.picture.isEmpty
                         ? const Icon(Icons.person, size: 25, color: Colors.white)
                         : null,
                   ),
                 )
              ],
            ),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: GetBuilder<DashBoardController>(
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: controller.isGifVisible
                  ? Image.asset(
                "assets/popup_Default.gif",
              )
                  :
              Column(
                children: [
                  // Divider(
                  //   color: AppColor.greyLight,
                  //   thickness: 1,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:  SvgPicture.asset(
                              "assets/calendar3.svg"
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              DateFormat('EEE, d MMMM yyyy').format(DateTime.now()), // Always shows current date
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
                                    controller.islamicDate.value,
                                    style: const TextStyle(fontSize: 12, color: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            ),
                        
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 340,
                    width: 350,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Obx(() {
                          controller.calculateCompletionPercentage();
                          print("completionPercentage ${controller.completionPercentage}");
                          print("controller.isPrayed ${controller.isPrayed}");
                          return controller.isPrayed?CircularPercentIndicator(
                            restartAnimation: false,
                            circularStrokeCap: CircularStrokeCap.round,
                            animation: false,
                            // animateFromLastPercent: true,
                            animationDuration: 1200,
                            radius: 130,
                            lineWidth: 40,
                            widgetIndicator: Container(
                              height: 5,
                              width: 5,
                              alignment: Alignment.center,
                              child: Lottie.asset(
                                "assets/Star.lottie",
                                fit: BoxFit.contain,
                                width: 80,
                                height: 80,
                                decoder: customDecoder,
                              ),
                            ),
                            percent:0.0,
                            progressColor:controller.currentPrayer.value=='Free'?Colors.grey :AppColor.circleIndicator,
                            backgroundColor: AppColor.circleIndicator,
                            // center: Text(
                            //   '${(completionPercentage * 100).toStringAsFixed(1)}%',
                            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            // ),
                          ) :CircularPercentIndicator(
                            restartAnimation: true,
                            circularStrokeCap: CircularStrokeCap.round,
                            animation: true,
                            // animateFromLastPercent: true,
                            animationDuration: 1200,
                            radius: 140,
                            lineWidth: 40,
                            widgetIndicator: Container(
                              height: 5,
                              width: 5,
                              alignment: Alignment.center,
                              child: Lottie.asset(
                                "assets/Star.lottie",
                                fit: BoxFit.contain,
                                width: 80,
                                height: 80,
                                decoder: customDecoder,
                              ),
                            ),
                            percent:controller.completionPercentage.value==0.0?0.0:1.0-controller.completionPercentage.value,
                            progressColor:controller.currentPrayer.value=='Free'?Colors.grey :AppColor.circleIndicator,
                            backgroundColor: Colors.grey.shade300,
                            // center: Text(
                            //   '${(completionPercentage * 100).toStringAsFixed(1)}%',
                            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            // ),
                          );
                        }),
                      //   Obx(() {
                      //     double completionPercentage = controller.calculateCompletionPercentage();
                      //     // Circle center and radius
                      //     double radius = 100;
                      //     // Radius of the circle (adjust based on CircularPercentIndicator radius)
                      //     double angle = 2 * pi * completionPercentage;
                      //     // Convert percentage to radians
                      //
                      //   // Calculate x and y positions based on angle
                      //   double x = radius * cos(angle);
                      //   double y = radius * sin(angle);
                      //
                      //   return Positioned(
                      //     left: radius + x - 120,
                      //     // Offset to center the crown on the circle
                      //     top: radius - y - 100,
                      //     // Offset to center the crown on the circle
                      //     child: CircleAvatar(
                      //       radius: 15,
                      //       backgroundColor: Colors.white,
                      //       child:     Lottie.asset("assets/Star.lottie",
                      //           decoder: customDecoder, height: 1000),
                      //     ),
                      //
                      //   );
                      // }),
                        if(!controller.isPrayed)
                        Positioned(
                          top: 70,
                          child: Obx(() {
                            // Check if there's a current prayer, if not, show the next prayer
                            print("ccccccccccc ${controller.currentPrayer.value}");
                            if (controller.currentPrayer.value.isEmpty) {
                              // Show next prayer message with blinking effect
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 50,),
                                    BlinkingTextWidget(
                                      text: "${controller.nextPrayer.value} starts at ${controller.nextPrayerStartTime.value}",
                                      style: MyTextTheme.mustard,
                                    ),
                                  ],
                                ),
                              );
                            }
                            else if(controller.currentPrayer.value=='Free'){
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 75,),
                                    BlinkingTextWidget(
                                      text: "${controller.nextPrayer.value} starts at ${controller.nextPrayerStartTime.value}",
                                      style: MyTextTheme.greyNormal,
                                    ),
                                  ],
                                ),
                              );
                            }
                            else {
                              // Show the current prayer timings if available
                              return  Column(
                                children: [
                                  SizedBox(height: 35,),
                                  Center(
                                    child: Text(
                                      '${controller.currentPrayerStartTime.value} - ${controller.currentPrayerEndTime.value}',
                                      style: MyTextTheme.smallBCn,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    controller.remainingTime.value,
                                    style: MyTextTheme.largeCustomBCB,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Left for ${controller.currentPrayer.value} Prayer",
                                    style: MyTextTheme.greyNormal,
                                  ),
                                ],
                              );
                            }
                          }),
                        ),

                        // Conditionally show the "Mark as Prayer" button
                       controller.isPrayed?Text("",style: TextStyle(
                           color: AppColor.circleIndicator,fontWeight: FontWeight.w600
                       ),):
                       Positioned(
                          bottom: 120,
                          child: Obx(() {
                            DateTime now = DateTime.now();
                            DateTime nextPrayerTime;

                            try {
                              nextPrayerTime = DateFormat('hh:mm a').parse(controller.nextPrayerStartTime.value);
                              nextPrayerTime = DateTime(now.year, now.month, now.day, nextPrayerTime.hour, nextPrayerTime.minute);
                            } catch (e) {
                              nextPrayerTime = DateTime.now().subtract(const Duration(days: 1));
                            }

                            bool isBeforeNextPrayer = now.isBefore(nextPrayerTime);

                            return isBeforeNextPrayer
                                ? const SizedBox.shrink() // Hide the button
                                : InkWell(
                              child:controller.isPrayed? Text("Prayed!",style: TextStyle(
                                  color: AppColor.circleIndicator,fontWeight: FontWeight.w600
                              ),) :Text("Mark as Prayed", style: MyTextTheme.mustardN),
                              onTap: () {
                                if (!controller.isPrayed) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return GestureDetector(
                                        onTap: () => Navigator.of(context).pop(),
                                        child: Stack(
                                          children: [
                                            // Apply blur to the background
                                            BackdropFilter(
                                              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                              child: Container(
                                                color: Colors.black.withOpacity(0.5), // Optional dark overlay
                                              ),
                                            ),
                                             TimePicker()
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              },

                            );
                          }),
                        ),
                        if(controller.isPrayed)
                        GetBuilder<DashBoardController>(
                          id: 'lottie',
                          builder: (_) {
                            return Positioned(
                              // top: -30, // Adjust the 'top' value as per your layout
                                child: Column(
                                  children: [
                                    // SizedBox(height: 20,),
                                    ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                        Colors.blue.withOpacity(0), // The color you want to blend with
                                        BlendMode.multiply,            // The blend mode
                                      ),
                                      child: Lottie.asset(
                                        "assets/circular.lottie", // Your existing Lottie animation path
                                        decoder: customDecoder,    // Your custom decoder
                                        width: 430,                // Adjust width as needed
                                        height: 330,
                                        fit: BoxFit.contain,// Adjust height as needed

                                      ),
                                    ),
                                  ],
                                ),
                            );
                          }
                        ),
                        if(controller.isPrayed)
                        GetBuilder<DashBoardController>(
                          id: 'lottie',
                          builder: (_) {
                            return Positioned(
                              // top: -35, // Adjust the 'top' value as per your layout
                              child: Lottie.asset(
                                "assets/crystal.lottie",
                                decoder: customDecoder, // Replace with your new Lottie animation path
                                width: 300,  // Adjust the width and height as per your design
                                height: 190,
                                 fit: BoxFit.contain,

                            ),
                          );
                        }
                      ),
                        if(controller.isPrayed)
                        GetBuilder<DashBoardController>(
                          id: 'lottie',
                          builder: (_) {
                            return Positioned(
                              // top: -35, // Adjust the 'top' value as per your layout
                              child: Lottie.asset(
                                "assets/award.lottie",
                                repeat: false,
                                decoder: customDecoder, // Replace with your new Lottie animation path
                                width: 300,  // Adjust the width and height as per your design
                                height: 150,
                                 fit: BoxFit.contain,

                            ),
                          );
                        }
                      ),


                    ],
                  )),
                  // Lottie.asset(
                  //   "assets/circular.lottie", // Replace with your new Lottie animation path
                  //   decoder: customDecoder,
                  //   width: 300,  // Adjust the width and height as per your design
                  //   height: 100,
                  //   // fit: BoxFit.contain,
                  // ),
                // const SizedBox(height: 10),
                  GetBuilder<DashBoardController>(
                    id: 'leader',
                    builder: (_) {
                      return Visibility(
                        visible: true,
                        child: InkWell(
                          onTap: (){
                            Get.to(() => const LeaderBoardView(),
                              transition: Transition.rightToLeft,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColor.leaderboard,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("LEADERBOARD",style: MyTextTheme.greyN,),
                                    SvgPicture.asset("assets/Close.svg")
                                  ],
                                ),
                                const SizedBox(height: 12,),
                                UserRankList(records: controller.getLeaderboardList.value == null
                                    ? []
                                    : controller.getLeaderboardList.value!.records, prayerName: controller.currentPrayer.value,),
                                // RankedFriendsIndicator(
                                //   rankedFriends: controller.getLeaderboardList.value == null
                                //       ? []
                                //       : controller.getLeaderboardList.value!.rankedFriends,
                                //   currentUserId: int.parse(controller.userData.getUserData!.id),
                                // ),
                              ],
                            ),


                                                        ),
                        ),
                        );
                    }
                  ),


                  // Obx(() {
                  //   if (controller.rank.value == 0) {
                  //     return SizedBox.shrink();
                  //   } else {
                  //     return InkWell(
                  //       onTap: () {
                  //         Get.toNamed(AppRoutes.leaderboardRoute);
                  //       },
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Container(
                  //           alignment: Alignment.center,
                  //           padding: const EdgeInsets.all(10),
                  //           decoration: BoxDecoration(
                  //             color: AppColor.leaderboard,
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: RankedFriendsIndicator(
                  //             rankedFriends: controller.getLeaderboardList.value == null
                  //                 ? []
                  //                 : controller.getLeaderboardList.value!.rankedFriends,
                  //             currentUserId: int.parse(controller.userData.getUserData!.id),
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   }
                  // }),


                  const SizedBox(height: 15),
                  // GetBuilder<DashBoardController>(
                  //   builder: (_){
                  //     return Column(
                  //       children: [
                  //                 Container(
                  //                   height: 200,
                  //                   decoration: BoxDecoration(
                  //                     color: Colors.black87,
                  //                     image: const DecorationImage(
                  //                         fit: BoxFit.cover,
                  //                         image: AssetImage("assets/jalih.png")
                  //                     ),
                  //                     borderRadius: BorderRadius.circular(15),
                  //                   ),
                  //
                  //                   child: Stack(
                  //                     children: [
                  //                       Row(
                  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                         children: [
                  //
                  //                            InkWell(
                  //                              onTap: (){
                  //                                Get.to(() => Upcoming(),
                  //                                  transition: Transition.rightToLeft,
                  //                                  duration: Duration(milliseconds: 500),
                  //                                  curve: Curves.ease,);
                  //
                  //                              },
                  //                                child: Padding(
                  //                                  padding: const EdgeInsets.all(8.0),
                  //                                  child: Text("UPCOMING PRAYERS", style: MyTextTheme.mediumWCB),
                  //                                )),
                  //
                  //                           Padding(
                  //                             padding: const EdgeInsets.all(8.0),
                  //                             child: InkWell(
                  //                               onTap: () {
                  //                                 Get.to(() => Upcoming(),
                  //                                   transition: Transition.rightToLeft,
                  //                                   duration: Duration(milliseconds: 500),
                  //                                   curve: Curves.ease,);
                  //                               },
                  //                               child: SvgPicture.asset("assets/cl.svg"),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                       // Positioned block to properly contain ListView.builder
                  //                       Positioned(
                  //                         top: 60,  // Adjust as necessary
                  //                         left: 0,
                  //                         right: 0,
                  //                         bottom: 0,
                  //                         child: ListView.builder(
                  //                           scrollDirection: Axis.horizontal,
                  //                           controller: controller.scrollController,
                  //                           itemCount: controller.prayerNames.length,
                  //                           itemBuilder: (context, index) {
                  //                             print("ddddddddd "+controller.nextPrayer.value.toString());
                  //                             print("eeeeeeeee "+controller.currentPrayer.value.toString());
                  //                             // // Determine if the current item is highlighted (active)
                  //                             // bool isHighlighted = dashboardController.nextPrayer.value ==
                  //                             //      dashboardController.prayerNames[index];
                  //                             bool isHighlighted = false;
                  //                             if(controller.nextPrayer.value.isEmpty){
                  //                               int currentPrayerIndex = controller.prayerNames.indexOf(controller.currentPrayer.value);
                  //                               int nextPrayerIndex = (currentPrayerIndex + 1) % controller.prayerNames.length;
                  //                               print("NEXT PRAYER INDEX !!@# $nextPrayerIndex");
                  //                                isHighlighted = nextPrayerIndex == index;
                  //                             }
                  //                             else{
                  //                                isHighlighted = controller.nextPrayer.value == controller.prayerNames[index];
                  //                                print("NEXT PRAYER INDEX !!@# $isHighlighted");
                  //                                print("NEXT PRAYER INDEX !!@# ${controller.nextPrayer.value}");
                  //                             }
                  //                             return Transform.scale(
                  //                               scale: isHighlighted ? 1.1 : 1.0,  // Scale up the active item
                  //                               child: Opacity(
                  //                                 opacity: isHighlighted ? 1.0 : 0.6,  // Reduce opacity of inactive items
                  //                                 child: Container(
                  //                                   width: 80,
                  //                                   margin: const EdgeInsets.symmetric(horizontal: 8),
                  //                                   // decoration: BoxDecoration(
                  //                                   //   image: DecorationImage(
                  //                                   //     image: const AssetImage('assets/vector.png'),
                  //                                   //     colorFilter: isHighlighted
                  //                                   //         ? null
                  //                                   //         : ColorFilter.mode(
                  //                                   //       Colors.grey.withOpacity(0.3),
                  //                                   //       BlendMode.srcATop,
                  //                                   //     ),
                  //                                   //   ),
                  //                                   //   borderRadius: BorderRadius.circular(10),
                  //                                   //   // border: Border.all(
                  //                                   //   //   color: isHighlighted ? Colors.orangeAccent : Colors.transparent,
                  //                                   //   //   width: 2,
                  //                                   //   // ),
                  //                                   // ),
                  //                                   child: Stack(
                  //                                     children:[
                  //                                       SvgPicture.asset("assets/Vec.svg"),
                  //                                     Column(
                  //                                       mainAxisAlignment: MainAxisAlignment.center,
                  //                                       children: [
                  //                                         // const SizedBox(height: 20),
                  //                                         Text(
                  //                                           controller.prayerNames[index].toUpperCase(),
                  //                                           style: TextStyle(
                  //                                             color: Colors.white,
                  //                                             fontSize: isHighlighted ? 13 : 13,
                  //                                           ),
                  //                                         ),
                  //                                         const SizedBox(height: 8),
                  //                                         Center(
                  //                                           child: Text(
                  //                                             controller.getPrayerTimes.isEmpty
                  //                                                 ? "Loading"
                  //                                                 : controller.getPrayerTimes[index].toString(),
                  //                                             style: isHighlighted
                  //                                                 ? MyTextTheme.smallBCN
                  //                                                 : MyTextTheme.smallGCN,
                  //                                           ),
                  //                                         )
                  //                                       ],
                  //                                     ),
                  //                                     ]
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                             );
                  //                             // return Transform.scale(
                  //                             //   scale: isHighlighted ? 1.1 : 1.0, // Scale up the active item
                  //                             //   child: Opacity(
                  //                             //     opacity: isHighlighted ? 1.0 : 0.5, // Reduce opacity of inactive items
                  //                             //     child: Container(
                  //                             //       width: 80,
                  //                             //       margin: const EdgeInsets.symmetric(horizontal: 8),
                  //                             //       decoration: BoxDecoration(
                  //                             //         borderRadius: BorderRadius.circular(10),
                  //                             //       ),
                  //                             //       child: Stack(
                  //                             //         children: [
                  //                             //           // Load the SVG image in the background
                  //                             //           SvgPicture.asset(
                  //                             //             'assets/Vec.svg',height: 40,
                  //                             //             fit: BoxFit.cover,// Use your SVG image here
                  //                             //
                  //                             //             colorFilter: isHighlighted
                  //                             //                 ? null
                  //                             //                 : ColorFilter.mode(
                  //                             //               Colors.grey.withOpacity(0.3),
                  //                             //               BlendMode.srcATop,
                  //                             //             ),
                  //                             //           ),
                  //                             //           // Place the rest of the content over the SVG image
                  //                             //           Column(
                  //                             //             mainAxisAlignment: MainAxisAlignment.center,
                  //                             //             children: [
                  //                             //               const SizedBox(height: 20),
                  //                             //               Text(
                  //                             //                 dashboardController.prayerNames[index].toUpperCase(),
                  //                             //                 style: TextStyle(
                  //                             //                   color: Colors.white,
                  //                             //                   fontSize: isHighlighted ? 14 : 14,
                  //                             //                 ),
                  //                             //               ),
                  //                             //               const SizedBox(height: 8),
                  //                             //               Center(
                  //                             //                 child: Text(
                  //                             //                   dashboardController.getPrayerTimes.isEmpty
                  //                             //                       ? "Loading"
                  //                             //                       : dashboardController.getPrayerTimes[index].toString(),
                  //                             //                   style: isHighlighted
                  //                             //                       ? MyTextTheme.smallBCN
                  //                             //                       : MyTextTheme.smallGCN,
                  //                             //                 ),
                  //                             //               ),
                  //                             //             ],
                  //                             //           ),
                  //                             //         ],
                  //                             //       ),
                  //                             //     ),
                  //                             //   ),
                  //                             // );
                  //
                  //                           },
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //
                  //                 ),
                  //       ],
                  //     );
                  //   }),
                  Obx((){
                      return InkWell(
                        onTap: (){
                          Get.toNamed(AppRoutes.upcomingRoute);
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/jalih.png")
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),


                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(controller.nextPrayerName.value,style: MyTextTheme.largeWCB.copyWith(
                                  fontSize: 20,fontWeight: FontWeight.w600
                                ),),
                                Text(controller.isPrayed?'Next Prayer':"Upcoming Prayer",style: MyTextTheme.mustard2),
                              ],
                            ),
                            const SizedBox(height: 15,),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset('assets/alarm.svg',color: Colors.white,height: 25,),

                                      const SizedBox(width: 10,),
                                      Row(
                                        children: [
                                          Text("starts in ",style: MyTextTheme.smallWCN,),
                                         controller.nextPrayerName.value=='Fajr'?Text(controller.formatDuration(controller.upcomingRemainingTime.value),style: MyTextTheme.smallWCB,) :Text(controller.remainingTime.value,style: MyTextTheme.smallWCB,),
                                          // Text("${controller.upcomingRemainingTime.value.inHours.toString().padLeft(2, '0')}:${(controller.upcomingRemainingTime.value.inMinutes% 60).toString().padLeft(2, '0')}:${(controller.upcomingRemainingTime.value.inSeconds % 60).toString().padLeft(2, '0')}",style: MyTextTheme.smallWCB,),
                                        ],
                                      )
                                    ],
                                  ),
                                  // IconButton(onPressed: (){
                                  //
                                  // },
                                  //
                                  //     icon: Icon(Icons.volume_up_outlined,color: AppColor.circleIndicator,),
                                  // )
                                 InkWell(
                                   onTap: (){
                                 controller.toggle(controller.nextPrayerName.value);
                                //  controller.userData.toggleSound(controller.nextPrayerName.value);
                                // bool isEnable = controller.userData.isSoundEnabled(controller.nextPrayerName.value);
                                // print("isEnable $isEnable");
                                   },

                             child: Obx(() {
                               return SvgPicture.asset(controller.isMute.value
                                   ? 'assets/mute.svg'
                                   : 'assets/sound.svg',height: 20,);
                             }),
                                 )
                                ],
                              ),
                            ),
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Starts at',style: TextStyle(
                                        color: Colors.white,fontSize: 11
                                    )),
                                    Text(controller.upcomingPrayerStartTime.value,style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,fontWeight: FontWeight.w600
                                    ))
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Ends at',style: TextStyle(
                                        color: Colors.white,fontSize: 11
                                    )),
                                    Text(controller.upcomingPrayerEndTime.value,style: const TextStyle(
                                        color: Colors.white,
                                      fontSize: 14,fontWeight: FontWeight.w600
                                    ))
                                  ],
                                ),
                              ],
                            )
                            // Positioned block to properly contain ListView.builder
                            // Positioned(
                            //   top: 60,  // Adjust as necessary
                            //   left: 0,
                            //   right: 0,
                            //   bottom: 0,
                            //   child: ListView.builder(
                            //     scrollDirection: Axis.horizontal,
                            //     controller: controller.scrollController,
                            //     itemCount: controller.prayerNames.length,
                            //     itemBuilder: (context, index) {
                            //       print("ddddddddd "+controller.nextPrayer.value.toString());
                            //       print("eeeeeeeee "+controller.currentPrayer.value.toString());
                            //       // // Determine if the current item is highlighted (active)
                            //       // bool isHighlighted = dashboardController.nextPrayer.value ==
                            //       //      dashboardController.prayerNames[index];
                            //       bool isHighlighted = false;
                            //       if(controller.nextPrayer.value.isEmpty){
                            //         int currentPrayerIndex = controller.prayerNames.indexOf(controller.currentPrayer.value);
                            //         int nextPrayerIndex = (currentPrayerIndex + 1) % controller.prayerNames.length;
                            //         print("NEXT PRAYER INDEX !!@# $nextPrayerIndex");
                            //          isHighlighted = nextPrayerIndex == index;
                            //       }
                            //       else{
                            //          isHighlighted = controller.nextPrayer.value == controller.prayerNames[index];
                            //          print("NEXT PRAYER INDEX !!@# $isHighlighted");
                            //          print("NEXT PRAYER INDEX !!@# ${controller.nextPrayer.value}");
                            //       }
                            //       return Transform.scale(
                            //         scale: isHighlighted ? 1.1 : 1.0,  // Scale up the active item
                            //         child: Opacity(
                            //           opacity: isHighlighted ? 1.0 : 0.6,  // Reduce opacity of inactive items
                            //           child: Container(
                            //             width: 80,
                            //             margin: const EdgeInsets.symmetric(horizontal: 8),
                            //             // decoration: BoxDecoration(
                            //             //   image: DecorationImage(
                            //             //     image: const AssetImage('assets/vector.png'),
                            //             //     colorFilter: isHighlighted
                            //             //         ? null
                            //             //         : ColorFilter.mode(
                            //             //       Colors.grey.withOpacity(0.3),
                            //             //       BlendMode.srcATop,
                            //             //     ),
                            //             //   ),
                            //             //   borderRadius: BorderRadius.circular(10),
                            //             //   // border: Border.all(
                            //             //   //   color: isHighlighted ? Colors.orangeAccent : Colors.transparent,
                            //             //   //   width: 2,
                            //             //   // ),
                            //             // ),
                            //             child: Stack(
                            //               children:[
                            //                 SvgPicture.asset("assets/Vec.svg"),
                            //               Column(
                            //                 mainAxisAlignment: MainAxisAlignment.center,
                            //                 children: [
                            //                   // const SizedBox(height: 20),
                            //                   Text(
                            //                     controller.prayerNames[index].toUpperCase(),
                            //                     style: TextStyle(
                            //                       color: Colors.white,
                            //                       fontSize: isHighlighted ? 13 : 13,
                            //                     ),
                            //                   ),
                            //                   const SizedBox(height: 8),
                            //                   Center(
                            //                     child: Text(
                            //                       controller.getPrayerTimes.isEmpty
                            //                           ? "Loading"
                            //                           : controller.getPrayerTimes[index].toString(),
                            //                       style: isHighlighted
                            //                           ? MyTextTheme.smallBCN
                            //                           : MyTextTheme.smallGCN,
                            //                     ),
                            //                   )
                            //                 ],
                            //               ),
                            //               ]
                            //             ),
                            //           ),
                            //         ),
                            //       );
                            //       // return Transform.scale(
                            //       //   scale: isHighlighted ? 1.1 : 1.0, // Scale up the active item
                            //       //   child: Opacity(
                            //       //     opacity: isHighlighted ? 1.0 : 0.5, // Reduce opacity of inactive items
                            //       //     child: Container(
                            //       //       width: 80,
                            //       //       margin: const EdgeInsets.symmetric(horizontal: 8),
                            //       //       decoration: BoxDecoration(
                            //       //         borderRadius: BorderRadius.circular(10),
                            //       //       ),
                            //       //       child: Stack(
                            //       //         children: [
                            //       //           // Load the SVG image in the background
                            //       //           SvgPicture.asset(
                            //       //             'assets/Vec.svg',height: 40,
                            //       //             fit: BoxFit.cover,// Use your SVG image here
                            //       //
                            //       //             colorFilter: isHighlighted
                            //       //                 ? null
                            //       //                 : ColorFilter.mode(
                            //       //               Colors.grey.withOpacity(0.3),
                            //       //               BlendMode.srcATop,
                            //       //             ),
                            //       //           ),
                            //       //           // Place the rest of the content over the SVG image
                            //       //           Column(
                            //       //             mainAxisAlignment: MainAxisAlignment.center,
                            //       //             children: [
                            //       //               const SizedBox(height: 20),
                            //       //               Text(
                            //       //                 dashboardController.prayerNames[index].toUpperCase(),
                            //       //                 style: TextStyle(
                            //       //                   color: Colors.white,
                            //       //                   fontSize: isHighlighted ? 14 : 14,
                            //       //                 ),
                            //       //               ),
                            //       //               const SizedBox(height: 8),
                            //       //               Center(
                            //       //                 child: Text(
                            //       //                   dashboardController.getPrayerTimes.isEmpty
                            //       //                       ? "Loading"
                            //       //                       : dashboardController.getPrayerTimes[index].toString(),
                            //       //                   style: isHighlighted
                            //       //                       ? MyTextTheme.smallBCN
                            //       //                       : MyTextTheme.smallGCN,
                            //       //                 ),
                            //       //               ),
                            //       //             ],
                            //       //           ),
                            //       //         ],
                            //       //       ),
                            //       //     ),
                            //       //   ),
                            //       // );
                            //
                            //     },
                            //   ),
                            // ),
                          ],
                        ),

                        ),
                      );
                    }),
                  // UserRankCarousel(),
                  // UserRankList()
            ]
        ),
      );}
  ))
    );
}}

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
   initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
 dispose() {
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


class UserRankCarousel extends StatelessWidget {
  
  final String prayerName;

  const UserRankCarousel({this.prayerName='Asr'});

  @override
  Widget build(BuildContext context) {
    List records= [
      {
        "user": {
          "id": 70,
          "username": "914",
          "mobile_no": "6390319914",
          "name": "Amritash",
          "picture": null
        },
        "user_timestamp": null,
        "latitude": 26.8784825,
        "longitude": 80.8715478,
        "date": "2024-11-05",
        "prayer_name": "Fajr",
        "score": 0,
        "jamat": true,
        "times_of_prayer": 5
      },
      {
        "user": {
          "id": 70,
          "username": "914",
          "mobile_no": "6390319914",
          "name": "Amritash",
          "picture": null
        },
        "user_timestamp": null,
        "latitude": 26.8784825,
        "longitude": 80.8715478,
        "date": "2024-11-05",
        "prayer_name": "Dhuhr",
        "score": 0,
        "jamat": true,
        "times_of_prayer": 5
      },
      {
        "user": {
          "id": 70,
          "username": "914",
          "mobile_no": "6390319914",
          "name": "Amritash",
          "picture": null
        },
        "user_timestamp": "16:46",
        "latitude": 26.8784825,
        "longitude": 80.8715478,
        "date": "2024-11-05",
        "prayer_name": "Asr",
        "score": 100.0,
        "jamat": true,
        "times_of_prayer": 5
      },
      {
        "user": {
          "id": 70,
          "username": "914",
          "mobile_no": "6390319914",
          "name": "Amritash",
          "picture": null
        },
        "user_timestamp": null,
        "latitude": 26.8784825,
        "longitude": 80.8715478,
        "date": "2024-11-05",
        "prayer_name": "Maghrib",
        "score": 0,
        "jamat": true,
        "times_of_prayer": 5
      },
      {
        "user": {
          "id": 70,
          "username": "914",
          "mobile_no": "6390319914",
          "name": "Amritash",
          "picture": null
        },
        "user_timestamp": null,
        "latitude": 26.8784825,
        "longitude": 80.8715478,
        "date": "2024-11-05",
        "prayer_name": "Isha",
        "score": 0,
        "jamat": true,
        "times_of_prayer": 5
      },
      {
        "user": {
          "id": 40,
          "username": "111",
          "mobile_no": "1111111111",
          "name": "Demo 111",
          "picture": null
        },
        "user_timestamp": null,
        "latitude": 26.8784713,
        "longitude": 80.8715507,
        "date": "2024-11-05",
        "prayer_name": "Fajr",
        "score": 0,
        "jamat": false,
        "times_of_prayer": 5
      },
      {
        "user": {
          "id": 40,
          "username": "111",
          "mobile_no": "1111111111",
          "name": "Demo 111",
          "picture": null
        },
        "user_timestamp": null,
        "latitude": 26.8784713,
        "longitude": 80.8715507,
        "date": "2024-11-05",
        "prayer_name": "Dhuhr",
        "score": 0,
        "jamat": false,
        "times_of_prayer": 5
      },
      {
        "user": {
          "id": 40,
          "username": "111",
          "mobile_no": "1111111111",
          "name": "Demo 111",
          "picture": null
        },
        "user_timestamp": "16:47",
        "latitude": 26.8784713,
        "longitude": 80.8715507,
        "date": "2024-11-05",
        "prayer_name": "Asr",
        "score": 23.19,
        "jamat": false,
        "times_of_prayer": 5
      },
      {
        "user": {
          "id": 40,
          "username": "111",
          "mobile_no": "1111111111",
          "name": "Demo 111",
          "picture": null
        },
        "user_timestamp": null,
        "latitude": 26.8784713,
        "longitude": 80.8715507,
        "date": "2024-11-05",
        "prayer_name": "Maghrib",
        "score": 0,
        "jamat": false,
        "times_of_prayer": 5
      },
      {
        "user": {
          "id": 40,
          "username": "111",
          "mobile_no": "1111111111",
          "name": "Demo 111",
          "picture": null
        },
        "user_timestamp": null,
        "latitude": 26.8784713,
        "longitude": 80.8715507,
        "date": "2024-11-05",
        "prayer_name": "Isha",
        "score": 0,
        "jamat": false,
        "times_of_prayer": 5
      },
      {
        "user": {
          "id": 59,
          "username": "444",
          "mobile_no": "6332266444",
          "name": "Testing",
          "picture": null
        },
        "prayer_name": "Fajr",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 59,
          "username": "444",
          "mobile_no": "6332266444",
          "name": "Testing",
          "picture": null
        },
        "prayer_name": "Dhuhr",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 59,
          "username": "444",
          "mobile_no": "6332266444",
          "name": "Testing",
          "picture": null
        },
        "prayer_name": "Asr",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 59,
          "username": "444",
          "mobile_no": "6332266444",
          "name": "Testing",
          "picture": null
        },
        "prayer_name": "Maghrib",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 59,
          "username": "444",
          "mobile_no": "6332266444",
          "name": "Testing",
          "picture": null
        },
        "prayer_name": "Isha",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 42,
          "username": "300",
          "mobile_no": "8840888300",
          "name": "Israr Khan",
          "picture": "/media/image_cropper_1726754868996.jpg"
        },
        "prayer_name": "Fajr",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 42,
          "username": "300",
          "mobile_no": "8840888300",
          "name": "Israr Khan",
          "picture": "/media/image_cropper_1726754868996.jpg"
        },
        "prayer_name": "Dhuhr",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 42,
          "username": "300",
          "mobile_no": "8840888300",
          "name": "Israr Khan",
          "picture": "/media/image_cropper_1726754868996.jpg"
        },
        "prayer_name": "Asr",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 42,
          "username": "300",
          "mobile_no": "8840888300",
          "name": "Israr Khan",
          "picture": "/media/image_cropper_1726754868996.jpg"
        },
        "prayer_name": "Maghrib",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 42,
          "username": "300",
          "mobile_no": "8840888300",
          "name": "Israr Khan",
          "picture": "/media/image_cropper_1726754868996.jpg"
        },
        "prayer_name": "Isha",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 6,
          "username": "447",
          "mobile_no": "7905216447",
          "name": "Baqar N",
          "picture": "/media/image_cropper_1729749137337.jpg"
        },
        "user_timestamp": null,
        "latitude": 37.4219983,
        "longitude": -122.084,
        "date": "2024-11-05",
        "prayer_name": "Fajr",
        "score": 0,
        "jamat": true,
        "times_of_prayer": 5
      },
      {
        "user": {
          "id": 6,
          "username": "447",
          "mobile_no": "7905216447",
          "name": "Baqar N",
          "picture": "/media/image_cropper_1729749137337.jpg"
        },
        "user_timestamp": "13:25",
        "latitude": 37.4219983,
        "longitude": -122.084,
        "date": "2024-11-05",
        "prayer_name": "Dhuhr",
        "score": 100.0,
        "jamat": true,
        "times_of_prayer": 5
      },
      {
        "user": {
          "id": 6,
          "username": "447",
          "mobile_no": "7905216447",
          "name": "Baqar N",
          "picture": "/media/image_cropper_1729749137337.jpg"
        },
        "user_timestamp": "16:44",
        "latitude": 37.4219983,
        "longitude": -122.084,
        "date": "2024-11-05",
        "prayer_name": "Asr",
        "score": 25.36,
        "jamat": true,
        "times_of_prayer": 5
      },
      {
        "user": {
          "id": 6,
          "username": "447",
          "mobile_no": "7905216447",
          "name": "Baqar N",
          "picture": "/media/image_cropper_1729749137337.jpg"
        },
        "user_timestamp": null,
        "latitude": 37.4219983,
        "longitude": -122.084,
        "date": "2024-11-05",
        "prayer_name": "Maghrib",
        "score": 0,
        "jamat": true,
        "times_of_prayer": 5
      },
      {
        "user": {
          "id": 6,
          "username": "447",
          "mobile_no": "7905216447",
          "name": "Baqar N",
          "picture": "/media/image_cropper_1729749137337.jpg"
        },
        "user_timestamp": null,
        "latitude": 37.4219983,
        "longitude": -122.084,
        "date": "2024-11-05",
        "prayer_name": "Isha",
        "score": 0,
        "jamat": true,
        "times_of_prayer": 5
      },
      {
        "user": {
          "id": 75,
          "username": "464",
          "mobile_no": "3666466464",
          "name": "helo",
          "picture": null
        },
        "prayer_name": "Fajr",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 75,
          "username": "464",
          "mobile_no": "3666466464",
          "name": "helo",
          "picture": null
        },
        "prayer_name": "Dhuhr",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 75,
          "username": "464",
          "mobile_no": "3666466464",
          "name": "helo",
          "picture": null
        },
        "prayer_name": "Asr",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 75,
          "username": "464",
          "mobile_no": "3666466464",
          "name": "helo",
          "picture": null
        },
        "prayer_name": "Maghrib",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 75,
          "username": "464",
          "mobile_no": "3666466464",
          "name": "helo",
          "picture": null
        },
        "prayer_name": "Isha",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 109,
          "username": "534",
          "mobile_no": "8318215534",
          "name": "Arshad Test",
          "picture": null
        },
        "prayer_name": "Fajr",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 109,
          "username": "534",
          "mobile_no": "8318215534",
          "name": "Arshad Test",
          "picture": null
        },
        "prayer_name": "Dhuhr",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 109,
          "username": "534",
          "mobile_no": "8318215534",
          "name": "Arshad Test",
          "picture": null
        },
        "prayer_name": "Asr",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 109,
          "username": "534",
          "mobile_no": "8318215534",
          "name": "Arshad Test",
          "picture": null
        },
        "prayer_name": "Maghrib",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 109,
          "username": "534",
          "mobile_no": "8318215534",
          "name": "Arshad Test",
          "picture": null
        },
        "prayer_name": "Isha",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 53,
          "username": "303",
          "mobile_no": "7784928303",
          "name": "Baqar Naqvi",
          "picture": "/media/image_cropper_1727453197024.jpg"
        },
        "prayer_name": "Fajr",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 53,
          "username": "303",
          "mobile_no": "7784928303",
          "name": "Baqar Naqvi",
          "picture": "/media/image_cropper_1727453197024.jpg"
        },
        "prayer_name": "Dhuhr",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 53,
          "username": "303",
          "mobile_no": "7784928303",
          "name": "Baqar Naqvi",
          "picture": "/media/image_cropper_1727453197024.jpg"
        },
        "prayer_name": "Asr",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 53,
          "username": "303",
          "mobile_no": "7784928303",
          "name": "Baqar Naqvi",
          "picture": "/media/image_cropper_1727453197024.jpg"
        },
        "prayer_name": "Maghrib",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      },
      {
        "user": {
          "id": 53,
          "username": "303",
          "mobile_no": "7784928303",
          "name": "Baqar Naqvi",
          "picture": "/media/image_cropper_1727453197024.jpg"
        },
        "prayer_name": "Isha",
        "score": 0,
        "user_timestamp": null,
        "jamat": false,
        "latitude": null,
        "longitude": null,
        "date": "2024-11-05",
        "times_of_prayer": null
      }
    ];
    // Filter and sort users by score for the selected prayer
    final filteredRecords = records
        .where((record) => record['prayer_name'] == prayerName)
        .toList();
    filteredRecords.sort((a, b) => (double.parse(b['score'].toString())).compareTo(double.parse(a['score'].toString())));

    return SizedBox(
      height: 150,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: filteredRecords.length,
        itemBuilder: (context, index) {
          final user = filteredRecords[index]['user'];
          final rank = index + 1; // Rank is index + 1 because index starts at 0
          final scoreChange = filteredRecords[index]['score_change'] ?? 0; // Assume a field `score_change`
          final totalPeers = filteredRecords.length;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Rank and Score Change
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rank < 10 ? '0$rank' : '$rank', // Format for 2 digits
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_upward,
                            color: Colors.green,
                            size: 16,
                          ),
                          Text(
                            '+$scoreChange',
                            style: TextStyle(color: Colors.green, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // User Information
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user['name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$rank${getOrdinalSuffix(rank)} out of $totalPeers people in peers',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),

                  // Profile Picture with Badge
                  SizedBox(
                    height: 50,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: user['picture'] != null
                              ? NetworkImage(user['picture'])
                              : AssetImage('assets/default-avatar.jpg') as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper function to get the ordinal suffix for a number (e.g., "1st", "2nd")
  String getOrdinalSuffix(int number) {
    if (number >= 11 && number <= 13) {
      return 'th';
    }
    switch (number % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}


//
// class UserRankList extends StatefulWidget {
//   final List<Record> records; // Accept a list of Record objects
//   final String prayerName;
//
//   const UserRankList({Key? key, required this.prayerName, required this.records}) : super(key: key);
//
//   @override
//   _UserRankListState createState() => _UserRankListState();
// }
//
// class _UserRankListState extends State<UserRankList> {
//   late ScrollController _scrollController;
//   Timer? _timer;
//   int _currentIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _startAutoScroll();
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   void _startAutoScroll() {
//     _timer = Timer.periodic(Duration(seconds: 3), (timer) {
//       if (_currentIndex < _filteredRecords.length - 1) {
//         _currentIndex++;
//       } else {
//         _currentIndex = 0; // Reset to start for circular scrolling
//       }
//       _scrollToIndex(_currentIndex);
//     });
//   }
//
//   void _scrollToIndex(int index) {
//     _scrollController.animateTo(
//       index * 72.0, // Assumes each item has a height of around 100
//       duration: Duration(milliseconds: 500),
//       curve: Curves.easeInOutCubicEmphasized,
//     );
//   }
//
//   // Filtered and sorted records based on prayer name
//   List<Record> get _filteredRecords {
//     final filteredRecords = widget.records
//         .where((record) => record.prayerName == widget.prayerName)
//         .toList();
//     filteredRecords.sort((a, b) => double.parse(b.score).compareTo(double.parse(a.score)));
//     return filteredRecords;
//   }
//
//
//   // List<Map<String, dynamic>> get _filteredRecords {
//   //   final filteredRecords = _records
//   //       .where((record) => record['prayer_name'] == widget.prayerName)
//   //       .toList();
//   //   filteredRecords.sort((a, b) => (double.parse(b['score'].toString()))
//   //       .compareTo(double.parse(a['score'].toString())));
//   //   return filteredRecords;
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 80,
//       child: ListView.builder(
//         padding: EdgeInsets.only(top: 8),
//         controller: _scrollController,
//         itemCount: _filteredRecords.length,
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           final record = _filteredRecords[index];
//           final user = record.user;
//           final rank = index + 1; // Rank is index + 1 because index starts at 0
//           final totalPeers = _filteredRecords.length;
//           // final user = _filteredRecords[index]['user'];
//           // final rank = index + 1; // Rank is index + 1 because index starts at 0
//           // final totalPeers = _filteredRecords.length;
//
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Rank display
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       rank < 10 ? '0$rank' : '$rank',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 // User Information
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       user.name,
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       '$rank${getOrdinalSuffix(rank)} out of $totalPeers people in peers',
//                       style: TextStyle(color: Colors.grey, fontSize: 14),
//                     ),
//                   ],
//                 ),
//                 // Profile Picture with Badge
//                 Stack(
//                   children: [
//                     CircleAvatar(
//                       radius: 28,
//                       backgroundImage: user.picture != null
//                           ? NetworkImage(user.picture!)
//                           : AssetImage('assets/default-avatar.jpg') as ImageProvider,
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: Container(
//                         padding: EdgeInsets.all(4),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Icon(
//                           Icons.star,
//                           color: Colors.orange,
//                           size: 16,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   // Helper function to get the ordinal suffix for a number (e.g., "1st", "2nd")
//   String getOrdinalSuffix(int number) {
//     if (number >= 11 && number <= 13) {
//       return 'th';
//     }
//     switch (number % 10) {
//       case 1:
//         return 'st';
//       case 2:
//         return 'nd';
//       case 3:
//         return 'rd';
//       default:
//         return 'th';
//     }
//   }
// }
//
// import 'dart:async';
// import 'package:flutter/material.dart';

class UserRankList extends StatefulWidget {
  final String prayerName;
  final List<Record> records;

  const UserRankList({Key? key, required this.records, required this.prayerName}) : super(key: key);

  @override
  _UserRankListState createState() => _UserRankListState();
}

class _UserRankListState extends State<UserRankList> {
  late PageController _pageController;
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0); // Smaller viewportFraction for stacking effect
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentIndex < _filteredRecords.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 700),
        curve: Curves.easeInOutCubicEmphasized,
      );
    });
  }

  List<Record> get _filteredRecords {
    final filteredRecords = widget.records
        .where((record) => record.prayerName == widget.prayerName)
        .toList();
    filteredRecords.sort((a, b) => double.parse(b.score).compareTo(double.parse(a.score)));
    return filteredRecords;
  }

  @override
  Widget build(BuildContext context) {
    return _filteredRecords.isEmpty?const Center(child: Text('No Prayer Time Found',style: TextStyle(
      color: Colors.grey
    ),)):SizedBox(
      height: 70, // Adjust height as needed for better spacing
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _filteredRecords.length,
        itemBuilder: (context, index) {
          final record = _filteredRecords[index];
          final user = record.user;
          final rank = index + 1;
          final totalPeers = _filteredRecords.length;

          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              // Apply scaling transformation for stacking effect
              double scale = 1.0;
              if (_pageController.position.haveDimensions) {
                double pageOffset = _pageController.page! - index;
                scale = (1 - (pageOffset.abs() * 0.2)).clamp(0.8, 1.0);
              }

              return Transform.scale(
                scale: scale,
                alignment: Alignment.topCenter,
                child: Opacity(
                  opacity: scale, // Fade effect as the item moves out
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Rank display
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rank < 10 ? '0$rank' : '$rank',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      // User Information
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$rank${getOrdinalSuffix(rank)} out of $totalPeers people in peers',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                      // Profile Picture with Badge
                      Stack(
                        children: [
                          user.picture != null?  CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage("http://182.156.200.177:8011${user.picture!}")

                          ):CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 20,
                                  ),
                                  Positioned(
                                    child: Text(
                                      '$rank', // Display the rank number
                                      style: const TextStyle(fontSize: 7,
                                          color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Helper function to get the ordinal suffix for a number (e.g., "1st", "2nd")
  String getOrdinalSuffix(int number) {
    if (number >= 11 && number <= 13) {
      return 'th';
    }
    switch (number % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}







