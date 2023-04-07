// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sports_app/auth/verify_phone.dart';

import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _sendOTP() async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+234${phoneController.text}",
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        await _firebaseAuth.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (FirebaseAuthException error) {
        if (error.code == 'invalid-phone-number') {
          print("The provided phone number is invalid");
        }
      },
      codeSent: (verificationId, forceResedningToken) {
        log("Verification ID: $verificationId");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VerifyPhone(
                      verificationId: verificationId,
                    )));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: const Duration(seconds: 60),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Welcome",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 28,
                        color: Color(0xFF26005f),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "Let's help you get started",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 19,
                        color: Color(0xFF26005f),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(32, 40, 0, 0),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFF26005f),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                BuildTextField(
                  hintText: "Phone Number",
                  icon: Icons.numbers_outlined,
                  obscureText: false,
                  textEditingController: phoneController,
                ),
                BuildTextField(
                  hintText: "Email",
                  icon: Icons.email_outlined,
                  obscureText: false,
                  textEditingController: emailController,
                ),
                BuildTextField(
                  hintText: "Password",
                  icon: Icons.lock_outline,
                  obscureText: true,
                  textEditingController: passwordController,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: () async {
                        await _sendOTP();
                        // await signUpWithEmail(
                        //   emailController.text.trim(),
                        //   passwordController.text.trim(),
                        // );
                        // await updateUserPhoneNumber(
                        //   phoneController.text.trim(),
                        // );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const Master(),
                        //   ),
                        // );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFF26005f),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(70, 50, 10, 0),
                  child: Row(
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Color(0xFF26005f),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<UserCredential> signUpWithEmail(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print("The password provided is too weak");
    } else if (e.code == "email-already-in-use") {
      print("Account already in use");
    }
    rethrow;
  } catch (e) {
    print(e.toString());
    rethrow;
  }
}

Future<void> updateUserPhoneNumber(String phoneNumber) async {
  final user = FirebaseAuth.instance.currentUser;
  final credential = PhoneAuthProvider.credential(
      verificationId: user!.uid, smsCode: phoneNumber);
  await user.updatePhoneNumber(credential);
}

//Input Fields
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
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextField(
          autocorrect: false,
          obscureText: obscureText,
          controller: textEditingController,
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
