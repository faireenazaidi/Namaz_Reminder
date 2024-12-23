import 'dart:async';
import 'dart:ui';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
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
import '../Widget/MyRank/myRankController.dart';
import '../Widget/MyRank/myweeklyrank.dart';

class DashBoardView extends GetView<DashBoardController> {
  const DashBoardView({super.key});


  @override
  Widget build(BuildContext context) {
    final DashBoardController controller = Get.find();
    final MyRankController myRankController = Get.put(MyRankController());

    // final LeaderBoardController leaderBoardController = Get.put(LeaderBoardController());
    Future<LottieComposition?> customDecoder(List<int> bytes) {
      return LottieComposition.decodeZip(bytes, filePicker: (files) {
        return files.firstWhereOrNull(
                (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'));
      });
    }
    return DoubleBack(
      message: "Press again to exit!",
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar:
                AppBar(
                  bottom: PreferredSize(
                    preferredSize:  const Size.fromHeight(1.0),
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
                      padding: const EdgeInsets.all(7.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                              "assets/loc.svg"
                          ),
                          const SizedBox(width: 4),
                          GetBuilder<DashBoardController>(
                              id: 'add',
                              builder: (_) {
                                return
                                  InkWell(
                                  onTap: (){
                                    Dialogs.showConfirmationDialog(
                                    context: context,
                                    onConfirmed: ()async{
                                      return controller.changeLocation();
                                    },
                                    showCancelButton: false,
                                        initialMessage: 'Change Location',
                                        confirmButtonText: 'Use Current Location',
                                        confirmButtonColor: Colors.white.withOpacity(0.1),
                                        successMessage: "Location Updated",
                                        loadingMessage: 'Getting Current Location...');
                                  },
                                  child:
                                  Text(
                                     controller.address.split(',')[0].toString(),
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
                            child:  GetBuilder<DashBoardController>(
                              builder: (controller) {
                                return Stack(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.circleIndicator, // Outer circle color
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: controller.userData.getUserData!.picture.isNotEmpty
                                                ? DecorationImage(
                                              image: NetworkImage(
                                                "http://182.156.200.177:8011${controller.userData.getUserData!.picture}",
                                              ),
                                              fit: BoxFit.cover,
                                            )
                                                : null,
                                            color: controller.userData.getUserData!.picture.isEmpty
                                                ? AppColor.packageGray
                                                : null,
                                          ),
                                          child: controller.userData.getUserData!.picture.isEmpty
                                              ? Icon(
                                            Icons.person,
                                            size: 20,
                                            color: AppColor.circleIndicator,
                                          )
                                              : null,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 28,
                                      bottom: 20,
                                      child: Stack(
                                        children: [
                                             SvgPicture.asset(
                                                myRankController.rank == 1
                                                    ? 'assets/Gold.svg'
                                                    : myRankController.rank == 2
                                                    ? 'assets/silver.svg'
                                                    : myRankController.rank == 3
                                                    ? 'assets/Bronze.svg'
                                                    : 'assets/other.svg',
                                                height: 20,
                                             ),

                                          Positioned(
                                            right: 8,
                                            bottom: 2,
                                            child: Column(
                                              children: [
                                                Center(
                                                  child: MyRank(
                                                    rankedFriends: controller.weeklyRanked,
                                                    textSize: 8,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

            drawer: const CustomDrawer(),
            body: GetBuilder<DashBoardController>(
              builder: (_) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: controller.isGifVisible
                      ? Center(
                        child: Image.asset(
                                          alignment: Alignment.center,
                                          "assets/popup_Default.gif",
                                        ),
                      )
                      :
                  SingleChildScrollView(
                    child: Column(
                      children: [
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
                                // controller.calculateCompletionPercentage();
                                // print("completionPercentage ${controller.completionPercentage}");
                                // print("controller.isPrayed ${controller.isPrayed}");
                                // print("controller.nextPrayer ${controller.nextPrayer}");
                                // print("controller.nextPrayer ${controller.currentPrayer}");
                                // print("controller.nextPrayer ${controller.currentPrayerStartTime}");
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
                                ) :CircularPercentIndicator(
                                  restartAnimation: false,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  animation: true,
                                  animateFromLastPercent: true,
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
                                  progressColor:controller.isGapPeriod.value?Colors.grey :AppColor.circleIndicator,
                                  backgroundColor: Colors.grey.shade300,
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
                                    //print("ccccccccccc ${controller.currentPrayer.value}");
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
                                    else if(controller.isGapPeriod.value){
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
                                        // controller.onPrayerMarked(controller.currentPrayer.value);
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
                                      // "assets/award.lottie",
                                      "assets/shield.lottie",
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
                        GetBuilder<DashBoardController>(
                          id: 'leader',
                          builder: (_) {
                            return InkWell(
                              onTap: (){
                                Get.to(() => const LeaderBoardView(),
                                  transition: Transition.circularReveal,
                                  duration: Duration(milliseconds: 400),
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
                                        : controller.getLeaderboardList.value!.records, prayerName: controller.trackMarkPrayer,),
                                  ],
                                ),

                              ),
                            );
                          }
                        ),
                        const SizedBox(height: 20),

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
                                      Text(controller.isGapPeriod.value?controller.currentPrayer.value:controller.nextPrayerName.value,style: MyTextTheme.largeWCB.copyWith(
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

                                       InkWell(
                                         onTap: (){
                                       controller.toggle(controller.nextPrayerName.value);
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
                                          Text(controller.isGapPeriod.value?controller.currentPrayerStartTime.value:controller.upcomingPrayerStartTime.value,style: const TextStyle(
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
                                          Text(controller.isGapPeriod.value?controller.currentPrayerEndTime.value:controller.upcomingPrayerEndTime.value,style: const TextStyle(
                                              color: Colors.white,
                                            fontSize: 14,fontWeight: FontWeight.w600
                                          ))
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),

                              ),
                            );
                          }),
                        // UserRankCarousel(),
                        // UserRankList()
                              ]
                          ),
                  ),
                  );}
              )
          ),
        ),
      ),
    );
}
  // showCustomBottomSheet2({
  //   required BuildContext context,
  //   required String message,
  //   required String confirmButtonText,
  //   String? cancelButtonText,
  //   Color? confirmButtonColor,
  //   bool showCancelButton = true,
  //   VoidCallback? onConfirmed,
  //   VoidCallback? onCancelled,
  //   bool isProcessing = false,
  //   required String loadingMessage, required String successMessage,
  // }) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.circular(50)
  //     ),
  //     backgroundColor: Colors.transparent,
  //     builder: (BuildContext context) {
  //       return Container(
  //         height: 380,
  //         padding: const EdgeInsets.all(20.0),
  //         decoration: BoxDecoration(
  //           image: const DecorationImage(
  //             opacity: 0.9,
  //             image: AssetImage("assets/net.png"),
  //             fit: BoxFit.cover,
  //           ),
  //           color: AppColor.gray,
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
  //         ),
  //         child: Column(
  //           // mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             SizedBox(height: 50,),
  //             Image.asset(
  //               "assets/container.png",
  //               width: 40,
  //               height: 50,
  //             ),
  //             const SizedBox(height: 10),
  //             Text(
  //               message,
  //              style: MyTextTheme.mustardN,
  //               textAlign: TextAlign.center,
  //             ),
  //             const SizedBox(height: 40),
  //             TextField(
  //               //controller: controller.nameC.value,
  //               cursorColor: AppColor.circleIndicator,
  //               decoration: InputDecoration(
  //                 suffixIcon: Icon(Icons.search),
  //                 hintText: "Enter an address",
  //                 hintStyle: MyTextTheme.mediumCustomGCN,
  //                 // prefixIcon: Image.asset("asset/profile.png"),
  //                 fillColor: Colors.white.withOpacity(0.1),
  //                 filled: true,
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(10),
  //                   borderSide: const BorderSide(
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //                 enabledBorder: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(10),
  //                   borderSide: const BorderSide(
  //                     color: Colors.white,
  //                     width: 1,
  //                   ),
  //                 ),
  //                 focusedBorder: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(10),
  //                   borderSide: const BorderSide(
  //                     color: Colors.white,
  //                     width: 1,
  //                   ),
  //                 ),
  //               ),
  //               style: const TextStyle(
  //                 color: Colors.white,
  //               ),
  //             ),
  //             SizedBox(
  //               height: 20,
  //             ),
  //
  //             // TextField(
  //             //   //controller: controller.nameC.value,
  //             //   cursorColor: AppColor.circleIndicator,
  //             //   decoration: InputDecoration(
  //             //     prefixIcon: Icon(Icons.location_on),
  //             //     hintText: "Use Current Location",
  //             //     suffixIcon:  InkWell(
  //             //       onTap: (){
  //             //       },
  //             //         child: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,)
  //             //
  //             //     ),
  //             //     hintStyle: MyTextTheme.mediumCustomGCN,
  //             //     // prefixIcon: Image.asset("asset/profile.png"),
  //             //     fillColor: Colors.white.withOpacity(0.1),
  //             //     filled: true,
  //             //     border: OutlineInputBorder(
  //             //       borderRadius: BorderRadius.circular(10),
  //             //       borderSide: const BorderSide(
  //             //         color: Colors.white,
  //             //       ),
  //             //     ),
  //             //     enabledBorder: OutlineInputBorder(
  //             //       borderRadius: BorderRadius.circular(10),
  //             //       borderSide: const BorderSide(
  //             //         color: Colors.white,
  //             //         width: 1,
  //             //       ),
  //             //     ),
  //             //     focusedBorder: OutlineInputBorder(
  //             //       borderRadius: BorderRadius.circular(10),
  //             //       borderSide: const BorderSide(
  //             //         color: Colors.white,
  //             //         width: 1,
  //             //       ),
  //             //     ),
  //             //   ),
  //             //   style: const TextStyle(
  //             //     color: Colors.white,
  //             //   ),
  //             // ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
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
  late List<Record> _filteredRecords; // Stores filtered and sorted records
  bool _areAllScoresZero = true; // Checks if all scores are zero for conditional display

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0); // Smaller viewportFraction for stacking effect
    _initializeRecords(); // Filter, sort, and set zero-score flag
    _startAutoScroll();
  }

  // Check if widget's records or prayer name change, update filtered records if necessary
  @override
  void didUpdateWidget(covariant UserRankList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.records != oldWidget.records || widget.prayerName != oldWidget.prayerName) {
      _initializeRecords();
    }
  }

  // Filters and sorts records based on the prayer name and checks if all scores are zero
  void _initializeRecords() {
    // Filter records based on the selected prayer name
    _filteredRecords = widget.records
        .where((record) => record.prayerName == widget.prayerName)
        .toList()
      ..sort((a, b) => double.parse(b.score).compareTo(double.parse(a.score))); // Sort by score descending

    // Check if all scores are zero
    _areAllScoresZero = _filteredRecords.every((record) => double.parse(record.score) == 0);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) { // Check if controller is attached
        if (_currentIndex < _filteredRecords.length - 1) {
          _currentIndex++;
        } else {
          _currentIndex = 0;
        }
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubicEmphasized,
        );
      } else {
        timer.cancel(); // Cancel the timer if the controller is not attached
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_filteredRecords.isEmpty){
      return const Center(child: Text('Prayer timings not available yet.',style: TextStyle(
          color: Colors.grey
      ),));
    }
    else if(_areAllScoresZero){
      return const Center(
        child: Text(
          "No one has marked the Prayer",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
    else{
      return SizedBox(
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
                if (_pageController.hasClients && _pageController.position.haveDimensions) {
                  double pageOffset = (_pageController.page ?? 0) - index;
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
                              radius: 29,
                              backgroundColor: AppColor.circleIndicator,
                              child: CircleAvatar(
                                radius: 28,
                               backgroundColor: AppColor.packageGray,
                                child: Icon(
                                  Icons.person,
                                  color: AppColor.circleIndicator,
                                  size: 30,
                                ),
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
                                    SvgPicture.asset('assets/Gold.svg',height: 15,color: AppColor.circleIndicator,),
                                    Positioned(
                                      bottom: 1,
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


