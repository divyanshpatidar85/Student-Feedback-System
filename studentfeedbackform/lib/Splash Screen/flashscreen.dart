import 'dart:async';

import 'package:flutter/material.dart';
import 'package:studentfeedbackform/main.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  @override
  initState() {
    super.initState();
    // ignore: unused_element
    print('Ram ');
    navigateToHomePage();
  }

  Future<void> navigateToHomePage() async {
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyHomePage(title: "hello")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: screenSize.height * 0.09,
                  right: screenSize.width * 0.2,
                  left: screenSize.width * 0.2,
                ),
                child: Container(
                  height: screenSize.height * 0.4,
                  width: screenSize.width * 0.4,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(2)),
                  // height: screenSize.height * 0.4,
                  // width: screenSize.width * 0.4,
                  child: Image.asset(
                    'asset/image/acro.png',
                    fit: BoxFit.contain,
                    height: screenSize.width * 0.9,
                    width: 80,
                  ),
                ),
              ),
            ),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  // Column(
                  TextSpan(
                    text: "Student \n",
                    style: TextStyle(
                      fontSize: screenSize.height * 0.09,
                      color: Color.fromARGB(255, 142, 28, 20),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FontMain2',
                    ),
                  ),

                  TextSpan(
                      text: "Feedback \n",
                      style: TextStyle(
                          fontSize: screenSize.height * 0.08,
                          color: const Color.fromARGB(255, 117, 76, 14),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'FontMain1')),
                  TextSpan(
                      text: "System",
                      style: TextStyle(
                          fontSize: screenSize.height * 0.07,
                          color: const Color.fromARGB(255, 28, 16, 105),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'FontMain3')),
                ]),
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "divyanshpatidar85",
                style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.none,
                    fontFamily: 'FontMain1'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
