import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UserRepository {
  FirebaseAuth firebaseAuth;

  UserRepository() {
    this.firebaseAuth = FirebaseAuth.instance;
  }

  Future<User> createUser(email, password) async {
    try {
      var result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user;

      return user;
    } on PlatformException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User> signInUser(String email, String password) async {
    var result = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    return result.user;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<bool> isUserSignedIn() async {
    final User user = firebaseAuth.currentUser;
    return user != null;
  }

  Future<User> getCurrentUser() async {
    return firebaseAuth.currentUser;
  }
}
