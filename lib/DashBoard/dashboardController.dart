import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:namaz_reminders/Services/user_data.dart';
import '../DataModels/CalendarDataModel.dart';
import 'package:http/http.dart' as http;

import '../Leaderboard/leaderboardDataModal.dart';
import '../SplashScreen/splashController.dart';
import '../Widget/location_services.dart';
class DashBoardController extends GetxController {
  RxString islamicDate = ''.obs;
  RxInt rank = 0.obs;
  RxInt totalPeers = 1.obs;
  RxString currentPrayer = ''.obs;
  RxString currentPrayerStartTime = ''.obs;
  RxString currentPrayerEndTime = ''.obs;
  RxString remainingTime = '0h 0m 0s'.obs;
  RxString sunsetTime = ''.obs;
  RxString zawalTime = ''.obs;
  RxString nextPrayer = ''.obs;
  RxString nextPrayerStartTime = ''.obs;
  RxDouble progressPercent = 0.0.obs;
  RxList<String> avatars = <String>[].obs;
  RxString location = ''.obs;
  var selectedDate = Rx<DateTime>(DateTime.now());

  UserData userData = UserData();


  var prayerNames = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'].obs;
  var currentPrayerIndex = 0.obs;
  var nextPrayerIndex = 1.obs;
  var isLoading = false.obs;
  List calendarData = [].obs;
  List<CalendarWiseData> extractedData = [];
  List prayerTimes = [].obs;
  Map<String, Map<String, String>> prayerDuration = {};

  Timer? prayerTimer;
  Timer? remainingTimeTimer;

  void updateLocation(String newLocation) {
    location.value = newLocation;
  }

  set updateExtractedData(List<CalendarWiseData> data) {
    extractedData = data;
    update();
  }

  List<CalendarWiseData> get getExtractedData => extractedData;

  set updateCalendarData(List val) {
    calendarData = val;
    update();
  }

  List<CalendarWiseData> get getCalendarData => List<CalendarWiseData>.from(
      calendarData.map((element) => CalendarWiseData.fromJson(element)));

  set updatePrayerTimes(List val) {
    prayerTimes = val;
    update();
  }

  List get getPrayerTimes => prayerTimes;

  set updatePrayerDuration(Map<String, Map<String, String>> val) {
    prayerDuration = val;
    update();
  }

