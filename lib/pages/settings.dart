import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/auth/change_email.dart';
import 'package:sports_app/auth/change_password.dart';
import 'package:sports_app/auth/login.dart';
import 'package:sports_app/widgets/widgets.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: CircleAvatar(
                radius: 75,
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.settings,
                  size: 100,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Center(
              child: Text('Settings', style: TextStyle(fontSize: 25)),
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 10.0, top: 15.0),
                  child: Text(
                    'Security',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                BuildProfileListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassword())),
                  leadingIcon: const Icon(
                    Icons.lock,
                    size: 25,
                  ),
                  title: 'Change Password',
                  trailingIcon: const Icon(Icons.arrow_forward_ios, size: 20),
                ),
                BuildProfileListTile(
                  onTap: () => dialogBuilder(
                    context,
                    'Are you sure you want to sign out?',
                    () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                  ),
                  leadingIcon: const Icon(Icons.logout_outlined, size: 25),
                  title: 'Sign Out',
                  trailingIcon: const Icon(Icons.arrow_forward_ios, size: 20),
                ),
                BuildProfileListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeEmail(),
                      )),
                  leadingIcon: const Icon(Icons.email_outlined, size: 25),
                  title: 'Update Email',
                  trailingIcon: const Icon(Icons.arrow_forward_ios, size: 20),
                ),
                BuildProfileListTile(
                  onTap: () {},
                  leadingIcon: const Icon(Icons.text_fields, size: 25),
                  title: 'Update Username',
                  trailingIcon: const Icon(Icons.arrow_forward_ios, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
