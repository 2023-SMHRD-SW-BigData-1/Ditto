import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:alfa/provider/shared.dart';
import 'package:alfa/server/dio.dart';

import 'package:crypto/crypto.dart';

class Google_login2 extends StatefulWidget {
  const Google_login2({super.key});

  @override
  State<Google_login2> createState() => _MyAppState();
}

class _MyAppState extends State<Google_login2> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String? name, imageUrl, userEmail, uid, userNum, userPw;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: 50.0,
          child: ElevatedButton(
            onPressed: signInWithGoogle,
            // ignore: sort_child_properties_last
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign in with Google',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 0,
              side: const BorderSide(
                  width: 2, color: Colors.black, style: BorderStyle.solid),
            ),
          ),
        ),
      ],
    );
  }

  Future<User?> signInWithGoogle() async {
    // Initialize Firebase
    await Firebase.initializeApp();
    User? user;
    FirebaseAuth auth = FirebaseAuth.instance;
    // The `GoogleAuthProvider` can only be
    // used while running on the web
    GoogleAuthProvider authProvider = GoogleAuthProvider();

    try {
      final UserCredential userCredential =
          await auth.signInWithPopup(authProvider);
      user = userCredential.user;
    } catch (e) {
      print(e);
    }

    if (user != null) {
      uid = user.uid;
      name = user.displayName;
      userEmail = user.email;
      userNum = user.phoneNumber;
      userPw = '0000';

      var bytes = utf8.encode(userPw!);
      var pwHash = sha256.convert(bytes).toString();

      await server.join(userEmail!, pwHash, name!, '01000000000');
      var result = DataManager.loadData('joinResult');

      if (result == 'success') {
        Navigator.of(context).pop();
      } else if (result == 'failed') {}
    }
    // return user;
  }
}
