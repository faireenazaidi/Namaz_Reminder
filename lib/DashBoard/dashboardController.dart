import 'dart:async';
import 'dart:convert';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import '../DataModels/CalendarDataModel.dart';
import 'package:http/http.dart' as http;

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
  RxList<String> avatars = <String>[].obs;

  var prayerNames = ['Fajr', 'Zuhr', 'Asar', 'Maghrib', 'Isha'].obs;
  var currentPrayerIndex = 0.obs;
  var isLoading = false.obs;
  List calendarData = [].obs;
  List<CalendarWiseData> extractedData = [];
  List prayerTimes = [].obs;
  Map<String, Map<String, String>> prayerDuration = {};

  Timer? prayerTimer;
  Timer? remainingTimeTimer;

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
          '${hijriDate?.day ?? "Day"} ${hijriDate?.month?.en ?? "Month"} ${hijriDate?.year ?? "Year"} (${hijriDate?.designation?.abbreviated ?? "Abbreviation"})';

          // Set prayer start and end time
          updatePrayerDuration = {
            'Fajr': {
              'start': convertTo12HourFormat(getExtractedData[0].timings?.fajr ?? 'N/A'),
              'end': convertTo12HourFormat(getExtractedData[0].timings?.sunrise ?? 'N/A')
            },
            'Zuhr': {
              'start': convertTo12HourFormat(getExtractedData[0].timings?.dhuhr ?? 'N/A'),
              'end': convertTo12HourFormat(getExtractedData[0].timings?.asr ?? 'N/A')
            },
            'Asar': {
              'start': convertTo12HourFormat(getExtractedData[0].timings?.asr ?? 'N/A'),
              'end': convertTo12HourFormat(getExtractedData[0].timings?.sunset ?? 'N/A')
            },
            'Maghrib': {
              'start': convertTo12HourFormat(getExtractedData[0].timings?.maghrib ?? 'N/A'),
              'end': convertTo12HourFormat(getExtractedData[0].timings?.isha ?? 'N/A')
            },
            'Isha': {
              'start': convertTo12HourFormat(getExtractedData[0].timings?.isha ?? 'N/A'),
              'end': convertTo12HourFormat(getExtractedData[0].timings?.midnight ?? 'N/A')
            }
          };
          // Get current time
          String currentTime = DateFormat('HH:mm').format(DateTime.now());
          // Get the current prayer based on the current time
          currentPrayer.value = getCurrentPrayer(prayerDuration, convertTo12HourFormat(currentTime));
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
  String getCurrentPrayer(Map<String, Map<String, String>> prayerDuration, String currentTime) {
    String currentPrayer = '';
    String startTime = '';
    String endTime = '';

    for (var prayer in prayerDuration.keys) {
      var times = prayerDuration[prayer]!;
      var prayerStartTime = times['start']!;
      var prayerEndTime = times['end']!;

      if (currentTime.compareTo(prayerStartTime) >= 0 &&
          currentTime.compareTo(prayerEndTime) <= 0) {
        currentPrayer = prayer;
        startTime = prayerStartTime;
        endTime = prayerEndTime;
        break; // Exit loop once the current prayer is found
      }
    }

    // Update the reactive variables
    this.currentPrayer.value = currentPrayer;
    this.currentPrayerStartTime.value = startTime;
    this.currentPrayerEndTime.value = endTime;

    return currentPrayer;
  }

  void highlightCurrentPrayer() {
    prayerTimer = Timer.periodic(Duration(minutes: 1), (timer) {
      DateTime now = DateTime.now();

      for (int i = 0; i < prayerTimes.length; i++) {
        DateTime prayerTime = DateFormat('hh:mm a').parse(prayerTimes[i]);

        if (now.isBefore(prayerTime)) {
          currentPrayerIndex.value = i;
          break;
        }
      }
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
    var endTime=currentPrayerEndTime.value;
    remainingTimeTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (currentPrayerStartTime.value.isNotEmpty && currentPrayerEndTime.value.isNotEmpty) {
        DateTime now = DateTime.now();
        print("Current Time: ${DateFormat('hh:mm a').format(now)}");
        print("Current Prayer End Time: ${currentPrayerEndTime.value}");

        // Parse end time
        try {
          DateTime endTime = DateFormat('hh:mm a').parse(currentPrayerEndTime.value);
          print("Parsed End Time: $endTime");

          // Calculate remaining time
          Duration remainingDuration = endTime.difference(now);

          if (remainingDuration.isNegative) {
            remainingTime.value = '0h 0m 0s';
          } else {
            remainingTime.value = formatDuration(remainingDuration);
          }
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
}
