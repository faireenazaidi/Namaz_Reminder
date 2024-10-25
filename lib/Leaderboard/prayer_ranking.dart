import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namaz_reminders/Widget/appColor.dart';

import '../Widget/text_theme.dart';
import 'leaderboardDataModal.dart';

class PrayerRanking extends StatelessWidget {
  final List<Record> records;
  final List<RankedFriend> ranked;
  final String? id;

  const PrayerRanking({super.key, required this.records, required this.ranked, this.id});

  @override
  Widget build(BuildContext context) {
    // Group users by prayer and sort by score (descending)
    Map<String, List<Record>> groupedByPrayer = groupByPrayer(records);

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          // Header with prayer names
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildPrayerCircle('F', AppColor.circleIndicator,),
              buildPrayerCircle('Z', AppColor.circleIndicator),
              buildPrayerCircle('A', AppColor.circleIndicator),
              buildPrayerCircle('M', AppColor.circleIndicator),
              buildPrayerCircle('I', AppColor.circleIndicator),
              Text("Overall",style: MyTextTheme.mediumBCb.copyWith(color: Colors.black,)),
            ],
          ),
          const SizedBox(height: 16),
          // User ranking under each prayer
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildUserList(groupedByPrayer['Fajr']),
              buildUserList(groupedByPrayer['Dhuhr']),
              buildUserList(groupedByPrayer['Asr']),
              buildUserList(groupedByPrayer['Maghrib']),
              buildUserList(groupedByPrayer['Isha']),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 7),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ranked.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(1), // Padding around the circular image
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.yellow,), // Yellow border
                            ),
                            child:ranked[index].picture!=null? CircleAvatar(
                              radius: 24, // Radius of the circular image
                              backgroundImage: NetworkImage(
                                "http://182.156.200.177:8011${ranked[index].picture}", // Replace with your image URL
                              ),
                            ):const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.person,color: Colors.grey,size: 30,),
                            ),
                          ),
                          id==ranked[index].id.toString()?const Text('You',style: TextStyle(fontSize: 12),):Text(ranked[index].name.split(' ')[0],style: const TextStyle(
                            fontSize: 12
                          ),)
                        ],
                      ),
                    );

                  },),
              )
            ],
          ),
        ],
      ),
    );
  }

  // Widget to build prayer circle header
  Widget buildPrayerCircle(String label, Color color,) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: color,
      child: Text(
        label,
        style: const TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w400),
      ),
    );
  }

  // Widget to build user list under each prayer
  Widget buildUserList(List<Record>? users) {
    if (users == null || users.isEmpty) {
      return const Expanded(child: Center(child: Text('-'))); // Placeholder for empty column
    }
    return Expanded(
      child: Column(
        children: users.map((user) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child:user.userTimestamp!=null? user.user.picture!=null? Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    // border: Border.all(color: Colors.yellow,), // Yellow border
                  ),
                  child: CircleAvatar(
                    radius: 24, // Radius of the circular image
                    backgroundImage: NetworkImage(
                      "http://182.156.200.177:8011${user.user.picture}", // Replace with your image URL
                    ),
                  ),
                ),
                id==user.user.id.toString()?const Text("You",style: TextStyle(fontSize: 12),):Text(user.user.name.split(' ')[0],style: const TextStyle(fontSize: 12),)
              ],
            ):Column(
              children: [
                Container(
                  padding: EdgeInsets.all(1), // Padding around the circular image
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey,), // Yellow border
                  ),
                  child:const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.person,color: Colors.grey,size: 30,),
                  ),
                ),
                id==user.user.id.toString()?const Text("You",style: TextStyle(fontSize: 12),):Text(user.user.name.split(' ')[0],style: const TextStyle(fontSize: 12),)
              ],
            ):const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('-'),
            ),
            // CircleAvatar(
            //   radius: 24,
            //   backgroundImage: NetworkImage(getUserAvatarUrl(user.user.id)), // Use user id for avatar URL
            // ),
          );
        }).toList(),
      ),
    );
  }

  // Helper method to filter and group data by prayer
  Map<String, List<Record>> groupByPrayer(List<Record> records) {
    Map<String, List<Record>> prayerGroups = {
      'Fajr': [],
      'Dhuhr': [],
      'Asr': [],
      'Maghrib': [],
      'Isha': [],
    };
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    // Filter today's date and group by prayer, sorted by score descending
    for (var record in records) {
      if (record.date == formattedDate) {
        String prayer = record.prayerName;
        if (prayerGroups.containsKey(prayer)) {
          prayerGroups[prayer]?.add(record);
        }
      }
    }

    // Sort each prayer group by score descending
    prayerGroups.forEach((prayer, users) {
      users.sort((a, b) => (double.parse(b.score)).compareTo(double.parse(a.score)));
    });

    return prayerGroups;
  }

  // Placeholder for user avatar URL based on user ID
  String getUserAvatarUrl(int userId) {
    return 'https://via.placeholder.com/150'; // Placeholder for avatars
  }
}