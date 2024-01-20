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

class Complaint {
  final String problemType;
  final String probText;
  final String problemDesc;
  final String base64Image;
  final int isUrgent;

  Complaint({required this.problemType, required this.probText, required this.problemDesc, required this.base64Image, required this.isUrgent});

  factory Complaint.fromJson(Map<String, dynamic> json) => 
    Complaint(problemType: json['problemType'], probText: json['probText'], problemDesc: json['problemDesc'], base64Image: json['base64Image'], isUrgent: json['isUrgent']);

  Map<String ,dynamic> toJson() => {'problemType': problemType, 'probText': probText, 'problemDesc': problemDesc, 'base64Image': base64Image, 'isUrgent': isUrgent};
}