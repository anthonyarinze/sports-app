import 'package:flutter/material.dart';

class Interests extends StatefulWidget {
  const Interests({super.key});

  @override
  State<Interests> createState() => _InterestsState();
}

class _InterestsState extends State<Interests> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0, right: 10.0, top: 30.0),
                child: Text(
                  "What do you want to follow?",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, right: 40.0, top: 10.0),
              child: Text(
                "Select your areas of interest you'd like to keep up with",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
            buildInterestWidget(
              isChecked: isChecked,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}

class buildInterestWidget extends StatelessWidget {
  const buildInterestWidget({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });

  final bool isChecked;
  final ValueSetter<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      stepWidth: 20.0,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          children: [
            Checkbox(
              shape: const CircleBorder(),
              checkColor: Colors.white,
              activeColor: Colors.black,
              fillColor: MaterialStateProperty.all(Colors.black),
              value: isChecked,
              onChanged: onChanged,
            ),
            const Text(
              "Football",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
