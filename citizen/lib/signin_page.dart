// ignore_for_file: use_build_context_synchronously

import 'package:citizen/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dbHelper/constant.dart';
import 'dbHelper/mongodb.dart';
import 'user_dashboard.dart';
import 'signup_page.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

void main() {
  runApp(const MaterialApp(home: LoginPage()));
}

class _LoginState extends State<LoginPage> {

  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  var userData;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
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
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Enter Email",
                    icon: Icon(Icons.email),
                    border: OutlineInputBorder(), // Add a border
                  ),
                  controller: _emailTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Enter Password",
                      icon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder()),
                  controller: _passwordTextController,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, true, () async {
                  try {
                    bool userExists = await checkUserExistence();

                    if (userExists) {
                      User? user = await _auth.signInWithEmailANdPassword(
                          _emailTextController.text,
                          _passwordTextController.text);

                      if(user != null)
                        {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Success'),
                              content: const Text('Login Successful.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Dashboard(
                                            user: _emailTextController.text)),
                                  ),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      else{
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
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }

                    } else {
                      // User doesn't exist, show appropriate dialog or handle it as needed
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text("User Doesn't Exist"),
                          content: const Text('Sign Up to continue'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()),
                              ),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  }//on FirebaseAuthException
                  catch (error) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                                title: const Text('Error'),
                                content: Text(
                                    "Error ${error.toString().split(']')[1]}"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('OK'),
                                  )
                                ]));
                  }
                }),
                const SizedBox(
                  height: 10,
                ),
                signUpOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? ",
            style: TextStyle(color: Color(0xFF21222D))),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUp()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
                color: Color(0xFF21222D), fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
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
        "Sign In",
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
        ),
      ),
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
