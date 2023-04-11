import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sports_app/pages/master.dart';

class Interests extends StatefulWidget {
  const Interests({super.key});

  @override
  State<Interests> createState() => _InterestsState();
}

class _InterestsState extends State<Interests> {
  bool isChecked = false;
  Map<String, bool?> myMap = {
    "Football": false,
    "Basketball": false,
    "Ice Hockey": false,
    "Motorsports": false,
    "Bandy": false,
    "Rugby": false,
    "Skiing": false,
    "Shooting": false,
  };

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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
              const SizedBox(height: 20.0),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                childAspectRatio: 2.5,
                padding: const EdgeInsets.all(10.0),
                children: List.generate(myMap.length, (index) {
                  final topic = myMap.keys.elementAt(index);
                  var isCheckedAtIndex = myMap.values.elementAt(index);
                  return buildInterestWidget(
                    isChecked: isCheckedAtIndex,
                    onChanged: (bool? value) {
                      setState(() {
                        isCheckedAtIndex = !(isCheckedAtIndex ?? false);
                        myMap[topic] = isCheckedAtIndex;
                        log(isCheckedAtIndex.toString());
                        log(topic);
                      });
                    },
                    topic: topic,
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.05,
                  height: 56,
                  child: TextButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Master()));
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
              ),
            ],
          ),
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
    required this.topic,
  });

  final bool? isChecked;
  final ValueSetter<bool> onChanged;
  final String topic;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      stepWidth: 20.0,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(19),
          color: isChecked! ? const Color(0xFF26005f) : Colors.transparent,
        ),
        child: Row(
          children: [
            Checkbox(
              shape: const CircleBorder(),
              checkColor: Colors.white,
              activeColor: Colors.black,
              fillColor: MaterialStateProperty.all(Colors.black),
              value: isChecked,
              onChanged: (value) {
                onChanged(!isChecked!);
              },
            ),
            Text(
              topic,
              style: TextStyle(
                  fontSize: 20,
                  color: isChecked! ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
