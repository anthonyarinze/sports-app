import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sports_app/pages/buddies.dart';
import 'package:sports_app/pages/discover.dart';
import 'package:sports_app/pages/profile.dart';
import 'package:sports_app/pages/settings.dart';

class Master extends StatefulWidget {
  const Master({super.key});

  @override
  State<Master> createState() => _MasterState();
}

class _MasterState extends State<Master> {
  int index = 1;
  final screens = [
    const Discover(),
    const Buddies(),
    const Profile(),
    const Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        color: const Color(0xFF333e97),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: GNav(
            gap: 10.0,
            padding: const EdgeInsets.all(16.0),
            activeColor: Colors.white,
            tabBackgroundColor: const Color(0xFF7b85cf),
            textStyle: const TextStyle(color: Colors.white),
            onTabChange: (value) {
              setState(() {
                index = value;
              });
            },
            tabs: const [
              GButton(
                icon: Icons.search_outlined,
                text: "Discover",
                iconColor: Colors.white,
              ),
              GButton(
                icon: Icons.people,
                text: "Buddies",
                iconColor: Colors.white,
              ),
              GButton(
                icon: Icons.person,
                text: "Profile",
                iconColor: Colors.white,
              ),
              GButton(
                icon: Icons.settings,
                text: "Settings",
                iconColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
      body: screens[index],
    );
  }
}
