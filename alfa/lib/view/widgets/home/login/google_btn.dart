import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  clientId:
      '319935940047-9kuhg4tnr09ch6qff6lp03d63khtp5dl.apps.googleusercontent.com',
  scopes: scopes,
);

class Google_btn extends StatefulWidget {
  const Google_btn({super.key});

  @override
  State<Google_btn> createState() => _Google_btnState();
}

Future<Object?> signInWithGoogle() async {
  final FirebaseAuth fAuth = FirebaseAuth.instance; // Firebase 인증 플러그인의 인스턴스
  User _user;
  try {
    final GoogleSignInAccount? googleUser = (await _googleSignIn.signIn());

    GoogleSignInAuthentication googleAuth;

    try {
      googleAuth = await googleUser!.authentication;
    } catch (e) {
      return false;
    }
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    final User user = (await fAuth.signInWithCredential(credential)).user!;
    assert(user.email != null);
    final User currentUser = fAuth.currentUser!;
    assert(user.uid == currentUser.uid);

    return user; //유저를 return
  } on Exception catch (e) {
    try {
      print(e.toString()); //에러 출력
    } catch (e) {}
    return null;
  }
}

class _Google_btnState extends State<Google_btn> {
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
                Image.asset(
                  'assets/image/Google_logo.png',
                  width: 20.0,
                  height: 20.0,
                ),
                SizedBox(
                  width: 20,
                ),
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
}
