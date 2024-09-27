import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Leaderboard/leaderboardDataModal.dart';
import '../Widget/text_theme.dart';

void showToast({required String msg,Color? bgColor,Color? textColor}){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor:bgColor?? Colors.red,
      textColor:textColor?? Colors.white,
      fontSize: 16.0
  );
}





// class PrayerRanking extends StatelessWidget {
//   final List<Map<String, dynamic>> records = [
//     {
//       "user": {
//         "id": 6,
//         "username": "447",
//         "mobile_no": "7905216447"
//       },
//       "user_timestamp": null,
//       "latitude": 26.878406,
//       "longitude": 80.8715481,
//       "date": "2024-09-27",
//       "prayer_name": "Fajr",
//       "score": 20,
//       "jamat": true,
//       "times_of_prayer": 3
//     },
//     {
//       "user": {
//         "id": 6,
//         "username": "447",
//         "mobile_no": "7905216447"
//       },
//       "user_timestamp": "15:13",
//       "latitude": 26.878406,
//       "longitude": 80.8715481,
//       "date": "2024-09-27",
//       "prayer_name": "Dhuhr",
//       "score": 100.0,
//       "jamat": true,
//       "times_of_prayer": 3
//     },
//     {
//       "user": {
//         "id": 6,
//         "username": "447",
//         "mobile_no": "7905216447"
//       },
//       "user_timestamp": null,
//       "latitude": 26.878406,
//       "longitude": 80.8715481,
//       "date": "2024-09-27",
//       "prayer_name": "Asr",
//       "score": 10,
//       "jamat": true,
//       "times_of_prayer": 3
//     },
//     {
//       "user": {
//         "id": 6,
//         "username": "447",
//         "mobile_no": "7905216447"
//       },
//       "user_timestamp": null,
//       "latitude": 26.878406,
//       "longitude": 80.8715481,
//       "date": "2024-09-27",
//       "prayer_name": "Maghrib",
//       "score": 60,
//       "jamat": true,
//       "times_of_prayer": 3
//     },
//     {
//       "user": {
//         "id": 6,
//         "username": "447",
//         "mobile_no": "7905216447"
//       },
//       "user_timestamp": null,
//       "latitude": 26.878406,
//       "longitude": 80.8715481,
//       "date": "2024-09-27",
//       "prayer_name": "Isha",
//       "score": 0,
//       "jamat": true,
//       "times_of_prayer": 3
//     },
//     {
//       "user": {
//         "id": 53,
//         "username": "303",
//         "mobile_no": "7784928303"
//       },
//       "user_timestamp": null,
//       "latitude": 26.8784241,
//       "longitude": 80.8715441,
//       "date": "2024-09-27",
//       "prayer_name": "Fajr",
//       "score": 0,
//       "jamat": true,
//       "times_of_prayer": 3
//     },
//     {
//       "user": {
//         "id": 53,
//         "username": "303",
//         "mobile_no": "7784928303"
//       },
//       "user_timestamp": "15:14",
//       "latitude": 26.8784241,
//       "longitude": 80.8715441,
//       "date": "2024-09-27",
//       "prayer_name": "Dhuhr",
//       "score": 100.0,
//       "jamat": true,
//       "times_of_prayer": 3
//     },
//     {
//       "user": {
//         "id": 53,
//         "username": "303",
//         "mobile_no": "7784928303"
//       },
//       "user_timestamp": null,
//       "latitude": 26.8784241,
//       "longitude": 80.8715441,
//       "date": "2024-09-27",
//       "prayer_name": "Asr",
//       "score": 15,
//       "jamat": true,
//       "times_of_prayer": 3
//     },
//     {
//       "user": {
//         "id": 53,
//         "username": "303",
//         "mobile_no": "7784928303"
//       },
//       "user_timestamp": null,
//       "latitude": 26.8784241,
//       "longitude": 80.8715441,
//       "date": "2024-09-27",
//       "prayer_name": "Maghrib",
//       "score": 40,
//       "jamat": true,
//       "times_of_prayer": 3
//     },
//     {
//       "user": {
//         "id": 53,
//         "username": "303",
//         "mobile_no": "7784928303"
//       },
//       "user_timestamp": null,
//       "latitude": 26.8784241,
//       "longitude": 80.8715441,
//       "date": "2024-09-27",
//       "prayer_name": "Isha",
//       "score": 90,
//       "jamat": true,
//       "times_of_prayer": 3
//     }
//     // Add the data records here as provided in the question
//   ];
//
//    PrayerRanking({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Group users by prayer and sort by score (descending)
//     Map<String, List<Map<String, dynamic>>> groupedByPrayer = groupByPrayer(records);
//
//     return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header with prayer names
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 buildPrayerCircle('F', Colors.orange),
//                 buildPrayerCircle('Z', Colors.orange),
//                 buildPrayerCircle('A', Colors.orange),
//                 buildPrayerCircle('M', Colors.orange),
//                 buildPrayerCircle('I', Colors.orange),
//               ],
//             ),
//             SizedBox(height: 16),
//             // User ranking under each prayer
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 buildUserList(groupedByPrayer['Fajr']),
//                 buildUserList(groupedByPrayer['Dhuhr']),
//                 buildUserList(groupedByPrayer['Asr']),
//                 buildUserList(groupedByPrayer['Maghrib']),
//                 buildUserList(groupedByPrayer['Isha']),
//               ],
//             ),
//           ],
//         ),
//       );
//   }
//
//   // Widget to build prayer circle header
//   Widget buildPrayerCircle(String label, Color color) {
//     return CircleAvatar(
//       radius: 24,
//       backgroundColor: color,
//       child: Text(
//         label,
//         style: TextStyle(color: Colors.white, fontSize: 18),
//       ),
//     );
//   }
//
//   // Widget to build user list under each prayer
//   Widget buildUserList(List<Map<String, dynamic>>? users) {
//     print("users $users");
//     if (users == null || users.isEmpty) {
//       return Expanded(child: Center(child: Text('-'))); // Placeholder for empty column
//     }
//     return Expanded(
//       child: Column(
//         children: users.map((user) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: CircleAvatar(
//               radius: 24,
//               backgroundImage: NetworkImage(getUserAvatarUrl(user['user']['id'])), // Placeholder for avatar URL
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   // Helper method to filter and group data by prayer
//   Map<String, List<Map<String, dynamic>>> groupByPrayer(List<Map<String, dynamic>> records) {
//     Map<String, List<Map<String, dynamic>>> prayerGroups = {
//       'Fajr': [],
//       'Dhuhr': [],
//       'Asr': [],
//       'Maghrib': [],
//       'Isha': [],
//     };
//
//     // Filter today's date and group by prayer, sorted by score descending
//     for (var record in records) {
//       if (record['date'] == '2024-09-27') {
//         String prayer = record['prayer_name'];
//         if (prayerGroups.containsKey(prayer)) {
//           prayerGroups[prayer]?.add(record);
//         }
//       }
//     }
//
//     // Sort each prayer group by score descending
//     prayerGroups.forEach((prayer, users) {
//       users.sort((a, b) => (double.parse(b['score'].toString())).compareTo(double.parse(a['score'].toString())));
//     });
//
//     return prayerGroups;
//   }
//
//   // Placeholder for user avatar URL based on user ID
//   String getUserAvatarUrl(int userId) {
//     return 'https://via.placeholder.com/150'; // Placeholder for avatars
//   }
// }
