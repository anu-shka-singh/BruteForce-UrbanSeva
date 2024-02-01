import 'dart:convert';

Users mongoDbFromJson(String str) => Users.fromJson(json.decode(str));

String mongoDbToJson(Users data) => json.encode(data.toJson());

class Users {
  final String userId;
  final String name;

  Users({required this.userId, required this.name});

  factory Users.fromJson(Map<String, dynamic> json) =>
      Users(userId: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {'id': userId, 'name': name};
}

class Complaint {
  final String problemType;
  final String probText;
  final String problemDesc;
  final String base64Image;
  final int resolveStatus;
  final int isUrgent;

  Complaint({required this.problemType, required this.probText, required this.problemDesc, required this.base64Image, required this.resolveStatus, required this.isUrgent});

  factory Complaint.fromJson(Map<String, dynamic> json) => 
    Complaint(problemType: json['problemType'], probText: json['probText'], problemDesc: json['problemDesc'], base64Image: json['base64Image'], resolveStatus: json['resolveStatus'], isUrgent: json['isUrgent']);

  Map<String ,dynamic> toJson() => {'problemType': problemType, 'probText': probText, 'problemDesc': problemDesc, 'base64Image': base64Image, 'resolveStatus': resolveStatus, 'isUrgent': isUrgent};
}