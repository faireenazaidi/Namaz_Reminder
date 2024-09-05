import 'dart:convert';

import 'package:get/get.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:namaz_reminders/DataModels/CalendarDataModel.dart';

class DashBoardController extends GetxController {
  // Leaderboard related variables
  RxInt rank = 5.obs;
  RxInt totalPeers = 12.obs;
  RxList<String> avatars = <String>[
    'https://example.com/avatar1.png',
    'https://example.com/avatar4.png',
    'https://example.com/avatar1.png',
    'https://example.com/avatar4.png',
    'https://example.com/avatar5.png',
    'https://example.com/avatar6.png',
    'https://example.com/avatar7.png',
  ].obs;




  // Observable list for prayer names and times
  var prayerNames = ['Fajr', 'Zuhr', 'Asar', 'Maghrib', 'Isha'].obs;
  //var prayerTimes = ['05:30 AM', '12:24 PM', '04:55 PM', '06:53 PM', '07:50 PM'].obs;

  var currentPrayerIndex = 0.obs;
  var isLoading = false.obs;

  List calendarData = [].obs;
  set updateCalendarData(List val){
    calendarData = val;
    update();
  }

  List<CalendarWiseData> get getCalendarData => List<CalendarWiseData>.from(
      calendarData.map((element)=>CalendarWiseData.fromJson(element))
  );


  Timer? prayerTimer;
  var prayerTimes=[];
  @override
  void onInit() {
    super.onInit();
    highlightCurrentPrayer();
    // fetchPrayerTime();
    // Automatically highlight current prayer based on time
  }

  @override
  void onReady()
  {
    super.onReady();
    fetchPrayerTime();
  }

//get the prayer time list
//   Future<void> fetchPrayerTime() async {
//     final latitude=26.8664718;
//     final longitude=80.8654426;
//     final method=1;
//
//     isLoading.value = true;
//
//     try {
//        Uri uri = Uri.https(
//         'api.aladhan.com',
//         '/v1/calendar/2024/9',
//         {
//           'latitude': latitude.toString(),
//           'longitude': longitude.toString(),
//           'method': method.toString(),
//         },
//       );
//       final response = await http.get(uri);
//       print("LINK ${response.request!.url}");
//
//       print('API RESPONSE @@@ : ${response.body}');
//       if (response.statusCode == 200) {
//         print("JSON DECODED RESPONSE ${jsonDecode(response.body.toString())["data"]}");
//         updateCalendarData = jsonDecode(response.body.toString())["data"];
//         print("GETTER DATA ${getCalendarData[0].timings!.fajr.toString()}");
//         DateTime now = DateTime.now();
//         DateFormat formatter = DateFormat('dd MMM yyyy');
//         String formattedDate = formatter.format(now);
//         List<CalendarWiseData> extractedData = getCalendarData.map((element)=> element).where((e)=> e.date!.readable.toString() == formattedDate.toString()).toList();
//         print("EXTRACTED DATA ${extractedData[0].timings!.fajr}");
//       } else {
//         print('Failed to load prayer data');
//       }
//     } catch (e) {
//       print('Error: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }

  //new
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
      print("LINK ${response.request!.url}");

      print('API RESPONSE @@@ : ${response.body}');
      if (response.statusCode == 200) {
        print("JSON DECODED RESPONSE ${jsonDecode(response.body.toString())["data"]}");

        // Decode the API response
        List<dynamic> jsonData = jsonDecode(response.body.toString())["data"];

        // Get today's date and format it as required
        DateTime now = DateTime.now();
        DateFormat formatter = DateFormat('dd MMM yyyy');
        String formattedDate = formatter.format(now);

        // Filter data for the specific date
        List<CalendarWiseData> filteredData = jsonData
            .map((element) => CalendarWiseData.fromJson(element))
            .where((e) => e.date?.readable == formattedDate)//current date data
            .toList();

        // Update calendar data
        updateCalendarData = filteredData;

        // Print the specific day's prayer times
        // fefjebnf5965fesf
        if (filteredData.isNotEmpty) {

          prayerTimes = [
            _convertTo12HourFormat(filteredData[0].timings?.fajr ?? 'N/A') ,
            _convertTo12HourFormat(filteredData[0].timings?.dhuhr ?? 'N/A'),
            _convertTo12HourFormat(filteredData[0].timings?.asr ?? 'N/A'),
            _convertTo12HourFormat(filteredData[0].timings?.maghrib ?? 'N/A'),
            _convertTo12HourFormat(filteredData[0].timings?.isha ?? 'N/A')
          ];
          //new comment
          //print("Filtered Data ${filteredData[0].timings?.fajr}");
          print("Filtered Data ${prayerTimes}");
        } else {
          print("No data available for the date $formattedDate");
        }
      } else {
        print('Failed to load prayer data');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
  String _convertTo12HourFormat(String time24) {
    try {
      // Parse 24-hour time format
      DateTime parsedTime = DateFormat('HH:mm').parse(time24);
      // Convert to 12-hour time format
      return DateFormat('hh:mm a').format(parsedTime);
    } catch (e) {
      // If parsing fails, return the original time
      return time24;
    }
  }

  @override
  void onClose() {
    prayerTimer?.cancel();
    // Cancel timer when controller is disposed
    super.onClose();
  }


  // Function to dynamically highlight the current prayer based on system time
  void highlightCurrentPrayer() {
    prayerTimer = Timer.periodic(Duration(minutes: 1), (timer) {
      DateTime now = DateTime.now();

      // Parse prayer times and compare with current time
      for (int i = 0; i < prayerTimes.length; i++) {
        DateTime prayerTime = DateFormat('hh:mm a').parse(prayerTimes[i]);

        if (now.isBefore(prayerTime)) {
          currentPrayerIndex.value = i;
          // Set the next prayer as the current one
          break;
        }
      }
    });
  }

  // Function to update leaderboard data
  void updateLeaderboard(int newRank, int newTotalPeers, List<String> newAvatars) {
    rank.value = newRank;
    totalPeers.value = newTotalPeers;
    avatars.value = newAvatars;
  }
}