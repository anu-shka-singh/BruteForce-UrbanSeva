import 'package:complaint_app/user_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      userProvider.fetchData();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF21222D),
        elevation: 0,
        // title: Text("Profile", style: TextStyle(fontSize: 26),),
        // centerTitle: true,
      ),

      body:
          Column(
          children: [
        Container(
          child:
            Text(
              "Profile",
              style: TextStyle(
                  fontSize: 35,
                  //fontWeight: FontWeight.bold,
                  //fontStyle: FontStyle.italic,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),

          height: 60,
          width: double.infinity,// Adjust the height of the rounded box
          decoration: BoxDecoration(
            color: const Color(0xFF21222D), // Change the color of the box
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(45),
              //bottomRight:Radius.circular(45),
            ),
          ),
        ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30.0,
                    horizontal: 15.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start, // Center align the content
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage(
                          'images/female.png',
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        widget.user,
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 40),
                      PointsCard(),
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

class PointsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350, // Set your desired width
      height: 90, // Set your desired height
      child: Card(
        elevation: 5, // Add elevation for shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Image.asset(
            'images/reward.png', // Replace with your actual image asset
            width: 50, // Set the width of the image
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

