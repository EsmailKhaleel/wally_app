// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wallyapp/screens/home_screen.dart';
import 'package:wallyapp/screens/login_screen.dart';
import 'package:wallyapp/screens/splash_screen.dart';
import 'package:wallyapp/style/costants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        appBarTheme: AppBarTheme(color: kPrimaryColor),
        bottomNavigationBarTheme:
            BottomNavigationBarThemeData(selectedItemColor: kPrimaryColor),
        brightness: Brightness.light,
      ),
      home: SplashScreen(),
    );
  }
}

class MainPage extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.authStateChanges(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return HomeScreen();
        } else if (snapshot.hasError) {
          return loginScreen();
        } else {
          return loginScreen();
        }
      }),
    );
  }
}
