import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FeedbackController extends GetxController{

  var email = ''.obs;
  var rating = 0.obs;
  var comment = ''.obs;

  // Check if form is valid
  bool get isFormValid => rating.value > 0;

  void setEmail(String value) {
    email.value = value;
  }

  void setRating(int value) {
    rating.value = value;
  }

  void setComment(String value) {
    comment.value = value;
  }

  void submitFeedback() {
    if (isFormValid) {
      // Handle feedback submission logic here
      print('Feedback submitted: Email: ${email.value}, Rating: ${rating.value}, Comment: ${comment.value}');
    }
  }
}

