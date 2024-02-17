import 'package:citizen/dbHelper/mongodb.dart';
import 'package:citizen/screens/user_dashboard.dart';
import '../chatbot/chatbot_screen.dart';
import 'community_page.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key, required this.user});
  String user;

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
    String name = "";

  Future<void> fetchName(String? uid) async {
    try {
      print("inside fetch name");
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
    print(widget.user);
  }
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
        MaterialPageRoute(
            builder: (context) => Communities(
                  user: widget.user,
                )),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatBotScreen(user: widget.user)),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfileScreen(
                  user: widget.user,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF21222D),
        elevation: 0,
        // title: Text("Profile", style: TextStyle(fontSize: 26),),
        // centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF21222D),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(45),
              ),
            ),
            child: const Text(
              "Profile",
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30.0,
                horizontal: 15.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('images/female.png'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  const PointsCard(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align children to the start
              children: [
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Coupons",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10), // Add some vertical spacing
                Image.asset(
                  'images/coupon.png', // Replace with your image path
                  width: 350, // Set the width of the image
                  height: 190, // Set the height of the image
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
              color: Color(0xFF21222D),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.group,
              size: 30,
              color: Color(0xFF21222D),
            ),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              size: 30,
              color: Color(0xFF21222D),
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
    );
  }
}

class PointsCard extends StatelessWidget {
  const PointsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 355, // Set your desired width
      height: 90, // Set your desired height
      child: Card(
        elevation: 5, // Add elevation for shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'images/reward.png', // Replace with your actual image asset
                width: 60, // Set the width of the image
                height: 50, // Set the height of the image
              ),

              const Text(
                'Your Points',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 7),
              const Text(
                '50', // Replace with your actual points
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Change the text color
                ),
              ),
              // If you want to add an image, uncomment the following lines
              // Image.asset(
              //   'assets/images/points_image.png', // Replace with your actual image asset
              //   width: 50, // Set the width of the image
              //   height: 50, // Set the height of the image
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
