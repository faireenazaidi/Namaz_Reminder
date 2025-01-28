import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import '../DashBoard/dashboardController.dart';
import '../DashBoard/timepickerpopup.dart';
import '../Drawer/drawerController.dart';
import '../Widget/text_theme.dart';
import 'LeaderBoardController.dart';
import 'leaderboardDataModal.dart';

class PrayerRanking extends StatelessWidget {
  final List<Record> records;
  final List<RankedFriend> ranked;
  final String? id;
  final LeaderBoardController controller;

  const PrayerRanking({super.key, required this.records, required this.ranked, this.id, required this.controller});

  @override
  Widget build(BuildContext context) {
    final DashBoardController dashBoardController = Get.put(DashBoardController());
    final CustomDrawerController customDrawerController = Get.put(CustomDrawerController());

    DateTime fajrStartTime = DateFormat("HH:mm").parse(dashBoardController.prayerDuration['Fajr']?['start'] ?? '');
    DateTime fajrEndTime = DateFormat("HH:mm").parse(dashBoardController.prayerDuration['Fajr']?['end'] ?? '');
    DateTime currentDateTime = DateTime.now();
    String currentTimeStr = DateFormat("HH:mm").format(currentDateTime);
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
    return
      Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              InkWell(
                onTap: () async {
                  if(currentTime.isAfter(fajrEndTime)){
                    bool isMissed = isUserPrayerTimestampNull(records,id!,'Fajr');
                    print("isMissed $isMissed");
                    String formattedDate = DateFormat('dd-MM-yyyy').format(currentDateTime);
                    print("object $formattedDate");
                    DateTime? prayerTime = await Future
                        .delayed(
                        Duration
                            .zero, () {
                      return controller
                          .getPrayerTime(
                        controller
                            .dashboardController
                            .calendarData,
                        formattedDate,
                        'Fajr',
                      );
                    });
                    print("prayerTime $prayerTime");
                    showDialog(
                      context: context,
                      builder: (
                          BuildContext context) {
                        return TimePicker(
                          date: formattedDate,
                          prayerNames: 'Fajr',
                          isFromMissed: true,
                          missedPrayerTime: prayerTime,
                          missedCallBack: ()async{} );
                      },
                    );
                  }
                },
                child: buildPrayerCircle(
                  'F',
                  currentTime.isBefore(fajrStartTime)
                      ? customDrawerController.isDarkMode == false ? AppColor.packageGray: Colors.white12
                      : currentTime.isAfter(fajrEndTime)
                      ? Colors.redAccent  // Prayer time has passed
                      : AppColor.color,
                ),
              ),

              InkWell(
                onTap: () async {
                  if(currentTime.isAfter(dhuhrEndTime)){
                    bool isMissed = isUserPrayerTimestampNull(records,id!,'Dhuhr');
                    print("isMissed $isMissed");
                    String formattedDate = DateFormat('dd-MM-yyyy').format(currentDateTime);
                    print("object $formattedDate");
                    DateTime? prayerTime = await Future
                        .delayed(
                        Duration
                            .zero, () {
                      return controller
                          .getPrayerTime(
                        controller
                            .dashboardController
                            .calendarData,
                        formattedDate,
                        'Dhuhr',
                      );
                    });
                    print("prayerTime $prayerTime");
                    showDialog(
                      context: context,
                      builder: (
                          BuildContext context) {
                        return TimePicker(
                            date: formattedDate,
                            prayerNames: 'Dhuhr',
                            isFromMissed: true,
                            missedPrayerTime: prayerTime,
                            missedCallBack: ()async{} );
                      },
                    );
                  }
                },
                child: buildPrayerCircle(
                  'D',
                  currentTime.isBefore(dhuhrStartTime)
                      ? AppColor.packageGray  // Prayer has not started yet
                      : currentTime.isAfter(dhuhrEndTime)
                      ? Colors.redAccent  // Prayer time has passed
                      : AppColor.color,  // Prayer is ongoing
                        // : AppColor.packageGray
                      // : ( DhuhrEndTime.isBefore(currentTime)
                      // ? Colors.redAccent
                      // : AppColor.packageGray),

                ),
              ),
              InkWell(
                onTap: () async {
                  if(currentTime.isAfter(asrEndTime)){
                    bool isMissed = isUserPrayerTimestampNull(records,id!,'Asr');
                    print("isMissed $isMissed");
                    String formattedDate = DateFormat('dd-MM-yyyy').format(currentDateTime);
                    print("object $formattedDate");
                    DateTime? prayerTime = await Future
                        .delayed(
                        Duration
                            .zero, () {
                      return controller
                          .getPrayerTime(
                        controller
                            .dashboardController
                            .calendarData,
                        formattedDate,
                        'Asr',
                      );
                    });
                    print("prayerTime $prayerTime");
                    showDialog(
                      context: context,
                      builder: (
                          BuildContext context) {
                        return TimePicker(
                            date: formattedDate,
                            prayerNames: 'Asr',
                            isFromMissed: true,
                            missedPrayerTime: prayerTime,
                            missedCallBack: ()async{} );
                      },
                    );
                  }
                },
                child: buildPrayerCircle(
                    'A',
                  currentTime.isBefore(asrStartTime)
                      ? AppColor.packageGray  // Prayer has not started yet
                      : currentTime.isAfter(asrEndTime)
                      ? Colors.redAccent  // Prayer time has passed
                      : AppColor.color,
                ),
              ),
              InkWell(
                onTap: () async {
                  if(currentTime.isAfter(maghribEndTime)){
                    bool isMissed = isUserPrayerTimestampNull(records,id!,'Maghrib');
                    print("isMissed $isMissed");
                    String formattedDate = DateFormat('dd-MM-yyyy').format(currentDateTime);
                    print("object $formattedDate");
                    DateTime? prayerTime = await Future
                        .delayed(
                        Duration
                            .zero, () {
                      return controller
                          .getPrayerTime(
                        controller
                            .dashboardController
                            .calendarData,
                        formattedDate,
                        'Maghrib',
                      );
                    });
                    print("prayerTime $prayerTime");
                    showDialog(
                      context: context,
                      builder: (
                          BuildContext context) {
                        return TimePicker(
                            date: formattedDate,
                            prayerNames: 'Maghrib',
                            isFromMissed: true,
                            missedPrayerTime: prayerTime,
                            missedCallBack: ()async{} );
                      },
                    );
                  }
                },
                child: CircleAvatar(
                  radius: 21,
                  backgroundColor: AppColor.color,
                  child: buildPrayerCircle(
                      'M',
                    currentTime.isBefore(maghribStartTime)
                        ? customDrawerController.isDarkMode == false ? AppColor.packageGray: Colors.white
                        : currentTime.isAfter(maghribEndTime)
                        ? Colors.redAccent
                        : AppColor.color,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  if(currentTime.isAfter(ishaEndTime)){
                    bool isMissed = isUserPrayerTimestampNull(records,id!,'Isha');
                    print("isMissed $isMissed");
                    String formattedDate = DateFormat('dd-MM-yyyy').format(currentDateTime);
                    print("object $formattedDate");
                    DateTime? prayerTime = await Future
                        .delayed(
                        Duration
                            .zero, () {
                      return controller
                          .getPrayerTime(
                        controller
                            .dashboardController
                            .calendarData,
                        formattedDate,
                        'Isha',
                      );
                    });
                    print("prayerTime $prayerTime");
                    showDialog(
                      context: context,
                      builder: (
                          BuildContext context) {
                        return TimePicker(
                            date: formattedDate,
                            prayerNames: 'Isha',
                            isFromMissed: true,
                            missedPrayerTime: prayerTime,
                            missedCallBack: ()async{} );
                      },
                    );
                  }
                },
                child: buildPrayerCircle(
                    'I',
                  currentTime.isBefore(ishaStartTime)
                      ? AppColor.packageGray  // Prayer has not started yet
                      : currentTime.isAfter(ishaEndTime)
                      ? Colors.redAccent  // Prayer time has passed
                      : AppColor.color,
                ),
              ),
              Text(
                "Overall",
                style: MyTextTheme.orange.copyWith(color: Theme.of(context).textTheme.displaySmall?.color),
              ),


            ],

          ),

          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child:
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
                              height : 45,
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColor.color,),
                              ),
                              child:ranked[index].picture!=null? CircleAvatar(
                                radius: 25, // Radius of the circular image
                                backgroundImage: NetworkImage(
                                  "http://182.156.200.177:8011${ranked[index].picture}",
                                ),
                              ): Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.person,color: AppColor.color,size: 25,),
                              ),
                            ),
                            id==ranked[index].id.toString()?const 
                            Text('You',style: TextStyle(fontSize: 12,color: AppColor.color,fontWeight: FontWeight.w500),):
                            Text(ranked[index].name.split(' ')[0],
                              style: const TextStyle(fontSize: 12),)
                          ],
                        ),
                      );

                    },),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget buildPrayerCircle(String label, Color color,) {
    return CircleAvatar(
      radius: 21,
      backgroundColor: (AppColor == AppColor.color)
          ? AppColor.color
          : (color == Colors.redAccent)
          ? Colors.redAccent
          : Colors.white10,
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
          radius: 20,
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
                CircleAvatar(
                  radius: 21,
                  backgroundImage: NetworkImage(
                    "http://182.156.200.177:8011${user.user.picture}",
                  ),
                ),
                id==user.user.id.toString()?const Text("You",style: TextStyle(fontSize: 12,color: AppColor.color,fontWeight: FontWeight.w500),):Text(user.user.name.split(' ')[0],style: const TextStyle(fontSize: 12),)
              ],
            ):
            Column(
              children: [
                Container(
                  height: 45,
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColor.color,),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.person,color: AppColor.color,size: 25,),
                  ),
                ),
                id==user.user.id.toString()?const Text("You",style: TextStyle(fontSize: 12,color: AppColor.color,fontWeight: FontWeight.w500),):Text(user.user.name.split(' ')[0],style: const TextStyle(fontSize: 12),)
              ],
            ):
            CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 30,
                child: Container(
               height: 3,
                      width: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                       borderRadius: BorderRadius.circular(10)
                      ),
                      )
                //Text('-')),
                        )
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

  bool isUserPrayerTimestampNull(List<Record> records, String userId, String prayerName) {
    // Loop through the records
    for (var record in records) {
      // Check if the user ID and prayer name match
      if (record.user.id.toString() == userId && record.prayerName == prayerName) {
        // Return true if user_timestamp is null
        return record.userTimestamp == null;
      }
    }
    // Return false if no matching record is found
    return false;
  }

}
