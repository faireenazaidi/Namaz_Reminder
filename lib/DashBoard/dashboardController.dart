import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:namaz_reminders/Services/user_data.dart';
import 'package:namaz_reminders/Setting/SettingController.dart';
import '../AppManager/dialogs.dart';
import '../DataModels/CalendarDataModel.dart';
import 'package:http/http.dart' as http;
import '../DataModels/LoginResponse.dart';
import '../Leaderboard/leaderboardDataModal.dart';
import '../Notification/NotificationSetting/notificationSettingController.dart';
import '../Services/ApiService/api_service.dart';
import '../Widget/appColor.dart';
import '../Widget/location_services.dart';
import '../Widget/myButton.dart';
import '../Widget/no_internet.dart';
import '../main.dart';
class DashBoardController extends GetxController {
  final PageController pageController = PageController();
  Rx<TextEditingController> locationController = TextEditingController().obs;
  final SettingController settingController = Get.put(SettingController());
  final NotificationSettingController notificationSettingController = Get.put(NotificationSettingController());

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
  String trackMarkPrayer = '';
  var missedPrayersCount = 0.obs;
  var pending = 0.obs;
  var selectedDate = Rx<DateTime>(DateTime.now());
  var isMute= false.obs;
  // final AudioPlayer audioPlayer = AudioPlayer();
  var prayerMuteStates = <String, bool>{}.obs;
  var muteStates = <String, RxBool>{}.obs;
  UserData userData = UserData();
  //
  void toggle(String prayerName){
    userData.toggleSound(prayerName);
    isMute.value = userData.isSoundEnabled(prayerName);
    // isMute.value = !isMute.value;
  }


  void toggleMute(String prayerName) {
    // Toggle the mute state for the specific prayer
    prayerMuteStates[prayerName] = !(prayerMuteStates[prayerName] ?? false);
  }

  Future<void> onRefresh() async {
    await get();
    // Simulate a network call or refresh logic

  }

  // String convertTime(String time) {
  //   if (time.isEmpty) {
  //     return "Invalid time input";
  //   }
  //   try {
  //     if (settingController.timeFormat == true) {
  //       // Convert 12-hour to 24-hour
  //
  //       final DateTime dateTime = DateFormat("hh:mm a").parse(time);
  //       return DateFormat("HH:mm").format(dateTime);
  //     }
  //     else {
  //       // Convert 24-hour to 12-hour
  //
  //       final DateTime dateTime = DateFormat("HH:mm").parse(time);
  //       return DateFormat("hh:mm a").format(dateTime); // AM/PM included
  //     }
  //   }
  //   catch (e)
  //   {
  //     return "Error: Unable to parse time";
  //   }
  // }

  String convertTime(String time) {
    if (time.isEmpty) {
      return " ";
    }
    try {
      if (notificationSettingController.timeFormat == true) {
        // Convert 12-hour to 24-hour
        final DateTime dateTime = DateFormat("hh:mm a").parse(time); // 12-hour format
        String convertedTime = DateFormat("HH:mm ").format(dateTime); // 24-hour format
        print("12-hour Input: $time, 24-hour Output: $convertedTime");
        return convertedTime;
      } else {
        return time;
      }
    }
    catch (e) {
      print("Error parsing time: $time, Exception: $e");
      return "Error: Unable to parse time";
    }
  }

  var prayerNames = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'].obs;
  var upcomingPrayers = [
    'Fajr',
    'Sunrise',
    'Zawal',
    'Dhuhr',
    'Asr',
    'Sunset',
    'Maghrib',
    'Isha'
  ].obs;

  var currentPrayerIndex = 0.obs;
  RxInt nextPrayerIndex = 1.obs;
  var isLoading = false.obs;
  List calendarData = [].obs;
  List<CalendarWiseData> extractedData = [];
  List prayerTimes = [].obs;
  List upcomingPrayerTimes = [].obs;
  Map<String, Map<String, String>> prayerDuration = {};
  Map<String, Map<String, String>> upcomingPrayerDuration = {};


  Timer? prayerTimer;
  Timer? remainingTimeTimer;

