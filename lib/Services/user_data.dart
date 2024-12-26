import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:namaz_reminders/DataModels/LoginResponse.dart';
import '../LocationSelectionPage/locationPageDataModal.dart';

class UserData extends GetxController {
  final _storage = GetStorage('user');
  String get getUserToken => (_storage.read('userToken')) ?? '';

  UserModel? get getUserData {
    final data = _storage.read('personModal');
    if (data != null) {
      return UserModel.fromJson(Map<String, dynamic>.from(data));
    }
    return null;
  }

  LocationDataModel? get getLocationData {
    final data = _storage.read('location');
    if (data != null) {
      return LocationDataModel.fromJson(Map<String, dynamic>.from(data));
    }
    return null;
  }

  // Map<String, Map<String, String>> get getPrayerDurationForShia {
  //   final data = _storage.read('duration');
  //   if (data != null) {
  //     // Casting the retrieved data to Map<String, Map<String, String>>
  //     return Map<String, Map<String, String>>.from(
  //       data.map((key, value) => MapEntry(
  //           key as String, // Cast key to String
  //           Map<String, String>.from(value as Map) // Cast inner map to Map<String, String>
  //       )),
  //     );
  //   }
  //   return {};
  // }
  /// Retrieve prayer timings for the current day
  Map<String, Map<String, String>> get getPrayerDurationForShia {
    final data = _storage.read('duration');
    if (data != null) {
      final storedDate = data['date']; // Retrieve stored date
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      if (storedDate == today) {
        // Return timings only if the date matches today
        return Map<String, Map<String, String>>.from(
          data['duration'].map((key, value) => MapEntry(
            key as String,
            Map<String, String>.from(value as Map),
          )),
        );
      } else {
        // Clear old data if the date has changed
        _storage.remove('duration');
      }
    }
    return {}; // Return empty map if no data or date mismatch
  }



  Future<void> addUserData(UserModel personModal) async {
    await _storage.write('personModal', personModal.toJson());
    update(); // Notify listeners of changes
  }

  Future<void> addLocationData(LocationDataModel location) async {
    await _storage.write('location', location.toJson());
    update(); // Notify listeners of changes
  }
  // Future<void> addPrayerDurationForShia(Map<String, Map<String, String>> duration) async {
  //   await _storage.write('duration', duration);
  //   update(); // Notify listeners of changes
  // }
  /// Save prayer timings for the current day
  Future<void> savePrayerTimings(Map<String, Map<String, String>> timings) async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final data = {
      'date': today,
      'duration': timings,
    };
    await _storage.write('duration', data);
    update();
  }

  ///sound
  // Define default sound settings for all prayers
  final Map<String, bool> defaultSoundSettings = {
    'Fajr': true,
    'Dhuhr': true,
    'Asr': true,
    'Maghrib': true,
    'Isha': true,
  };


  // Initialize settings in GetStorage if not already present or if it's a new day
  void initializePrayerSettings() {
    final String today = DateTime.now().toIso8601String().split('T')[0]; // Get today's date in YYYY-MM-DD format
    final String? storedDate = _storage.read<String>('lastUpdatedDate');

    // Check if settings are stored and if they're from today
    if (storedDate == null || storedDate != today) {
      // Store default settings and update last updated date
      _storage.write('prayerSoundSettings', defaultSoundSettings);
      _storage.write('lastUpdatedDate', today);
    }
  }
  // void initializePrayerSettings() {
  //   if (!_storage.hasData('prayerSoundSettings')) {
  //     _storage.write('prayerSoundSettings', defaultSoundSettings);
  //   }
  // }

  // Get sound setting for a specific prayer
  bool isSoundEnabled(String prayerName) {
    final settings = _storage.read<Map<String, dynamic>>('prayerSoundSettings');
    return settings?[prayerName] ?? true;
  }

  // Toggle sound setting for a specific prayer and update storage
  void toggleSound(String prayerName) {
    final settings = _storage.read<Map<String, dynamic>>('prayerSoundSettings');
    settings?[prayerName] = !(settings?[prayerName] ?? true);
    _storage.write('prayerSoundSettings', settings);
  }


  // Method to save the list data directly into GetStorage
  Future<void> savePrayerMonthTime(List listData) async {
    await _storage.write('prayerTimingsData', listData);
    update();  // Notify listeners of changes
  }

  // Method to retrieve the saved list data
  List get getPrayerTimingsData {
    final data = _storage.read('prayerTimingsData');
    if (data != null) {
      return List<Map<String, dynamic>>.from(data);
    }
    return [];
  }
  Future<void> clearPrayerTimings()async{
    await _storage.remove('prayerTimingsData');
  }


  // Optionally, add a method to clear user data
  Future<void> clearUserData() async {
    await _storage.remove('personModal');
    await _storage.remove('location');
    update(); // Notify listeners of changes
  }

  addToken(String val) async {
    await _storage.write('userToken', val);
    update();
  }

  removeUserData() async {
    await _storage.remove('personModal');
    await _storage.remove('userToken');
    await _storage.remove('location');
    await _storage.remove('duration');
    await _storage.remove('prayerTimingsData');

    update();
  }
}
