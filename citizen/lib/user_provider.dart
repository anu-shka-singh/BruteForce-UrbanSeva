import 'package:flutter/material.dart';
import '../../dbHelper/constant.dart';
import '../../dbHelper/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;



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
      final userCollection = MongoDatabase.db.collection(USER_COLLECTION);
      userData = await userCollection.findOne(
        mongo_dart.where.eq('email', _userEmail),
      );

      // If methods is not empty, a user with this email exists
      // Fetch additional data based on the email
      // ...

      // Notify listeners to update the UI
      notifyListeners();
    } catch (e) {
      print(e);
      // Handle any errors
    }
  }
}