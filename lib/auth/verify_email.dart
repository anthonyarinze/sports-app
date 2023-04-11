import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sports_app/pages/interests.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final bool _isVerifying = false;
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            Center(
              child: Container(
                height: 200,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: const Color(0xFF26005f).withOpacity(0.2),
                ),
                child: const Icon(
                  Icons.email_outlined,
                  color: Color(0xFF26005f),
                  size: 150,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Center(
              child: Text(
                "Check your mail",
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "We've sent a verification",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            const Text(
              " link to your email.",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () async {
                checkEmailVerifiedAndNavigate(context);
              },
              child: Container(
                height: 70,
                width: 350,
                decoration: const BoxDecoration(
                  color: Color(0xFF26005f),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Verify email",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Text(
                "Didn't receive an email? Check your spam filter or",
                style: TextStyle(fontSize: 17),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (user != null && !user!.emailVerified) {
                  try {
                    await user!.sendEmailVerification();
                    log('A verification email has been sent to ${user!.email}.');
                  } catch (e) {
                    log('An error occurred while sending the verification email: $e');
                  }
                }
              },
              child: const Text(
                "click to resend",
                style: TextStyle(color: Color(0xFF26005f), fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> checkEmailVerifiedAndNavigate(BuildContext context) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    if (user?.emailVerified == true) {
      log("Verified email");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Interests()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Email not verified, please check your inbox.')));
    }
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }
}
