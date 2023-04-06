import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool _isVerifying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              setState(() {
                _isVerifying = true;
              });

              final user = FirebaseAuth.instance.currentUser;
              await user!.reload();
              final isEmailVerified = user.emailVerified;

              setState(() {
                _isVerifying = false;
              });

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Email Verification'),
                    content: isEmailVerified
                        ? const Text('Your email has been verified')
                        : const Text('Your email has not been verified'),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
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
              "Didn't receive a email? Check your spam filter or",
              style: TextStyle(fontSize: 17),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "click to resend",
              style: TextStyle(color: Color(0xFF26005f), fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}

void isEmailVerified() {
  //Gets the current user
  final User? user = FirebaseAuth.instance.currentUser;

  //Check if the user's email is verified
  if (user != null && user.emailVerified) {
    //User verified
  } else {
    //User email not verified
  }
}
