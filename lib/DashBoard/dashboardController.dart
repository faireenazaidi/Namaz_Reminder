import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:namaz_reminders/Services/user_data.dart';
import '../DataModels/CalendarDataModel.dart';
import 'package:http/http.dart' as http;

import '../SplashScreen/splashController.dart';
class DashBoardController extends GetxController {
  RxString islamicDate = ''.obs;
  RxInt rank = 5.obs;
  RxInt totalPeers = 12.obs;
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
  RxString location = 'Lucknow'.obs;
  var selectedDate = Rx<DateTime>(DateTime.now());

  UserData userData = UserData();


  var prayerNames = ['Fajr', 'Zuhr', 'Asar', 'Maghrib', 'Isha'].obs;
  var currentPrayerIndex = 0.obs;
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

  @override
  void onInit() {
    super.onInit();
    highlightCurrentPrayer();
  }

  @override
  void onReady() {
    super.onReady();
    get();
  }

  get() async {
    await fetchPrayerTime();
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
    final latitude = 26.8664718;
    final longitude = 80.8654426;
    final method = 1;
    isLoading.value = true;
    try {
      Uri uri = Uri.https(
        'api.aladhan.com',
        '/v1/calendar/2024/9',
        {
          'latitude': latitude.toString(),
          'longitude': longitude.toString(),
          'method': method.toString(),
        },
      );
      final response = await http.get(uri);

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
            'Zuhr': {
              'start': (getExtractedData[0].timings?.dhuhr ?? 'N/A'),
              'end': (getExtractedData[0].timings?.asr ?? 'N/A')
            },
            'Asar': {
              'start': (getExtractedData[0].timings?.asr ?? 'N/A'),
              'end': (getExtractedData[0].timings?.sunset ?? 'N/A')
            },
            'Maghrib': {
              'start': (getExtractedData[0].timings?.maghrib ?? 'N/A'),
              'end': (getExtractedData[0].timings?.isha ?? 'N/A')
            },
            'Isha': {
              'start': (getExtractedData[0].timings?.isha ?? 'N/A'),
              'end': (getExtractedData[0].timings?.midnight ?? 'N/A')
            }
          };
          // Get current time
          String currentTime = DateFormat('HH:mm').format(DateTime.now());
          // Get the current prayer based on the current time
          currentPrayer.value = getCurrentPrayer(prayerDuration, currentTime);
          print('current time: $currentTime');
          print('Current Prayer Time: $currentPrayer');
          // Start the remaining time timer after prayer times are fetched
          startRemainingTimeTimer();
          update();
        } else {
          print('Failed to load prayer data');
        }
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Function to get the current prayer time
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
        startTime = prayerStartTime;
        endTime = prayerEndTime;
        foundCurrentPrayer = true;
        break;
      }
    }
    // If no current prayer is found (meaning the current prayer has ended),
    // fetch the next prayer and its start time
    if (!foundCurrentPrayer) {
      nextPrayer.value= getNextPrayer(prayerDuration, currentTime); // Fetch next prayer
      print('Next prayer :$nextPrayer');
    }


    // Update the reactive variables
    this.currentPrayer.value = currentPrayer;
    this.currentPrayerStartTime.value = convertTo12HourFormat(startTime);
    this.currentPrayerEndTime.value = convertTo12HourFormat(endTime);

    return currentPrayer;
  }

  String getNextPrayer(Map<String, Map<String, String>> prayerDuration, String currentTime) {
    String nextPrayer = '';
    String nextPrayerStartTime = '';

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
        // After Sunrise, the next prayer is Zuhr
        nextPrayer = 'Zuhr';
        nextPrayerStartTime = prayerDuration['Zuhr']!['start']!;
      }
    }

    // Update the reactive variables for next prayer
    this.nextPrayer.value = nextPrayer;
    this.nextPrayerStartTime.value = convertTo12HourFormat(nextPrayerStartTime);

    return nextPrayer;
  }


  void highlightCurrentPrayer() {
    prayerTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      // Example of how you might update progressPercent
      // Replace this with your actual logic
      DateTime now = DateTime.now();
      DateTime start = DateTime(now.year, now.month, now.day, 5, 0); // Example start time
      DateTime end = DateTime(now.year, now.month, now.day, 18, 0); // Example end time
      if (now.isAfter(start) && now.isBefore(end)) {
        progressPercent.value = (now.difference(start).inMinutes / end.difference(start).inMinutes).clamp(0.0, 1.0);
      } else {
        progressPercent.value = 0.0; // Set to 0 if not within the range
      }
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
            print('The end time has passed.');
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
  // Ensure that both start and end times are available
  if (currentPrayerStartTime.value.isNotEmpty && currentPrayerEndTime.value.isNotEmpty) {
  // Parse the start and end time strings into DateTime objects
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
  return 0.0; // Default to 0% in case of error
  }
  RxBool prayedAtMosque = false.obs;
  var hour = 1;
  var minute = 0;


  submitPrayer() async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://182.156.200.177:8011/adhanapi/prayer-record/19-09-2024/'));
    request.body = json.encode({
      "user_id": userData.getUserData!.responseData!.user!.id.toString(),
      "mobile_no": userData.getUserData!.responseData!.user!.mobileNo.toString(),
      "latitude": latAndLong?.latitude.toString(),
      "longitude": latAndLong?.longitude.toString(),
      "timestamp": "$hour:$minute",
      "jamat": prayedAtMosque.value.toString(),
      "times_of_prayer": 5
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var data = jsonDecode(await response.stream.bytesToString());
      print("APIRESPONSE "+data.toString());
      Get.snackbar('Error', data['detail'].toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
    else {
    print(response.reasonPhrase);
    }

  }




  }



