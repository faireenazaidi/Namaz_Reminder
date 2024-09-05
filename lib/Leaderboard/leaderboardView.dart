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
                backgroundColor: Colors.white, // Circular container background
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black), // Back arrow icon
                  onPressed: () {
                    Get.back(); // Go back to the previous page
                  },
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Daily and Weekly Tabs just below the title
                    Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Container for Daily button with rounded corners
                        Container(
                          decoration: BoxDecoration(
                            color: controller.selectedTab.value == 'Daily' ? Colors.orange[100] : Colors.transparent,
                            borderRadius: BorderRadius.circular(30), // Rounded background
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Adjust the padding
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => controller.updateSelectedTab('Daily'),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: controller.selectedTab.value == 'Daily' ? Colors.orange : Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Padding inside the button
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
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Container for Weekly button with rounded corners
                        Container(
                          decoration: BoxDecoration(
                            color: controller.selectedTab.value == 'Weekly' ? Colors.orange[100] : Colors.transparent,
                            borderRadius: BorderRadius.circular(15), // Rounded background
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4), // Adjust the padding
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => controller.updateSelectedTab('Weekly'),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: controller.selectedTab.value == 'Weekly' ? Colors.orange : Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Padding inside the button
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
                          ),
                        ),
                      ],
                    )),

                    const SizedBox(height: 20), // Adjust spacing between tabs and rest
                    // Date and timeline selection

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          child: Image.asset("assets/iconcalen.png"),
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
                        // Updated date display using intl package
                        Obx(() => Expanded(
                          child: Row(
                            children: [
                              Text(
                                DateFormat('EEEE, d MMMM yyyy').format(dateController.selectedDate.value),
                                style: const TextStyle(fontSize: 14, color: Colors.black), // Decreased font size
                              ),
                              const VerticalDivider(
                                width: 20,
                                thickness: 1,
                                color: Colors.black,
                                endIndent: 5,
                                indent: 5,
                              ),
                              // Display current Hijri date
                              Text(
                                dateController.formatHijriDate(dateController.selectedDate.value),
                                style: const TextStyle(fontSize: 14, color: Colors.black), // Decreased font size
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 10,),

                    // Today's Timeline (F, Z, A, etc)
                    SizedBox(
                      height: 50,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5, // Number of CircleAvatars
                        separatorBuilder: (context, index) => SizedBox(width: 40), // Spacing between items
                        itemBuilder: (context, index) {
                          // List of items
                          final labels = ['F', 'Z', 'A', 'M', 'I'];
                          return CircleAvatar(child: Text(labels[index]));
                        },
                      ),
                    )
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
                            radius: 30,
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
