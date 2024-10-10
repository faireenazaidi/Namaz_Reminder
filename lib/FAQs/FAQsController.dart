import 'package:get/get.dart';

class FAQController extends GetxController {
  // List of FAQs
  List<Map<String, dynamic>> faqs = [
    {
      'question': 'What is the purpose of this Islamic app?',
      'answer': 'This app is designed to help Muslims with their daily spiritual practices by providing access to various Islamic resources, such as Quran readings, prayer times, supplications (duas), and Islamic lectures.',
      'isExpanded': true
    },
    {'question': 'Is the app free to use?', 'answer': 'Yes, the app is free to use.', 'isExpanded': false},
    {'question': 'Does the app support multiple languages?', 'answer': 'Yes, the app supports multiple languages.', 'isExpanded': false},
    {'question': 'Can I read the Quran offline?', 'answer': 'Yes, the Quran can be read offline.', 'isExpanded': false},
    {'question': 'Does the app offer multiple Quran translations?', 'answer': 'Yes, the app offers multiple Quran translations.', 'isExpanded': false},
    {'question': 'Can I listen to Quran recitation?', 'answer': 'Yes, Quran recitation is available.', 'isExpanded': false},
    {'question': 'How do I set my location for accurate prayer times?', 'answer': 'You can set your location in the settings for accurate prayer times.', 'isExpanded': false},
    {'question': 'Can I receive Azan notifications?', 'answer': 'Yes, Azan notifications can be enabled.', 'isExpanded': false},
    {'question': 'Does the app provide daily duas?', 'answer': 'Yes, the app provides daily duas.', 'isExpanded': false},
    {'question': 'Are there translations and transliterations of the duas?', 'answer': 'Yes, translations and transliterations are provided.', 'isExpanded': false},
  ];

  // Toggle the expanded state of the selected FAQ
  void toggleExpansion(int index) {
    faqs[index]['isExpanded'] = !faqs[index]['isExpanded'];
    update();
  }
}
