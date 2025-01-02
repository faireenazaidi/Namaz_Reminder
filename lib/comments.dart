// Container(
// child: Image.asset(
// "assets/notifi.gif",
// )
// );
//
// Future<void> fetchMissedPrayersCount() async {
//   try {
//     final requestUrl = 'http://182.156.200.177:8011/adhanapi/missed-prayers/?user_id=${userData.getUserData!.id}&prayername=${currentPrayer}';
//     print('Request URL: $requestUrl');
//
//     final response = await http.get(Uri.parse(requestUrl));
//
//     if (response.statusCode == 200) {
//       print('Raw API Response: ${response.body}');
//       var data = jsonDecode(response.body);
//       print('Parsed JSON: $data');
//
//       missedPrayersCount.value = data['total_missed_prayers'] ?? 0;
//       print('Total Missed Prayers: ${missedPrayersCount.value}');
//
//       if (data.containsKey('pending_requests')) {
//         pending.value = data['pending_requests'];
//       } else {
//         print('Key "total_pending" does not exist in the response.');
//         pending.value = 0; // Fallback value
//       }
//       print('Pending Value: ${pending.value}');
//     } else {
//       print('Failed to fetch data. Status Code: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error fetching missed prayers count: $e');
//   }
// }
// void markPrayerAsPrayed(String prayer) {
//   if (userData.getUserData!.fiqh.toString() == '0') { // Only apply for Shia fiqh
//     if (prayer == 'Dhuhr') {
//       // Dhuhr ends now and Asr can start immediately
//       prayerDuration['Dhuhr']!['end'] = DateFormat('HH:mm').format(DateTime.now());
//       prayerDuration['Asr']!['start'] = prayerDuration['Dhuhr']!['end']!;
//       print("Dhuhr marked as prayed. Asr start time updated to ${prayerDuration['Asr']!['start']}");
//     } else if (prayer == 'Maghrib') {
//       // Maghrib ends now and Isha can start immediately
//       prayerDuration['Maghrib']!['end'] = DateFormat('HH:mm').format(DateTime.now());
//       prayerDuration['Isha']!['start'] = prayerDuration['Maghrib']!['end']!;
//       print("Maghrib marked as prayed. Isha start time updated to ${prayerDuration['Isha']!['start']}");
//     }
//
//     // Save the updated prayer timings to storage
//     userData.savePrayerTimings(prayerDuration);
//     // storage.write('prayerDuration', prayerDuration);
//   }
// }
