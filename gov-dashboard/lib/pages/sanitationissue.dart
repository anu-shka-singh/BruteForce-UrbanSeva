import 'package:flutter/material.dart';

import '../widgets/menu.dart';
import 'issue_tracker.dart';

class SanitationPage extends StatefulWidget {
  const SanitationPage({super.key});

  @override
  _SanitationPageState createState() => _SanitationPageState();
}

class _SanitationPageState extends State<SanitationPage> {
  String selectedZone = 'All Zones'; // Default selection

  List<String> zones = ['All Zones', 'Zone A', 'Zone B', 'Zone C', 'Zone D'];

  List<Map<String, String>> issues = [
    {
      'name': 'Garbage Piles',
      'area': 'Block 14, Patel Nagar',
      'date': 'Jan 18, 2024'
    },
    {
      'name': 'No Public Dustbins',
      'area': 'Block 23, Uttam Nagar',
      'date': 'Nov 10, 2023'
    },
    {
      'name': 'Unhygienic Public Washrooms',
      'area': 'Block 2, Subhash Nagar',
      'date': 'Oct 25, 2023'
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
                    "Sanitation Issues",
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
                                  builder: (context) => IssueTracker()),
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
