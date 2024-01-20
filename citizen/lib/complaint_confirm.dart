import 'package:flutter/material.dart';

import 'user_dashboard.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Directionality(
        textDirection: TextDirection.ltr, // Set the text direction to LTR
        child: ComplaintConfirmation(),
      ),
    ),
  );
}

class ComplaintConfirmation extends StatefulWidget {
  const ComplaintConfirmation({super.key});

  @override
  State<ComplaintConfirmation> createState() => _ComplaintConfirmationState();
}

class _ComplaintConfirmationState extends State<ComplaintConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF21222D),
        automaticallyImplyLeading: false,
        // title: Text('Confirmation'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30.0),
              const Text(
                "Confirmation",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF21222D),
                ),
              ),
              const SizedBox(
                  height: 50.0), // Add a SizedBox for spacing at the top
              Image.asset(
                'images/confetti.png', // Replace with your image path
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 40.0),
              const Text(
                "Complaint Successfully Raised",
                style: TextStyle(color: Color(0xFF21222D), fontSize: 20),
              ),
              const SizedBox(height: 30.0),
              const Text(
                "We want you to sit back and relax. Resolving your complaint will be our top priority.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50.0),
              Card(
                elevation: 10,
                color: const Color(0xFF21222D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                    color: Color(0xFF21222D),
                    width: 2.0,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dashboard(user: ''),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          "Go to home page",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
