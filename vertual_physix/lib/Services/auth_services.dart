import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_physix/Screens/home_page.dart';

class AuthService {
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Configure GoogleSignIn with the required scopes
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
        ],
      );

      // Begin interactive sign-in process
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();

      if (gUser != null) {
        // Obtain auth details from request
        final GoogleSignInAuthentication gAuth = await gUser.authentication;

        // Create a new credential for the user
        final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );

        // Finally, let's sign in
        final authResult = await FirebaseAuth.instance.signInWithCredential(credential);

        // If the sign-in is successful, retrieve and pass user data to UpdateProfileScreen
        if (authResult.user != null) {
          final user = authResult.user!;
          AuthService.setLoggedIn(true);
          Navigator.pop(context);
          // Store user data in Firestore
          FirebaseFirestore firestore = FirebaseFirestore.instance;
          CollectionReference userDataCollection = firestore.collection('user_data');

          await userDataCollection.doc(user.uid).set({
            'email': user.email ?? "",
            'userProfilePic': user.photoURL ?? "",
            'userName': user.displayName ?? "",
          });
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      }
    } catch (e) {
      // Handle any errors that occur during sign-in
      print("Error during sign-in: $e");
    }
  }
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await setLoggedIn(false);
  }
}