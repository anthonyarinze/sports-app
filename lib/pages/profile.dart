import 'package:flutter/material.dart';
import 'package:sports_app/widgets/widgets.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: CircleAvatar(
                radius: 75,
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.account_box,
                  size: 100,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Center(
              child: Text('Profile', style: TextStyle(fontSize: 25)),
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 10.0, top: 15.0),
                  child: Text(
                    'Personal',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                BuildProfileListTile(
                  onTap: () {},
                  leadingIcon: const Icon(
                    Icons.person,
                    size: 25,
                  ),
                  title: 'user1234',
                ),
                BuildProfileListTile(
                  onTap: () {},
                  leadingIcon: const Icon(Icons.phone, size: 25),
                  title: "+234 8009001000",
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 10.0, top: 15.0),
                  child: Text(
                    'Interests',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                BuildProfileListTile(
                  onTap: () {},
                  leadingIcon: const Icon(Icons.interests),
                  title: "Football, basketball, rugby, motorsports, bandy",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
