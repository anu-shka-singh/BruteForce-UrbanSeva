import 'package:flutter/material.dart';
import 'package:flutter_dashboard/dashboard.dart';
import 'package:provider/provider.dart';
import 'home/user_provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final TextEditingController _passwordTextController = TextEditingController();
final TextEditingController _emailTextController = TextEditingController();
var userData;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    String email = '';
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
                    labelText: 'Email',
                  ),
                  onChanged: (value) {
                    email = value;
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
                  onPressed: () async {
                    try {
                      bool userExists = await doesUserExists(email);
                      if (userExists) {
                        String userEmail = email;
                        Provider.of<UserProvider>(context, listen: false)
                            .setUserEmail(userEmail);
                        while (userData['pswd'] != password) {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Try Again"),
                              content: const Text('Incorrect Password'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()),
                                    );
                                    _emailTextController.text = userEmail;
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DashBoard()),
                        );
                      } else {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Invalid Credentials"),
                            content: const Text('Try Again'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                ),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    } catch (e) {
                      print('Error connecting to MongoDB: $e');
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

// Future<bool> doesUserExists(String email) async {
//   try {
//     // Check if the email is already registered
//     final userCollection = MongoDatabase.db.collection(GOVN_COLLECTION);
//     userData = await userCollection.findOne(
//       mongo_dart.where.eq('email', email),
//     );

//     // If methods is not empty, a user with this email exists
//     return userData.isNotEmpty;
//   } catch (e) {
//     // Handle any errors
//     return false;
//   }
// }

Future<bool> doesUserExists(String email) async {
  try {
    final response = await http.get(
      Uri.parse(
          'https://node-server-us.onrender.com/api/checkUser?email=$email'),
    );

    // Check the response from the server
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      userData = data['userdata'];
      print('UserData: $userData');
      return data['exists'];
    } else {
      return false;
    }
  } catch (e) {
    // Handle network errors
    return false;
  }
}
