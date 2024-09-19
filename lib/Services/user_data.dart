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

  Future<void> addUserData(UserModel personModal) async {
    await _storage.write('personModal', personModal.toJson());
    update(); // Notify listeners of changes
  }

  // Optionally, add a method to clear user data
  Future<void> clearUserData() async {
    await _storage.remove('personModal');
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