  RxString locationName = "".obs;
  void updateLocation(LocationDataModel location) {
    updateAddress = location.address.toString();
    userData.addLocationData(location);
    clearTimingFromStorage();
    // fetchPrayerTime();
    // location.value = newLocation;
    // locationName.value = location.value;
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

  List<CalendarWiseData> get getCalendarData =>
      List<CalendarWiseData>.from(
          calendarData.map((element) => CalendarWiseData.fromJson(element)));

  set updatePrayerTimes(List val) {
    prayerTimes = val;
    update();
  }

// set prayer times for upcoming prayers
  set updateUpcomingPrayers(List val) {
    upcomingPrayerTimes = val;
    update();
  }

  List get getUpcomingPrayerTimes => upcomingPrayerTimes;

  List get getPrayerTimes => prayerTimes;

  set updatePrayerDuration(Map<String, Map<String, String>> val) {
    prayerDuration = val;
    update();
  }

  set updateUpcomingPrayerDuration(Map<String, Map<String, String>> val) {
    upcomingPrayerDuration = val;
    update();
  }
  final ScrollController scrollController = ScrollController();

  LocationService _locationService = LocationService();
  Position? position;
  String address = '';

  set updateAddress(String val) {
    address = val;
    update(['add']);
  }

  Future<bool> changeLocation() async {
    position = await LocationService().getCurrentLocation();
    print("new llllllllll${position!.latitude.toString()}");
    print("new llllllllllll${position!.longitude.toString()}");
    updateAddress = await _locationService.getAddressFromCoordinates(position!);
    final locationData = LocationDataModel(
        latitude: position!.latitude.toString(),
        longitude: position!.longitude.toString(),
        address: address);
    print("Address "+address.toString());
    userData.addLocationData(locationData);
    print("new uuuuuuuuuuuuuuuuuuu${userData.getLocationData!.latitude
        .toString()}");
    clearTimingFromStorage();
    return true;
  }
  void clearTimingFromStorage()async{
    stopBackgroundService();
   await userData.clearPrayerTimings();
   fetchPrayerTime();
  }
  Future<void> fetchMissedPrayersCount() async {
    print("currentppppppppppp");
    print(currentPrayer.value);
    try {
      final requestUrl = 'http://182.156.200.177:8011/adhanapi/missed-prayers/?user_id=${userData.getUserData!.id}';
         // '&prayername=${currentPrayer.value}';
      print('Request URL: $requestUrl');

      final response = await http.get( Uri.parse(requestUrl));

      if (response.statusCode == 200) {
        print('Raw API Response: ${response.body}');
        var data = jsonDecode(response.body);
        print('Parsed JSON: $data');

        missedPrayersCount.value = data['total_missed_prayers'] ?? 0;
        print('Total Missed Prayers: ${missedPrayersCount.value}');

        if (data.containsKey('pending_requests')) {
          pending.value = data['pending_requests'];
        } else {
          print('Key "total_pending" does not exist in the response.');
          pending.value = 0; // Fallback value
        }
        print('Pending Value: ${pending.value}');
      } else {
        print('Failed to fetch data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching missed prayers count: $e');

    }
  }

  @override
  void onInit() async {
    super.onInit();
    fetchPrayerTimeData();
    highlightCurrentPrayer();
    //userData.initializePrayerSettings();
    await Future.delayed(Duration(milliseconds: 1000));
  fetchMissedPrayersCount();
  }

  @override
  void dispose() {
    scrollController.dispose();
    remainingTimeTimer!.cancel();
    prayerTimer!.cancel();
    _timer?.cancel();
    locationController.value.dispose();
    // audioPlayer.dispose();
    super.dispose();
  }
  @override
  void onReady() {
    super.onReady();
    get();

  }

  // get() async {
  //   print("mydata${userData.getUserData!.toJson()}");
  //   if (userData.getLocationData == null) {
  //     print("annnnder");
  //     print("userData ander ${userData.getLocationData?.toJson()}");
  //     position = await _locationService.getCurrentLocation();
  //     print("llllllllll${position!.latitude.toString()}");
  //     print("llllllllllll${position!.longitude.toString()}");
  //     updateAddress =
  //     await _locationService.getAddressFromCoordinates(position!);
  //     final locationData = LocationDataModel(
  //         latitude: position!.latitude.toString(),
  //         longitude: position!.longitude.toString(),
  //         address: address);
  //     userData.addLocationData(locationData);
  //     print("uuuuuuuuuuuuuuuuuuu${userData.getLocationData!.latitude
  //         .toString()}");
  //   }
  //   else {
  //     print("baaaaaaahar");
  //     print("userData bahar ${userData.getLocationData?.toJson()}");
  //     updateAddress = userData.getLocationData!.address!;
  //   }
  //   print("address $address");
  //   print("lat ${userData.getLocationData!.latitude}");
  //   await getIsPrayed();
  //   await fetchPrayerTime();
  //   leaderboard();
  //   // scrollToHighlightedPrayer();
  //   updateIslamicDateBasedOnOption(userData.getUserData!.hijriAdj!);
  //   weeklyApi();
  // }
  get() async {
    // Check connectivity before proceeding
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.none) {
    //   // Show snackbar if there is no internet connection
    //   Get.showSnackbar(
    //     const GetSnackBar(
    //       snackPosition: SnackPosition.BOTTOM,
    //       message: "No Internet Connection",
    //       duration: Duration(days: 1),
    //     ),
    //   );
    //   return; // Exit the method if there is no connection
    // }

    print("mydata${userData.getUserData!.toJson()}");
    if (userData.getLocationData == null) {
    print("annnnder");
    print("userData ander ${userData.getLocationData?.toJson()}");
    position = await _locationService.getCurrentLocation();
    print("llllllllll${position!.latitude.toString()}");
    print("llllllllllll${position!.longitude.toString()}");
    updateAddress =
    await _locationService.getAddressFromCoordinates(position!);
    final locationData = LocationDataModel(
    latitude: position!.latitude.toString(),
    longitude: position!.longitude.toString(),
        address: address// Make sure to use the correct variable
    );
    userData.addLocationData(locationData);
    print("uuuuuuuuuuuuuuuuuuu${userData.getLocationData!.latitude.toString()}");
    } else {
    print("baaaaaaahar");
    print("userData bahar ${userData.getLocationData?.toJson()}");
    updateAddress = userData.getLocationData!.address!;
    }
    print("address $address");
    print("lat ${userData.getLocationData!.latitude}");

    // Proceed with API calls
    await getIsPrayed();
    await fetchPrayerTime();
    leaderboard();
    // scrollToHighlightedPrayer();
    updateIslamicDateBasedOnOption(userData.getUserData!.hijriAdj!);
    weeklyApi();
  }

  // get() async {
  //   // Check connectivity before proceeding
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.none) {
  //     // Show snackbar if there is no internet connection
  //     if (!Get.isSnackbarOpen) {
  //       Get.showSnackbar(
  //         GetSnackBar(
  //           snackPosition: SnackPosition.BOTTOM,
  //           message: "No Internet Connection",
  //           isDismissible: false, // Prevents the snackbar from being dismissed
  //           duration: Duration(days: 1), // Set a long duration
  //         ),
  //       );
  //     }
  //     return; // Exit the method if there is no connection
  //   }
  //
  //   print("mydata${userData.getUserData!.toJson()}");
  //   if (userData.getLocationData == null) {
  //   print("annnnder");
  //   print("userData ander ${userData.getLocationData?.toJson()}");
  //   position = await _locationService.getCurrentLocation();
  //   print("llllllllll${position!.latitude.toString()}");
  //   print("llllllllllll${position!.longitude.toString()}");
  //   updateAddress =
  //   await _locationService.getAddressFromCoordinates(position!);
  //   final locationData = LocationDataModel(
  //   latitude: position!.latitude.toString(),
  //   longitude: position!.longitude.toString(),
  //   address: address, // Make sure to use the correct variable
  //   );
  //   userData.addLocationData(locationData);
  //   print("uuuuuuuuuuuuuuuuuuu${userData.getLocationData!.latitude.toString()}");
  //   } else {
  //   print("baaaaaaahar");
  //   print("userData bahar ${userData.getLocationData?.toJson()}");
  //   updateAddress = userData.getLocationData!.address!;
  //   }
  //   print("address $address");
  //   print("lat ${userData.getLocationData!.latitude}");
  //
  //   // Proceed with API calls
  //   await getIsPrayed();
  //   await fetchPrayerTime();
  //   leaderboard();
  //   // scrollToHighlightedPrayer();
  //   updateIslamicDateBasedOnOption(userData.getUserData!.hijriAdj!);
  //   weeklyApi();
  // }
  String convertTo12HourFormat(String time24) {
    try {
      DateTime parsedTime = DateFormat('HH:mm').parse(time24);
      return DateFormat('hh:mm a').format(parsedTime);
    } catch (e) {
      return time24;
    }
  }
  Future<void> fetchAndSchedulePrayers() async {
    try {
      await fetchPrayerTimeData();
    } catch (e) {
      print("Error in fetchAndSchedulePrayers: $e");
    }
  }


  DateTime parseTime(String time24) {
    final now = DateTime.now();

    // Use a regular expression to extract only the hour and minute parts
    final match = RegExp(r'^(\d{1,2}):(\d{2})').firstMatch(time24);
    if (match == null) return now; // Return current time if the format is invalid

    int hour = int.parse(match.group(1)!);
    int minute = int.parse(match.group(2)!);

    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  Future<void> fetchPrayerTime({DateTime? specificDate}) async {
    DateTime now = specificDate ?? DateTime.now();
    if(userData.getPrayerTimingsData.isEmpty){
    final latitude = userData.getLocationData != null ?double.parse(
        userData.getLocationData!.latitude.toString()): position!.latitude;
    final longitude = userData.getLocationData != null ? double.parse(
        userData.getLocationData!.longitude.toString()) : position!.longitude;
    final method = userData.getUserData!.methodId;

    String formattedDates = DateFormat('yyyy/MM').format(now);
    print("bull $latitude");
    print("bull $longitude");
    // print("current3333");
    // print(currentPrayer.value);
    isLoading.value = true;
    try {
      Uri uri = Uri.https(
        'api.aladhan.com',
        '/v1/calendar/$formattedDates',
        {
          'latitude': latitude.toString(),
          'longitude': longitude.toString(),
          'method': method.toString(),
        },
      );
      final response = await http.get(uri);
      log("API Response: ${response.body}");
      //print("formatted:"+formattedDates);
      if (response.statusCode == 200) {
        // Decode the data
        updateCalendarData = jsonDecode(response.body.toString())["data"];


      } else {
        updateCalendarData = [];
        print(
            'Error fetching prayer times. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print("kekej");
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
    }else{
      updateCalendarData = userData.getPrayerTimingsData;
      print("not empty $calendarData");
    }
    // DateTime now = DateTime.now();
    // DateTime now = specificDate ?? DateTime.now();
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
      print("kkkkkkkk${getExtractedData[0].timings?.dhuhr}");
      String dhuhrTimeStr=    convertTo12HourFormat(getExtractedData[0].timings?.dhuhr ?? 'N/A');
      DateTime dhuhrTime = DateFormat('HH:mm').parse(dhuhrTimeStr);
      DateTime zawalTime = dhuhrTime.subtract(Duration(minutes: 10));
      String formattedZawalTime= DateFormat('hh:mm a').format(zawalTime);
      updatePrayerTimes = [
        convertTo12HourFormat(getExtractedData[0].timings?.fajr ?? 'N/A'),
        convertTo12HourFormat(getExtractedData[0].timings?.dhuhr ?? 'N/A'),
        convertTo12HourFormat(getExtractedData[0].timings?.asr ?? 'N/A'),
        convertTo12HourFormat(getExtractedData[0].timings?.maghrib ?? 'N/A'),
        convertTo12HourFormat(getExtractedData[0].timings?.isha ?? 'N/A'),
      ];

      updateUpcomingPrayers = [
        convertTo12HourFormat(getExtractedData[0].timings?.fajr ?? 'N/A'),
        convertTo12HourFormat(getExtractedData[0].timings?.sunrise ?? 'N/A'),
        convertTo12HourFormat(getExtractedData[0].timings?.zawal ?? 'N/A'),
        convertTo12HourFormat(getExtractedData[0].timings?.dhuhr ?? 'N/A'),
        convertTo12HourFormat(getExtractedData[0].timings?.asr ?? 'N/A'),
        convertTo12HourFormat(getExtractedData[0].timings?.sunset ?? 'N/A'),
        convertTo12HourFormat(getExtractedData[0].timings?.maghrib ?? 'N/A'),
        convertTo12HourFormat(getExtractedData[0].timings?.isha ?? 'N/A'),
        //-------Zawal and sunset data (25-10-2024) by fai----//


      ];
      print("gggggggggggggg:$prayerNames");
      print(upcomingPrayers);

      sunsetTime.value =
          convertTo12HourFormat(
              getExtractedData[0].timings?.sunset ?? 'N/A');

      final hijriDate = getExtractedData[0].date?.hijri;
      islamicDate.value =
      '${hijriDate?.day ?? "Day"} ${hijriDate?.month?.en ?? "Month"} ${hijriDate?.year ?? "Year"} ${hijriDate?.designation?.abbreviated ?? "Abbreviation"}';
      print("baqar");
      print("isEmpty ${userData.getPrayerDurationForShia}");
      updatePrayerDuration = userData.getUserData!.fiqh.toString() == '0' // Shia fiqh
          ? {
        'Fajr': {
          'start': getExtractedData[0].timings?.fajr ?? 'N/A',
          'end': getExtractedData[0].timings?.sunrise ?? 'N/A'
        },
        // 'Free': {
        //   'start': getExtractedData[0].timings?.sunrise ?? 'N/A',
        //   'end': getExtractedData[0].timings?.dhuhr ?? 'N/A'
        // },
        'Dhuhr': {
          'start': getExtractedData[0].timings?.dhuhr ?? 'N/A',
          'end': getExtractedData[0].timings?.sunset ?? 'N/A'  // Ends at sunset for Shia Muslims
        },
        'Asr': {
          'start': getExtractedData[0].timings?.dhuhr ?? 'N/A', // Allows Asr start after Dhuhr is prayed
          'end': getExtractedData[0].timings?.sunset ?? 'N/A'
        },
        'Maghrib': {
          'start': getExtractedData[0].timings?.maghrib ?? 'N/A',
          'end': '23:58 (IST)' // Ends at midnight for Shia Muslims
        },
        'Isha': {
          'start': getExtractedData[0].timings?.maghrib ?? 'N/A', // Allows Isha start after Maghrib is prayed
          'end': '23:58 (IST)'
        },
      }
          : // Sunni fiqh standard times
      {
        'Fajr': {
          'start': getExtractedData[0].timings?.fajr ?? 'N/A',
          'end': getExtractedData[0].timings?.sunrise ?? 'N/A'
        },
        // 'Free': {
        //   'start': getExtractedData[0].timings?.sunrise ?? 'N/A',
        //   'end': getExtractedData[0].timings?.dhuhr ?? 'N/A'
        // },
        'Dhuhr': {
          'start': getExtractedData[0].timings?.dhuhr ?? 'N/A',
          'end': getExtractedData[0].timings?.asr ?? 'N/A'
        },
        'Asr': {
          'start': getExtractedData[0].timings?.asr ?? 'N/A',
          'end': getExtractedData[0].timings?.sunset ?? 'N/A'
        },
        'Maghrib': {
          'start': getExtractedData[0].timings?.maghrib ?? 'N/A',
          'end': getExtractedData[0].timings?.isha ?? 'N/A'
        },
        'Isha': {
          'start': getExtractedData[0].timings?.isha ?? 'N/A',
          'end': '23:58 (IST)'
        },
      };
      //   userData.savePrayerTimings(prayerDuration);
      // }

      print("hhhhhhhh");
      print("###### $prayerDuration");
      print("getExtractedData[0].timings?.fajr ${getExtractedData[0].toJson()}");

      updateUpcomingPrayerDuration = {
        'Fajr': {
          'start': getExtractedData[0].timings?.fajr ?? 'N/A',
          'end': getExtractedData[0].timings?.sunrise ?? 'N/A'
        },
        // 'Free': {
        //   'start': getExtractedData[0].timings?.sunrise ?? 'N/A',
        //   'end': getExtractedData[0].timings?.dhuhr ?? 'N/A'
        // },
        'Sunrise': {
          'start': getExtractedData[0].timings?.sunrise ?? 'N/A',
          'end': getExtractedData[0].timings?.sunset ?? 'N/A'
        },
        'Zawal': {
          'start': formattedZawalTime,
          'end': convertTo12HourFormat(getExtractedData[0].timings?.dhuhr ?? 'N/A')
        },
        'Dhuhr': {
          'start': getExtractedData[0].timings?.dhuhr ?? 'N/A',
          'end': getExtractedData[0].timings?.asr ?? 'N/A'
        },
        'Asr': {
          'start': getExtractedData[0].timings?.asr ?? 'N/A',
          'end': getExtractedData[0].timings?.sunset ?? 'N/A'
        },
        'Sunset': {
          'start': getExtractedData[0].timings?.sunset ?? 'N/A',
          // 'end':getExtractedData[0].timings?.sunrise ?? 'N/A'
        },
        'Maghrib': {
          'start': getExtractedData[0].timings?.maghrib ?? 'N/A',
          'end': getExtractedData[0].timings?.isha ?? 'N/A'
        },
        'Isha': {
          'start': getExtractedData[0].timings?.isha ?? 'N/A',
          'end':   getExtractedData[0].timings?.midnight ?? 'N/A'
          //'17:50'

        },
        //-----FZ (25-10-2024) update sunrise & subset time----//

      };


      // Get current time
      String currentTime = DateFormat('HH:mm').format(DateTime.now());
      currentPrayer.value = getCurrentPrayer(prayerDuration, currentTime);

      print('Current time: $currentTime');
      print('Current Prayer: $currentPrayer');
      trackMarkPrayer = currentPrayer.value;

      // Check Shia-specific conditions
      if (userData.getUserData!.fiqh.toString() == '0') {
        // Check if Dhuhr or Maghrib is prayed
        bool dhuhrPrayed = isPrayedList.any((item) =>
        item['prayer_name'] == 'Dhuhr' && item['prayed'] == true);
        print("dhuhrPrayed $dhuhrPrayed");
        bool asrPrayed = isPrayedList.any((item) =>
        item['prayer_name'] == 'Asr' && item['prayed'] == true);
        print("asrPrayed $asrPrayed");
        bool maghribPrayed = isPrayedList.any((item) =>
        item['prayer_name'] == 'Maghrib' && item['prayed'] == true);
        bool ishaPrayed = isPrayedList.any((item) =>
        item['prayer_name'] == 'Isha' && item['prayed'] == true);
        print("maghribPrayed$maghribPrayed");
        print("maghribPrayed$ishaPrayed");
        if ((dhuhrPrayed || maghribPrayed)&&(currentPrayer.value=='Dhuhr'||currentPrayer.value=='Maghrib')) {
          print("Dhuhr or Maghrib is prayed. Moving to the next prayer. ${currentPrayer.value}");
          // moveToNextPrayer();
          if(currentPrayer.value=='Dhuhr'){
            print("+++++++++++");
            prayerDuration['Dhuhr']!['end'] = DateFormat('HH:mm').format(DateTime.now().subtract(Duration(minutes: 1)));
            currentPrayer.value = 'Asr';
            if(!asrPrayed) {
              isPrayed = false;
            }else{
              trackMarkPrayer = currentPrayer.value;
              isPrayed = asrPrayed;
            }
            print('prayerDuration: $prayerDuration');
            print('isPrayed: $isPrayed');
          }
          else{
            if(maghribPrayed){
              prayerDuration['Maghrib']!['end'] = DateFormat('HH:mm').format(DateTime.now().subtract(Duration(minutes: 1)));
              currentPrayer.value = 'Isha';
              if(!ishaPrayed){
                isPrayed = false;
              }
              else{
                trackMarkPrayer = currentPrayer.value;
              }
            }
          }

          // return;
        }
      }
      print('prayerDuration: $prayerDuration');
      // Start timer for remaining time

      startRemainingTimeTimer();
      showNextPrayer();
      update();
      if(userData.getPrayerTimingsData.isEmpty){
        print("is saved prayer time");
        await userData.savePrayerMonthTime(calendarData);
        startBackgroundService();
      }
    } else {
      print('No data found for current date.');
    }
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
    // this.currentPrayerStartTime.value =(startTime);
    // this.currentPrayerEndTime.value = (endTime);

    isPrayed = getPrayedValue(currentPrayer);
    update(['lottie']);
    // print("ispadhi $ispadhi");

    return currentPrayer;
  }
  // String convert12To24(String time12Hour) {
  //   // Parse the 12-hour format time
  //   final DateTime dateTime = DateFormat("hh:mm a").parse(time12Hour);
  //
  //   // Format to 24-hour format
  //   return DateFormat("HH:mm").format(dateTime);
  // }


  bool getPrayedValue(String prayerName) {
    print("prayer list**** $isPrayedList");
    for (var prayer in isPrayedList) {
      print("prayer name $prayerName");
      print("prayer name2 ${prayer['prayer_name']}");
      if (prayer['prayer_name'] == prayerName) {
        print("isPrayed ${prayer['prayer_name']}");
        print("lllllllllll${prayer['prayed']}");
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
      // scrollToHighlightedPrayer();
      update();
    });
  }
RxString upcomingPrayerStartTime = ''.obs;
RxString upcomingPrayerEndTime = ''.obs;
RxString nextPrayerName = ''.obs;
  Timer? _timer; // Make _timer nullable
  Rx<Duration> upcomingRemainingTime = Duration.zero.obs;

  void showNextPrayer() {
    print("currentPrayer## ${currentPrayer.value}");
    print("nextPrayer## ${nextPrayer.value}");

    // Check if the current prayer is "Isha" (the last prayer of the day)
    if (currentPrayer.value == "Isha") {
      // Fetch Fajr timing for tomorrow using the 'gregorian' date field directly
      String tomorrowDate = getTomorrowGregorianDate();
      var nextDayData = calendarData.firstWhere(
            (element) => element['date']['gregorian']['date'] == tomorrowDate,
        orElse: () => <String, dynamic>{},
      );

      if (nextDayData.isNotEmpty) {
        nextPrayerName.value = "Fajr";
        var nextDayFajrTiming = nextDayData['timings']['Fajr'];
        upcomingPrayerStartTime.value = convertTo12HourFormat(nextDayFajrTiming);
        upcomingPrayerEndTime.value = convertTo12HourFormat(nextDayData['timings']['Sunrise']); // assuming Sunrise marks Fajr end time
        // Start the countdown to Fajr
        _startCountdown(nextDayFajrTiming);
      }
    } else {
      // Continue with the usual next prayer handling
      if (currentPrayer.value.isNotEmpty) {
        if(currentPrayer.value=='Free'){
          nextPrayerName.value = prayerNames[1];
        }
        else{
          int currentIndex = prayerNames.indexOf(currentPrayer.value);
          int nextIndex = (currentIndex + 1) % prayerNames.length;
          nextPrayerName.value = prayerNames[nextIndex];
        }
      } else {
        int currentIndex = prayerNames.indexOf(nextPrayer.value);
        nextPrayerName.value = prayerNames[currentIndex];
      }
      var nextPrayerTimes = prayerDuration[nextPrayerName.value]!;
      print("prayerDuration[nextPrayer.value] ${prayerDuration[nextPrayerName.value]!}");
      print("nextPrayerTimes['start'] ${nextPrayerTimes['start']!}");
      print("Next Prayer Name");
      print(nextPrayerName);
      upcomingPrayerStartTime.value = convertTo12HourFormat(nextPrayerTimes['start']!);
      upcomingPrayerEndTime.value = convertTo12HourFormat(nextPrayerTimes['end']!);
    }
  }

  void _startCountdown(String fajrStartTime) {
    print("fajrStartTime $fajrStartTime");
    print("upcomingRemainingTime.value1 ${upcomingRemainingTime.value}");
    // Cancel any existing timer
    _timer?.cancel();
    // Remove (IST) from the time string
    // Remove any text after the time by targeting the first five characters or removing known text patterns
    String cleanedFajrTime = fajrStartTime.replaceAll(" (IST)", "").trim();
    print("upcomingRemainingTime.value2 ${upcomingRemainingTime.value}");
    // Parse Fajr start time into DateTime
    DateTime now = DateTime.now();
    DateTime fajrDateTime = DateFormat('HH:mm').parse(cleanedFajrTime);
    DateTime fajrDateTimeFull = DateTime(
      now.year,
      now.month,
      now.day + 1, // Assuming this is for the next day
      fajrDateTime.hour,
      fajrDateTime.minute,
    );
    print("upcomingRemainingTime.value ${upcomingRemainingTime.value}");
    Duration difference = fajrDateTimeFull.difference(now);
    upcomingRemainingTime.value = difference;
    print("upcomingRemainingTime.value ${upcomingRemainingTime.value}");

    // Start a timer to count down
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (upcomingRemainingTime.value.inSeconds <= 0) {
        print("ggggggggggg");
        timer.cancel(); // Stop the timer when it reaches zero
      } else {
        upcomingRemainingTime.value -= Duration(seconds: 1); // Update remaining time
        print("qqqqqqqqqqqq ${upcomingRemainingTime.value}");
      }
    });
  }

// Helper function to get tomorrow's date in the same format as the 'gregorian' date field
  String getTomorrowGregorianDate() {
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    return DateFormat('dd-MM-yyyy').format(tomorrow);
  }

  @override
  void onClose() {
    prayerTimer?.cancel();
    remainingTimeTimer?.cancel();
    _timer?.cancel();
    super.onClose();
  }
  bool isNotificationSent = false;
  RxBool isGapPeriod = false.obs;
  // Updated startRemainingTimeTimer method with debugging and time formatting
  void startRemainingTimeTimer() {
    // Check if start and end times are set; if not, attempt to set them
    if (currentPrayerStartTime.value.isEmpty || currentPrayerEndTime.value.isEmpty) {
      print("Prayer times are not set. Attempting to set them.");
      moveToNextPrayer(); // Ensure this function sets start and end times for the current prayer
    }

    remainingTimeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      //print("Timer tick... Checking prayer start and end times.");

      // Check again to see if start and end times are now set
      if (currentPrayerStartTime.value.isNotEmpty && currentPrayerEndTime.value.isNotEmpty)  {
        //print("Start and end times are set, proceeding with timer logic.");

        try {
          DateTime now = DateTime.now();

          // Parse the start and end times for the current prayer
          DateTime startTime = DateFormat('hh:mm a').parse(currentPrayerStartTime.value);
          DateTime endTime = DateFormat('hh:mm a').parse(currentPrayerEndTime.value);
          startTime = DateTime(now.year, now.month, now.day, startTime.hour, startTime.minute);
          endTime = DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);

          print("currentPrayerStartTime ${currentPrayerStartTime.value}");
          print("currentPrayerEndTime ${currentPrayerEndTime.value}");
          // print("now $now");

          // Check if the current time is in a gap (before the next prayer's start time)
          if (now.isBefore(startTime)) {
            print("Currently in a gap period before the next prayer.");
            // Mark as gap period
            isGapPeriod.value = true;
            Duration gapDuration = startTime.difference(now);
            remainingTime.value = formatDuration(gapDuration);

          } else if (now.isAfter(endTime)) {
            print("Current prayer has ended, moving to next prayer.");
            // Reset gap period state
            isGapPeriod.value = true;
            // Move to the next prayer
            moveToNextPrayer();

            // Handle gap before the next prayer if it exists
            if (nextPrayerStartTime.value.isNotEmpty) {
              print("Handle gap before the next prayer if it exists");
              DateTime nextPrayerStart = DateFormat('hh:mm a').parse(nextPrayerStartTime.value);
              nextPrayerStart = DateTime(now.year, now.month, now.day, nextPrayerStart.hour, nextPrayerStart.minute);

              // Calculate the gap duration until the next prayer
              Duration gapDuration = nextPrayerStart.difference(now);

              if (gapDuration.isNegative) {
                print("Next prayer start time has passed, transitioning again.");
                timer.cancel();
                moveToNextPrayer();
              } else {
                print("Gap until next prayer starts, updating remaining time.");
                remainingTime.value = formatDuration(gapDuration);
              }
            }
          } else {
            // Inside prayer time
            isGapPeriod.value = false;
            // Calculate remaining time for the current prayer duration
            Duration remainingDuration = endTime.difference(now);
            //print("Time remaining for the current prayer: ${formatDuration(remainingDuration)}");
            remainingTime.value = formatDuration(remainingDuration);

            // Check if remaining time is negative to transition to the next prayer
            if (remainingDuration.isNegative) {
              isNotificationSent = false;
              timer.cancel();
              moveToNextPrayer();
            }
          }
        } catch (e) {
          print('Error parsing prayer time: $e');
        }
      } else {
        print("Prayer start or end time is still empty, skipping this tick.");
      }
      calculateCompletionPercentage();
    });
  }


