import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyPhone extends StatefulWidget {
  const VerifyPhone({super.key});

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  User? user = FirebaseAuth.instance.currentUser;

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
                Icons.phone_outlined,
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
              "Check your messages",
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
              //read user's phone number
              String? phoneController = user!.phoneNumber;

              // Send OTP to user's phone number using Firebase
              verificationCompleted(PhoneAuthCredential phoneAuthCredential) {
                // This callback is triggered when the verification is done automatically
                print(
                    'Phone number automatically verified and user signed in: $phoneAuthCredential');
              }

              verificationFailed(FirebaseAuthException authException) {
                // This callback is triggered if an error occurred while verifying the phone number
                print(
                    'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
              }

              codeSent(String verificationId, int? resendToken) async {
                // This callback is triggered after the OTP is sent to the user's phone number
                print('Verification code sent to $phoneController');
                // Show popup dialog to notify the user
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('OTP Sent'),
                    content: const Text(
                        'An OTP has been sent to your phone number.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }

              codeAutoRetrievalTimeout(String verificationId) {
                // This callback is triggered after the OTP auto-retrieval timeout has expired
                print('Phone number verification code auto-retrieval timeout.');
              }

              try {
                // Send OTP to user's phone number
                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: phoneController,
                  verificationCompleted: verificationCompleted,
                  verificationFailed: verificationFailed,
                  codeSent: codeSent,
                  codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
                  timeout: const Duration(seconds: 60),
                  forceResendingToken: null,
                );
              } catch (e) {
                // Handle error while sending OTP
                print('Error sending OTP: $e');
              }
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Didn't receive a code?",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Resend",
                  style: TextStyle(color: Color(0xFF26005f), fontSize: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
