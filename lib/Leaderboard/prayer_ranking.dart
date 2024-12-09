import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import '../DashBoard/dashboardController.dart';
import '../Widget/text_theme.dart';
import 'leaderboardDataModal.dart';

class PrayerRanking extends StatelessWidget {
  final List<Record> records;
  final List<RankedFriend> ranked;
  final String? id;

  const PrayerRanking({super.key, required this.records, required this.ranked, this.id});

  @override
  Widget build(BuildContext context) {
    final DashBoardController dashBoardController = Get.put(DashBoardController());

    DateTime fajrStartTime = DateFormat("HH:mm").parse(dashBoardController.prayerDuration['Fajr']?['start'] ?? '');
    DateTime fajrEndTime = DateFormat("HH:mm").parse(dashBoardController.prayerDuration['Fajr']?['end'] ?? '');
    String currentTimeStr = DateFormat("HH:mm").format(DateTime.now());
    // print('currentTimeStr: $currentTimeStr');
    DateTime currentTime = DateFormat("HH:mm").parse(currentTimeStr);

    // FZ Extracting Dhuhr end time
    String DhuhrEndTimeStr = dashBoardController.prayerDuration['Dhuhr']?['end'] ?? '';
    DateTime dhuhrEndTime = DateFormat("HH:mm").parse(DhuhrEndTimeStr);
    DateTime dhuhrStartTime = DateFormat("HH:mm").parse(dashBoardController.prayerDuration['Dhuhr']?['start'] ?? '');
    // print('dhuhrStartTime end time: $dhuhrEndTime');
    // print('dhuhrStartTime end time: $currentTime');

    // FZ Extracting Asr end time
    String asrEndTimeStr = dashBoardController.prayerDuration['Asr']?['end']??'';
    DateTime asrEndTime =  DateFormat("HH:mm").parse(asrEndTimeStr);
    DateTime asrStartTime =  DateFormat("HH:mm").parse(dashBoardController.prayerDuration['Asr']?['start']??'');

    //Extracting Maghrib end time
    String MaghribEndTimeStr = dashBoardController.prayerDuration['Maghrib']?['end']??'';
    DateTime maghribEndTime =  DateFormat("HH:mm").parse(MaghribEndTimeStr);
    DateTime maghribStartTime =  DateFormat("HH:mm").parse(dashBoardController.prayerDuration['Maghrib']?['start']??'');

    //Extracting Isha end time
    String IshaEndTimeStr = dashBoardController.prayerDuration['Isha']?['end']??'';
    DateTime ishaEndTime =  DateFormat("HH:mm").parse(IshaEndTimeStr);
    DateTime ishaStartTime =  DateFormat("HH:mm").parse(dashBoardController.prayerDuration['Isha']?['start']??'');






    // print('Fajr end time: $fajrEndTime');
    //
    // print(currentTime);
    // print(dashBoardController.currentPrayerStartTime.value);
    // print(dashBoardController.nextPrayer.value);
    // print(dashBoardController.prayerDuration);
    // print(dhuhrEndTime);



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
              buildPrayerCircle(
                'F',
                currentTime.isBefore(fajrStartTime)
                    ? AppColor.packageGray  // Prayer has not started yet
                    : currentTime.isAfter(fajrEndTime)
                    ? Colors.redAccent  // Prayer time has passed
                    : AppColor.circleIndicator,
              ),

              buildPrayerCircle(
                'D',
                currentTime.isBefore(dhuhrStartTime)
                    ? AppColor.packageGray  // Prayer has not started yet
                    : currentTime.isAfter(dhuhrEndTime)
                    ? Colors.redAccent  // Prayer time has passed
                    : AppColor.circleIndicator,  // Prayer is ongoing
                      // : AppColor.packageGray
                    // : ( DhuhrEndTime.isBefore(currentTime)
                    // ? Colors.redAccent
                    // : AppColor.packageGray),

              ),
              buildPrayerCircle(
                  'A',
                currentTime.isBefore(asrStartTime)
                    ? AppColor.packageGray  // Prayer has not started yet
                    : currentTime.isAfter(asrEndTime)
                    ? Colors.redAccent  // Prayer time has passed
                    : AppColor.circleIndicator,
              ),
              buildPrayerCircle(
                  'M',
                currentTime.isBefore(maghribStartTime)
                    ? AppColor.packageGray  // Prayer has not started yet
                    : currentTime.isAfter(maghribEndTime)
                    ? Colors.redAccent  // Prayer time has passed
                    : AppColor.circleIndicator,
              ),
              buildPrayerCircle(
                  'I',
                currentTime.isBefore(ishaStartTime)
                    ? AppColor.packageGray  // Prayer has not started yet
                    : currentTime.isAfter(ishaEndTime)
                    ? Colors.redAccent  // Prayer time has passed
                    : AppColor.circleIndicator,
              ),
              Text(
                "Overall",
                style: MyTextTheme.mediumBCb.copyWith(color: Colors.black),
              ),


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
                            height : 50,
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColor.circleIndicator,),
                            ),
                            child:ranked[index].picture!=null? CircleAvatar(
                              radius: 25, // Radius of the circular image
                              backgroundImage: NetworkImage(
                                "http://182.156.200.177:8011${ranked[index].picture}",
                              ),
                            ): Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.person,color: AppColor.circleIndicator,size: 30,),
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
      radius: 21,
      backgroundColor: (AppColor == AppColor.circleIndicator)
          ? AppColor.circleIndicator
          : (color == Colors.redAccent)
          ? Colors.redAccent
          : AppColor.amberColor,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: color,
        child: Text(
          label,
          style: const TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget buildUserList(List<Record>? users) {
    if (users == null || users.isEmpty) {
      return  Expanded(
          child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 24,
          child: Container(
            height: 3,
            width: 12,
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10)
            ),
          )
          //Text('-')
          ));
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
                  child: Container(
                 height: 3,
          width: 12,
          decoration: BoxDecoration(
            color: Colors.grey[400],
           borderRadius: BorderRadius.circular(10)
          ),
          )
                  //Text('-')),
            ),
            ));
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
