import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static User? get currentUser => FirebaseAuth.instance.currentUser;
  static Future<User?> signInWithGoogle() async {
    try {
      log("sign in google");
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // Nếu người dùng hủy đăng nhập, trả về null
        log("huy sign in");
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      log("user sign in: ${userCredential.user?.displayName}");
      return userCredential.user;
    } catch (e) {
      log("Error FirebaseService signInWithGoogle : $e");
      signOut();
      return null;
    }
  }

  static Future<UserCredential> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future signOut() async {
    if (currentUser != null) {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
    } else {
      print("Không có account ");
    }
  }
}
