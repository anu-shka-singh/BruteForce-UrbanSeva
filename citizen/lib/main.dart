// import 'package:citizen/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'login/splash.dart';
// import 'package:flutter/material.dart';
//
// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(
//     const MyApp(),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primaryColor: const Color(0xFF21222D),
//       ),
//       title: 'Urban Seva',
//       home: const MyHomePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login/splash.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF21222D),
      ),
      title: 'Urban Seva',
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}