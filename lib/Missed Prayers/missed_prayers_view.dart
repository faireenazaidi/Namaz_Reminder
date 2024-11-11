import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:namaz_reminders/DashBoard/dashboardView.dart';
import 'package:namaz_reminders/Leaderboard/LeaderBoardController.dart';
import '../AppManager/dialogs.dart';
import '../DashBoard/dashboardController.dart';
import '../DashBoard/timepickerpopup.dart';
import '../Leaderboard/leaderboardDataModal.dart';
import '../Widget/appColor.dart';
import '../Widget/text_theme.dart';

class MissedPrayersView extends GetView<LeaderBoardController>{
  const MissedPrayersView({super.key});

  @override
  Widget build(BuildContext context) {

    LeaderBoardController controller = Get.put(LeaderBoardController());
    final DateController dateController = Get.put(DateController());
    
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColor.cream,
      body: CustomScrollView(
          slivers: [
            // SliverAppBar(
            //   title:  Text("Missed Prayers",style: MyTextTheme.mediumBCD,),
            //   centerTitle: true,
            //   pinned: true,
            //   expandedHeight: 300.0,
            //   backgroundColor: AppColor.cream,
            //   leading: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child:
            //       InkWell(
            //           onTap: () {
            //             Get.back();
            //             // Get.to(
            //             //       () => DashBoardView(),
            //             //   transition: Transition.leftToRight,
            //             //   duration: Duration(milliseconds: 500),
            //             //   curve: Curves.ease,
            //             // );
            //           },
            //           child: Icon(Icons.arrow_back_ios_new, color: Colors.black)),
            //
            //
            //   ),
            //
            //   flexibleSpace: FlexibleSpaceBar(
            //     centerTitle: true,
            //     background: Padding(
            //       padding: const EdgeInsets.all(16.0), // Adjust padding to avoid overflow
            //       child: Column(
            //         // mainAxisAlignment: MainAxisAlignment.end,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           const SizedBox(height: 80,),
            //           Obx(() => Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               // Daily Button
            //               GestureDetector(
            //                 onTap: () => controller.updateSelectedTab='Daily',
            //                 child: Container(
            //                   decoration: BoxDecoration(
            //                     color: controller.selectedTab.value == 'Daily' ? AppColor.circleIndicator : Colors.transparent,
            //                     borderRadius: BorderRadius.circular(15),
            //                   ),
            //                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            //                   child: Text(
            //                     'Daily',
            //                     style: TextStyle(
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.bold,
            //                       color: controller.getSelectedTab == 'Daily' ? Colors.white : Colors.black,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               const SizedBox(width: 10),
            //               // Weekly Button
            //               GestureDetector(
            //                 onTap: () => controller.updateSelectedTab ='Weekly',
            //                 child: Container(
            //                   decoration: BoxDecoration(
            //                     color: controller.getSelectedTab == 'Weekly' ? AppColor.circleIndicator : Colors.transparent,
            //                     borderRadius: BorderRadius.circular(15),
            //                   ),
            //                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            //                   child: Text(
            //                     'Weekly',
            //                     style: TextStyle(
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.bold,
            //                       color: controller.getSelectedTab == 'Weekly' ? Colors.white : Colors.black,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           )),
            //           const SizedBox(height: 60),
            //           InkWell(
            //             onTap: () async {
            //               DateTime? picked = await showDatePicker(
            //                 context: context,
            //                 initialDate: dateController.selectedDate.value,
            //                 firstDate: DateTime(2020),
            //                 lastDate: DateTime.now(),
            //               );
            //               if (picked != null) {
            //                 print("picked $picked");
            //                 dateController.updateSelectedDate(picked);
            //                 String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
            //                 if(controller.getSelectedTab == 'Daily'){
            //                   controller.leaderboard(formattedDate);
            //                 }
            //                 else{
            //                   controller.weeklyApi(formattedDate);
            //                 }
            //
            //               }
            //             },
            //             child: Row(
            //               children: [
            //                SvgPicture.asset("assets/calendar3.svg",height: 15,),
            //                 const SizedBox(width: 5),
            //                 Obx(() => Row(
            //                   children: [
            //                     Text(
            //                       DateFormat('EEE,d MMMM yyyy').format(dateController.selectedDate.value),
            //                       style: const TextStyle(fontSize: 12, color: Colors.black),
            //                       overflow: TextOverflow.ellipsis,
            //                     ),
            //                     Container(
            //                       width: 1, // Vertical divider width
            //                       height: 15, // Divider height
            //                       color: Colors.grey,
            //                       margin: const EdgeInsets.symmetric(horizontal: 10), // Adjust spacing between texts and divider
            //                     ),
            //
            //                     Obx(
            //                           () => Text(
            //                         dashboardController.islamicDate.value,
            //                         style: const TextStyle(fontSize: 12, color: Colors.black),
            //                         overflow: TextOverflow.ellipsis,
            //                       ),
            //                     ),
            //                     // Expanded(
            //                     //   child: Text(
            //                     //     dateController.formatHijriDate(dateController.selectedDate.value),
            //                     //     style: const TextStyle(fontSize: 14, color: Colors.black),
            //                     //     overflow: TextOverflow.ellipsis,
            //                     //   ),
            //                     // ),
            //                   ],
            //                 )),
            //               ],
            //             ),
            //           ),
            //           SizedBox(height: 10,),
            //           Center(child: const Text("TODAY'S TIMELINE",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),)),
            //           const SizedBox(height: 15),
            //
            //
            //            Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               CircleAvatar(child: Text("F"),
            //                 backgroundColor: AppColor.circleIndicator,
            //               ),
            //               SizedBox(width: 5,),
            //               CircleAvatar(child: Text("Z"),
            //                 backgroundColor: AppColor.circleIndicator,),
            //               SizedBox(width: 5,),
            //               CircleAvatar(child: Text("A"),
            //                 backgroundColor: AppColor.circleIndicator,),
            //               SizedBox(width: 5,),
            //               CircleAvatar(child: Text("M"),
            //                 backgroundColor: AppColor.circleIndicator,),
            //               SizedBox(width: 5,),
            //               CircleAvatar(child: Text("I"),
            //                 backgroundColor: AppColor.circleIndicator,),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            SliverAppBar(
              title: Text("Missed Prayers", style: MyTextTheme.mediumBCD),
              centerTitle: true,
              pinned: true,
              expandedHeight: 300.0,
              backgroundColor: AppColor.cream,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
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
                          Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.updateSelectedDate(DateTime.now());
                                  controller.updateSelectedTab = 'Daily';
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: controller.selectedTab.value == 'Daily'
                                        ? AppColor.circleIndicator
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  child: Text(
                                    'Daily',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: controller.getSelectedTab == 'Daily'
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  controller.updateSelectedDate(DateTime.now());
                                  controller.updateSelectedTab = 'Weekly';
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: controller.getSelectedTab == 'Weekly'
                                        ? AppColor.circleIndicator
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  child: Text(
                                    'Weekly',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: controller.getSelectedTab == 'Weekly'
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                          const SizedBox(height: 60),
                          InkWell(
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate:controller.getSelectedTab == 'Daily'?controller.selectedDate.value:DateTime.now().subtract(Duration(days: 1)),
                                firstDate: DateTime(2020),
                                lastDate:controller.getSelectedTab == 'Daily'? DateTime.now():DateTime.now().subtract(Duration(days: 1)),
                              );
                              if (picked != null) {
                                controller.updateSelectedDate(picked);
                                // controller.updateIslamicDateBasedOnOption(date: picked);
                                String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
                                if (controller.getSelectedTab == 'Daily') {
                                  controller.leaderboard(formattedDate);
                                } else {
                                  controller.weeklyApi(formattedDate);
                                }
                              }
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/calendar3.svg", height: 15),
                                const SizedBox(width: 5),
                                Obx(() => Row(
                                  children: [
                                    Text(
                                      DateFormat('EEE, d MMMM yyyy')
                                          .format(controller.selectedDate.value),
                                      style: const TextStyle(fontSize: 12, color: Colors.black),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 15,
                                      color: Colors.grey,
                                      margin: const EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                    Obx(() => Text(
                                      controller.islamicDate.value,
                                      style: const TextStyle(fontSize: 12, color: Colors.black),
                                    )),
                                  ],
                                )),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: const Text(
                              "TODAY'S TIMELINE",
                              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                child: Text("F"),
                                backgroundColor: AppColor.circleIndicator,
                              ),
                              SizedBox(width: 5),
                              CircleAvatar(
                                child: Text("Z"),
                                backgroundColor: AppColor.circleIndicator,
                              ),
                              SizedBox(width: 5),
                              CircleAvatar(
                                child: Text("A"),
                                backgroundColor: AppColor.circleIndicator,
                              ),
                              SizedBox(width: 5),
                              CircleAvatar(
                                child: Text("M"),
                                backgroundColor: AppColor.circleIndicator,
                              ),
                              SizedBox(width: 5),
                              CircleAvatar(
                                child: Text("I"),
                                backgroundColor: AppColor.circleIndicator,
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

            // SliverToBoxAdapter(
            //   child: Obx(() {
            //     return Container(
            //          height:controller.selectedTab.value == 'Weekly' ? Get.height: 800,
            //         decoration: const BoxDecoration(
            //             borderRadius: BorderRadius.vertical(
            //               top: Radius.circular(50.0),
            //             ),
            //             color: Colors.white
            //         ),
            //
            //         child: Column(
            //           children: [
            //             SizedBox(height: 10,),
            //             Container(
            //               width: 100,
            //               height: 8,
            //               decoration: BoxDecoration(
            //                   color:AppColor.packageGray,
            //                   borderRadius: BorderRadius.circular(10)
            //               ),
            //
            //             ),
            //             // Space between leaderboard and toggle buttons
            //             const SizedBox(height: 20), // Adjust the height as needed
            //             if(controller.selectedTab.value == 'Daily')
            //             Row(
            //               children: [
            //                 Obx((){
            //                   return controller.getLeaderboardList.value!=null?
            //                     Expanded(
            //                       child: ListView.builder(
            //                         physics: const NeverScrollableScrollPhysics(),
            //                         padding: EdgeInsets.zero,
            //                         shrinkWrap: true,
            //                         itemCount: controller.getLeaderboardList.value!.records.length,
            //                         itemBuilder: (context, index) {
            //                           var isMissedPrayers = controller.getLeaderboardList.value!.records[index].userTimestamp == null;
            //                           return Visibility(
            //                             visible: controller.getLeaderboardList.value!.records[index].prayerName == "Fajr",
            //                             child: Column(
            //                               children: [
            //                                 Padding(
            //                                   padding: const EdgeInsets.all(8.0),
            //                                   child:!isMissedPrayers? CircleAvatar(
            //                                       child: controller.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
            //                                         radius: 24, // Radius of the circular image
            //                                         backgroundImage: NetworkImage(
            //                                           "http://182.156.200.177:8011${controller.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
            //                                         ),
            //                                       ):
            //                                       Icon(Icons.person,color: Colors.grey,size: 30,)
            //                                     // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
            //                                   ):
            //                                   InkWell(
            //                                     onTap: (){
            //                                       if(controller.userData.getUserData!.id.toString()==controller.getLeaderboardList.value!.records[index].user.id.toString()){
            //                                         showDialog(
            //                                           context: context,
            //                                           builder: (BuildContext context) {
            //                                             return  const TimePicker();
            //                                           },
            //                                         );
            //                                       }
            //                                     },
            //                                     child: ColorFiltered(
            //                                       colorFilter: ColorFilter.matrix(
            //                                         <double>[
            //                                           0.2126, 0.7152, 0.0722, 0, 0, // Red channel coefficients
            //                                           0.2126, 0.7152, 0.0722, 0, 0, // Green channel coefficients
            //                                           0.2126, 0.7152, 0.0722, 0, 0, // Blue channel coefficients
            //                                           0, 0, 0, 1, 0,               // Alpha channel
            //                                         ],
            //                                       ),
            //                                       child: CircleAvatar(
            //                                           child: controller.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
            //                                             radius: 24, // Radius of the circular image
            //                                             backgroundImage: NetworkImage(
            //                                               "http://182.156.200.177:8011${controller.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
            //                                             ),
            //                                           ):const Padding(
            //                                             padding: EdgeInsets.all(8.0),
            //                                             child: Icon(Icons.person,color: Colors.grey,size: 30,),
            //                                           )
            //                                         // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 ),
            //                                 controller.getLeaderboardList.value!.records[index].user.id.toString()==controller.userData.getUserData!.id? const Text('You',style: TextStyle(fontSize: 10),):
            //                                 Text(controller.getLeaderboardList.value!.records[index].user.name.split(' ')[0],style: const TextStyle(fontSize: 10),)
            //                               ],
            //                             ),
            //                           );
            //
            //                         },),
            //                     ):const SizedBox();
            //                 }),
            //
            //                 Obx((){
            //                   return controller.getLeaderboardList.value!=null? Expanded(
            //                     child: Expanded(
            //                       child: ListView.builder(
            //                         physics: const NeverScrollableScrollPhysics(),
            //                         padding: EdgeInsets.zero,
            //                         shrinkWrap: true,
            //                         itemCount: controller.getLeaderboardList.value!.records.length,
            //                         itemBuilder: (context, index) {
            //                           var isMissedPrayers = controller.getLeaderboardList.value!.records[index].userTimestamp == null;
            //                           return Visibility(
            //                             visible: controller.getLeaderboardList.value!.records[index].prayerName == "Dhuhr",
            //                             child: Column(
            //                               children: [
            //                                 Padding(
            //                                   padding: const EdgeInsets.all(8.0),
            //                                   child:!isMissedPrayers? CircleAvatar(
            //                                       child: controller.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
            //                                         radius: 24, // Radius of the circular image
            //                                         backgroundImage: NetworkImage(
            //                                           "http://182.156.200.177:8011${controller.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
            //                                         ),
            //                                       ):const Padding(
            //                                         padding: EdgeInsets.all(8.0),
            //                                         child: Icon(Icons.person,color: Colors.grey,size: 30,),
            //                                       )
            //                                     // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
            //                                   ):
            //                                   InkWell(
            //                                     onTap: (){
            //                                       if(controller.userData.getUserData!.id.toString()==controller.getLeaderboardList.value!.records[index].user.id.toString()){
            //                                         showDialog(
            //                                           context: context,
            //                                           builder: (BuildContext context) {
            //                                             return  const TimePicker();
            //                                           },
            //                                         );
            //                                       }
            //                                     },
            //                                     child: ColorFiltered(
            //                                       colorFilter: const ColorFilter.matrix(
            //                                         <double>[
            //                                           0.2126, 0.7152, 0.0722, 0, 0, // Red channel coefficients
            //                                           0.2126, 0.7152, 0.0722, 0, 0, // Green channel coefficients
            //                                           0.2126, 0.7152, 0.0722, 0, 0, // Blue channel coefficients
            //                                           0, 0, 0, 1, 0,               // Alpha channel
            //                                         ],
            //                                       ),
            //                                       child: CircleAvatar(
            //                                           child: controller.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
            //                                             radius: 24, // Radius of the circular image
            //                                             backgroundImage: NetworkImage(
            //                                               "http://182.156.200.177:8011${controller.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
            //                                             ),
            //                                           ):const Padding(
            //                                             padding: EdgeInsets.all(8.0),
            //                                             child: Icon(Icons.person,color: Colors.grey,size: 30,),
            //                                           )
            //                                         // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 ),
            //                                 controller.getLeaderboardList.value!.records[index].user.id.toString()==controller.userData.getUserData!.id? const Text('You',style: TextStyle(fontSize: 10),):
            //                                 Text(controller.getLeaderboardList.value!.records[index].user.name.split(' ')[0],style: const TextStyle(fontSize: 10),)
            //                               ],
            //                             ),
            //                           );
            //
            //                         },),
            //                     ),
            //                   ):const SizedBox();
            //                 }),
            //
            //
            //                 Obx((){
            //                   return controller.getLeaderboardList.value!=null? Expanded(
            //                     child: ListView.builder(
            //                       physics: const NeverScrollableScrollPhysics(),
            //                       padding: EdgeInsets.zero,
            //                       shrinkWrap: true,
            //                       itemCount: controller.getLeaderboardList.value!.records.length,
            //                       itemBuilder: (context, index) {
            //                         var isMissedPrayers = controller.getLeaderboardList.value!.records[index].userTimestamp == null;
            //                         return Visibility(
            //                           visible: controller.getLeaderboardList.value!.records[index].prayerName == "Asr",
            //                           child: Column(
            //                             children: [
            //                               Padding(
            //                                 padding: const EdgeInsets.all(8.0),
            //                                 child:!isMissedPrayers? CircleAvatar(
            //                                     child: controller.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
            //                                       radius: 24, // Radius of the circular image
            //                                       backgroundImage: NetworkImage(
            //                                         "http://182.156.200.177:8011${controller.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
            //                                       ),
            //                                     ):const Padding(
            //                                       padding: EdgeInsets.all(8.0),
            //                                       child: Icon(Icons.person,color: Colors.grey,size: 30,),
            //                                     )
            //                                   // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
            //                                 ):
            //                                 InkWell(
            //                                   onTap: (){
            //                                     if(controller.userData.getUserData!.id.toString()==controller.getLeaderboardList.value!.records[index].user.id.toString()){
            //                                       showDialog(
            //                                         context: context,
            //                                         builder: (BuildContext context) {
            //                                           return  const TimePicker();
            //                                         },
            //                                       );
            //                                     }
            //                                   },
            //                                   child: ColorFiltered(
            //                                     colorFilter: const ColorFilter.matrix(
            //                                       <double>[
            //                                         0.2126, 0.7152, 0.0722, 0, 0, // Red channel coefficients
            //                                         0.2126, 0.7152, 0.0722, 0, 0, // Green channel coefficients
            //                                         0.2126, 0.7152, 0.0722, 0, 0, // Blue channel coefficients
            //                                         0, 0, 0, 1, 0,               // Alpha channel
            //                                       ],
            //                                     ),
            //                                     child: CircleAvatar(
            //                                         child: controller.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
            //                                           radius: 24, // Radius of the circular image
            //                                           backgroundImage: NetworkImage(
            //                                             "http://182.156.200.177:8011${controller.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
            //                                           ),
            //                                         ):const Padding(
            //                                           padding: EdgeInsets.all(8.0),
            //                                           child: Icon(Icons.person,color: Colors.grey,size: 30,),
            //                                         )
            //                                       // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ),
            //                               controller.getLeaderboardList.value!.records[index].user.id.toString()==controller.userData.getUserData!.id? const Text('You',style: TextStyle(fontSize: 10),):
            //                               Text(controller.getLeaderboardList.value!.records[index].user.name.split(' ')[0],style: const TextStyle(fontSize: 10),)
            //                             ],
            //                           ),
            //                         );
            //
            //                       },),
            //                   ):const SizedBox();
            //                 }),
            //
            //                 Obx((){
            //                   return controller.getLeaderboardList.value!=null? Expanded(
            //                     child: ListView.builder(
            //                       physics: const NeverScrollableScrollPhysics(),
            //                       padding: EdgeInsets.zero,
            //                       shrinkWrap: true,
            //                       itemCount: controller.getLeaderboardList.value!.records.length,
            //                       itemBuilder: (context, index) {
            //                         var isMissedPrayers = controller.getLeaderboardList.value!.records[index].userTimestamp == null;
            //                         return Visibility(
            //                           visible: controller.getLeaderboardList.value!.records[index].prayerName == "Maghrib",
            //                           child: Column(
            //                             children: [
            //                               Padding(
            //                                 padding: const EdgeInsets.all(8.0),
            //                                 child:!isMissedPrayers? CircleAvatar(
            //                                     child: controller.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
            //                                       radius: 24, // Radius of the circular image
            //                                       backgroundImage: NetworkImage(
            //                                         "http://182.156.200.177:8011${controller.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
            //                                       ),
            //                                     ):const Padding(
            //                                       padding: EdgeInsets.all(8.0),
            //                                       child: Icon(Icons.person,color: Colors.grey,size: 30,),
            //                                     )
            //                                   // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
            //                                 ):
            //                                 InkWell(
            //                                   onTap: (){
            //                                     if(controller.userData.getUserData!.id.toString()==controller.getLeaderboardList.value!.records[index].user.id.toString()){
            //                                       showDialog(
            //                                         context: context,
            //                                         builder: (BuildContext context) {
            //                                           return  const TimePicker();
            //                                         },
            //                                       );
            //                                     }
            //                                   },
            //                                   child: ColorFiltered(
            //                                     colorFilter: const ColorFilter.matrix(
            //                                       <double>[
            //                                         0.2126, 0.7152, 0.0722, 0, 0, // Red channel coefficients
            //                                         0.2126, 0.7152, 0.0722, 0, 0, // Green channel coefficients
            //                                         0.2126, 0.7152, 0.0722, 0, 0, // Blue channel coefficients
            //                                         0, 0, 0, 1, 0,               // Alpha channel
            //                                       ],
            //                                     ),
            //                                     child: CircleAvatar(
            //                                         child: controller.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
            //                                           radius: 24, // Radius of the circular image
            //                                           backgroundImage: NetworkImage(
            //                                             "http://182.156.200.177:8011${controller.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
            //                                           ),
            //                                         ):const Padding(
            //                                           padding: EdgeInsets.all(8.0),
            //                                           child: Icon(Icons.person,color: Colors.grey,size: 30,),
            //                                         )
            //                                       // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ),
            //                               controller.getLeaderboardList.value!.records[index].user.id.toString()==controller.userData.getUserData!.id? const Text('You',style: TextStyle(fontSize: 10),):
            //                               Text(controller.getLeaderboardList.value!.records[index].user.name.split(' ')[0],style: const TextStyle(fontSize: 10),)
            //                             ],
            //                           ),
            //                         );
            //
            //                       },),
            //                   ):const SizedBox();
            //                 }),
            //
            //                 Obx((){
            //                   return controller.getLeaderboardList.value!=null? Expanded(
            //                     child: ListView.builder(
            //                       physics: const NeverScrollableScrollPhysics(),
            //                       padding: EdgeInsets.zero,
            //                       shrinkWrap: true,
            //                       itemCount: controller.getLeaderboardList.value!.records.length,
            //                       itemBuilder: (context, index) {
            //                         var isMissedPrayers = controller.getLeaderboardList.value!.records[index].userTimestamp == null;
            //                         return Visibility(
            //                           visible: controller.getLeaderboardList.value!.records[index].prayerName == "Isha",
            //                           child: Column(
            //                             children: [
            //                               Padding(
            //                                 padding: const EdgeInsets.all(8.0),
            //                                 child:!isMissedPrayers? CircleAvatar(
            //                                     child: controller.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
            //                                       radius: 24, // Radius of the circular image
            //                                       backgroundImage: NetworkImage(
            //                                         "http://182.156.200.177:8011${controller.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
            //                                       ),
            //                                     ):const Padding(
            //                                       padding: EdgeInsets.all(8.0),
            //                                       child: Icon(Icons.person,color: Colors.grey,size: 30,),
            //                                     )
            //                                   // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
            //                                 ):
            //                                 InkWell(
            //                                   onTap: (){
            //                                     if(controller.userData.getUserData!.id.toString()==controller.getLeaderboardList.value!.records[index].user.id.toString()){
            //                                       showDialog(
            //                                         context: context,
            //                                         builder: (BuildContext context) {
            //                                           return  const TimePicker();
            //                                         },
            //                                       );
            //                                     }
            //                                   },
            //                                   child: ColorFiltered(
            //                                     colorFilter: const ColorFilter.matrix(
            //                                       <double>[
            //                                         0.2126, 0.7152, 0.0722, 0, 0, // Red channel coefficients
            //                                         0.2126, 0.7152, 0.0722, 0, 0, // Green channel coefficients
            //                                         0.2126, 0.7152, 0.0722, 0, 0, // Blue channel coefficients
            //                                         0, 0, 0, 1, 0,               // Alpha channel
            //                                       ],
            //                                     ),
            //                                     child: CircleAvatar(
            //                                         child: controller.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
            //                                           radius: 24, // Radius of the circular image
            //                                           backgroundImage: NetworkImage(
            //                                             "http://182.156.200.177:8011${controller.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
            //                                           ),
            //                                         ):
            //                                         const Padding(
            //                                           padding: EdgeInsets.all(8.0),
            //                                           child: Icon(Icons.person,color: Colors.grey,size: 30,),
            //                                         )
            //                                       // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ),
            //                               controller.getLeaderboardList.value!.records[index].user.id.toString()==controller.userData.getUserData!.id? const Text('You',style: TextStyle(fontSize: 10),):
            //                               Text(controller.getLeaderboardList.value!.records[index].user.name.split(' ')[0],style: const TextStyle(fontSize: 10),)
            //                             ],
            //                           ),
            //                         );
            //
            //                       },),
            //                   ):const SizedBox();
            //                 }),
            //
            //               ],
            //             ),
            //             if(controller.selectedTab.value =='Weekly')
            //               Obx(() {
            //                   return Expanded(
            //                     child: ListView.builder(
            //                       shrinkWrap: true,
            //                       padding: EdgeInsets.zero,
            //                       physics: const NeverScrollableScrollPhysics(),
            //                       itemCount: controller.weeklyMissedPrayer.keys.length,
            //                       itemBuilder: (context, index) {
            //                         final date = controller.weeklyMissedPrayer.keys.elementAt(index);
            //
            //                         return Column(
            //                           crossAxisAlignment: CrossAxisAlignment.start,
            //                           children: [
            //                             Padding(
            //                               padding: const EdgeInsets.all(8.0),
            //                               child: Text(
            //                                 date,
            //                                 style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                             Row(
            //                               crossAxisAlignment: CrossAxisAlignment.start,
            //                               mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                               children: controller.prayers.map((prayer) {
            //                                 return Expanded(
            //                                   child: Column(
            //                                     children: [
            //                                       Text(
            //                                         controller.prayerShortNames[prayer]!,
            //                                         style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            //                                       ),
            //                                       // Display user prayer info under each prayer
            //                                       ...controller.weeklyMissedPrayer[date]!
            //                                           .where((record) => record.prayerName == prayer)
            //                                           .map((record) {
            //                                         return record.userTimestamp != null
            //                                             ? Padding(
            //                                               padding: const EdgeInsets.only(bottom: 5.0),
            //                                               child: Column(
            //                                                 children: [
            //                                                   Container(
            //                                                     margin: EdgeInsets.all(5),
            //                                                     padding: const EdgeInsets.all(1), // Padding around the circular image
            //                                                     decoration: BoxDecoration(
            //                                                   shape: BoxShape.circle,
            //                                                   border: Border.all(
            //                                                     color: Colors.yellow,
            //                                                   ), // Yellow border
            //                                                     ),
            //                                                     child: record.user.picture != null
            //                                                     ? Column(
            //                                                       children: [
            //                                                         CircleAvatar(
            //                                                           radius: 20, // Radius of the circular image
            //                                                           backgroundImage: NetworkImage(
            //                                                         "http://182.156.200.177:8011${record.user.picture}", // Replace with your image URL
            //                                                           ),
            //                                                         ),
            //                                                       ],
            //                                                     )
            //                                                     :  Padding(
            //                                                   padding: EdgeInsets.all(8.0),
            //                                                   child: Icon(
            //                                                     Icons.person,
            //                                                    color: AppColor.circleIndicator,
            //                                                     size: 20,
            //                                                   ),
            //                                                     ),
            //                                                   ),
            //                                                  record.user.id.toString()==controller.userData.getUserData!.id? Text('You',style: TextStyle(fontSize: 10),):
            //                                                  Text(record.user.name.split(' ')[0],style: const TextStyle(fontSize: 10),)
            //                                                 ],
            //                                               ),
            //                                             )
            //                                             : InkWell(
            //                                           onTap: (){
            //                                             if(controller.userData.getUserData!.id.toString()==record.user.id.toString()){
            //                                               showDialog(
            //                                                 context: context,
            //                                                 builder: (BuildContext context) {
            //                                                   return   TimePicker(date: date);
            //                                                 },
            //                                               );
            //                                             }
            //                                           },
            //                                               child: Padding(
            //                                                 padding: const EdgeInsets.only(bottom: 5.0),
            //                                                 child: Column(
            //                                                   children: [
            //                                                     Container(
            //                                                       margin: EdgeInsets.all(5),
            //                                                       padding: const EdgeInsets.all(1), // Padding around the circular image
            //                                                       decoration: BoxDecoration(
            //                                                     shape: BoxShape.circle,
            //                                                     border: Border.all(
            //                                                       color: Colors.grey,
            //                                                     ), // Grey border
            //                                                       ),
            //                                                       child: record.user.picture != null
            //                                                       ? ColorFiltered(
            //                                                     colorFilter: const ColorFilter.matrix(
            //                                                       <double>[
            //                                                         0.2126,
            //                                                         0.7152,
            //                                                         0.0722,
            //                                                         0,
            //                                                         0, // Red channel coefficients
            //                                                         0.2126,
            //                                                         0.7152,
            //                                                         0.0722,
            //                                                         0,
            //                                                         0, // Green channel coefficients
            //                                                         0.2126,
            //                                                         0.7152,
            //                                                         0.0722,
            //                                                         0,
            //                                                         0, // Blue channel coefficients
            //                                                         0,
            //                                                         0,
            //                                                         0,
            //                                                         1,
            //                                                         0, // Alpha channel
            //                                                       ],
            //                                                     ),
            //                                                     child: CircleAvatar(
            //                                                       radius: 20, // Radius of the circular image
            //                                                       backgroundImage: NetworkImage(
            //                                                         "http://182.156.200.177:8011${record.user.picture}", // Replace with your image URL
            //                                                       ),
            //                                                     ),
            //                                                                                                   )
            //                                                       : const Padding(
            //                                                     padding: EdgeInsets.all(8.0),
            //                                                     child: Icon(
            //                                                       Icons.person,
            //                                                       color: Colors.grey,
            //                                                       size: 20,
            //                                                     ),
            //                                                                                                   ),
            //                                                                                                 ),
            //                                                     record.user.id.toString()==controller.userData.getUserData!.id? Text('You',style: TextStyle(fontSize: 10),):
            //                                                     Text(record.user.name.split(' ')[0],style: const TextStyle(fontSize: 10),)
            //                                                   ],
            //                                                 ),
            //                                               ),
            //                                             );
            //                                       }).toList(),
            //                                     ],
            //                                   ),
            //                                 );
            //                               }).toList(),
            //                             ),
            //                             Divider(),
            //                           ],
            //                         );
            //                       },
            //                     ),
            //                   );
            //                 }
            //               )
            //
            //
            //
            //
            //
            //             // Leaderboard GridView
            //             // Padding(
            //             //   padding: const EdgeInsets.all(16.0),
            //             //   child: GridView.builder(
            //             //     shrinkWrap: true,
            //             //     physics: const NeverScrollableScrollPhysics(),
            //             //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //             //       crossAxisCount: 5,
            //             //       mainAxisSpacing: 10,
            //             //       crossAxisSpacing: 10,
            //             //     ),
            //             //     itemCount: 1, // number of items
            //             //     itemBuilder: (context, index) {
            //             //       // Example of dynamic data for CircleAvatars
            //             //       final avatarUrls = List.generate(25, (i) => 'https://via.placeholder.com/150'); // Placeholder URLs
            //             //       return Column(
            //             //         children: [
            //             //           CircleAvatar(
            //             //             radius: 20,
            //             //             backgroundImage: NetworkImage(avatarUrls[index]),  // Dynamically set image
            //             //           ),
            //             //           const Text("sdddd",style: TextStyle(color: Colors.black),),
            //             //         ],
            //             //       );
            //             //     },
            //             //   ),
            //             // ),
            //           ],
            //         ),
            //       );
            //     }
            //   ),
            // ),
            SliverToBoxAdapter(
              child: Obx(() {
                return Visibility(
                    visible: controller.selectedTab.value == 'Daily',
                    child: Container(
                      height: Get.height,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(50.0),
                          ),
                          color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Container(
                                width: 100,
                                height: 8  ,
                                decoration: BoxDecoration(
                                    color:AppColor.packageGray,
                                    borderRadius: BorderRadius.circular(10)
                                ),

                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx((){
                                    return controller.getLeaderboardList.value!=null?
                                    Expanded(
                                      child: ListView.builder(
                                        // physics: const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: controller.getLeaderboardList.value!.records.length,
                                        itemBuilder: (context, index) {
                                          var isMissedPrayers = controller.getLeaderboardList.value!.records[index].userTimestamp == null;
                                          final prayerStartTime = controller.dashboardController.getExtractedData[0].timings?.fajr ?? "00:00";

                                          // Compare current time with prayer start time
                                          final shouldShowDash = controller.currentTime.compareTo(prayerStartTime) < 0;
                                          return Visibility(
                                            visible: controller.getLeaderboardList.value!.records[index].prayerName == "Fajr",
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child:shouldShowDash?const CircleAvatar(radius: 20,backgroundColor: Colors.white70,child: Text('-')):!isMissedPrayers? CircleAvatar(
                                                    radius: 21,
                                                    backgroundColor: Colors.yellowAccent,
                                                    child: CircleAvatar(
                                                        child: controller.getLeaderboardList.value!.records[index].user.picture!=null?
                                                        CircleAvatar(
                                                          radius: 22, // Radius of the circular image
                                                          backgroundImage: NetworkImage(
                                                            "http://182.156.200.177:8011${controller.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
                                                          ),
                                                        ):
                                                        const Icon(Icons.person,color: Colors.grey,size: 30,),
                                                      // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                                    ),
                                                  ):
                                                  InkWell(
                                                    onTap: (){
                                                      if(controller.userData.getUserData!.id.toString()==controller.getLeaderboardList.value!.records[index].user.id.toString()){
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return   TimePicker(isFromMissed: true,missedCallBack: ()=>controller.leaderboard(controller.getFormattedDate()),);
                                                          },
                                                        );
                                                      }
                                                    },
                                                    child: ColorFiltered(
                                                      colorFilter: const ColorFilter.matrix(
                                                        <double>[
                                                          0.2126, 0.7152, 0.0722, 0, 0, // Red channel coefficients
                                                          0.2126, 0.7152, 0.0722, 0, 0, // Green channel coefficients
                                                          0.2126, 0.7152, 0.0722, 0, 0, // Blue channel coefficients
                                                          0, 0, 0, 1, 0,               // Alpha channel
                                                        ],
                                                      ),
                                                      child: CircleAvatar(
                                                          child:controller.getLeaderboardList.value!.records[index].user.name.isNotEmpty? controller.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
                                                            radius: 24, // Radius of the circular image
                                                            backgroundImage: NetworkImage(
                                                              "http://182.156.200.177:8011${controller.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
                                                            ),
                                                          ):const Icon(Icons.person,color: Colors.grey,size: 30,):const Text('-',style: TextStyle(color: Colors.black45),)
                                                        // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                if(!shouldShowDash)
                                                controller.getLeaderboardList.value!.records[index].user.id.toString()==controller.userData.getUserData!.id? const Text('You',style: TextStyle(fontSize: 10),):
                                                Text(controller.getLeaderboardList.value!.records[index].user.name.split(' ')[0],style: const TextStyle(fontSize: 10),)
                                                else
                                                  const Text('',style: TextStyle(fontSize: 10),)
                                              ],
                                            ),
                                          );

                                        },),
                                    ):const SizedBox();
                                  }),

                                  Obx((){
                                    return controller.getLeaderboardList.value!=null? Expanded(
                                      child: ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: controller.getLeaderboardList.value!.records.length,
                                        itemBuilder: (context, index) {
                                          var isMissedPrayers = controller.getLeaderboardList.value!.records[index].userTimestamp == null;
                                          final prayerStartTime = controller.dashboardController.getExtractedData[0].timings?.dhuhr ?? "00:00";

                                          // Compare current time with prayer start time
                                          final shouldShowDash = controller.currentTime.compareTo(prayerStartTime) < 0;
                                          return Visibility(
                                            visible: controller.getLeaderboardList.value!.records[index].prayerName == "Dhuhr",
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child:shouldShowDash?const CircleAvatar(radius: 20,backgroundColor: Colors.white70,child: Text('-')):!isMissedPrayers? CircleAvatar(
                                                    radius: 21,
                                                    backgroundColor: Colors.yellowAccent,
                                                    child: CircleAvatar(
                                                        child: controller.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
                                                          radius: 22, // Radius of the circular image
                                                          backgroundImage: NetworkImage(
                                                            "http://182.156.200.177:8011${controller.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
                                                          ),
                                                        ):const Padding(
                                                          padding: EdgeInsets.all(8.0),
                                                          child: Icon(Icons.person,color: Colors.grey,size: 30,),
                                                        )
                                                      // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                                    ),
                                                  ):
                                                  InkWell(
                                                    onTap: (){
                                                      if(controller.userData.getUserData!.id.toString()==controller.getLeaderboardList.value!.records[index].user.id.toString()){
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return   TimePicker(isFromMissed: true,missedCallBack: ()=>controller.leaderboard(controller.getFormattedDate()));
                                                          },
                                                        );
                                                      }
                                                    },
                                                    child: ColorFiltered(
                                                      colorFilter: const ColorFilter.matrix(
                                                        <double>[
                                                          0.2126, 0.7152, 0.0722, 0, 0, // Red channel coefficients
                                                          0.2126, 0.7152, 0.0722, 0, 0, // Green channel coefficients
                                                          0.2126, 0.7152, 0.0722, 0, 0, // Blue channel coefficients
                                                          0, 0, 0, 1, 0,               // Alpha channel
                                                        ],
                                                      ),
                                                      child: CircleAvatar(
                                                          child:controller.getLeaderboardList.value!.records[index].user.name.isNotEmpty? controller.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
                                                            radius: 24, // Radius of the circular image
                                                            backgroundImage: NetworkImage(
                                                              "http://182.156.200.177:8011${controller.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
                                                            ),
                                                          ):const Icon(Icons.person,color: Colors.grey,size: 30,):Text('-',style: TextStyle(color: Colors.black45),)
                                                        // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                if(!shouldShowDash)
                                                controller.getLeaderboardList.value!.records[index].user.id.toString()==controller.userData.getUserData!.id? const Text('You',style: TextStyle(fontSize: 10),):
                                                Text(controller.getLeaderboardList.value!.records[index].user.name.split(' ')[0],style: const TextStyle(fontSize: 10),)
                                                else
                                                  const Text('',style: TextStyle(fontSize: 10),)
                                              ],
                                            ),
                                          );

                                        },),
                                    ):const SizedBox();
                                  }),


                                  Obx((){
                                    return controller.getLeaderboardList.value!=null? Expanded(
                                      child: ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: controller.getLeaderboardList.value!.records.length,
                                        itemBuilder: (context, index) {
                                          var isMissedPrayers = controller.getLeaderboardList.value!.records[index].userTimestamp == null;
                                          final prayerStartTime = controller.dashboardController.getExtractedData[0].timings?.asr ?? "00:00";

                                          // Compare current time with prayer start time
                                          final shouldShowDash = controller.currentTime.compareTo(prayerStartTime) < 0;
                                          return Visibility(
                                            visible: controller.getLeaderboardList.value!.records[index].prayerName == "Asr",
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child:shouldShowDash?const CircleAvatar(radius: 20,backgroundColor: Colors.white70,child: Text('-')):!isMissedPrayers? CircleAvatar(
                                                    radius: 21,
                                                    backgroundColor: Colors.yellowAccent,
                                                    child: CircleAvatar(
                                                        child: controller.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
                                                          radius: 22, // Radius of the circular image
                                                          backgroundImage: NetworkImage(
                                                            "http://182.156.200.177:8011${controller.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
                                                          ),
                                                        ):const Icon(Icons.person,color: Colors.grey,size: 30,)
                                                      // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                                    ),
                                                  ):
                                                  InkWell(
                                                    onTap: (){
                                                      if(controller.userData.getUserData!.id.toString()==controller.getLeaderboardList.value!.records[index].user.id.toString()){
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return   TimePicker(isFromMissed: true,missedCallBack: ()=>controller.leaderboard(controller.getFormattedDate()));
                                                          },
                                                        );
                                                      }
                                                    },
                                                    child: ColorFiltered(
                                                      colorFilter: const ColorFilter.matrix(
                                                        <double>[
                                                          0.2126, 0.7152, 0.0722, 0, 0, // Red channel coefficients
                                                          0.2126, 0.7152, 0.0722, 0, 0, // Green channel coefficients
                                                          0.2126, 0.7152, 0.0722, 0, 0, // Blue channel coefficients
                                                          0, 0, 0, 1, 0,               // Alpha channel
                                                        ],
                                                      ),
                                                      child: CircleAvatar(
                                                          child:controller.getLeaderboardList.value!.records[index].user.name.isNotEmpty? controller.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
                                                            radius: 24, // Radius of the circular image
                                                            backgroundImage: NetworkImage(
                                                              "http://182.156.200.177:8011${controller.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
                                                            ),
                                                          ):const Icon(Icons.person,color: Colors.grey,size: 30,):Text('-',style: TextStyle(color: Colors.black45),)
                                                        // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                if(!shouldShowDash)
                                                controller.getLeaderboardList.value!.records[index].user.id.toString()==controller.userData.getUserData!.id? const Text('You',style: TextStyle(fontSize: 10),):
                                                Text(controller.getLeaderboardList.value!.records[index].user.name.split(' ')[0],style: const TextStyle(fontSize: 10),)
                                                else
                                                  const Text('',style: TextStyle(fontSize: 10),)
                                              ],
                                            ),
                                          );

                                        },),
                                    ):const SizedBox();
                                  }),

                                  Obx((){
                                    return controller.getLeaderboardList.value!=null? Expanded(
                                      child: ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: controller.getLeaderboardList.value!.records.length,
                                        itemBuilder: (context, index) {
                                          var isMissedPrayers = controller.getLeaderboardList.value!.records[index].userTimestamp == null;
                                          final prayerStartTime = controller.dashboardController.getExtractedData[0].timings?.maghrib ?? "00:00";
                                          // Compare current time with prayer start time
                                          final shouldShowDash = controller.currentTime.compareTo(prayerStartTime) < 0;
                                          return Visibility(
                                            visible: controller.getLeaderboardList.value!.records[index].prayerName == "Maghrib",
                                            child: Column(
                                              children: [
                                            Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:shouldShowDash?const CircleAvatar(radius: 20,backgroundColor: Colors.white70,child: Text('-')):!isMissedPrayers? CircleAvatar(
                                                  radius: 21,
                                                  backgroundColor: Colors.yellowAccent,
                                                  child: CircleAvatar(
                                                      child: controller.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
                                                        radius: 22, // Radius of the circular image
                                                        backgroundImage: NetworkImage(
                                                          "http://182.156.200.177:8011${controller.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
                                                        ),
                                                      ):const Icon(Icons.person,color: Colors.grey,size: 30,)
                                                    // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                                  ),
                                                ):
                                                InkWell(
                                                  onTap: (){
                                                    if(controller.userData.getUserData!.id.toString()==controller.getLeaderboardList.value!.records[index].user.id.toString()){
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return  TimePicker(isFromMissed: true,missedCallBack: ()=>controller.leaderboard(controller.getFormattedDate()));
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: ColorFiltered(
                                                    colorFilter: const ColorFilter.matrix(
                                                      <double>[
                                                        0.2126, 0.7152, 0.0722, 0, 0, // Red channel coefficients
                                                        0.2126, 0.7152, 0.0722, 0, 0, // Green channel coefficients
                                                        0.2126, 0.7152, 0.0722, 0, 0, // Blue channel coefficients
                                                        0, 0, 0, 1, 0,               // Alpha channel
                                                      ],
                                                    ),
                                                    child: CircleAvatar(
                                                        child:controller.getLeaderboardList.value!.records[index].user.name.isNotEmpty? controller.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
                                                          radius: 24, // Radius of the circular image
                                                          backgroundImage: NetworkImage(
                                                            "http://182.156.200.177:8011${controller.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
                                                          ),
                                                        ):const Icon(Icons.person,color: Colors.grey,size: 30,):const Text('-',style: TextStyle(color: Colors.black45),)
                                                      // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                                    ),
                                                  ),
                                                )),
                                                if(!shouldShowDash)
                                                controller.getLeaderboardList.value!.records[index].user.id.toString()==controller.userData.getUserData!.id? const Text('You',style: TextStyle(fontSize: 10),):
                                                Text(controller.getLeaderboardList.value!.records[index].user.name.split(' ')[0],style: const TextStyle(fontSize: 10),)
                                                else
                                                  const Text('',style: TextStyle(fontSize: 10),)
                                              ],
                                            ),
                                          );

                                        },),
                                    ):const SizedBox();
                                  }),

                                  Obx((){
                                    return controller.getLeaderboardList.value!=null? Expanded(
                                      child: ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: controller.getLeaderboardList.value!.records.length,
                                        itemBuilder: (context, index) {
                                          var isMissedPrayers = controller.getLeaderboardList.value!.records[index].userTimestamp == null;
                                          // final record = controller.getLeaderboardList.value!.records[index];
                                          // final prayerName = record.prayerName;
                                          final prayerStartTime = controller.dashboardController.getExtractedData[0].timings?.isha ?? "00:00";

                                          // Compare current time with prayer start time
                                          final shouldShowDash = controller.currentTime.compareTo(prayerStartTime) < 0;
                                          return Visibility(
                                            visible: controller.getLeaderboardList.value!.records[index].prayerName == "Isha",
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child:shouldShowDash?const CircleAvatar(radius: 20,backgroundColor: Colors.white70,child: Text('-')):!isMissedPrayers? CircleAvatar(
                                                    radius: 21,
                                                    backgroundColor: Colors.yellowAccent,
                                                    child: CircleAvatar(
                                                        child: controller.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
                                                          radius: 22, // Radius of the circular image
                                                          backgroundImage: NetworkImage(
                                                            "http://182.156.200.177:8011${controller.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
                                                          ),
                                                        ):const Icon(Icons.person,color: Colors.grey,size: 30,)
                                                      // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                                    ),
                                                  ):
                                                  InkWell(
                                                    onTap: (){
                                                      if(controller.userData.getUserData!.id.toString()==controller.getLeaderboardList.value!.records[index].user.id.toString()){
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return TimePicker(isFromMissed: true,missedCallBack: ()=>controller.leaderboard(controller.getFormattedDate()));
                                                          },
                                                        );
                                                      }
                                                    },
                                                    child: ColorFiltered(
                                                      colorFilter: const ColorFilter.matrix(
                                                        <double>[
                                                          0.2126, 0.7152, 0.0722, 0, 0, // Red channel coefficients
                                                          0.2126, 0.7152, 0.0722, 0, 0, // Green channel coefficients
                                                          0.2126, 0.7152, 0.0722, 0, 0, // Blue channel coefficients
                                                          0, 0, 0, 1, 0,               // Alpha channel
                                                        ],
                                                      ),
                                                      child: CircleAvatar(
                                                          child:controller.getLeaderboardList.value!.records[index].user.name.isNotEmpty? controller.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
                                                            radius: 24, // Radius of the circular image
                                                            backgroundImage: NetworkImage(
                                                              "http://182.156.200.177:8011${controller.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
                                                            ),
                                                          ):
                                                          const Icon(Icons.person,color: Colors.grey,size: 30,):const Text('-',style: TextStyle(color: Colors.black45),)
                                                        // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                if(!shouldShowDash)
                                                controller.getLeaderboardList.value!.records[index].user.id.toString()==controller.userData.getUserData!.id? const Text('You',style: TextStyle(fontSize: 10),):
                                                Text(controller.getLeaderboardList.value!.records[index].user.name.split(' ')[0],style: const TextStyle(fontSize: 10),)
                                                else
                                                  const Text('',style: TextStyle(fontSize: 10),)
                                              ],
                                            ),
                                          );

                                        },),
                                    ):const SizedBox();
                                  }),

                                ],
                              ),
                            ]
                        ),
                      ),
                    )
                );
              },),
            ),
            SliverToBoxAdapter(
              child: Obx(() {
                return Visibility(
                    visible: controller.selectedTab.value == 'Weekly',
                    child: Container(
                      height:Get.height,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(50.0),
                          ),
                          color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,80),
                        child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Container(
                                width: 100,
                                height: 8  ,
                                decoration: BoxDecoration(
                                    color:AppColor.packageGray,
                                    borderRadius: BorderRadius.circular(10)
                                ),

                              ),
                        Obx(() {
                          return Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: controller.weeklyMissedPrayer.keys.length,
                              itemBuilder: (context, index) {
                                final date = controller.weeklyMissedPrayer.keys.elementAt(index);

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        date,
                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: controller.prayers.map((prayer) {
                                        return Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                controller.prayerShortNames[prayer]!,
                                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                              ),
                                              // Display user prayer info under each prayer
                                              ...controller.weeklyMissedPrayer[date]!
                                                  .where((record) => record.prayerName == prayer)
                                                  .map((record) {
                                                return record.userTimestamp != null
                                                    ? Padding(
                                                  padding: const EdgeInsets.only(bottom: 5.0),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.all(5),
                                                        padding: const EdgeInsets.all(1), // Padding around the circular image
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(
                                                            color: Colors.yellow,
                                                          ), // Yellow border
                                                        ),
                                                        child: record.user.picture != null
                                                            ? Column(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 20, // Radius of the circular image
                                                              backgroundImage: NetworkImage(
                                                                "http://182.156.200.177:8011${record.user.picture}", // Replace with your image URL
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                            :  Padding(
                                                          padding: EdgeInsets.all(8.0),
                                                          child: Icon(
                                                            Icons.person,
                                                            color: AppColor.circleIndicator,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ),
                                                      record.user.id.toString()==controller.userData.getUserData!.id? Text('You',style: TextStyle(fontSize: 10),):
                                                      Text(record.user.name.split(' ')[0],style: const TextStyle(fontSize: 10),)
                                                    ],
                                                  ),
                                                )
                                                    : InkWell(
                                                  onTap: ()async{
                                                    print("dateT $date");
                                                    print("isThisMonth ${record.prayerName}");
                                                    if(controller.userData.getUserData!.id.toString()==record.user.id.toString()){
                                                      bool isThisMonth = controller.isCurrentMonth(date);
                                                      print("isThisMonth $isThisMonth");
                                                      if(isThisMonth){
                                                        Dialogs.showLoading(context,message: 'Please wait, Getting Prayer Time');
                                                        // Use await to make getPrayerTime asynchronous
                                                        DateTime? prayerTime = await Future.delayed(Duration.zero, () {
                                                          return controller.getPrayerTime(
                                                            controller.dashboardController.calendarData,
                                                            date,
                                                            record.prayerName,
                                                          );
                                                        });
                                                        // DateTime? prayerTime = controller.getPrayerTime(controller.dashboardController.calendarData,date,record.prayerName);
                                                        print("prayerTime $prayerTime");
                                                        // Hide loading only if the context is still mounted
                                                        if (context.mounted) {
                                                          WidgetsBinding.instance.addPostFrameCallback((_) {
                                                          Dialogs.hideLoading();
                                                          showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return   TimePicker(date: date,isFromMissed: true,missedPrayerTime: prayerTime,
                                                                missedCallBack:() =>controller.weeklyApi(controller.getFormattedDate()),);
                                                            },
                                                          );});
                                                        }

                                                      }
                                                      else{
                                                        controller.hitPrayerTimeByDate(date,record.prayerName,context);
                                                      }
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom: 5.0),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets.all(5),
                                                          padding: const EdgeInsets.all(1), // Padding around the circular image
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            border: Border.all(
                                                              color: Colors.grey,
                                                            ), // Grey border
                                                          ),
                                                          child: record.user.picture != null
                                                              ? ColorFiltered(
                                                            colorFilter: const ColorFilter.matrix(
                                                              <double>[
                                                                0.2126,
                                                                0.7152,
                                                                0.0722,
                                                                0,
                                                                0, // Red channel coefficients
                                                                0.2126,
                                                                0.7152,
                                                                0.0722,
                                                                0,
                                                                0, // Green channel coefficients
                                                                0.2126,
                                                                0.7152,
                                                                0.0722,
                                                                0,
                                                                0, // Blue channel coefficients
                                                                0,
                                                                0,
                                                                0,
                                                                1,
                                                                0, // Alpha channel
                                                              ],
                                                            ),
                                                            child: CircleAvatar(
                                                              radius: 20, // Radius of the circular image
                                                              backgroundImage: NetworkImage(
                                                                "http://182.156.200.177:8011${record.user.picture}", // Replace with your image URL
                                                              ),
                                                            ),
                                                          )
                                                              : const Padding(
                                                            padding: EdgeInsets.all(8.0),
                                                            child: Icon(
                                                              Icons.person,
                                                              color: Colors.grey,
                                                              size: 20,
                                                            ),
                                                          ),
                                                        ),
                                                        record.user.id.toString()==controller.userData.getUserData!.id? Text('You',style: TextStyle(fontSize: 10),):
                                                        Text(record.user.name.split(' ')[0],style: const TextStyle(fontSize: 10),)
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
                              SizedBox(height: Get.height/3,)
                            ]
                        ),
                      ),
                    )
                );
              },),
            ),

          ]
      )
    );
  }

}
