import 'dart:convert';

User mongoDbFromJson(String str) => User.fromJson(json.decode(str));

String mongoDbToJson(User data) => json.encode(data.toJson());

class User {
  final String email;
  final String pswd;
  final String name;

  User({required this.email, required this.pswd, required this.name});

  factory User.fromJson(Map<String, dynamic> json) =>
      User(email: json['email'], pswd: json['pswd'], name: json['name']);

  Map<String, dynamic> toJson() => {'email': email, 'pswd': pswd, 'name': name};
}
