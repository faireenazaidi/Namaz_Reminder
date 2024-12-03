import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'leaderboardDataModal.dart';

class DailyTopLeaderboard extends StatelessWidget {
  final List<Record> records;
  final List<RankedFriend> ranked;

  const DailyTopLeaderboard({super.key, required this.records, required this.ranked});

  @override
  Widget build(BuildContext context) {
    // Group users by prayer and sort by score (descending)
    Map<String, List<Record>> groupedByPrayer = groupByPrayer(records);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with prayer names
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildPrayerCircle('F', Colors.orange),
            buildPrayerCircle('D', Colors.orange),
            buildPrayerCircle('A', Colors.orange),
            buildPrayerCircle('M', Colors.orange),
            buildPrayerCircle('I', Colors.orange),
          ],
        ),
        // const SizedBox(height: 16),
        // User ranking under each prayer
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildUserList(groupedByPrayer['Fajr']),
            buildUserList(groupedByPrayer['Zuhr']),
            buildUserList(groupedByPrayer['Asr']),
            buildUserList(groupedByPrayer['Maghrib']),
            buildUserList(groupedByPrayer['Isha']),
          ],
        ),
      ],
    );
  }

  // Widget to build prayer circle header
  Widget buildPrayerCircle(String label, Color color) {
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
            child:user.userTimestamp!=null? user.user.picture!=null? Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                // border: Border.all(color: Colors.yellow,), // Yellow border
              ),
              child: CircleAvatar(
                radius: 20, // Radius of the circular image
                backgroundImage: NetworkImage(
                  "http://182.156.200.177:8011${user.user.picture}", // Replace with your image URL
                ),
              ),
            ):Container(
              padding: EdgeInsets.all(1), // Padding around the circular image
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey,), // Yellow border
              ),
              child:const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.person,color: Colors.grey,size: 30,),
              ),
            ):const SizedBox.shrink(),
          );
        }).toList(),
      ),
    );
  }

  // Helper method to filter and group data by prayer
  Map<String, List<Record>> groupByPrayer(List<Record> records) {
    Map<String, List<Record>> prayerGroups = {
      'Fajr': [],
      'Zuhr': [],
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