  void moveToNextPrayer() {
    isPrayed = false;
    String nextPrayerName = getNextPrayer(prayerDuration, DateFormat('HH:mm').format(DateTime.now()));
    print('Next prayer: $nextPrayerName');
    currentPrayer.value = nextPrayerName;
    // Fetch next prayer timings
    var nextPrayerTimes = prayerDuration[nextPrayerName]!;
    currentPrayerStartTime.value = convertTo12HourFormat(nextPrayerTimes['start']!);
    currentPrayerEndTime.value = convertTo12HourFormat(nextPrayerTimes['end']!);

    // Restart the timer with new prayer times
    startRemainingTimeTimer(); // Restart timer after switching to next prayer
    showNextPrayer();
    print('Next prayer2: $nextPrayerName');
  }

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;
    return '${hours}h ${minutes}m ${seconds}s';
  }

  RxDouble completionPercentage = 0.0.obs;
  Duration? totalGapDuration; // Define totalGapDuration outside of the Timer to persist across ticks
  void calculateCompletionPercentage() {
    try {
      DateTime now = DateTime.now();

      // Check if start and end times for the current prayer are set
      if (currentPrayerStartTime.value.isNotEmpty && currentPrayerEndTime.value.isNotEmpty) {
        // Parse start and end times for the current prayer
        DateTime startTime = DateFormat('hh:mm a').parse(currentPrayerStartTime.value);
        DateTime endTime = DateFormat('hh:mm a').parse(currentPrayerEndTime.value);
        startTime = DateTime(now.year, now.month, now.day, startTime.hour, startTime.minute);
        endTime = DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);

        // Detect if we are in a gap before the next prayer
        if (now.isBefore(startTime)) {
          // We are in a gap period before the next prayer
          print("Currently in a gap period before the next prayer.");


          // Calculate totalGapDuration once, at the start of the gap
          if (totalGapDuration == null) {
            totalGapDuration = startTime.difference(now); // gap duration from current time to start of next prayer
          }
          // Calculate duration for the gap (time until the prayer starts)
          Duration gapDuration = startTime.difference(now);



          // Set progress based on the gap period until the next prayer
          completionPercentage.value = 1 - (gapDuration.inSeconds / totalGapDuration!.inSeconds);

          print("Gap progress: ${completionPercentage.value}");
          print("Gap progress: ${completionPercentage.value * 100}%");

        } else if (now.isAfter(endTime)) {
          // Current prayer has ended, calculate progress for the next prayer
          print("Current prayer has ended, moving to next prayer.");
          totalGapDuration = null; // Reset totalGapDuration for the next gap period
          moveToNextPrayer();

        } else {
          // We are within the current prayer, calculate progress as before
          totalGapDuration = null; // Reset totalGapDuration as it's no longer needed in a prayer period
          Duration totalDuration = endTime.difference(startTime);
          Duration elapsedDuration = now.difference(startTime);

          if (elapsedDuration.isNegative) {
            // Prayer has not started yet
            completionPercentage.value = 0.0;
          } else if (elapsedDuration > totalDuration) {
            // Prayer time is over
            completionPercentage.value = 1.0;
          } else {
            // Prayer is ongoing, calculate progress as a fraction
            completionPercentage.value = elapsedDuration.inSeconds / totalDuration.inSeconds;
          }

          // print("Prayer progresss: ${completionPercentage.value}");
          // print("Prayer progress: ${completionPercentage.value * 100}%");
        }
      } else {
        // Start or end time is missing; reset the progress
        completionPercentage.value = 0.0;
        print("Start or end time not set, resetting progress.");
      }
    } catch (e) {
      print('Error calculating completion percentage: $e');
      // Reset to 0 in case of error to avoid incorrect progress display
      completionPercentage.value = 0.0;
    }
  }

  RxBool prayedAtMosque = false.obs;
  var hour = 1;
  var minute = 0;
  bool isGifVisible = false;
  bool isAm = false;
