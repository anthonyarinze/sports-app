import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sports_app/pages/master.dart';

class VerifyPhone extends StatefulWidget {
  final String verificationId;
  const VerifyPhone({super.key, required this.verificationId});

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  TextEditingController numberController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final String verificationId =
      "AHTqx5a0ZWLBUoY78rcukMZM0NpXlJLxsjPUbiEGZ9-TaC_CSGDP0_vwuck2QFlVYYsAm7cIJa06Nrk7Nsl4AwKUPzalARkCuXVs-9jNhIYB9XaD9_xwsW-nvEbejCHU15Eq4FElzIDSwt7ugdJr3D0dIZvhpvqxfg";
  String currentText = "";

  _verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: currentText,
    );
    await _firebaseAuth.signInWithCredential(credential).then((value) => {
          if (value.user != null)
            {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Master()))
            }
        });
  }

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Center(
              child: Container(
                height: 150,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: const Color(0xFF26005f).withOpacity(0.2),
                ),
                child: const Icon(
                  Icons.phone_outlined,
                  color: Color(0xFF26005f),
                  size: 100,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Center(
              child: Text(
                "Phone Verification",
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "We need to verify your phone number before getting started",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            Center(
              child: PinCodeTextField(
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 20,
                  activeFillColor: Colors.white,
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                controller: numberController,
                onCompleted: (v) {
                  debugPrint("Completed");
                },
                onChanged: (value) {
                  debugPrint(value);
                  setState(() {
                    currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  return true;
                },
                appContext: context,
              ),
            ),
            TextButton(
              onPressed: () async {
                _verifyOTP();
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
                    "Verify code",
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
      ),
    );
  }
}
