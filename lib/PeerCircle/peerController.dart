import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PeerController extends GetxController{
  var searchText = ''.obs;

  void setSearchText(String value) {
    searchText.value = value;
  }

  var peers = <Map<String, dynamic>>[
  {'name': 'Amira', 'phone': '(319) 555-0115'},
  {'name': 'Waleed Ahmed', 'phone': '(319) 555-0115'},
  ].obs;

  void removePeer(int index) {
  peers.removeAt(index);
  }

}