//   submitPrayer(
//       {String? valDate,bool? isFromMissed,Future<dynamic> Function()? missedCallBack, String? prayerNames,String? startTime,
//   String? endTime,required BuildContext context}) async {
//     Get.back();
//     Dialogs.showLoading(context,message: 'loading...');
//     // print("quad: ${latAndLong?.latitude}   ${latAndLong?.longitude}");
//     DateTime date = DateTime.now();
//     String formattedDate =valDate ?? DateFormat('dd-MM-yyyy').format(date);
//     print("formattedDate $formattedDate");
//     try {
//       var headers = {'Content-Type': 'application/json'};
//
//       // Use null-aware operators and default values
//       var userId = userData.getUserData!.id.toString();
//       var mobileNo = userData.getUserData!.mobileNo.toString();
//       if (!isAm && hour < 12) {
//         hour += 12; // Convert to PM (24-hour format)
//       } else if (isAm && hour == 12) {
//         hour = 0; // Handle 12 AM as 00:00 in 24-hour format
//       }
//       // Create a DateTime object with the hour and minute
//       DateTime time = DateTime(0, 1, 1, hour, minute);
//
//       // Format it to 24-hour format
//       String formattedTime = DateFormat('HH:mm').format(time);
//
//       print("formattedTime $formattedTime"); // Output will be in 24-hour format, like 18:32 or 06:32
//       // isTimeWithinRange();
//
//       var request = http.Request('POST', Uri.parse('http://182.156.200.177:8011/adhanapi/prayer-record/${formattedDate}/'));
//       request.body = json.encode({
//         "user_id": int.parse(userId),
//         "prayer_name" : prayerNames??currentPrayer.value,
//         "mobile_no": int.parse(mobileNo),
//         "latitude": position!=null? position!.latitude.toString():userData.getLocationData!.latitude.toString(),
//         "longitude": position!=null? position!.longitude.toString():userData.getLocationData!.longitude.toString(),
//         "timestamp":formattedTime, //"$hour:$minute",
//         "jamat": prayedAtMosque.value,
//         // "times_of_prayer": userData.getUserData!.timesOfPrayer.toString(),
//         'prayed':true
//       });
//       print("URL ${request.url}");
//       print("prayer-record ${request.body}");
//       print('heyyyy Fairy');
//       print(upcomingPrayers);
//       request.headers.addAll(headers);
//       http.StreamedResponse response = await request.send();
//       String responseString = await response.stream.bytesToString();
//       print("Raw API response: $responseString");
//       Dialogs.hideLoading();
// if(isFromMissed!){
//   missedCallBack!();
//   Get.snackbar('Prayer Marked', 'Success',backgroundColor: Colors.black,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,duration: const Duration(seconds: 1));
// }
//
// else{
//   isPrayed = true;
//   isGifVisible = true;
//   update();
//   trackMarkPrayer = currentPrayer.value;
//   leaderboard();
//   Future.delayed(Duration(seconds: 3), () async {
//
//     isGifVisible = false;
//     if(userData.getUserData!.fiqh=='0'){
//       onPrayerMarked(currentPrayer.value);
//     }
//     update();
//     // Get.back();
//
//   });
// }
//
//
//     } catch (e) {
//
//       print('Error: $e');
//     }
//   }
//   submitPrayer(
//       {String? valDate,
//         bool? isFromMissed,
//         Future<dynamic> Function()? missedCallBack,
//         String? prayerNames,
//         String? startTime,
//         String? endTime,
//         required BuildContext context}) async {
//     Get.back();
//     Dialogs.showLoading(context, message: 'loading...');
//     DateTime date = DateTime.now();
//     String formattedDate = valDate ?? DateFormat('dd-MM-yyyy').format(date);
//     print("formattedDate $formattedDate");
//     try {
//       var headers = {'Content-Type': 'application/json'};
//       var userId = userData.getUserData!.id.toString();
//       var mobileNo = userData.getUserData!.mobileNo.toString();
//       if (!isAm && hour < 12) {
//         hour += 12; // Convert to PM (24-hour format)
//       } else if (isAm && hour == 12) {
//         hour = 0; // Handle 12 AM as 00:00 in 24-hour format
//       }
//       DateTime time = DateTime(0, 1, 1, hour, minute);
//       String formattedTime = DateFormat('HH:mm').format(time);
//
//       var request = http.Request(
//           'POST',
//           Uri.parse(
//               'http://182.156.200.177:8011/adhanapi/prayer-record/${formattedDate}/'));
//       request.body = json.encode({
//         "user_id": int.parse(userId),
//         "prayer_name": prayerNames ?? currentPrayer.value,
//         "mobile_no": int.parse(mobileNo),
//         "latitude": position != null
//             ? position!.latitude.toString()
//             : userData.getLocationData!.latitude.toString(),
//         "longitude": position != null
//             ? position!.longitude.toString()
//             : userData.getLocationData!.longitude.toString(),
//         "timestamp": formattedTime,
//         "jamat": prayedAtMosque.value,
//         'prayed': true
//       });
//       request.headers.addAll(headers);
//       http.StreamedResponse response = await request.send();
//       String responseString = await response.stream.bytesToString();
//       print("Raw API response: $responseString");
//       Dialogs.hideLoading();
//
//       if (isFromMissed!) {
//         missedCallBack!();
//         Get.snackbar('Prayer Marked', 'Success',
//             backgroundColor: Colors.black,
//             colorText: Colors.white,
//             snackPosition: SnackPosition.BOTTOM,
//             duration: const Duration(seconds: 1));
//
//       } else {
//         isPrayed = true;
//         isGifVisible = true;
//         update();
//         trackMarkPrayer = currentPrayer.value;
//         leaderboard();
//         Future.delayed(Duration(seconds: 3), () async {
//           isGifVisible = false;
//           if (userData.getUserData!.fiqh == '0') {
//             onPrayerMarked(currentPrayer.value);
//           }
//           update();
//         });
//       }
//        fetchMissedPrayersCount();
//       print('Jjjjjjj');
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

  submitPrayer({
    String? valDate,
    bool? isFromMissed,
    Future<dynamic> Function()? missedCallBack,
    String? prayerNames,
    String? startTime,
    String? endTime,
    required BuildContext context,
  }) async {
    Get.back();
    Dialogs.showLoading(context, message: 'Loading...');
    DateTime date = DateTime.now();
    String formattedDate = valDate ?? DateFormat('dd-MM-yyyy').format(date);

    try {
      // Parse start and end times to DateTime for validation
      DateTime now = DateTime.now();
      DateTime parsedStartTime = DateFormat('HH:mm').parse(startTime ?? "00:00");
      DateTime parsedEndTime = DateFormat('HH:mm').parse(endTime ?? "23:59");

      // Convert parsed times to today's date for comparison
      parsedStartTime = DateTime(now.year, now.month, now.day, parsedStartTime.hour, parsedStartTime.minute);
      parsedEndTime = DateTime(now.year, now.month, now.day, parsedEndTime.hour, parsedEndTime.minute);

      // Validate against prayer time
      if (now.isBefore(parsedStartTime) || now.isAfter(parsedEndTime)) {
        Dialogs.hideLoading();
        Get.snackbar(
          'Invalid Prayer Time',
          'You can only mark this prayer during its valid time range.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        return; // Exit the method
      }

      // Validate if the prayer has already been marked
      if (trackMarkPrayer == prayerNames) {
        Dialogs.hideLoading();
        Get.snackbar(
          'Prayer Already Marked',
          'This prayer has already been submitted.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        return; // Exit the method
      }

      var headers = {'Content-Type': 'application/json'};
      var userId = userData.getUserData!.id.toString();
      var mobileNo = userData.getUserData!.mobileNo.toString();

      if (!isAm && hour < 12) {
        hour += 12; // Convert to PM (24-hour format)
      } else if (isAm && hour == 12) {
        hour = 0; // Handle 12 AM as 00:00 in 24-hour format
      }
      DateTime time = DateTime(0, 1, 1, hour, minute);
      String formattedTime = DateFormat('HH:mm').format(time);

      var request = http.Request(
        'POST',
        Uri.parse('http://182.156.200.177:8011/adhanapi/prayer-record/${formattedDate}/'),
      );
      request.body = json.encode({
        "user_id": int.parse(userId),
        "prayer_name": prayerNames ?? currentPrayer.value,
        "mobile_no": int.parse(mobileNo),
        "latitude": position != null
            ? position!.latitude.toString()
            : userData.getLocationData!.latitude.toString(),
        "longitude": position != null
            ? position!.longitude.toString()
            : userData.getLocationData!.longitude.toString(),
        "timestamp": formattedTime,
        "jamat": prayedAtMosque.value,
        'prayed': true,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      String responseString = await response.stream.bytesToString();
      print("Raw API response: $responseString");
      Dialogs.hideLoading();

      if (isFromMissed!) {
        missedCallBack!();
        Get.snackbar('Prayer Marked', 'Success',
            backgroundColor: Colors.black,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 1));
      } else {
        isPrayed = true;
        isGifVisible = true;
        update();
        trackMarkPrayer = currentPrayer.value;
        leaderboard();
        Future.delayed(Duration(seconds: 3), () async {
          isGifVisible = false;
          if (userData.getUserData!.fiqh == '0') {
            onPrayerMarked(currentPrayer.value);
          }
          update();
        });
      }

      fetchMissedPrayersCount();
      print('Jjjjjjj');
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
    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd-MM-yyyy').format(now);

      var request = await ApiService().getRequest(
          'prayer-response/$formattedDate/?user_id=${userData.getUserData!.id
              .toString()}');
      // var request = http.Request('GET',
      //     Uri.parse('http://182.156.200.177:8011/adhanapi/prayer-response/$formattedDate/?user_id=${userData.getUserData!.id.toString()}'));


      // http.StreamedResponse response = await request.send();
      print("responseBaqar $request");
      updateIsPrayedList(request['records']);
    }
    catch(e){
      print("eeee $e");
      final context = navigatorKey.currentContext!;
      Dialogs.showCustomBottomSheet(context: context, content: NoInternet(message: '$e', onRetry: get,),);
    }
    // if (response.statusCode == 200) {
    //   // print(await response.stream.bytesToString());
    //   var decodeData = jsonDecode(await response.stream.bytesToString());
    //   print(decodeData);
    //   // updateLeaderboardList = decodeData['records'];
    //   updateIsPrayedList(decodeData['records']);
    //   log("@@@@@@@@@@@@ $isPrayedList");
    // }
    // else {
    //   print(response.reasonPhrase);
    // }

  }

  Rxn<LeaderboardDataModal>  getLeaderboardList = Rxn<LeaderboardDataModal>();
  // leaderboard() async{
  //   DateTime now = DateTime.now();
  //   String formattedDate = DateFormat('dd-MM-yyyy').format(now);
  //   var request = http.Request('GET', Uri.parse('http://182.156.200.177:8011/adhanapi/prayer-response-friend/?user_id=${userData.getUserData!.id}&date=$formattedDate'));
  //   http.StreamedResponse response = await request.send();
  //   print(request.url);
  //
  //   if (response.statusCode == 200) {
  //     // print(await response.stream.bytesToString());
  //     var decodeData = jsonDecode(await response.stream.bytesToString());
  //     print("decodeData $decodeData");
  //     // updateLeaderboardList = decodeData;
  //     getLeaderboardList.value= LeaderboardDataModal.fromJson(decodeData);
  //     print("getLeaderboardList $getLeaderboardList");
  //     // print("@@@@@@@@@@@@ "+getLeaderboardList.toString());
  //     update(['leader']);
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }
  leaderboard() async {
    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd-MM-yyyy').format(now);
      String endpoint = 'prayer-response-friend/?user_id=${userData.getUserData!.id}&date=$formattedDate';
      final response = await ApiService().getRequest(endpoint);
      print("hhhkd");
      print("Response Data: $response");
      getLeaderboardList.value = LeaderboardDataModal.fromJson(response);
      update(['leader']);
    } catch (e) {
      print("Error occurred in leaderboard API call: $e");
    }
  }
  void updateIslamicDateBasedOnOption(int id) {
    final hijriDate = getExtractedData[0].date?.hijri;
    DateTime onlyDate  = DateTime.now();
    DateTime baseDate = DateTime(onlyDate.year, onlyDate.month, onlyDate.day,);
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

    final hijriNewDate = HijriCalendar.fromDate(newDate);
   // final hijriNewDate = HijriCalendar.fromDate(newDate.subtract(Duration(days: 1)));


    // Update the islamicDate value with the new Hijri date
    islamicDate.value =
    '${hijriNewDate.hDay} ${hijriNewDate.longMonthName} ${hijriNewDate.hYear}';
  }

  // Function to update timings and save to storage upon marking a prayer as prayed
  Future<void> markPrayerAsPrayed(String prayer) async {
    if (userData.getUserData!.fiqh.toString() == '0') { // Only apply for Shia fiqh
      if (prayer == 'Dhuhr') {
        // Dhuhr ends now and Asr can start immediately
        prayerDuration['Dhuhr']!['end'] =
            DateFormat('HH:mm').format(DateTime.now());
        prayerDuration['Asr']!['start'] = prayerDuration['Dhuhr']!['end']!;
        print(
            "Dhuhr marked as prayed. Asr start time updated to ${prayerDuration['Asr']!['start']}");
      } else if (prayer == 'Maghrib') {
        // Maghrib ends now and Isha can start immediately
        prayerDuration['Maghrib']!['end'] =
            DateFormat('HH:mm').format(DateTime.now());
        prayerDuration['Isha']!['start'] = prayerDuration['Maghrib']!['end']!;
        print(
            "Maghrib marked as prayed. Isha start time updated to ${prayerDuration['Isha']!['start']}");
      }

      // Save the updated prayer timings to storage
      userData.savePrayerTimings(prayerDuration);
      // storage.write('prayerDuration', prayerDuration);

      ///Fetch the updated prayer count///

    }
  }

// Sample usage for marking a prayer as prayed and saving updated times
  void onPrayerMarked(String prayerName) {
    markPrayerAsPrayed(prayerName);
    if(prayerName=='Dhuhr'||prayerName=='Maghrib') {
      moveToNextPrayer();
    }
  }

  List weeklyRanked = [];
  // weeklyApi() async {
  //   // String formatDate = getFormattedDate();
  //   String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate.value);
  //   var request = http.Request('GET', Uri.parse('http://182.156.200.177:8011/adhanapi/friend-weekly-prayer-response/?user_id=${userData.getUserData!.id}&date=$formattedDate'));
  //   http.StreamedResponse response = await request.send();
  //   print("URL ${request.url.toString()}");
  //
  //   if (response.statusCode == 200) {
  //     // print(await response.stream.bytesToString());
  //     var data = jsonDecode(await response.stream.bytesToString());
  //     // print("weekly baqar ${data['ranked_friends']}");
  //     // if(data['ranked_friends'].isNotEmpty){
  //     //   // height.value= double.parse(data['ranked_friends'][0]['percentage'].toStringAsFixed(2));
  //     // }
  //     // height.value= sizedBoxHeight(data['ranked_friends']);
  //     weeklyRanked = data['ranked_friends'];
  //     print("decodeData $data");
  //     // updateLeaderboardList = decodeData;
  //     // List recordData= data['records'];
  //     // recordsList= recordData.map((e)=>Record.fromJson(e)).toList();
  //     // print("recordList $recordsList");
  //     // weeklyMissedPrayer.value = groupByDate(recordsList);
  //     update();
  //     print("WeeklyApi data check:$weeklyRanked");
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }
  weeklyApi() async {
    try {
        String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate.value);
      String endpoint = 'friend-weekly-prayer-response/?user_id=${userData.getUserData!.id}&date=$formattedDate';
      final response = await ApiService().getRequest(endpoint);
      print("hju");
      print("Response Data: $response");
        weeklyRanked = response['ranked_friends'];
      update();
      print("weekly data check: $weeklyRanked");
    } catch (e) {
      print("Error occurred in Weekly API call: $e");
    }
  }

  // Function to check if current time (tap event) is within range
  bool isTimeWithinRange(String startTime,String endTime,String tapTime) {
    // Get current time
    DateTime now = DateTime.now();

    // Parse the start and end times
    DateTime start = _parseTime(startTime, now);
    DateTime end = _parseTime(endTime, now);
    print("00 $start");
    print("00 $end");

    // Parse the tap time (in 24-hour format)
    DateTime tapEventTime = _parse24HourTime(tapTime, now);
    print("00 $tapEventTime");

    // Check if the tap event time is within or equal to the range
    return (tapEventTime.isAfter(start) || tapEventTime.isAtSameMomentAs(start)) &&
        (tapEventTime.isBefore(end) || tapEventTime.isAtSameMomentAs(end));
  }
  // Function to parse a time string (12-hour format) into a DateTime object
  DateTime _parseTime(String timeStr, DateTime now) {
    final format = DateFormat("hh:mm a"); // Hour-Minute AM/PM format
    DateTime parsedTime = format.parse(timeStr);

    // Set the date of the parsed time to today
    return DateTime(now.year, now.month, now.day, parsedTime.hour, parsedTime.minute);
  }

  // Function to parse a 24-hour time string into a DateTime object
  DateTime _parse24HourTime(String timeStr, DateTime now) {
    final format = DateFormat("HH:mm"); // 24-hour format
    DateTime parsedTime = format.parse(timeStr);

    // Set the date of the parsed time to today
    return DateTime(now.year, now.month, now.day, parsedTime.hour, parsedTime.minute);
  }

}








