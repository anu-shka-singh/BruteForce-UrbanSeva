import 'package:flutter/material.dart';
import 'signin_page.dart';
import '../../dbHelper/mongodb.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

void main() {
  runApp(const MaterialApp(home: MyHomePage()));
}

class _MyHomePageState extends State<MyHomePage> {
  late io.Socket socket;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    // Initialize the local notifications plugin
    initializeNotifications();

    // Connect to the WebSocket server
    socket = io.io('https://node-server-us.onrender.com/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    // Handle events from the server
    socket.on('alertAdded', (data) {
      // Handle the incoming data and show notifications
      print('Received alertAdded event: $data');
      showNotification(data.toString());
    });

    _navigatetohome();
  }

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings(
        '@mipmap/ic_launcher'); // Update this line
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        // Handle notification click event
      },
    );
  }

  Future<void> showNotification(String message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'New Alert',
      message,
      platformChannelSpecifics,
    );
  }

  _navigatetohome() async {
    WidgetsFlutterBinding.ensureInitialized();
    await MongoDatabase.connect();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/logo.png'),
              //fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}