import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:namaz_reminders/Services/user_data.dart';
import '../DataModels/CalendarDataModel.dart';
import 'package:http/http.dart' as http;

import '../DataModels/LoginResponse.dart';
import '../Leaderboard/leaderboardDataModal.dart';
import '../Services/notification_service.dart';
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
  String address= '';
  set updateAddress(String val){
    address =val;
    update(['add']);
  }
  Future<bool> changeLocation()async{
     position= await LocationService().getCurrentLocation();
     print("new llllllllll${position!.latitude.toString()}");
     print("new llllllllllll${position!.longitude.toString()}");
     updateAddress = await _locationService.getAddressFromCoordinates(position!);
     final locationData=LocationDataModel(latitude: position!.latitude.toString(),longitude: position!.longitude.toString(),address: address);
     userData.addLocationData(locationData);
     print("new uuuuuuuuuuuuuuuuuuu${userData.getLocationData!.latitude.toString()}");
     return true;
  }

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
    if(userData.getLocationData==null){
      print("annnnder");
      print("userData ander ${userData.getLocationData?.toJson()}");
      position = await _locationService.getCurrentLocation();
      print("llllllllll${position!.latitude.toString()}");
      print("llllllllllll${position!.longitude.toString()}");
      updateAddress = await _locationService.getAddressFromCoordinates(position!);
      final locationData=LocationDataModel(latitude: position!.latitude.toString(),longitude: position!.longitude.toString(),address: address);
      userData.addLocationData(locationData);
      print("uuuuuuuuuuuuuuuuuuu${userData.getLocationData!.latitude.toString()}");
    }
    else{
      print("baaaaaaahar");
      print("userData bahar ${userData.getLocationData?.toJson()}");
      updateAddress = userData.getLocationData!.address!;
    }
    print("address $address");
    print("lat ${userData.getLocationData!.latitude}");
    getIsPrayed();
    await fetchPrayerTime();
    leaderboard();
    scrollToHighlightedPrayer();
    updateIslamicDateBasedOnOption(userData.getUserData!.hijriAdj!);
  }

  String convertTo12HourFormat(String time24) {
    try {
      DateTime parsedTime = DateFormat('HH:mm').parse(time24);
      return DateFormat('hh:mm a').format(parsedTime);
    } catch (e) {
      return time24;
    }
  }

  Future<void> fetchPrayerTime({DateTime? specificDate}) async {
    final latitude =position!=null? position!.latitude:double.parse(userData.getLocationData!.latitude.toString());
    final longitude =position!=null? position!.longitude:double.parse(userData.getLocationData!.longitude.toString());
    print("latitude $latitude");
    print("longitude $longitude");
    final method = userData.getUserData!.methodId;
    DateTime now =specificDate?? DateTime.now();
    String formattedDate = DateFormat('yyyy/MM').format(now);

    isLoading.value = true;
    print("hhhhhhh"+formattedDate);

    try {
      Uri uri = Uri.https(
        'api.aladhan.com',
        '/v1/calendar/$formattedDate',
        {
          'latitude': latitude.toString(),
          'longitude': longitude.toString(),
          'method': method.toString(),
        },

      );
      print("ff"+latitude.toString());
      print("zz"+ method.toString());
      final response = await http.get(uri);
      log("API Response: ${response.body}");
      if (response.statusCode == 200) {
        // Decode the data
        updateCalendarData = jsonDecode(response.body.toString())["data"];

       // DateTime now = DateTime.now();
        DateTime now=specificDate??DateTime.now();
        DateFormat formatter = DateFormat('dd MMM yyyy');
        String formattedDate = formatter.format(now);

        // Extract current day's data
        List<CalendarWiseData> extractedData = getCalendarData
            .map((e) => e)
            .where((element) =>
        element.date!.readable.toString() == formattedDate.toString())
            .toList();
        updateExtractedData = extractedData;

        if (getExtractedData.isNotEmpty) {
          print("Isha Time: ${extractedData.map((e) => e.timings!.isha).toList()}");

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
              'start': getExtractedData[0].timings?.dhuhr ?? 'N/A',
              'end': getExtractedData[0].timings?.asr ?? 'N/A'
            },
            'Asr': {
              'start': getExtractedData[0].timings?.asr ?? 'N/A',
              'end': getExtractedData[0].timings?.maghrib ?? 'N/A'
            },
            'Maghrib': {
              'start': getExtractedData[0].timings?.maghrib ?? 'N/A',
              'end': getExtractedData[0].timings?.isha ?? 'N/A'
            },
            'Isha': {
              'start': getExtractedData[0].timings?.isha ?? 'N/A',
              'end': '23:59'
            }
          };

          // Get current time
          String currentTime = DateFormat('HH:mm').format(DateTime.now());
          currentPrayer.value = getCurrentPrayer(prayerDuration, currentTime);

          print('Current time: $currentTime');
          print('Current Prayer: $currentPrayer');

          // Start timer for remaining time
          startRemainingTimeTimer();
          update();
        } else {
          print('No data found for current date.');
        }
      } else {
        print('Error fetching prayer times. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }


  // Future<void> fetchPrayerTime() async {
  //   final latitude = position!.latitude;
  //   final longitude = position!.longitude;
  //   final method = userData.getUserData!.methodId;
  //   DateTime now = DateTime.now();
  //   String formattedDate = DateFormat('yyyy/MM').format(now);
  //   // final method = 1;
  //   isLoading.value = true;
  //   // try {
  //     Uri uri = Uri.https(
  //       'api.aladhan.com',
  //       '/v1/calendar/$formattedDate',
  //       {
  //         'latitude': latitude.toString(),
  //         'longitude': longitude.toString(),
  //         'method': method.toString(),
  //       },
  //     );
  //     final response = await http.get(uri);
  //     log("checking response ${response.body}");
  //
  //     if (response.statusCode == 200) {
  //       updateCalendarData = jsonDecode(response.body.toString())["data"];
  //
  //       DateTime now = DateTime.now();
  //       DateFormat formatter = DateFormat('dd MMM yyyy');
  //       String formattedDate = formatter.format(now);
  //
  //       List<CalendarWiseData> extractedData = getCalendarData
  //           .map((e) => e)
  //           .where((element) =>
  //       element.date!.readable.toString() == formattedDate.toString())
  //           .toList();
  //       updateExtractedData = extractedData;
  //
  //       if (getExtractedData.isNotEmpty) {
  //         print("bbbbbbbb${extractedData.map((e)=>e.timings!.isha).toList()}");
  //         updatePrayerTimes = [
  //           convertTo12HourFormat(getExtractedData[0].timings?.fajr ?? 'N/A'),
  //           convertTo12HourFormat(getExtractedData[0].timings?.dhuhr ?? 'N/A'),
  //           convertTo12HourFormat(getExtractedData[0].timings?.asr ?? 'N/A'),
  //           convertTo12HourFormat(getExtractedData[0].timings?.maghrib ?? 'N/A'),
  //           convertTo12HourFormat(getExtractedData[0].timings?.isha ?? 'N/A'),
  //         ];
  //         // Update sunset and zawal times
  //         sunsetTime.value =
  //             convertTo12HourFormat(getExtractedData[0].timings?.sunset ?? 'N/A');
  //         zawalTime.value =
  //             convertTo12HourFormat(getExtractedData[0].timings?.zawal ?? 'N/A');
  //         final hijriDate = getExtractedData[0].date?.hijri;
  //         islamicDate.value =
  //         '${hijriDate?.day ?? "Day"} ${hijriDate?.month?.en ?? "Month"} ${hijriDate?.year ?? "Year"} ${hijriDate?.designation?.abbreviated ?? "Abbreviation"}';
  //
  //         // Set prayer start and end time
  //         updatePrayerDuration = {
  //           'Fajr': {
  //             'start': getExtractedData[0].timings?.fajr ?? 'N/A',
  //             'end': getExtractedData[0].timings?.sunrise ?? 'N/A'
  //           },
  //           'Free': {
  //             'start': getExtractedData[0].timings?.sunrise ?? 'N/A',
  //             'end': getExtractedData[0].timings?.dhuhr ?? 'N/A'
  //           },
  //           'Dhuhr': {
  //             'start': (getExtractedData[0].timings?.dhuhr ?? 'N/A'),
  //             'end': (getExtractedData[0].timings?.asr ?? 'N/A')
  //           },
  //           'Asr': {
  //             'start': (getExtractedData[0].timings?.asr ?? 'N/A'),
  //             'end': (getExtractedData[0].timings?.sunset ?? 'N/A')
  //           },
  //           'Maghrib': {
  //             'start': (getExtractedData[0].timings?.maghrib ?? 'N/A'),
  //             'end': (getExtractedData[0].timings?.isha ?? 'N/A')
  //           },
  //           'Isha': {
  //             'start': (getExtractedData[0].timings?.isha ?? 'N/A'),
  //             // 'end': (getExtractedData[0].timings?.midnight ?? 'N/A')
  //             'end': ('23:59')
  //           }
  //         };
  //         // Get current time
  //         String currentTime = DateFormat('HH:mm').format(DateTime.now());
  //         currentPrayer.value = getCurrentPrayer(prayerDuration, currentTime);
  //         print('current time: $currentTime');
  //         print('Current Prayer Time: $currentPrayer');
  //         startRemainingTimeTimer();
  //         update();
  //       } else {
  //         print('Failed to load prayer data');
  //       }
  //     }
  //   // } catch (e) {
  //   //   print('Error: $e');
  //   // } finally {
  //   //   isLoading.value = false;
  //   // }
  // }

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
      print("TIMES !!@# $times");
      var prayerStartTime = times['start']!;
      print("PRAYER START TIME $prayerStartTime");

      // If the current time is before the start time of a prayer, it is the next prayer
      if (currentTime.compareTo(prayerStartTime) < 0 || currentTime.compareTo(prayerStartTime) == 0) {
        nextPrayer = prayer;
        print("NEXT PRAYER !@# $nextPrayer");
        nextPrayerStartTime = prayerStartTime;
        break;
      }
    }

    // If no upcoming prayer was found, check if it's after Isha or Sunrise
    if (nextPrayer.isEmpty) {
      var ishaEndTime = prayerDuration['Isha']!['end']!;
      var sunriseTime = prayerDuration['Sunrise']!['start']!;

      if (currentTime.compareTo(ishaEndTime) >= 0 ||currentTime.compareTo(ishaEndTime) == 0) {
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
    // this.nextPrayer.value = nextPrayer;
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
  bool isNotificationSent = false;
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
          print("endTime $endTime");
          // Schedule a reminder notification exactly 10 minutes before the current prayer ends
          // if (remainingDuration.inMinutes == 10 && !isNotificationSent) {
          //   // Send the notification only once
          //   AwesomeNotificationService().showNotification(
          //     title: "Reminder: ${nextPrayer.value}",
          //     body: "${nextPrayer.value} prayer starts in 10 minutes.",
          //     channelKey: 'important_channel',
          //   );
          //   isNotificationSent = true; // Set the flag to true to prevent further notifications
          // }
          // Format and print the remaining time
          if (remainingDuration.isNegative) {
            // Reset the flag for the next prayer
            isNotificationSent = false;
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
    isPrayed = false;
    String nextPrayerName = getNextPrayer(prayerDuration, DateFormat('HH:mm').format(DateTime.now()));
    print('Next prayer: $nextPrayerName');
    currentPrayer.value = nextPrayerName;
    // Fetch next prayer timings
    var nextPrayerTimes = prayerDuration[nextPrayerName]!;
    currentPrayerStartTime.value = convertTo12HourFormat(nextPrayerTimes['start']!);
    currentPrayerEndTime.value = convertTo12HourFormat(nextPrayerTimes['end']!);

    // Convert next prayer start time to DateTime
    // DateTime nextPrayerTime = DateFormat('hh:mm a').parse(nextPrayerTimes['start']!);

      AwesomeNotificationService().showNotification(
        title: "Reminder: $nextPrayerName",
        body: "$nextPrayerName prayer started",
        channelKey: 'important_channel',
      );

    // Restart the timer with new prayer times
    startRemainingTimeTimer(); // Restart timer after switching to next prayer
    print('Next prayer2: $nextPrayerName');
  }
  // Future<void> moveToNextPrayer() async {
  //   // Get the next prayer based on the current time
  //   String nextPrayerName = getNextPrayer(
  //       prayerDuration,
  //       DateFormat('HH:mm').format(DateTime.now())
  //   );
  //
  //   // If the current time is past Isha and the next prayer is Fajr, it's the end of the day
  //   if (nextPrayerName == 'Fajr' && DateTime.now().hour >= 0) {
  //     // Fetch next day's prayer timings
  //     await fetchPrayerTime(specificDate: DateTime.now().add(Duration(days: 1)));
  //
  //     // Recalculate the next prayer after fetching new timings
  //     nextPrayerName = getNextPrayer(
  //         prayerDuration,
  //         DateFormat('HH:mm').format(DateTime.now())
  //     );
  //   }
  //
  //   // Safety check: Ensure that the next prayer exists in the prayerDuration map
  //   if (prayerDuration.containsKey(nextPrayerName)) {
  //     // Update the current prayer details
  //     currentPrayer.value = nextPrayerName;
  //
  //     var nextPrayerTimes = prayerDuration[nextPrayerName]!;
  //
  //     // Update start and end times for the next prayer
  //     currentPrayerStartTime.value = convertTo12HourFormat(nextPrayerTimes['start']!);
  //     currentPrayerEndTime.value = convertTo12HourFormat(nextPrayerTimes['end']!);
  //
  //     // Also update the next prayer that comes after the current prayer
  //     nextPrayer.value = getNextPrayer(prayerDuration, currentPrayerEndTime.value);
  //
  //     // Restart the timer for the new prayer
  //     startRemainingTimeTimer();
  //     print('Next prayer: $nextPrayerName');
  //     print('Upcoming prayer: ${nextPrayer.value}');
  //   } else {
  //     print('Error: Next prayer not found in prayerDuration map.');
  //   }
  // }

  // void moveToNextPrayer() async {
  //   String nextPrayerName = getNextPrayer(prayerDuration, DateFormat('HH:mm').format(DateTime.now()));
  //
  //   // If the current time is past Isha and it's the end of the day, fetch next day's timings
  //   if (nextPrayerName == 'Fajr' && DateTime.now().hour >= 0) {
  //     await fetchPrayerTime(); // Fetch the next day's prayer timings
  //     // nextPrayerName = getNextPrayer(prayerDuration, DateFormat('HH:mm').format(DateTime.now())); // Recheck next prayer
  //   }
  //
  //   // Update current prayer details
  //   currentPrayer.value = nextPrayerName;
  //
  //   var nextPrayerTimes = prayerDuration[nextPrayerName]!;
  //   currentPrayerStartTime.value = convertTo12HourFormat(nextPrayerTimes['start']!);
  //   currentPrayerEndTime.value = convertTo12HourFormat(nextPrayerTimes['end']!);
  //
  //   // Restart the timer for the new prayer time
  //   startRemainingTimeTimer();
  //   print('Next prayer: $nextPrayerName');
  // }



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
        "latitude": position!=null? position!.latitude:double.parse(userData.getLocationData!.latitude.toString()),
        "longitude": position!=null? position!.longitude:double.parse(userData.getLocationData!.longitude.toString()),
        "timestamp":formattedTime, //"$hour:$minute",
        "jamat": prayedAtMosque.value.toString(),
        "times_of_prayer": userData.getUserData!.timesOfPrayer.toString(),
        'prayed':true
      });
      print("URL ${request.url}");
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
      // var data = jsonDecode(await response.stream.bytesToString());
      // print("API RESPONSE: " + data['detail'].toString());
      String responseString = await response.stream.bytesToString();
      // print("Raw API response: $responseString");

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

  Rxn<LeaderboardDataModal>  getLeaderboardList = Rxn<LeaderboardDataModal>();
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
      update(['leader']);
    }
    else {
      print(response.reasonPhrase);
    }

  }
  void updateIslamicDateBasedOnOption(int id) {
    final hijriDate = getExtractedData[0].date?.hijri;
    DateTime onlyDate  = DateTime.now();
    DateTime baseDate = DateTime(onlyDate.year, onlyDate.month, onlyDate.day);
    print("base # $baseDate");
    DateTime newDate;

    switch (id) {
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

  // New method to get all prayer times including Zawal, sunset, and sunrise

  Map<String, Map<String, String>> getAllPrayerTimes() {
  // Initialize a map to hold the prayer times
  Map<String, Map<String, String>> allPrayerTimes = {};

  // Add prayer times to the map
  allPrayerTimes['Fajr'] = {
  'start': convertTo12HourFormat(prayerDuration['Fajr']?['start'] ?? 'N/A'),
  'end': convertTo12HourFormat(prayerDuration['Fajr']?['end'] ?? 'N/A'),
  };
  allPrayerTimes['Dhuhr'] = {
  'start': convertTo12HourFormat(prayerDuration['Dhuhr']?['start'] ?? 'N/A'),
  'end': convertTo12HourFormat(prayerDuration['Dhuhr']?['end'] ?? 'N/A'),
  };
  allPrayerTimes['Asr'] = {
  'start': convertTo12HourFormat(prayerDuration['Asr']?['start'] ?? 'N/A'),
  'end': convertTo12HourFormat(prayerDuration['Asr']?['end'] ?? 'N/A'),
  };
  allPrayerTimes['Maghrib'] = {
  'start': convertTo12HourFormat(prayerDuration['Maghrib']?['start'] ?? 'N/A'),
  'end': convertTo12HourFormat(prayerDuration['Maghrib']?['end'] ?? 'N/A'),
  };
  allPrayerTimes['Isha'] = {
  'start': convertTo12HourFormat(prayerDuration['Isha']?['start'] ?? 'N/A'),
  'end': convertTo12HourFormat(prayerDuration['Isha']?['end'] ?? 'N/A'),
  };
  allPrayerTimes['Zawal'] = {
  'time': zawalTime.value, // Assuming zawalTime is already set
  };
  allPrayerTimes['Sunrise'] = {
  'time': convertTo12HourFormat(getExtractedData[0].timings?.sunrise ?? 'N/A'),
  };
  allPrayerTimes['Sunset'] = {
  'time': sunsetTime.value, // Assuming sunsetTime is already set
  };

  return allPrayerTimes;
  }
}



