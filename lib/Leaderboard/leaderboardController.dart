import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:http/http.dart'as http;
import 'package:intl/intl.dart';
import 'package:namaz_reminders/Services/user_data.dart';
import '../AppManager/dialogs.dart';
import '../DashBoard/dashboardController.dart';
import '../DashBoard/timepickerpopup.dart';
import '../Services/ApiService/api_service.dart';
import 'leaderboardDataModal.dart';

class LeaderBoardController extends GetxController{

  UserData userData = UserData();
  final DashBoardController dashboardController = Get.find();
  final ApiService apiService = ApiService();
  final currentTime = DateFormat("HH:mm").format(DateTime.now());


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    updateIslamicDateBasedOnOption();
  }
  @override
  void onReady() {
    // TODO: implement onReady
    leaderboard(getFormattedDate());
    weeklyApi(getFormattedDate(daysBefore: 1));
    super.onReady();
  }
  @override
  void dispose() {
    Get.delete<LeaderBoardController>();
    super.dispose();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    Get.delete<LeaderBoardController>();
    Get.delete<DateController>();
    super.onClose();
  }

  RxString islamicDate = ''.obs;
  String getFormattedDate({int? daysBefore}) {
    // Get the current date and format it
    DateTime now = DateTime.now().subtract(Duration(days: daysBefore??0));
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    print("formattedDate$formattedDate");
    return formattedDate;
  }
  void updateIslamicDateBasedOnOption({DateTime? date}) {
    DateTime onlyDate  = date??DateTime.now();
    DateTime baseDate = DateTime(onlyDate.year, onlyDate.month, onlyDate.day);
    print("base # $baseDate");
    DateTime newDate;

    switch (userData.getUserData!.hijriAdj!) {
      case 0:
        newDate = baseDate;
        break;
      case 1:
        newDate = baseDate.add(Duration(days: 1));
        break;
      case 2:
        newDate = baseDate.add(Duration(days: 2));
        break;
      case 3:
        newDate = baseDate.subtract(Duration(days: 1));
        break;
      case 4:
        newDate = baseDate.subtract(Duration(days: 2));
        break;
      default:
        newDate = baseDate;
    }

    final hijriNewDate = HijriCalendar.fromDate(newDate); // Convert to Hijri date

    // Update the islamicDate value with the new Hijri date
    islamicDate.value =
    '${hijriNewDate.hDay} ${hijriNewDate.longMonthName} ${hijriNewDate.hYear}';
  }

  var selectedDate = DateTime.now().obs;
  // Method to update the selected date
  void updateSelectedDate(DateTime newDate) {
    selectedDate.value = newDate;
    updateIslamicDateBasedOnOption(date: newDate);
  }
  RxString selectedTab = 'Daily'.obs;
  String get getSelectedTab => selectedTab.value;
  set updateSelectedTab(String val){
    selectedTab.value = val;
    update();
  }


  leaderboard(formattedDate) async{
    print(getFormattedDate);
String formatDate = getFormattedDate();
    var request = http.Request('GET', Uri.parse('http://182.156.200.177:8011/adhanapi/prayer-response-friend/?user_id=${userData.getUserData!.id}&date=$formattedDate'));


    http.StreamedResponse response = await request.send();
    print(request.url);

    if (response.statusCode == 200) {
     // print(await response.stream.bytesToString());
      var decodeData = jsonDecode(await response.stream.bytesToString());
      print("decodeData $decodeData");
      // updateLeaderboardList = decodeData;
      getLeaderboardList.value= LeaderboardDataModal.fromJson(decodeData);
      print("getLeaderboardList $getLeaderboardList");
      // print("@@@@@@@@@@@@ "+getLeaderboardList.toString());
    }
    else {
      print(response.reasonPhrase);
    }

  }

  Map<String,dynamic> leaderboardList = {};
  // LeaderboardDataModal?  getLeaderboardList;
  var getLeaderboardList = Rxn<LeaderboardDataModal>();
  // var recordsList = Rxn<Record>();
  List<Record> recordsList = <Record>[].obs;
  set updateLeaderboardList(val){
    leaderboardList = val;
    update();
  }

  RxList weeklyRanked = [].obs;

  RxDouble height = 100.00.obs;
  double sizedBoxHeight(val){
    if(val.isEmpty){
      return 100;
    }
    return double.parse(val[0]['percentage'].toStringAsFixed(2));
  }

  weeklyApi(String formattedDate) async {
    String formatDate = getFormattedDate();

    var request = http.Request('GET', Uri.parse('http://182.156.200.177:8011/adhanapi/friend-weekly-prayer-response/?user_id=${userData.getUserData!.id}&date=$formattedDate'));

    http.StreamedResponse response = await request.send();
    print("URL ${request.url.toString()}");

    if (response.statusCode == 200) {
     // print(await response.stream.bytesToString());
      var data = jsonDecode(await response.stream.bytesToString());
      print("weekly baqar ${data['ranked_friends']}");
      if(data['ranked_friends'].isNotEmpty){
        // height.value= double.parse(data['ranked_friends'][0]['percentage'].toStringAsFixed(2));
      }
      height.value= sizedBoxHeight(data['ranked_friends']);
      weeklyRanked.value = data['ranked_friends'];
      print("decodeData $data");
      // updateLeaderboardList = decodeData;
      List recordData= data['records'];
      recordsList= recordData.map((e)=>Record.fromJson(e)).toList();
      print("recordList $recordsList");
      weeklyMissedPrayer.value = groupByDate(recordsList);
      update();
      print("WeeklyApi data check:$weeklyRanked");
    }
    else {
    print(response.reasonPhrase);
    }
  }

  final List<String> prayers = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
  final Map<String, String> prayerShortNames = {
    'Fajr': 'F',
    'Dhuhr': 'Z',
    'Asr': 'A',
    'Maghrib': 'M',
    'Isha': 'I'
  };
  RxMap<String, List<Record>> weeklyMissedPrayer=<String, List<Record>>{}.obs;
  // Group records by date
  Map<String, List<Record>> groupByDate(List<Record> records) {
    return records.fold<Map<String, List<Record>>>({}, (acc, record) {
      if (!acc.containsKey(record.date)) {
        acc[record.date] = [];
      }
      acc[record.date]?.add(record);
      return acc;
    });
  }

  bool isCurrentMonth(String dateString) {
    DateFormat format = DateFormat("dd-MM-yyyy");
    DateTime date = format.parse(dateString);
    DateTime now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  DateTime? getPrayerTime(List data,String date, String prayerName) {
    // Iterate over each entry in the data list
    for (var entry in data) {
      // Check if the date matches the given date in 'dd-MM-yyyy' format
      if (entry["date"]["gregorian"]["date"] == date) {
        // Retrieve the timing string for the specific prayer, if available
        String? prayerTime = entry["timings"][prayerName];

        if (prayerTime != null) {
          // Remove the "(IST)" timezone part and trim any whitespace
          String timeOnly = prayerTime.split(" ")[0];

          // Combine date and time into a single string in "dd-MM-yyyy HH:mm" format
          String dateTimeString = "$date $timeOnly";

          // Define the date-time format
          DateFormat format = DateFormat("dd-MM-yyyy HH:mm");

          // Parse and return the DateTime object
          return format.parse(dateTimeString);
        }
      }
    }
    // Return null if no matching date or prayer is found
    return null;
  }

  Map missedPrayerTimeData = {};

  Future<void> hitPrayerTimeByDate(String date,String prayerName,BuildContext contexts)async{
    print("apidate $date");
    Dialogs.showLoading(contexts,message: 'Please wait, Getting Prayer Time');
   var data =await apiService.getRequest("timings/$date?latitude=${userData.getLocationData!.latitude}&longitude=${userData.getLocationData!.longitude}&method=${userData.getUserData!.methodId}",customBaseUrl: 'https://api.aladhan.com/v1/');
   print("data $data");
   missedPrayerTimeData = data['data'];
   print("missedPrayerTimeData $missedPrayerTimeData");
    DateTime? prayerTime = getPrayerTime([missedPrayerTimeData],date,prayerName);
    Dialogs.hideLoading();
    if(contexts.mounted){
      showDialog(
        context: contexts,
        builder: (BuildContext context) {
          return   TimePicker(date: date, prayerNames: prayerName,isFromMissed: true,missedPrayerTime: prayerTime,
            missedCallBack:() {
              updateSelectedDate(DateFormat("dd-MM-yyyy").parse(date));
              return weeklyApi(date);
            },);
        },
      );
    }
  }


  void compareDates(DateTime selectedDate) {
    // Get current date
    DateTime currentDate = DateTime.now();

    // Strip the time part from both dates
    selectedDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    currentDate = DateTime(currentDate.year, currentDate.month, currentDate.day);

    // Compare the dates
    if (selectedDate.isAtSameMomentAs(currentDate)) {
      print("The selected date is the same as the current date.");
    } else {
      print("The selected date is not equal to the current date.");
    }
  }

}