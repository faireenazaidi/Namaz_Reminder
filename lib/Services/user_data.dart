import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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

  Future<void> addUserData(UserModel personModal) async {
    await _storage.write('personModal', personModal.toJson());
    update(); // Notify listeners of changes
  }

  Future<void> addLocationData(LocationDataModel location) async {
    await _storage.write('location', location.toJson());
    update(); // Notify listeners of changes
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
    update();
  }
}
