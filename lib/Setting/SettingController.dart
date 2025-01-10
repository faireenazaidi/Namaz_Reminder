import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SettingController extends GetxController {
  var timeFormat = false.obs;

  // String formatTime(DateTime dateTime) {
  //   if (timeFormat.value) {
  //     // 24-hour format
  //     return DateFormat('HH:mm').format(dateTime);
  //   } else {
  //     // 12-hour format
  //     return DateFormat('hh:mm a').format(dateTime);
  //   }
  // }
}
