import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/auth/login.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
                  Icons.account_box,
                  size: 100,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Center(
              child: Text('Account', style: TextStyle(fontSize: 25)),
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 10.0, top: 15.0),
                  child: Text(
                    'App Settings',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                BuildProfileListTile(
                  onTap: () {},
                  leadingIcon: const Icon(
                    Icons.sunny,
                    size: 25,
                  ),
                  title: 'Change Theme',
                  trailingIcon: const Icon(Icons.arrow_forward_ios, size: 20),
                ),
                BuildProfileListTile(
                  onTap: () => dialogBuilder(
                    context,
                    'Are you sure you want to sign out?',
                    () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                  ),
                  leadingIcon: const Icon(Icons.logout_outlined, size: 25),
                  title: 'Sign Out',
                  trailingIcon: const Icon(Icons.arrow_forward_ios, size: 20),
                ),
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
                  onTap: () => dialogBuilder(
                      context,
                      'Are you sure you want to delete your account? '
                      'This will delete all data related to your account on our end.',
                      () {}),
                  leadingIcon:
                      const Icon(Icons.delete_forever_outlined, size: 25),
                  title: 'Delete Account',
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

Future<void> dialogBuilder(
    BuildContext context, String title, Function() func) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 2.0,
        scrollable: true,
        title: const Text('Info'),
        content: Text(title),
        actions: <Widget>[
          TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: func,
              child: const Text('Yes')),
          TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No')),
        ],
      );
    },
  );
}

class BuildProfileListTile extends StatelessWidget {
  final Function() onTap;
  final Icon leadingIcon;
  final String title;
  final Icon trailingIcon;

  const BuildProfileListTile({
    super.key,
    required this.onTap,
    required this.leadingIcon,
    required this.title,
    required this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border.symmetric(
            horizontal: BorderSide(width: 1.0, color: Colors.grey),
          ),
        ),
        child: ListTile(
          leading: leadingIcon,
          title: Text(title,
              style: const TextStyle(
                fontSize: 20,
                overflow: TextOverflow.ellipsis,
              )),
          trailing: trailingIcon,
        ),
      ),
    );
  }
}
