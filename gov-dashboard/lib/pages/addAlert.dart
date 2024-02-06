import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_dashboard/dashboard.dart';
import 'package:intl/intl.dart';
import '../dashoboard_components/menu.dart';
import '../../dbHelper/datamodels.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddAlert extends StatefulWidget {
  const AddAlert({Key? key}) : super(key: key);

  @override
  _AddIssueState createState() => _AddIssueState();
}

class _AddIssueState extends State<AddAlert> {
  String selectedCategory = 'NDMC'; // Default category
  List<String> categories = ['NDMC', 'Jal Board', 'BSES', 'SDMC'];

  DateTime? selectedDate; // To store the selected date

  final TextEditingController detailsController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Menu on the left
          SizedBox(
            width: 270, // Set the width of the menu
            child: Menu(
              scaffoldKey: GlobalKey<ScaffoldState>(),
            ),
          ),
          // AddIssue content on the right
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Issue an Alert !',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40), // Add spacing below the heading

                  // Category selection dropdown inside a ListTile
                  ListTile(
                    title: const Text('Department'),
                    subtitle: DropdownButton<String>(
                      value: selectedCategory,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategory = newValue!;
                        });
                      },
                      items: categories.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),

                  // Date selection using the DateTimeField
                  DateTimeField(
                    format: DateFormat("yyyy-MM-dd"),
                    decoration: const InputDecoration(
                      labelText: 'Select Date',
                    ),
                    onChanged: (dt) {
                      setState(() {
                        selectedDate = dt;
                      });
                    },
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                    },
                  ),

                  // Rest of your AddIssue content
                  TextField(
                    controller: detailsController,
                    decoration:
                        const InputDecoration(labelText: 'Enter Details'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: reasonController,
                    decoration:
                        const InputDecoration(labelText: 'Enter Reason'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: locationController,
                    decoration:
                        const InputDecoration(labelText: 'Enter Location'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: pincodeController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Pin Code of the Area',
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      // Create an Issue object with the data from text fields
                      final alert = Alert(
                        auth: selectedCategory,
                        date: selectedDate != null
                            ? DateFormat("yyyy-MM-dd").format(selectedDate!)
                            : '',
                        desc:
                            '${detailsController.text} due to ${reasonController.text} in ${locationController.text} (${pincodeController.text})',
                        time: '${DateTime.now().hour}:${DateTime.now().minute}',
                      );

                      // Insert the issue into the database
                      await addAlert(alert);

                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Success'),
                          content: const Text('Alert Issued'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DashBoard())),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF21222D)),
                    ),
                    child: const Text('Submit', style: TextStyle(fontSize: 18)),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> addAlert(Alert alert) async {
  try {
    final response = await http.post(
      Uri.parse('https://node-server-us.onrender.com/api/addAlert'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(alert.toJson()),
    );

    if (response.statusCode == 201) {
      print('Alert inserted successfully');
    } else {
      print('Failed to insert alert. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
