import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart'; // Import Hijri package
import 'package:namaz_reminders/Widget/appColor.dart';
import 'leaderboardController.dart';
import 'leaderboardDataModal.dart'; // Import the DateController

class LeaderBoardView extends StatefulWidget {
  const LeaderBoardView({super.key});

  @override
  State<LeaderBoardView> createState() => _LeaderBoardViewState();
}

class _LeaderBoardViewState extends State<LeaderBoardView> {
  LeaderBoardController leaderBoardController = LeaderBoardController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    leaderBoardController.leaderboard();
  }
  @override
  Widget build(BuildContext context) {
    // Instantiate the DateController
    final DateController dateController = Get.put(DateController());
    final LeaderBoardController controller = Get.put(LeaderBoardController());

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text("Leaderboard"),
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
                          onTap: () => controller.updateSelectedTab('Daily'),
                          child: Container(
                            decoration: BoxDecoration(
                              color: controller.selectedTab.value == 'Daily' ? AppColor.circleIndicator : Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Text(
                              'Daily',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: controller.selectedTab.value == 'Daily' ? Colors.black : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Weekly Button
                        GestureDetector(
                          onTap: () => controller.updateSelectedTab('Weekly'),
                          child: Container(
                            decoration: BoxDecoration(
                              color: controller.selectedTab.value == 'Weekly' ? AppColor.circleIndicator : Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Text(
                              'Weekly',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: controller.selectedTab.value == 'Weekly' ? Colors.white : Colors.black,
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
                              dateController.updateSelectedDate(picked);
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


                    Row(
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
                    )


                    // SizedBox(
                    //   height: 50,
                    //   child: ListView.separated(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: 5,
                    //     separatorBuilder: (context, index) => const SizedBox(width: 30),
                    //     itemBuilder: (context, index) {
                    //       final labels = ['F', 'Z', 'A', 'M', 'I'];
                    //       return CircleAvatar(child: Text(labels[index]));
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),



          SliverToBoxAdapter(
            child: Column(
              children: [
                // Space between leaderboard and toggle buttons
                const SizedBox(height: 20), // Adjust the height as needed
                Row(
                  children: [
                    Obx((){
                      return
                      Expanded(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: leaderBoardController.getLeaderboardList.length,
                          itemBuilder: (context, index) {
                            print(leaderBoardController.getLeaderboardList.length);
                            return Visibility(
                              visible: leaderBoardController.getLeaderboardList[index].prayerName == "Fajr",
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.orange,
                                  child: Icon(Icons.person,color: Colors.white,),),
                              ),
                            );

                          },),
                      );
                    }),

                    Obx((){
                      return Expanded(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: leaderBoardController.getLeaderboardList.length,
                          itemBuilder: (context, index) {
                            print(leaderBoardController.getLeaderboardList.length);
                            return Visibility(
                              visible: leaderBoardController.getLeaderboardList[index].prayerName == "Dhuhr",
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.orange,
                                  child: Icon(Icons.person,color: Colors.white,),),
                              ),
                            );

                          },),
                      );
                    }),


                    Obx((){
                      return Expanded(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: leaderBoardController.getLeaderboardList.length,
                          itemBuilder: (context, index) {
                            print(leaderBoardController.getLeaderboardList.length);
                            return Visibility(
                              visible: leaderBoardController.getLeaderboardList[index].prayerName == "Asr",
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.transparent,
                                  child: Image.network("https://5.imimg.com/data5/SELLER/Default/2023/11/363042627/BL/GC/VA/141770070/ya-ali-islamic-wall-decor-metal-arts-for-muslim-homes-wall-hangings-islamic-calligraphy-islamic-gifts-500x500.jpg",scale: 6,),),
                              ),
                            );

                          },),
                      );
                    }),

                    Obx((){
                      return Expanded(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: leaderBoardController.getLeaderboardList.length,
                          itemBuilder: (context, index) {
                            print(leaderBoardController.getLeaderboardList.length);
                            return Visibility(
                              visible: leaderBoardController.getLeaderboardList[index].prayerName == "Maghrib",
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.transparent,
                                  child: Image.network("https://st.depositphotos.com/1057689/4949/i/450/depositphotos_49490713-stock-photo-islamic-symbol.jpg",scale: 6,),),
                              ),
                            );

                          },),
                      );
                    }),

                    Obx((){
                      return Expanded(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: leaderBoardController.getLeaderboardList.length,
                          itemBuilder: (context, index) {
                            print(leaderBoardController.getLeaderboardList.length);
                            return Visibility(
                              visible: leaderBoardController.getLeaderboardList[index].prayerName == "Isha",
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipOval(
                                  child: CircleAvatar(
                                    radius: 22,
                                    backgroundColor: Colors.transparent,
                                    child: Image.network("https://www.auromin.in/cdn/shop/products/Untitled-1_ee823ade-f1f3-4b60-9665-865f453b7f16_600x.jpg?v=1664521813",scale: 6,),),
                                ),
                              ),
                            );

                          },),
                      );
                    })


                  ],
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
            ),
          ),
        ],
      ),
    );
  }
}
