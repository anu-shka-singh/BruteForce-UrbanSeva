import 'package:citizen/user_dashboard.dart';
import 'chatbot_screen.dart';
import 'community_page.dart';
import 'user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key, required this.user});
  String user;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Map<String, dynamic> userData;

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
    final userProvider = Provider.of<UserProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      userProvider.fetchData();
    });

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
            child: Text(
              "Profile",
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF21222D),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(45),
              ),
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
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('images/female.png'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    widget.user,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  PointsCard(),
                  SizedBox(height: 20),
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
                Container(
                  width: double.infinity,
                  child: Text(
                    "Coupons",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10), // Add some vertical spacing
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
  @override
  Widget build(BuildContext context) {
    return Container(
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

              Text(
                'Your Points',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 7),
              Text(
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