  final ScrollController scrollController = ScrollController();
  void scrollToHighlightedPrayer() {
    int nextPrayerIndex =  prayerNames.indexOf(nextPrayer.value);
    scrollController.animateTo(
      nextPrayerIndex * 80.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  LocationService _locationService = LocationService();
  Position? position;

  @override
  void onInit() async{
    super.onInit();
    highlightCurrentPrayer();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   scrollToHighlightedPrayer();
    // });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
    get();
  }

  get() async {
    position = await _locationService.getCurrentLocation();
    getIsPrayed();
    await fetchPrayerTime();
    leaderboard();
    scrollToHighlightedPrayer();
  }

  String convertTo12HourFormat(String time24) {
    try {
      DateTime parsedTime = DateFormat('HH:mm').parse(time24);
      return DateFormat('hh:mm a').format(parsedTime);
    } catch (e) {
      return time24;
    }
  }

  Future<void> fetchPrayerTime() async {
    final latitude = position!.latitude;
    final longitude = position!.longitude;
    final method = userData.getUserData!.methodId;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy/MM').format(now);
    // final method = 1;
    isLoading.value = true;
    // try {
      Uri uri = Uri.https(
        'api.aladhan.com',
        '/v1/calendar/$formattedDate',
        {
          'latitude': latitude.toString(),
          'longitude': longitude.toString(),
          'method': method.toString(),
        },
      );
      final response = await http.get(uri);
      log("checking response ${response.body}");

      if (response.statusCode == 200) {
        updateCalendarData = jsonDecode(response.body.toString())["data"];

        DateTime now = DateTime.now();
        DateFormat formatter = DateFormat('dd MMM yyyy');
        String formattedDate = formatter.format(now);

        List<CalendarWiseData> extractedData = getCalendarData
            .map((e) => e)
            .where((element) =>
        element.date!.readable.toString() == formattedDate.toString())
            .toList();
        updateExtractedData = extractedData;

        if (getExtractedData.isNotEmpty) {
          print("bbbbbbbb${extractedData.map((e)=>e.timings!.isha).toList()}");
          updatePrayerTimes = [
            convertTo12HourFormat(getExtractedData[0].timings?.fajr ?? 'N/A'),
            convertTo12HourFormat(getExtractedData[0].timings?.dhuhr ?? 'N/A'),
            convertTo12HourFormat(getExtractedData[0].timings?.asr ?? 'N/A'),
            convertTo12HourFormat(getExtractedData[0].timings?.maghrib ?? 'N/A'),
            convertTo12HourFormat(getExtractedData[0].timings?.isha ?? 'N/A'),
          ];
          // Update sunset and zawal times
          sunsetTime.value =
              convertTo12HourFormat(getExtractedData[0].timings?.sunset ?? 'N/A');
          zawalTime.value =
              convertTo12HourFormat(getExtractedData[0].timings?.zawal ?? 'N/A');
          final hijriDate = getExtractedData[0].date?.hijri;
          islamicDate.value =
          '${hijriDate?.day ?? "Day"} ${hijriDate?.month?.en ?? "Month"} ${hijriDate?.year ?? "Year"} ${hijriDate?.designation?.abbreviated ?? "Abbreviation"}';

          // Set prayer start and end time
          updatePrayerDuration = {
            'Fajr': {
              'start': getExtractedData[0].timings?.fajr ?? 'N/A',
              'end': getExtractedData[0].timings?.sunrise ?? 'N/A'
            },
            'Free': {
              'start': getExtractedData[0].timings?.sunrise ?? 'N/A',
              'end': getExtractedData[0].timings?.dhuhr ?? 'N/A'
            },
            'Dhuhr': {
              'start': (getExtractedData[0].timings?.dhuhr ?? 'N/A'),
              'end': (getExtractedData[0].timings?.asr ?? 'N/A')
            },
            'Asr': {
              'start': (getExtractedData[0].timings?.asr ?? 'N/A'),
              'end': (getExtractedData[0].timings?.sunset ?? 'N/A')
            },
            'Maghrib': {
              'start': (getExtractedData[0].timings?.maghrib ?? 'N/A'),
              'end': (getExtractedData[0].timings?.isha ?? 'N/A')
            },
            'Isha': {
              'start': (getExtractedData[0].timings?.isha ?? 'N/A'),
              // 'end': (getExtractedData[0].timings?.midnight ?? 'N/A')
              'end': ('23:59')
            }
          };
          // Get current time
          String currentTime = DateFormat('HH:mm').format(DateTime.now());
          currentPrayer.value = getCurrentPrayer(prayerDuration, currentTime);
          print('current time: $currentTime');
          print('Current Prayer Time: $currentPrayer');
          startRemainingTimeTimer();
          update();
        } else {
          print('Failed to load prayer data');
        }
      }
    // } catch (e) {
    //   print('Error: $e');
    // } finally {
    //   isLoading.value = false;
    // }
  }

  bool isPrayed = false;

  String getCurrentPrayer(Map<String, Map<String, String>> c, String currentTime) {
    String currentPrayer = '';
    String startTime = '';
    String endTime = '';
    bool foundCurrentPrayer = false;

    for (var prayer in prayerDuration.keys) {
      var times = prayerDuration[prayer]!;
      var prayerStartTime = times['start']!;
      var prayerEndTime = times['end']!;

      if (currentTime.compareTo(prayerStartTime) >= 0 &&
          currentTime.compareTo(prayerEndTime) <= 0) {
        currentPrayer = prayer;
        print("current parayer $currentPrayer");
        startTime = prayerStartTime;
        endTime = prayerEndTime;
        foundCurrentPrayer = true;
        break;
      }
    }

    if(currentPrayer=='Free'){
      nextPrayer.value= getNextPrayer(prayerDuration, currentTime); // Fetch next prayer
      print('Next prayer :$nextPrayer');
    }

    if (!foundCurrentPrayer) {
      nextPrayer.value= getNextPrayer(prayerDuration, currentTime); // Fetch next prayer
      print('Next prayer :$nextPrayer');
    }


    // Update the reactive variables
    this.currentPrayer.value = currentPrayer;
    this.currentPrayerStartTime.value = convertTo12HourFormat(startTime);
    this.currentPrayerEndTime.value = convertTo12HourFormat(endTime);

    isPrayed = getPrayedValue(currentPrayer);
    update(['lottie']);
    // print("ispadhi $ispadhi");

    return currentPrayer;
  }

  bool getPrayedValue(String prayerName) {
    print("prayer list**** $isPrayedList");
    for (var prayer in isPrayedList) {
      print("prayer name $prayerName");
      print("prayer name2 ${prayer['prayer_name']}");
      if (prayer['prayer_name'] == prayerName) {
        print("isPrayed ${prayer['prayer_name']}");
        return prayer['prayed'];
      }
    }
    print("out of loop");
    return false; // Return null if prayer name is not found
  }

  String getNextPrayer(Map<String, Map<String, String>> prayerDuration, String currentTime) {
    String nextPrayer = '';
    String nextPrayerStartTime = '';
    print("prayerDuration $prayerDuration");
    print("currentTime $currentTime");

    for (var prayer in prayerDuration.keys) {
      var times = prayerDuration[prayer]!;
      var prayerStartTime = times['start']!;

      // If the current time is before the start time of a prayer, it is the next prayer
      if (currentTime.compareTo(prayerStartTime) < 0) {
        nextPrayer = prayer;
        nextPrayerStartTime = prayerStartTime;
        break;
      }
    }

    // If no upcoming prayer was found, check if it's after Isha or Sunrise
    if (nextPrayer.isEmpty) {
      var ishaEndTime = prayerDuration['Isha']!['start']!;
      var sunriseTime = prayerDuration['Sunrise']!['start']!;

      if (currentTime.compareTo(ishaEndTime) >= 0) {
        // After Isha, the next prayer is Fajr
        nextPrayer = 'Fajr';
        nextPrayerStartTime = prayerDuration['Fajr']!['start']!;
      } else if (currentTime.compareTo(sunriseTime) >= 0) {
        // After Sunrise, the next prayer is Dhuhr
        nextPrayer = 'Dhuhr';
        nextPrayerStartTime = prayerDuration['Dhuhr']!['start']!;
      }
    }

    // Update the reactive variables for next prayer
    this.nextPrayer.value = nextPrayer;
    this.nextPrayerStartTime.value = convertTo12HourFormat(nextPrayerStartTime);

    return nextPrayer;
  }


  void highlightCurrentPrayer() {
    prayerTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      DateTime now = DateTime.now();
      DateTime start = DateTime(now.year, now.month, now.day, 5, 0); // Example start time
      DateTime end = DateTime(now.year, now.month, now.day, 18, 0); // Example end time
      if (now.isAfter(start) && now.isBefore(end)) {
        progressPercent.value = (now.difference(start).inMinutes / end.difference(start).inMinutes).clamp(0.0, 1.0);
      } else {
        progressPercent.value = 0.0; // Set to 0 if not within the range
      }
      scrollToHighlightedPrayer();
      update();
    });
  }
  @override
  void onClose() {
    prayerTimer?.cancel();
    remainingTimeTimer?.cancel();

    super.onClose();
  }

