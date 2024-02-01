//use_build_context_synchronously

import 'dbHelper/constant.dart';
import 'dbHelper/datamodels.dart';
import 'user_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;
import 'dbHelper/mongodb.dart';
import 'signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();

  Future<void> registerUserInFirebase(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // User is registered in Firebase, now store additional data in MongoDB
      final data = Users(
        name: _nameTextController.text,
        userId: userCredential.user?.uid ?? '', // Firebase UID
      );

      await MongoDatabase.db.collection(USER_COLLECTION).insert(data.toJson());

      // Continue with your success dialog or navigation
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException, e.g., if the email is already in use
      print('Firebase Auth Exception: ${e.message}');
      // Show an error dialog or take appropriate action
    } catch (e) {
      // Handle other errors
      print('Error: $e');
      // Show an error dialog or take appropriate action
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF21222D),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              top: size.height * 0.1,
              right: 20,
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
                Image.asset("images/urban.png"),
                const SizedBox(
                  height: 40,
                ),
                // Use InputDecoration for text fields
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Enter Name",
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  // Use controller property to bind the controller
                  controller: _nameTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Enter Email",
                    icon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  // Use controller property to bind the controller
                  controller: _emailTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                // Use InputDecoration for text fields
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Enter Password",
                    icon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                  // Use controller property to bind the controller
                  controller: _passwordTextController,
                  obscureText: true, // Hide the password
                ),
                const SizedBox(
                  height: 20,
                ),

                // Use a custom button widget for reusability
                signInSignUpButton(context, false, () async {
                  final userExists =
                  await checkUserExistence();
                  if (userExists) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('User Already Exists'),
                        content:
                        const Text('This email is already registered.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage())),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    try {
                      await registerUserInFirebase(_emailTextController.text,
                          _passwordTextController.text);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Success'),
                          content: const Text('New User Registered.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboard(
                                        user: _nameTextController.text)),
                              ),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                    //on FirebaseAuthException
                    catch (error) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Error'),
                          content: Text("Error ${error.toString()}"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                }),
                const SizedBox(
                  height: 10,
                ),
                signInOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account? ",
            style: TextStyle(color: Color(0xFF21222D))),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          child: const Text(
            "Sign In",
            style: TextStyle(
                color: Color(0xFF21222D), fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Future<bool> checkUserExistence() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    // Get the current user
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      print('User exists. User ID: ${currentUser.uid}');
      return true;
    } else {
      print('User does not exist.');
      return false;
    }
  }
}

Widget signInSignUpButton(
    BuildContext context, bool isSignIn, Function() onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF21222D),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      minimumSize: const Size(150, 50),
    ),
    child: const Text(
      "Sign Up",
      style: TextStyle(
        fontSize: 22,
        color: Colors.white,
      ),
    ),
  );
}