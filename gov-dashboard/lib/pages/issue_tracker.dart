import 'package:flutter/material.dart';
import '../widgets/menu.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class IssueTracker extends StatefulWidget {
  const IssueTracker({Key? key}) : super(key: key);

  @override
  State<IssueTracker> createState() => _IssueTrackerState();
}

class _IssueTrackerState extends State<IssueTracker> {
  List listOfPoints = [];
  List<LatLng> points = [];

  List<bool> completedTasks = [true, true, false, false, false];
  List<String> tasks = [
    'Issue Registered',
    'Forwarded to Authorities',
    'Action Initiated',
    'Action in Progress',
    'Resolved',
  ];

  List<String> time = [
    '8th Oct at 2:40PM',
    '',
    '',
    '',
    '',
  ];

  void _onTaskCompleted(int index) {
    setState(() {
      completedTasks[index] = !completedTasks[index];
    });
  }

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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Pothole Issue",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                          Text(
                            "Issue ID: #227",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "A whole stretch of 1KM road is covered with potholes in subhash nagar block J making it difficult for people with two wheelers to commute.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ProfileCard(
                          profileName: "Citizen Reporter",
                          imgpath: "assets/images/citizen.jpeg",
                          name: "Diya Singla",
                          email: "diya@gmail.com",
                          phno: "+911234567890",
                        ),
                        ProfileCard(
                          profileName: "Assigned Department",
                          imgpath: "assets/images/officer.jpeg",
                          name: "SDMC",
                          email: "sdmc@gmail.com",
                          phno: "+911234567890",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          elevation: 6,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  "View Location",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 560,
                                height: 450,
                                child: FlutterMap(
                                  options: const MapOptions(
                                      initialZoom: 13,
                                      initialCenter: LatLng(28.6465, 77.1169)),
                                  children: [
                                    // Layer that adds the map
                                    TileLayer(
                                      urlTemplate:
                                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      userAgentPackageName:
                                          'dev.fleaflet.flutter_map.example',
                                      // Plenty of other options available!
                                    ),
                                    // Layer that adds points the map
                                    MarkerLayer(
                                      markers: [
                                        Marker(
                                          point: const LatLng(
                                              28.635986, 77.112825),
                                          width: 80,
                                          height: 80,
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.add_road),
                                            color: Colors.black,
                                            iconSize: 31,
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Polylines layer
                                    PolylineLayer(
                                      polylineCulling: false,
                                      polylines: [
                                        Polyline(
                                            points: points,
                                            color: Colors.black,
                                            strokeWidth: 5),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Card(
                          elevation: 6,
                          margin: const EdgeInsets.all(10),
                          child: SizedBox(
                            width: 400,
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Row(
                                children: [
                                  // Timeline (Vertical Line with Circles)
                                  Column(
                                    children: completedTasks
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      final index = entry.key;
                                      final completed = entry.value;
                                      return Column(
                                        children: [
                                          Container(
                                            width: 16, // Circle diameter
                                            height: 16, // Circle diameter
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: completed
                                                  ? Colors.green
                                                  : Colors.red, // Circle color
                                            ),
                                          ),
                                          if (index < completedTasks.length - 1)
                                            Container(
                                              width: 2, // Line width
                                              height: 75, // Line height
                                              color: completed
                                                  ? Colors.green
                                                  : Colors.grey, // Line color
                                            ),
                                        ],
                                      );
                                    }).toList(),
                                  ),

                                  // Task Items
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: 5,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              elevation: 2,
                                              margin: const EdgeInsets.only(
                                                top: 8.0,
                                                right: 16.0,
                                                bottom: 8.0,
                                                left: 16.0,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          tasks[index],
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        Text(
                                                          time[index],
                                                          style:
                                                              const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          3,
                                                                          31,
                                                                          54),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Checkbox(
                                                      value:
                                                          completedTasks[index],
                                                      onChanged: (value) {
                                                        _onTaskCompleted(index);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, right: 30, bottom: 20),
                      child: Card(
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              const Text(
                                "Attached Images",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Divider(
                                color: Colors.black.withOpacity(0.4),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Container(
                                          child: Image.asset(
                                            'assets/images/pothole1.jpg', // Replace with the actual path to your image
                                            width: 400,
                                            height: 200,
                                          ),
                                        )),
                                  ),
                                  Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        child: Image.asset(
                                          'assets/images/pothole2.jpg', // Replace with the actual path to your image
                                          width: 400,
                                          height: 200,
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String profileName;
  final String imgpath;
  final String name;
  final String email;
  final String phno;

  const ProfileCard({
    super.key,
    required this.profileName,
    required this.imgpath,
    required this.name,
    required this.email,
    required this.phno,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 6,
        child: SizedBox(
          width: 500,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 5,
                  left: 30,
                  right: 30,
                ),
                child: Text(
                  profileName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(
                color:
                    Colors.black.withOpacity(0.3), // Set the color of the line
                thickness: 1, // Set the thickness of the line
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, bottom: 15, left: 30, right: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                          imgpath), // Replace with the actual image path
                      radius: 25,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          email,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          phno,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
