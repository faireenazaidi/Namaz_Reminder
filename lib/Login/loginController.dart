import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import '../Routes/approutes.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();


      if (googleUser == null) {
        print('yessss');
        return null;
      }
      print('nooo $googleUser');

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;


      if (user != null) {
        // User successfully signed in
        print("User Name: ${user.displayName}");
        print("User Email: ${user.email}");
        Get.toNamed(AppRoutes.dashboardRoute); // Navigate to dashboard after login
      }
      return user;
    } catch (e) {
      print('exception:$e.toString()');
      Get.snackbar("Error", "Failed to sign in with Google");
      return null;
    }
  }

  void signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
