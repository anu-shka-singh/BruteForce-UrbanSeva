import 'user_provider.dart';
import 'package:provider/provider.dart';

import 'splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
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
