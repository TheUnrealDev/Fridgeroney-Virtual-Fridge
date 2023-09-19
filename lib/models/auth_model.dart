import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get isSignedIn => _auth.currentUser != null;

  AuthModel() {
    debugPrint("auth model created");
  }

  Future<bool> signUp(String email, String password) async {
    bool success = false;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
            (userCredential) => {
              debugPrint(FirebaseAuth.instance.currentUser.toString()),
              notifyListeners(),
            },
          );
      success = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        debugPrint("An user already exists with this email!");
      } else if (e.code == 'invalid-email') {
        debugPrint("The email is invalid!");
      } else if (e.code == 'operation-not-allowed') {
        debugPrint(
          "Email+Password sign ins are not enabled. Enable it in the Firebase Console.",
        );
      } else if (e.code == 'weak-password') {
        debugPrint("The password is not strong enough!");
      } else {
        debugPrint(e.code);
      }
    }

    return success;
  }

  void signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      } else {
        debugPrint(e.code);
      }
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
