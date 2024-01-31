import 'package:flutter/material.dart';

import '../widgets/menu.dart';
import 'issue_tracker.dart';

class StrayAnimalsPage extends StatefulWidget {
  const StrayAnimalsPage({super.key});

  @override
  _StrayAnimalsPageState createState() => _StrayAnimalsPageState();
}

class _StrayAnimalsPageState extends State<StrayAnimalsPage> {
  String selectedZone = 'All Zones'; // Default selection

  List<String> zones = ['All Zones', 'Zone A', 'Zone B', 'Zone C', 'Zone D'];

  List<Map<String, String>> issues = [
    {
      'name': 'Injured Animal',
      'area': 'Bus Route 3, Hari Nagar',
      'date': 'Oct 2, 2023'
    },
    {
      'name': 'Increased Animal Agression',
      'area': 'Street C, Rajouri Garden',
      'date': 'Sep 28, 2023'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 270, // Set the width of the menu
            child: Menu(
              scaffoldKey: GlobalKey<ScaffoldState>(),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text(
                    "Stray Animals Issues",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10.0),
                  child: DropdownButton<String>(
                    value: selectedZone,
                    onChanged: (value) {
                      setState(() {
                        selectedZone = value!;
                      });
                    },
                    items: zones.map((zone) {
                      return DropdownMenuItem<String>(
                        value: zone,
                        child: Text(zone),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical:
                            5.0), // Additional padding for the entire ListView
                    child: ListView.builder(
                      itemCount: issues.length,
                      itemBuilder: (context, index) {
                        final issue = issues[index];
                        if (selectedZone != 'All Zones' &&
                            issue['area'] != selectedZone) {
                          return Container(); // Skip items that don't match the selected zone
                        }
                        return Card(
                          elevation: 4, // Add elevation
                          margin: const EdgeInsets.all(
                              10), // Add padding to each Card
                          child: ListTile(
                            title: Text(issue['name']!),
                            subtitle: Text(
                                'Area: ${issue['area']}, Date: ${issue['date']}'),
                            trailing: const Icon(Icons.arrow_forward),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const IssueTracker()),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
