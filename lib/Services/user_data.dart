import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../LocationSelectionPage/locationPageDataModal.dart';

class UserData extends GetxController {
  final _storage = GetStorage('user');
  String get getUserToken => (_storage.read('userToken')) ?? '';

  UserDetailsDataModal? get getUserData {
    final data = _storage.read('userDetails');
    if (data != null) {
      return UserDetailsDataModal.fromJson(Map<String, dynamic>.from(data));
    }
    return null;
  }

  Future<void> addUserData(UserDetailsDataModal userDetails) async {
    await _storage.write('userDetails', userDetails.toJson());
    update(); // Notify listeners of changes
  }

  // Optionally, add a method to clear user data
  Future<void> clearUserData() async {
    await _storage.remove('userDetails');
    update(); // Notify listeners of changes
  }

  addToken(String val) async {
    await _storage.write('userToken', val);
    update();
  }

  removeUserData() async {
    await _storage.remove('userDetails');
    await _storage.remove('userToken');
    await _storage.remove('headAssigned');
  }
}
