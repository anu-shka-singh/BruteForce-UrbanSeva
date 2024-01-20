import 'package:flutter/material.dart';
import 'package:flutter_dashboard/const.dart';
import 'package:flutter_dashboard/pages/home/splash.dart';
import 'package:flutter_dashboard/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Urban Seva',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light, // Change to light mode
      theme: ThemeData(
        primaryColor: MaterialColor(
          primaryColorCode,
          <int, Color>{
            50: const Color(primaryColorCode).withOpacity(0.1),
            100: const Color(primaryColorCode).withOpacity(0.2),
            200: const Color(primaryColorCode).withOpacity(0.3),
            300: const Color(primaryColorCode).withOpacity(0.4),
            400: const Color(primaryColorCode).withOpacity(0.5),
            500: const Color(primaryColorCode).withOpacity(0.6),
            600: const Color(primaryColorCode).withOpacity(0.7),
            700: const Color(primaryColorCode).withOpacity(0.8),
            800: const Color(primaryColorCode).withOpacity(0.9),
            900: const Color(primaryColorCode).withOpacity(1.0),
          },
        ),
        scaffoldBackgroundColor:
            Colors.grey.shade100, // Change background color
        fontFamily: 'IBMPlexSans',
        brightness: Brightness.light, // Change to light mode
      ),
      home: const MyHomePage(),
      //home: LoginPage(),
    );
  }
}
