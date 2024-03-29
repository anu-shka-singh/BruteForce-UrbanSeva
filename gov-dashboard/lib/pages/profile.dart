import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dashoboard_components/menu.dart';
import '../user_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      userProvider.fetchData();
    });
    return Scaffold(
      body: Row(
        children: [
          // Menu on the left
          SizedBox(
            width: 270, // Set the width of the menu
            child: Container(
              child: Menu(
                scaffoldKey: GlobalKey<ScaffoldState>(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40.0,
                    horizontal: 60.0, // Horizontal padding
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/images/user_icon.png'),
                          ),
                          SizedBox(width: 120),
                          Text(
                            'User Information',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      UserProfileInfo(
                          label: 'Name',
                          value: '${userProvider.userData?['name'] ?? ''}'),
                      const SizedBox(height: 20),
                      UserProfileInfo(
                          label: 'Email',
                          value: '${userProvider.userData?['email'] ?? ''}'),
                      const SizedBox(height: 20),
                      UserProfileInfo(
                          label: 'Phone',
                          value: '${userProvider.userData?['phone'] ?? ''}'),
                      const SizedBox(height: 20),
                      UserProfileInfo(
                          label: 'Pin Code',
                          value: '${userProvider.userData?['pincode'] ?? ''}'),
                      const SizedBox(height: 20),
                      UserProfileInfo(
                          label: 'Zone',
                          value: '${userProvider.userData?['zone'] ?? ''}'),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfileInfo extends StatelessWidget {
  final String label;
  final String value;

  const UserProfileInfo({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
