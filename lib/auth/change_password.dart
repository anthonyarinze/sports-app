import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sports_app/auth/login.dart';

class ChangePassword extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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
                    Icons.password_outlined,
                    size: 130,
                  ),
                ),
              ),
            ),
            BuildTextField(
              hintText: "Enter new password",
              icon: Icons.lock,
              obscureText: true,
              textEditingController: controller,
            ),
            SizedBox(
              height: 55,
              width: size.width / 1.2,
              child: TextButton(
                onPressed: () async {
                  changePassword(controller.text.trim(), context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xFF26005f),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController textEditingController;

  const BuildTextField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.obscureText,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextField(
          onChanged: (value) => textEditingController.text = value,
          autocorrect: false,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(
              icon,
              color: Colors.grey.shade800,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> changePassword(String newPassword, BuildContext context) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
      await user.updatePassword(newPassword);
      log("password updated successfully");
      //navigate back to login page
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    } catch (e) {
      // An error occurred while updating the password
      // Show a snackbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }
}
