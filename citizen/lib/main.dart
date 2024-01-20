import 'package:complaint_app/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF21222D),
      ),
      title: 'Urban Seva',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
