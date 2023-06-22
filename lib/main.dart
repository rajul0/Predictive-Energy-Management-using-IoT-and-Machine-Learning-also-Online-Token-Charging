import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:i30_app/user/login_user_page.dart';
import 'package:i30_app/user/user_home_page.dart';
import 'package:i30_app/user/user_profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => LoginPageUser(),
        '/home': (context) => HomePageUser(),
        '/profile': (context) => UserProfilePage(),
      },
      debugShowCheckedModeBanner: false,
      home: LoginPageUser(),
    );
  }
}
