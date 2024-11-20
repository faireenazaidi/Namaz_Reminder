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
    Map<String, List<Record>> groupedByPrayer = groupByPrayer(records);

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
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
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.yellow,),
                            ),
                            child:ranked[index].picture!=null? CircleAvatar(
                              radius: 22, // Radius of the circular image
                              backgroundImage: NetworkImage(
                                "http://182.156.200.177:8011${ranked[index].picture}",
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
  Widget buildPrayerCircle(String label, Color color,) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: color,
      child: Text(
        label,
        style: const TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget buildUserList(List<Record>? users) {
    if (users == null || users.isEmpty) {
      return const Expanded(child: CircleAvatar(
          backgroundColor: Colors.transparent,
        radius: 24,
          child: Text('-')));
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
                  ),
                  child: CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(
                      "http://182.156.200.177:8011${user.user.picture}",
                    ),
                  ),
                ),
                id==user.user.id.toString()?const Text("You",style: TextStyle(fontSize: 12),):Text(user.user.name.split(' ')[0],style: const TextStyle(fontSize: 12),)
              ],
            ):Column(
              children: [
                Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey,),
                  ),
                  child:const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.person,color: Colors.grey,size: 30,),
                  ),
                ),
                id==user.user.id.toString()?const Text("You",style: TextStyle(fontSize: 12),):Text(user.user.name.split(' ')[0],style: const TextStyle(fontSize: 12),)
              ],
            ):

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white60,
                  radius: 24,
                    child: Text('-')),
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