import 'package:flutter/material.dart';
import 'package:flutter_dashboard/dashboard.dart';
import 'package:flutter_dashboard/pages/addAlert.dart';
import '../pages/login.dart';

class Menu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const Menu({super.key, required this.scaffoldKey});

  @override
  _MenuState createState() => _MenuState();
}

class MenuModel {
  final IconData icon;
  final String title;

  MenuModel({required this.icon, required this.title});
}

class _MenuState extends State<Menu> {
  List<MenuModel> menu = [
    MenuModel(icon: Icons.home, title: "Dashboard"),
    MenuModel(icon: Icons.person, title: "Profile"),
    MenuModel(icon: Icons.add, title: "Issue an Alert"),
    MenuModel(icon: Icons.history, title: "History"),
    MenuModel(icon: Icons.exit_to_app, title: "Signout"),
  ];

  int selected = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF21222D),
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Urban Seva",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              for (var i = 0; i < menu.length; i++)
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(6.0),
                    ),
                    color: selected == i
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                  ),
                  child: InkWell(
                    onTap: () {
                      if (i == 2) {
                        selected = i;
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AddAlert(),
                        ));
                      } else if (i == 0) {
                        selected = i;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DashBoard()));
                      } else if (i == 4) {
                        selected = i;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginPage()));
                      } else {
                        setState(() {
                          selected = i;
                        });
                        widget.scaffoldKey.currentState!.closeDrawer();
                      }
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 7),
                          child: Icon(
                            menu[i].icon,
                            color: selected == i ? Colors.black : Colors.grey,
                          ),
                        ),
                        Text(
                          menu[i].title,
                          style: TextStyle(
                            fontSize: 16,
                            color: selected == i ? Colors.black : Colors.grey,
                            fontWeight: selected == i
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
