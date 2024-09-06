import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart'; // Import Hijri package
import 'package:namaz_reminders/Widget/appColor.dart';
import 'leaderboardController.dart';
import 'leaderboardDataModal.dart'; // Import the DateController

class LeaderBoardView extends StatelessWidget {
  const LeaderBoardView({super.key});

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
                    SizedBox(height: 80,),
                    Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Daily Button
                        GestureDetector(
                          onTap: () => controller.updateSelectedTab('Daily'),
                          child: Container(
                            decoration: BoxDecoration(
                              color: controller.selectedTab.value == 'Daily' ? Colors.orange[100] : Colors.transparent,
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
                    Text("TODAYS'S TIMELINE",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        separatorBuilder: (context, index) => const SizedBox(width: 30),
                        itemBuilder: (context, index) {
                          final labels = ['F', 'Z', 'A', 'M', 'I'];
                          return CircleAvatar(child: Text(labels[index]));
                        },
                      ),
                    ),
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

                // Leaderboard GridView
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: 25, // number of items
                    itemBuilder: (context, index) {
                      // Example of dynamic data for CircleAvatars
                      final avatarUrls = List.generate(25, (i) => 'https://via.placeholder.com/150'); // Placeholder URLs
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(avatarUrls[index]),  // Dynamically set image
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
    );
  }
}
