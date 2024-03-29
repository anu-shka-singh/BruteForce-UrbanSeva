import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  String _userEmail = '';
  Map<String, dynamic>? userData;
  String get userEmail => _userEmail;

  void setUserEmail(String email) {
    _userEmail = email;
    notifyListeners();
  }

  Future<void> fetchData() async {
    try {
      // Check if the email is already registered
      final response = await http.get(
        Uri.parse(
            'https://node-server-us.onrender.com/api/checkUser?email=$_userEmail'),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        userData = data['userdata'];
      }
      // Notify listeners to update the UI
      notifyListeners();
    } catch (e) {
      print(e);
      // Handle any errors
    }
  }
}
