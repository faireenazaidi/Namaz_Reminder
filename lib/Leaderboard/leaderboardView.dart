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
    leaderBoardController.leaderboard(leaderBoardController.getFormattedDate());
    leaderBoardController.weeklyApi(leaderBoardController.getFormattedDate());
  }
  @override
  Widget build(BuildContext context) {
    // Instantiate the DateController
    final DateController dateController = Get.put(DateController());
    final LeaderBoardController controller = Get.put(LeaderBoardController());

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          Obx(()=>SliverAppBar(
            title: const Text("Leaderboard"),
            centerTitle: true,
            pinned: true,
            expandedHeight: controller.getSelectedTab == 'Daily'?Get.height/2.9:Get.height/2.3,
            // expandedHeight: 350.0,
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
                          onTap: () =>
                          controller.updateSelectedTab ='Daily',
                          child: Container(
                            decoration: BoxDecoration(
                              color: controller.getSelectedTab == 'Daily' ? AppColor.circleIndicator : Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Text(
                              'Daily',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: controller.selectedTab.value == 'Daily' ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Weekly Button
                        GestureDetector(
                          onTap: () => controller.updateSelectedTab = 'Weekly',
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


                    Obx(()=>Visibility(
                      visible: controller.selectedTab.value == 'Daily',
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            child: Text("F"),
                          ),
                          CircleAvatar(
                            radius: 20,
                            child: Text("Z"),
                          ),
                          CircleAvatar(
                            radius: 20,
                            child: Text("A"),
                          ),
                          CircleAvatar(
                            radius: 20,
                            child: Text("M"),
                          ),
                          CircleAvatar(
                            radius: 20,
                            child: Text("I"),
                          )
                        ],
                      ),
                    ),),

                    Obx(()=>Visibility(
                      visible: controller.selectedTab.value == 'Weekly',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTopUser("assets/bg.jpeg", "Abid Ali", "97%", 2),
                          _buildTopUser("assets/bg.jpeg", "Amira", "98.5%", 1),
                          _buildTopUser("assets/bg.jpeg", "Waleed Ahmed", "98%", 3),
                        ],
                      ),
                    ),)
                  ],
                ),
              ),
            ),
          ),),



          SliverToBoxAdapter(
            child: GetBuilder<LeaderBoardController>(
                builder: (_) {
                return Visibility(
                  visible: controller.selectedTab.value == 'Daily',
                  child: Column(
                    children: [
                      // Space between leaderboard and toggle buttons
                      const SizedBox(height: 20), // Adjust the height as needed
                      Row(
                        children: [
                            Expanded(
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: leaderBoardController.getLeaderboardList!.records.length,
                                itemBuilder: (context, index) {
                                  return Visibility(
                                    visible: leaderBoardController.getLeaderboardList!.records[index].prayerName == "Fajr",
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.orange,
                                        child: Icon(Icons.person,color: Colors.white,),),
                                    ),
                                  );

                                },),
                            ),
                          Expanded(
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: leaderBoardController.getLeaderboardList!.records.length,
                                itemBuilder: (context, index) {
                                  return Visibility(
                                    visible: leaderBoardController.getLeaderboardList!.records[index].prayerName == "Dhuhr",
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.orange,
                                        child: Icon(Icons.person,color: Colors.white,),),
                                    ),
                                  );

                                },),
                            ),


                         Expanded(
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: leaderBoardController.getLeaderboardList!.records.length,
                                itemBuilder: (context, index) {
                                  return Visibility(
                                    visible: leaderBoardController.getLeaderboardList!.records[index].prayerName == "Asr",
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.transparent,
                                        child: Image.network("https://5.imimg.com/data5/SELLER/Default/2023/11/363042627/BL/GC/VA/141770070/ya-ali-islamic-wall-decor-metal-arts-for-muslim-homes-wall-hangings-islamic-calligraphy-islamic-gifts-500x500.jpg",scale: 6,),),
                                    ),
                                  );

                                },),
                            ),
                          Expanded(
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: leaderBoardController.getLeaderboardList!.records.length,
                                itemBuilder: (context, index) {
                                  return Visibility(
                                    visible: leaderBoardController.getLeaderboardList!.records[index].prayerName == "Maghrib",
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.transparent,
                                        child: Image.network("https://st.depositphotos.com/1057689/4949/i/450/depositphotos_49490713-stock-photo-islamic-symbol.jpg",scale: 6,),),
                                    ),
                                  );

                                },),
                            ),

                Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: leaderBoardController.getLeaderboardList!.records.length,
                    itemBuilder: (context, index) {
                      return Visibility(
                        visible: leaderBoardController.getLeaderboardList!.records[index].prayerName == "Isha",
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
                )
                          },),
                      )

                        ],
                      )


                    ],
                  ),
                );
              }
            ),
          )),



          Obx(()=>SliverToBoxAdapter(
            child: Visibility(
                visible: controller.selectedTab.value == 'Weekly',
                child: SizedBox(
                  height: 500,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildUserProgress("assets/bg.jpeg", "Muhammad Ali", "90%"),
                      _buildUserProgress("assets/bg.jpeg", "Shihab Shaharia", "90%"),
                      _buildUserProgress("assets/bg.jpeg", "Ali Shaan", "95.5%"),
                      _buildUserProgress("assets/bg.jpeg", "You", "95%", highlight: true),
                      _buildUserProgress("assets/bg.jpeg", "Mahmudul Hasan", "95.5%"),
                    ],
                  ),
                ),
            ),
          ))

        ],
      ),
    );
  }



  Widget _buildTopUser(String imageUrl, String name, String score, int rank) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(imageUrl),
            ),
            CircleAvatar(
              radius: 12,
              backgroundColor: rank == 1 ? Colors.orange : Colors.grey.shade400,
              child: Text(
                rank.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(score, style: const TextStyle(color: Colors.orange)),
      ],
    );
  }


  Widget _buildUserProgress(String imageUrl, String name, String score, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10,top: 20),
      child: Column(
        children: [

          const Icon(Icons.star,size: 40,),

          Container(
            height: 380,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: highlight ? [Colors.orange.shade200, Colors.yellow.shade50] : [Colors.grey.shade400,Colors.white12, ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 50,width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(image: AssetImage(imageUrl),fit: BoxFit.fill)
                  ),
                ),
                const SizedBox(height: 5),
                Text(score, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 60,
              child: Text(name, style: const TextStyle())),
        ],
      ),
    );
  }



}
