import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:namaz_reminders/Leaderboard/leaderboardController.dart';
import '../DashBoard/timepickerpopup.dart';
import '../Leaderboard/leaderboardDataModal.dart';
import '../Widget/appColor.dart';
import 'missed_prayers_controller.dart';

class MissedPrayersView extends GetView<MissedPrayersController>{
  const MissedPrayersView({super.key});

  @override
  Widget build(BuildContext context) {

    LeaderBoardController leaderBoardController = Get.put(LeaderBoardController());
    final DateController dateController = Get.put(DateController());
    leaderBoardController.weeklyApi(leaderBoardController.getFormattedDate());
    // TODO: implement build
    return Scaffold(
      body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text("Missed Prayers"),
              centerTitle: true,
              pinned: true,
              expandedHeight: 300.0,
              backgroundColor: AppColor.cream,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                    onPressed: () {
                      Get.back();
                      // Get.toNamed(AppRoutes.dashboardRoute);

                    },
                  ),
                ),
              ),

              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Padding(
                  padding: const EdgeInsets.all(16.0), // Adjust padding to avoid overflow
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80,),
                      Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Daily Button
                          GestureDetector(
                            onTap: () => leaderBoardController.updateSelectedTab='Daily',
                            child: Container(
                              decoration: BoxDecoration(
                                color: leaderBoardController.selectedTab.value == 'Daily' ? AppColor.circleIndicator : Colors.transparent,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              child: Text(
                                'Daily',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: leaderBoardController.getSelectedTab == 'Daily' ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Weekly Button
                          GestureDetector(
                            onTap: () => leaderBoardController.updateSelectedTab ='Weekly',
                            child: Container(
                              decoration: BoxDecoration(
                                color: leaderBoardController.getSelectedTab == 'Weekly' ? AppColor.circleIndicator : Colors.transparent,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              child: Text(
                                'Weekly',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: leaderBoardController.getSelectedTab == 'Weekly' ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                      const SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            child: Image.asset("assets/iconcalen.png", width: 24, height: 24),
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: dateController.selectedDate.value,
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2025),
                              );
                              if (picked != null) {
                                print("picked $picked");
                                dateController.updateSelectedDate(picked);
                                String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
                                leaderBoardController.leaderboard(formattedDate);
                              }
                            },
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Obx(() => Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    DateFormat('EEEE, d MMMM yyyy').format(dateController.selectedDate.value),
                                    style: const TextStyle(fontSize: 14, color: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const VerticalDivider(
                                  width: 20,
                                  thickness: 1,
                                  color: Colors.black,
                                  endIndent: 5,
                                  indent: 5,
                                ),
                                // Expanded(
                                //   child: Text(
                                //     dateController.formatHijriDate(dateController.selectedDate.value),
                                //     style: const TextStyle(fontSize: 14, color: Colors.black),
                                //     overflow: TextOverflow.ellipsis,
                                //   ),
                                // ),
                              ],
                            )),
                          ),
                        ],
                      ),
                      const Text("TODAY'S TIMELINE",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 10),


                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(child: Text("F")),
                          SizedBox(width: 5,),
                          CircleAvatar(child: Text("Z")),
                          SizedBox(width: 5,),
                          CircleAvatar(child: Text("A")),
                          SizedBox(width: 5,),
                          CircleAvatar(child: Text("M")),
                          SizedBox(width: 5,),
                          CircleAvatar(child: Text("I")),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Obx(() {
                  return Column(
                    children: [
                      // Space between leaderboard and toggle buttons
                      const SizedBox(height: 20), // Adjust the height as needed
                      if(leaderBoardController.selectedTab.value == 'Daily')
                      Row(
                        children: [
                          Obx((){
                            return leaderBoardController.getLeaderboardList.value!=null?
                              Expanded(
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: leaderBoardController.getLeaderboardList.value!.records.length,
                                  itemBuilder: (context, index) {
                                    var isMissedPrayers = leaderBoardController.getLeaderboardList.value!.records[index].userTimestamp == null;
                                    return Visibility(
                                      visible: leaderBoardController.getLeaderboardList.value!.records[index].prayerName == "Fajr",
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:!isMissedPrayers? CircleAvatar(
                                            child: leaderBoardController.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
                                              radius: 24, // Radius of the circular image
                                              backgroundImage: NetworkImage(
                                                "http://182.156.200.177:8011${leaderBoardController.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
                                              ),
                                            ):const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(Icons.person,color: Colors.grey,size: 30,),
                                            )
                                          // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                        ):
                                        InkWell(
                                          onTap: (){
                                            if(leaderBoardController.userData.getUserData!.id.toString()==leaderBoardController.getLeaderboardList.value!.records[index].user.id.toString()){
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return  const TimePicker();
                                                },
                                              );
                                            }
                                          },
                                          child: ColorFiltered(
                                            colorFilter: ColorFilter.matrix(
                                              <double>[
                                                0.2126, 0.7152, 0.0722, 0, 0, // Red channel coefficients
                                                0.2126, 0.7152, 0.0722, 0, 0, // Green channel coefficients
                                                0.2126, 0.7152, 0.0722, 0, 0, // Blue channel coefficients
                                                0, 0, 0, 1, 0,               // Alpha channel
                                              ],
                                            ),
                                            child: CircleAvatar(
                                                child: leaderBoardController.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
                                                  radius: 24, // Radius of the circular image
                                                  backgroundImage: NetworkImage(
                                                    "http://182.156.200.177:8011${leaderBoardController.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
                                                  ),
                                                ):const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(Icons.person,color: Colors.grey,size: 30,),
                                                )
                                              // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );

                                  },),
                              ):SizedBox();
                          }),

                          Obx((){
                            return leaderBoardController.getLeaderboardList.value!=null? Expanded(
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: leaderBoardController.getLeaderboardList.value!.records.length,
                                itemBuilder: (context, index) {
                                  var isMissedPrayers = leaderBoardController.getLeaderboardList.value!.records[index].userTimestamp == null;
                                  return Visibility(
                                    visible: leaderBoardController.getLeaderboardList.value!.records[index].prayerName == "Dhuhr",
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:!isMissedPrayers? CircleAvatar(
                                          child: leaderBoardController.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
                                            radius: 24, // Radius of the circular image
                                            backgroundImage: NetworkImage(
                                              "http://182.156.200.177:8011${leaderBoardController.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
                                            ),
                                          ):const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.person,color: Colors.grey,size: 30,),
                                          )
                                        // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                      ):
                                      InkWell(
                                        onTap: (){
                                          if(leaderBoardController.userData.getUserData!.id.toString()==leaderBoardController.getLeaderboardList.value!.records[index].user.id.toString()){
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return  const TimePicker();
                                              },
                                            );
                                          }
                                        },
                                        child: ColorFiltered(
                                          colorFilter: ColorFilter.matrix(
                                            <double>[
                                              0.2126, 0.7152, 0.0722, 0, 0, // Red channel coefficients
                                              0.2126, 0.7152, 0.0722, 0, 0, // Green channel coefficients
                                              0.2126, 0.7152, 0.0722, 0, 0, // Blue channel coefficients
                                              0, 0, 0, 1, 0,               // Alpha channel
                                            ],
                                          ),
                                          child: CircleAvatar(
                                              child: leaderBoardController.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
                                                radius: 24, // Radius of the circular image
                                                backgroundImage: NetworkImage(
                                                  "http://182.156.200.177:8011${leaderBoardController.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
                                                ),
                                              ):const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Icon(Icons.person,color: Colors.grey,size: 30,),
                                              )
                                            // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );

                                },),
                            ):SizedBox();
                          }),


                          Obx((){
                            return leaderBoardController.getLeaderboardList.value!=null? Expanded(
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: leaderBoardController.getLeaderboardList.value!.records.length,
                                itemBuilder: (context, index) {
                                  var isMissedPrayers = leaderBoardController.getLeaderboardList.value!.records[index].userTimestamp == null;
                                  return Visibility(
                                    visible: leaderBoardController.getLeaderboardList.value!.records[index].prayerName == "Asr",
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:!isMissedPrayers? CircleAvatar(
                                          child: leaderBoardController.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
                                            radius: 24, // Radius of the circular image
                                            backgroundImage: NetworkImage(
                                              "http://182.156.200.177:8011${leaderBoardController.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
                                            ),
                                          ):const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.person,color: Colors.grey,size: 30,),
                                          )
                                        // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                      ):
                                      ColorFiltered(
                                        colorFilter: ColorFilter.matrix(
                                          <double>[
                                            0.2126, 0.7152, 0.0722, 0, 0, // Red channel coefficients
                                            0.2126, 0.7152, 0.0722, 0, 0, // Green channel coefficients
                                            0.2126, 0.7152, 0.0722, 0, 0, // Blue channel coefficients
                                            0, 0, 0, 1, 0,               // Alpha channel
                                          ],
                                        ),
                                        child: CircleAvatar(
                                            child: leaderBoardController.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
                                              radius: 24, // Radius of the circular image
                                              backgroundImage: NetworkImage(
                                                "http://182.156.200.177:8011${leaderBoardController.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
                                              ),
                                            ):const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(Icons.person,color: Colors.grey,size: 30,),
                                            )
                                          // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                        ),
                                      ),
                                    ),
                                  );

                                },),
                            ):SizedBox();
                          }),

                          Obx((){
                            return leaderBoardController.getLeaderboardList.value!=null? Expanded(
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: leaderBoardController.getLeaderboardList.value!.records.length,
                                itemBuilder: (context, index) {
                                  var isMissedPrayers = leaderBoardController.getLeaderboardList.value!.records[index].userTimestamp == null;
                                  return Visibility(
                                    visible: leaderBoardController.getLeaderboardList.value!.records[index].prayerName == "Maghrib",
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:!isMissedPrayers? CircleAvatar(
                                          child: leaderBoardController.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
                                            radius: 24, // Radius of the circular image
                                            backgroundImage: NetworkImage(
                                              "http://182.156.200.177:8011${leaderBoardController.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
                                            ),
                                          ):const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.person,color: Colors.grey,size: 30,),
                                          )
                                        // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                      ):
                                      ColorFiltered(
                                        colorFilter: ColorFilter.matrix(
                                          <double>[
                                            0.2126, 0.7152, 0.0722, 0, 0, // Red channel coefficients
                                            0.2126, 0.7152, 0.0722, 0, 0, // Green channel coefficients
                                            0.2126, 0.7152, 0.0722, 0, 0, // Blue channel coefficients
                                            0, 0, 0, 1, 0,               // Alpha channel
                                          ],
                                        ),
                                        child: CircleAvatar(
                                            child: leaderBoardController.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
                                              radius: 24, // Radius of the circular image
                                              backgroundImage: NetworkImage(
                                                "http://182.156.200.177:8011${leaderBoardController.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
                                              ),
                                            ):const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(Icons.person,color: Colors.grey,size: 30,),
                                            )
                                          // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                        ),
                                      ),
                                    ),
                                  );

                                },),
                            ):SizedBox();
                          }),

                          Obx((){
                            return leaderBoardController.getLeaderboardList.value!=null? Expanded(
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: leaderBoardController.getLeaderboardList.value!.records.length,
                                itemBuilder: (context, index) {
                                  var isMissedPrayers = leaderBoardController.getLeaderboardList.value!.records[index].userTimestamp == null;
                                  return Visibility(
                                    visible: leaderBoardController.getLeaderboardList.value!.records[index].prayerName == "Isha",
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:!isMissedPrayers? CircleAvatar(
                                          child: leaderBoardController.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
                                            radius: 24, // Radius of the circular image
                                            backgroundImage: NetworkImage(
                                              "http://182.156.200.177:8011${leaderBoardController.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
                                            ),
                                          ):const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.person,color: Colors.grey,size: 30,),
                                          )
                                        // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                      ):
                                      ColorFiltered(
                                        colorFilter: ColorFilter.matrix(
                                          <double>[
                                            0.2126, 0.7152, 0.0722, 0, 0, // Red channel coefficients
                                            0.2126, 0.7152, 0.0722, 0, 0, // Green channel coefficients
                                            0.2126, 0.7152, 0.0722, 0, 0, // Blue channel coefficients
                                            0, 0, 0, 1, 0,               // Alpha channel
                                          ],
                                        ),
                                        child: CircleAvatar(
                                            child: leaderBoardController.getLeaderboardList.value!.records[index].user.picture!=null? CircleAvatar(
                                              radius: 24, // Radius of the circular image
                                              backgroundImage: NetworkImage(
                                                "http://182.156.200.177:8011${leaderBoardController.getLeaderboardList.value!.records[index].user.picture}", // Replace with your image URL
                                              ),
                                            ):const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(Icons.person,color: Colors.grey,size: 30,),
                                            )
                                          // Icon(isMissedPrayers?Icons.close:Icons.check,color: Colors.red,),
                                        ),
                                      ),
                                    ),
                                  );

                                },),
                            ):SizedBox();
                          }),

                        ],
                      ),
                      if(leaderBoardController.selectedTab.value =='Weekly')
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: leaderBoardController.weeklyMissedPrayer.keys.length,
                          itemBuilder: (context, index) {
                            final date = leaderBoardController.weeklyMissedPrayer.keys.elementAt(index);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    date,
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: leaderBoardController.prayers.map((prayer) {
                                    return Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            leaderBoardController.prayerShortNames[prayer]!,
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          // Display user prayer info under each prayer
                                          ...leaderBoardController.weeklyMissedPrayer[date]!
                                              .where((record) => record.prayerName == prayer)
                                              .map((record) {
                                            return record.userTimestamp != null
                                                ? Container(
                                              margin: EdgeInsets.all(5),
                                              padding: const EdgeInsets.all(1), // Padding around the circular image
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.yellow,
                                                ), // Yellow border
                                              ),
                                              child: record.user.picture != null
                                                  ? CircleAvatar(
                                                radius: 20, // Radius of the circular image
                                                backgroundImage: NetworkImage(
                                                  "http://182.156.200.177:8011${record.user.picture}", // Replace with your image URL
                                                ),
                                              )
                                                  : const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.person,
                                                  color: Colors.blue,
                                                  size: 20,
                                                ),
                                              ),
                                            )
                                                : Container(
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
                        )





                      // Leaderboard GridView
                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      //   child: GridView.builder(
                      //     shrinkWrap: true,
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      //       crossAxisCount: 5,
                      //       mainAxisSpacing: 10,
                      //       crossAxisSpacing: 10,
                      //     ),
                      //     itemCount: 1, // number of items
                      //     itemBuilder: (context, index) {
                      //       // Example of dynamic data for CircleAvatars
                      //       final avatarUrls = List.generate(25, (i) => 'https://via.placeholder.com/150'); // Placeholder URLs
                      //       return Column(
                      //         children: [
                      //           CircleAvatar(
                      //             radius: 20,
                      //             backgroundImage: NetworkImage(avatarUrls[index]),  // Dynamically set image
                      //           ),
                      //           const Text("sdddd",style: TextStyle(color: Colors.black),),
                      //         ],
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  );
                }
              ),
            ),


          ]
      )
    );
  }

}