// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../screens/user_dashboard.dart';
import 'signup_page.dart';

GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly'
  ],
);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

void main() {
  runApp(const MaterialApp(home: LoginPage()));
}

class LoginState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  var userData;
  late GoogleSignInAccount currentUser;

  @override
  void initState() {
    super.initState();

    googleSignIn.onCurrentUserChanged.listen(
      (account) {
        setState(() {
          currentUser = account!;
        });

        if (currentUser != null) {
          print("User is already authenticated");
        }
      },
    );
    googleSignIn.signInSilently();
  }

  Future<void> handleSignIn() async {
    try {
      await googleSignIn.signIn();
    } catch (error) {
      print("Sign in error: $error");
    }
  }

  Future<void> handleSignOut() => googleSignIn.disconnect();

  // void fetchName(String? uid) async {
  //   final collection = MongoDatabase.db.collection('Users');
  //   final query = mongo.where.eq('id', uid);
  //   final cursor = await collection.find(query);
  //   print(cursor.toList());
  //   String name = await cursor.toList()[0][0];
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => Dashboard(user: name)),
  //   );
  // }

  void signin() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      );

      if (userCredential.user != null) {
        // User exists, proceed with login

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
                      builder: (context) =>
                          Dashboard(user: userCredential.user?.uid)),
                ),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Handle if userCredential.user is null
        await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text("User Doesn't Exist"),
            content: const Text('Sign Up to continue'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp()),
                ),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Handle authentication errors
      await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Try Again"),
          content: Text(e.toString()),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

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
                signInSignUpButton(context, true, signin),
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
}
