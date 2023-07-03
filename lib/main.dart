import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:i30_app/user/login_user_page.dart';
import 'package:i30_app/user/user_home_page.dart';
import 'package:i30_app/user/user_profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  bool isLoggedIn = await checkLoginStatus();
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

Future<bool> checkLoginStatus() async {
  // hanya butuh sekali login
  User? user = FirebaseAuth.instance.currentUser;
  return user != null;
}

class MyApp extends StatelessWidget {
  var isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => LoginPageUser(),
        '/home': (context) => HomePageUser(),
        '/profile': (context) => UserProfilePage(),
      },
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? NavbarBtmUser() : LoginPageUser(),
    );
  }
}