  // Updated startRemainingTimeTimer method with debugging and time formatting
  void startRemainingTimeTimer() {
    remainingTimeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentPrayerStartTime.value.isNotEmpty && currentPrayerEndTime.value.isNotEmpty) {
         try {
          // Current time
          DateTime now = DateTime.now();
          // Parse the end time string into a DateTime object
          DateTime endTime = DateFormat('hh:mm a').parse(currentPrayerEndTime.value);
          // Combine the end time with today's date to create a full DateTime object
          endTime = DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);
          // Calculate the remaining time
          Duration remainingDuration = endTime.difference(now);
          // Format and print the remaining time
          if (remainingDuration.isNegative) {
            // Stop the timer to prevent multiple executions
            timer.cancel();

            // End time has passed, move to the next prayer
            moveToNextPrayer(); // Transition to next prayer
          } else {
            remainingTime.value= formatDuration(remainingDuration);
          }
          //print("Remaining Time: ${remainingTime.value}");
        } catch (e) {
          print('Error parsing end time: $e');
        }
      }
    });
  }

  // Function to move to the next prayer
  void moveToNextPrayer() {
    String nextPrayerName = getNextPrayer(prayerDuration, DateFormat('HH:mm').format(DateTime.now()));
    currentPrayer.value = nextPrayerName;

    // Fetch next prayer timings
    var nextPrayerTimes = prayerDuration[nextPrayerName]!;
    currentPrayerStartTime.value = convertTo12HourFormat(nextPrayerTimes['start']!);
    currentPrayerEndTime.value = convertTo12HourFormat(nextPrayerTimes['end']!);

    // Restart the timer with new prayer times
    startRemainingTimeTimer(); // Restart timer after switching to next prayer
    print('Next prayer: $nextPrayerName');
  }


  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;
    return '${hours}h ${minutes}m ${seconds}s';
  }

  // Existing properties and methods
  //for percentage of circular indicator

  double calculateCompletionPercentage() {
  try {
    if (currentPrayerStartTime.value.isNotEmpty && currentPrayerEndTime.value.isNotEmpty) {
      DateTime now = DateTime.now();
  DateTime startTime = DateFormat('hh:mm a').parse(currentPrayerStartTime.value);
  DateTime endTime = DateFormat('hh:mm a').parse(currentPrayerEndTime.value);

  // Combine the times with today's date
  startTime = DateTime(now.year, now.month, now.day, startTime.hour, startTime.minute);
  endTime = DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);

  // Calculate total duration and elapsed duration
  Duration totalDuration = endTime.difference(startTime);
  Duration elapsedDuration = now.difference(startTime);

  // Calculate the percentage of completion
  double percentage = 0.0;
  if (elapsedDuration.isNegative) {
  // Prayer has not started yet
  percentage = 0.0;
  } else if (elapsedDuration > totalDuration) {
  // Prayer time is over
  percentage = 1.0;
  } else {
  percentage = elapsedDuration.inSeconds / totalDuration.inSeconds;
  }

  return percentage;
  }
  } catch (e) {
  print('Error calculating completion percentage: $e');
  }
  return 0.0;
  }
  RxBool prayedAtMosque = false.obs;
  var hour = 1;
  var minute = 0;


