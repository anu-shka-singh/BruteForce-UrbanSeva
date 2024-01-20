import 'dart:convert';

Alert mongoDbFromJson(String str) => Alert.fromJson(json.decode(str));

String mongoDbToJson(Alert data) => json.encode(data.toJson());

class Alert {
  final String auth;
  final String desc;
  final String date;
  final String sTime;
  final String eTime;

  Alert(
      {required this.auth,
      required this.desc,
      required this.date,
      required this.sTime,
      required this.eTime});

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
      auth: json['auth'],
      desc: json['desc'],
      date: json['date'],
      sTime: json['sTime'],
      eTime: json['eTime']);

  Map<String, dynamic> toJson() => {
        'auth': auth,
        'desc': desc,
        'date': date,
        'sTime': sTime,
        'eTime': eTime
      };
}
