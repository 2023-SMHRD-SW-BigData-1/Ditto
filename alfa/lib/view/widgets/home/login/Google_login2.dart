import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alfa/provider/shared.dart';

class Google_login2 extends StatefulWidget {
  const Google_login2({super.key});

  @override
  State<Google_login2> createState() => _MyAppState();
}

class _MyAppState extends State<Google_login2> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String? name, imageUrl, userEmail, uid, userNum;

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
  //   return MaterialApp(
  //     title: 'Flutter Demo',
  //     theme: ThemeData(
  //       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  //       useMaterial3: true,
  //     ),
  //     home: ElevatedButton(
  //         onPressed: () {
  //           signInWithGoogle();
  //         },
  //         child: const Text("Google Login")),
  //   );
  // }

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

      // DataManager.saveData('google_name', name)
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setBool('auth', true);
      print("name: $name");
      print("userEmail: $userEmail");
      print("imageUrl: $imageUrl");
      print("user : $user");
      print("uid : $uid");
    }
    return user;
  }
}
