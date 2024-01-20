import 'package:flutter/material.dart';
import 'dbHelper/mongodb.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Alerts(),
    ),
  );
}

class Alerts extends StatefulWidget {
  const Alerts({super.key});

  @override
  State<Alerts> createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
  List<Map<String, dynamic>> Alerts = [];

  void initState() {
    super.initState();
    fetchAlerts();
  }

  Future<void> fetchAlerts() async {
    final collection = MongoDatabase.db.collection('Alerts');
    final cursor = await collection.find();
    Alerts = await cursor.toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF21222D),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromARGB(238, 238, 238, 238),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF21222D),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.elliptical(45, 0),
                    bottomLeft: Radius.circular(45),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Alerts",
                        style: TextStyle(
                            fontSize: 35,
                            //fontWeight: FontWeight.bold,
                            //fontStyle: FontStyle.italic,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: Alerts.length,
                itemBuilder: (context, index) {
                  final announcement = Alerts[index];
                  return CustomCard(
                    dept: announcement['auth'],
                    dateTime:
                        announcement['date'] + ' at ' + announcement['time'],
                    msg: announcement['desc'],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String dept;
  final String dateTime;
  final String msg;

  const CustomCard({
    super.key,
    required this.dept,
    required this.dateTime,
    required this.msg,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 6,
      child: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    size: 55,
                    color: Color.fromARGB(255, 226, 41, 78),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dept,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        dateTime,
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              msg,
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
