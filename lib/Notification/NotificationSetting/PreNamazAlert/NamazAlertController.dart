import 'package:get/get.dart';

class NamazAlertController extends GetxController {
  var selectedId = 0.obs;

  @override
  void onInit()  {

    selectItem(selectedId.value);
    super.onInit();
  }
  List<Map<String, dynamic>> preNamazAlert = [
    {"id": 4, "name": "15 minutes ago"},
    {"id": 3, "name": "10 minutes ago"},
    {"id": 0, "name": "5 minutes ago"},
    {"id": 1, "name": "No Alert"},
  ];

  void updateSelectedId(int id) {
    selectedId.value = id; // Update reactive variable
  }
  void selectItem(int id) {
    updateSelectedId(id);

  }
  String getCurrentSubtitle() {
    // Find the entry matching the current selectedId
    final selectedOption = preNamazAlert.firstWhere(
          (option) => option['id'] == selectedId.value,
      orElse: () => {"id": null, "name": "No Alert"},
    );

    return selectedOption['name']; // Return the name of the matched option
  }

  }

