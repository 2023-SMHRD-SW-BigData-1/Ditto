import 'package:firebase_auth/firebase_auth.dart';

// 사용자 등록
Future<void> registerUser() async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: 'user@example.com', password: 'password123');
    User? user = userCredential.user;
    print('User registered: ${user?.uid}');
  } catch (e) {
    print('Error registering user: $e');
  }
}

// 사용자 로그인
Future<void> loginUser() async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: 'user@example.com', password: 'password123');
    User? user = userCredential.user;
    print('User logged in: ${user?.uid}');
  } catch (e) {
    print('Error logging in: $e');
  }
}

// 사용자 로그아웃
Future<void> logoutUser() async {
  await FirebaseAuth.instance.signOut();
  print('User logged out');
}