//   submitPrayer() async {
//     try {
//       var headers = {'Content-Type': 'application/json'};
//       var request = http.Request('POST', Uri.parse('http://172.16.61.15:8011/adhanapi/prayer-record/19-09-2024/'));
//
//       request.body = json.encode({
//         "user_id": userData.getUserData!.responseData!.user!.id.toString(),
//         "mobile_no": userData.getUserData!.responseData!.user!.mobileNo.toString(),
//         "latitude": latAndLong?.latitude.toString(),
//         "longitude": latAndLong?.longitude.toString(),
//         "timestamp": "$hour:$minute",
//         "jamat": prayedAtMosque.value.toString(),
//         "times_of_prayer": 5
//       });
// print(userData.getUserData!.responseData!.user!.id.toString());
//       request.headers.addAll(headers);
//
//       http.StreamedResponse response = await request.send();
//
//       if (response.statusCode == 200) {
//         var data = jsonDecode(await response.stream.bytesToString());
//         print("API RESPONSE: " + data.toString());
//
//         Get.snackbar('Success', data['detail'].toString(), snackPosition: SnackPosition.BOTTOM);
//       } else {
//         print('Failed with status code: ${response.statusCode}');
//         print('Reason: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

  bool isGifVisible = false;
  bool isAm = false;
  submitPrayer({String? valDate}) async {
    print("quad: ${latAndLong?.latitude}   ${latAndLong?.longitude}");
    DateTime date = DateTime.now();
    String formattedDate =valDate ?? DateFormat('dd-MM-yyyy').format(date);
    print("formattedDate $formattedDate");
    try {
      var headers = {'Content-Type': 'application/json'};

      // Use null-aware operators and default values
      var userId = userData.getUserData!.id.toString();
      var mobileNo = userData.getUserData!.mobileNo.toString();
      // var latitude = latAndLong!.latitude.toString() ?? '0.0';
      // var longitude = latAndLong!.longitude.toString() ?? '0.0';
      // var dataa = {
      //   "user_id": userId,
      //   "mobile_no": mobileNo,
      //   "latitude": position!.latitude,
      //   "longitude": position!.longitude,
      //   "timestamp": "$hour:$minute",
      //   "jamat": prayedAtMosque.value.toString(),
      //   "times_of_prayer": userData.getUserData!.timesOfPrayer.toString(),
      //   'prayed':true
      // };
      // print("########$dataa");
      // Convert hour to 24-hour format based on AM/PM
      if (!isAm && hour < 12) {
        hour += 12; // Convert to PM (24-hour format)
      } else if (isAm && hour == 12) {
        hour = 0; // Handle 12 AM as 00:00 in 24-hour format
      }

      // Create a DateTime object with the hour and minute
      DateTime time = DateTime(0, 1, 1, hour, minute);

      // Format it to 24-hour format
      String formattedTime = DateFormat('HH:mm').format(time);

      print("formattedTime $formattedTime"); // Output will be in 24-hour format, like 18:32 or 06:32

      var request = http.Request('POST', Uri.parse('http://182.156.200.177:8011/adhanapi/prayer-record/${formattedDate}/'));
      request.body = json.encode({
        "user_id": userId,
        "mobile_no": mobileNo,
        "latitude": position!.latitude,
        "longitude": position!.longitude,
        "timestamp":formattedTime, //"$hour:$minute",
        "jamat": prayedAtMosque.value.toString(),
        "times_of_prayer": userData.getUserData!.timesOfPrayer.toString(),
        'prayed':true
      });
      print("prayer-record ${request.body}");
      // print("User ID: $userId");
      // print("Mobile No: $mobileNo");
      // // print("Latitude: $latitude");
      // // print("Longitude: $longitude");
      // print("jamat: $jamatValue");
      // print("time: $hour:$minute");


      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      //print("API RESPONSE: " + await response.stream.bytesToString().toString());
      var data = jsonDecode(await response.stream.bytesToString());
      print("API RESPONSE: " + data['detail'].toString());
      isPrayed = true;
      isGifVisible = true;
      update();

      Future.delayed(Duration(seconds: 3), () {

          isGifVisible = false;
          update();

      });
      // Future.delayed(Duration(seconds: 6), () {
      //   Image.asset("assets/popup_Default.gif");
      //
      // });
      Get.back();
      // Get.snackbar('Success', data['detail'].toString(), snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.green);

    } catch (e) {
      print('Error: $e');
    }
  }

List isPrayedList = [];
  void updateIsPrayedList(val){
    isPrayedList = val;
    update();
  }
  Future<void> getIsPrayed() async{
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);

    var request = http.Request('GET', Uri.parse('http://182.156.200.177:8011/adhanapi/prayer-response/$formattedDate/?user_id=${userData.getUserData!.id.toString()}'));


    http.StreamedResponse response = await request.send();
    print(request.url);

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var decodeData = jsonDecode(await response.stream.bytesToString());
      print(decodeData);
      // updateLeaderboardList = decodeData['records'];
      updateIsPrayedList(decodeData['records']);
      print("@@@@@@@@@@@@ $isPrayedList");
    }
    else {
      print(response.reasonPhrase);
    }

  }

  var getLeaderboardList = Rxn<LeaderboardDataModal>();
  leaderboard() async{
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);

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

}



