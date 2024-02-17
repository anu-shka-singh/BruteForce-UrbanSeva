import '../dbHelper/mongodb.dart';
import 'profile.dart';
import 'community_page.dart';
import 'announcements.dart';
import '../map/map_page.dart';
import '../issue screens/select_problem.dart';
import '../login/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../chatbot/chatbot_screen.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class Dashboard extends StatefulWidget {
  Color clr = Colors.grey;
  Color clr2 = Colors.grey;
  String? user;
  Dashboard({super.key, required this.user});
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  Position? currentLocation;
  String name = "";
  List<Map<String, dynamic>> complaints = [];

  Future<void> fetchComplaints() async {
    final collection = MongoDatabase.db.collection('Complaints');
    final cursor = await collection.find();
    complaints = await cursor.toList();
    setState(() {});
  }

  Future<void> fetchName(String? uid) async {
    try {
      final collection = MongoDatabase.db.collection('Users');
      final query = mongo.where.eq('id', uid);
      final cursor = await collection.find(query);
      final userList = await cursor.toList();
      if (userList.isNotEmpty) {
        final n = userList[0]['name'] as String;
        setState(() {
          //widget.user = n;
          name = n;
          print("user:${widget.user}");
          print("name:$name");
        });
      }
    } catch (e) {
      print("Error fetching user name: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchName(widget.user);
    _getCurrentLocation().then((position) {
      setState(() {
        currentLocation = position;
        //reverseGeocode();
      });
      _livelocation();
    }).catchError((error) {
      print(error); // Handle location errors here
    });
    fetchComplaints();
  }

  void _livelocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      setState(() {
        currentLocation = position;
      });
    });
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location service is OFF';
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        throw 'Location permission is denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permission is permanently denied';
    }

    return await Geolocator.getCurrentPosition();
  }

  List<List<bool>> completedTasks = [
    [true, false, false, false, false],
    [true, true, false, false, false],
    [true, true, true, false, false],
    [true, true, true, true, false],
    [true, true, true, true, true],
  ];

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Dashboard(
                  user: widget.user,
                )),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Communities(user: name)),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatBotScreen(
                  user: widget.user!,
                )),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfileScreen(
                  user: widget.user!,
                )),
      );
    }
  }

  // Future<void> reverseGeocode() async {
  //   var latitude = currentLocation?.latitude;
  //   var longitude = currentLocation?.longitude;
  //   final url =
  //       'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude';
  //
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //
  //       if (data.containsKey('display_name')) {
  //         loc= data['display_name'];
  //       }
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  //   //return 'Loading';
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF21222D),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Alerts(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              //FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
          //color: Colors.grey.shade100,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF21222D),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(70),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 12.0, 20.0),
                child: Image.asset(
                  'images/female.png',
                  height: 60,
                  width: 60,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Latitude: ${currentLocation?.latitude}\nLongitude: ${currentLocation?.longitude}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Card(
          elevation: 9,
          color: const Color.fromARGB(255, 255, 255, 255),
          margin: const EdgeInsets.all(14.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Replace the Icon with an Image widget
                Image.asset(
                  'images/map.png', // Provide the path to your image
                  width: 70, // Adjust the width as needed
                  height: 90, // Adjust the height as needed
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Issues Near You",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapScreen(
                                  // Pass the coordinates to MapScreen
                                  initialLatitude: currentLocation?.latitude,
                                  initialLongitude: currentLocation?.longitude,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "See various issues in your locality",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "My Issues",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: complaints.length,
                itemBuilder: (context, index) {
                  final complaint = complaints[index];
                  return ProgressCard(
                    probType: complaint['problemType'],
                    probText: complaint['probText'],
                    resolveStatus: complaint['resolveStatus'],
                    completedTasks: completedTasks,
                  );
                },
              ),
            ],
          ),
        )
      ])),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color(0xFF21222D),
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.group,
              color: Color(0xFF21222D),
              size: 30,
            ),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              color: Color(0xFF21222D),
              size: 30,
            ),
            label: 'Chat Bot',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Color(0xFF21222D),
              size: 30,
            ),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 64.0),
        width: 80.0,
        height: 80.0,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SelectComplaintTypePage()),
            );
          },
          backgroundColor: const Color(0xFF21222D),
          child: const Icon(
            Icons.add,
            size: 50.0,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class ProgressCard extends StatelessWidget {
  final String probType;
  final String probText;
  final int resolveStatus;
  final List<List<bool>> completedTasks;

  const ProgressCard({
    super.key,
    required this.probType,
    required this.probText,
    required this.resolveStatus,
    required this.completedTasks,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 2,
      margin: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: const EdgeInsets.all(16.0),
            title: Text(
              probType,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            subtitle: Text(
              probText,
              style: const TextStyle(
                color: Color.fromARGB(255, 3, 31, 54),
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            tileColor: Colors.white,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Column(
                children:
                    completedTasks[resolveStatus].asMap().entries.map((entry) {
                  final taskIndex = entry.key;
                  final completed = entry.value;
                  return Column(
                    children: [
                      Container(
                        width: 16,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: completed ? Colors.green : Colors.red,
                        ),
                      ),
                      if (taskIndex < completedTasks[resolveStatus].length - 1)
                        Container(
                          width: 3,
                          height: 29,
                          color: completed ? Colors.green : Colors.grey,
                        ),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(
                width: 10,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Issue Registered", style: TextStyle(fontSize: 14)),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Forwarded to authorities",
                      style: TextStyle(fontSize: 14)),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Action Initiated", style: TextStyle(fontSize: 14)),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Action in Progress", style: TextStyle(fontSize: 14)),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Resolved", style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
