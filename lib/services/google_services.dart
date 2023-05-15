import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleServices {
  static Future<bool> googleSignIn() async {
    try {
      final GoogleSignIn signIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await signIn.signIn();

      final GoogleSignInAuthentication googleSignInAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> googleSignOut() async {
    final GoogleSignIn signIn = GoogleSignIn();
    await FirebaseAuth.instance.signOut();
    await signIn.signOut();
  }

  static Future<bool> checkIfUserIsAlreadyLoggedIn() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  static String getCurrentUserName() {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return user.displayName!;
    } else {
      return "User";
    }
  }
}
