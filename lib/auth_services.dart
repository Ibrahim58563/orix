import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:orix/screens/cart_screen.dart';
import 'package:orix/screens/home_screen.dart';
import 'package:orix/screens/login_screen.dart';

class AuthServices {
  //1- handle Auth State

  //Determine if the user is authenticated.
  handleAuthState() {
    return StreamBuilder(
        // let us know wheter snapshot has data or not
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return LoginScreen();
          }
        });
  }

  //2- signInWithGoogle

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //3- signOut
  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
