import 'package:flutter/material.dart';
import 'package:flutter_dashboard/dashboard.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // Define a map of credentials (username and password)
  final Map<String, String> credentials = {
    'gov7856': '123456',
    'mcd1234': '987654',
  };

  @override
  Widget build(BuildContext context) {
    String username = '';
    String password = '';

    return Scaffold(
      backgroundColor: const Color(0xFF21222D),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: 500, // Adjust the width as needed
            padding: const EdgeInsets.symmetric(
                horizontal: 40.0), // Add horizontal padding
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/urban.png',
                  width: 350,
                  height: 200,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                  onChanged: (value) {
                    username = value;
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Check if the entered credentials are valid
                    if (credentials.containsKey(username) &&
                        credentials[username] == password) {
                      // Navigate to the Home Page if credentials are valid
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DashBoard()),
                      );
                    } else {
                      // Show an invalid credentials dialog box
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Invalid Credentials'),
                          content: const Text(
                              'Please check the username and password.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF21222D)),
                    minimumSize: MaterialStateProperty.all(const Size(150, 50)),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
