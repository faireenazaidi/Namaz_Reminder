import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'AddFriendDataModal.dart';

class AddFriendController extends GetxController{
  var requests = <Person>[].obs;
  var contacts = <Person>[].obs;
  var nearbyPeople = <Person>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  void loadInitialData() {
    // Load your data here
    // For example:
    requests.assignAll([
      Person(name: 'Sharmad Ahmed', phoneNumber: '', imageUrl: 'assets/sharmad.png'),
    ]);
    contacts.assignAll([
      Person(name: 'Abdul Rasheed', phoneNumber: '(319) 555-0115', imageUrl: ''),
      Person(name: 'Shahzaib Khan', phoneNumber: '(319) 555-0115', imageUrl: ''),
      Person(name: 'Mansoor Khan', phoneNumber: '(319) 555-0115', imageUrl: ''),
    ]);
    nearbyPeople.assignAll([
      Person(name: 'Bilawal Shah', phoneNumber: '(319) 555-0115', imageUrl: ''),
    ]);
  }

  void acceptRequest(Person person) {
    requests.remove(person);

  }

  void invitePerson(Person person) {

  }
}
