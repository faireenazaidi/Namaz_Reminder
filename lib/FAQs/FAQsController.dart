import 'package:get/get.dart';

class FAQController extends GetxController {
  // List of FAQs
  List<Map<String, dynamic>> faqs = [
    {
      'question': 'What is the purpose of "Prayer o Clock" App ?',
      'answer': 'The "Prayer o Clock" app is designed to help users stay consistent with their daily prayers by offering timely reminders for each prayer time. It encourages users to build a habit of praying by tracking their streaks, which they can also share with friends for mutual motivation and support. The app fosters a sense of community and accountability, helping users strengthen their prayer routines while connecting with others who share similar goals.',
      'isExpanded': true
    },
    {'question': 'Is the app free to use?', 'answer': 'Yes, the app is free to use.', 'isExpanded': false},
   // {'question': 'How do I set my location for accurate prayer times?', 'answer': 'You can set your location in the settings for accurate prayer times.', 'isExpanded': false},
    {'question': 'Can I receive Azan notifications?', 'answer': 'Yes, Azan notifications can be enabled.', 'isExpanded': false},

  ];

  // Toggle the expanded state of the selected FAQ
  void toggleExpansion(int index) {
    faqs[index]['isExpanded'] = !faqs[index]['isExpanded'];
    update();
  }
}
