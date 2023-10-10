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
                padding: EdgeInsets.only(right: 35, left: 35),
                child: Container(
                  height: screenSize.height <= screenSize.width
                      ? screenSize.height * 0.3
                      : screenSize.height * 0.4,
                  width: screenSize.height >= screenSize.width
                      ? screenSize.width * 0.5
                      : screenSize.width * 0.3,

                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(2)),
                  // height: screenSize.height * 0.4,
                  // width: screenSize.width * 0.4,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: screenSize.height * 0.002,
                        top: screenSize.height * 0.1),
                    child: Image.asset(
                      'asset/image/acro.png',
                      fit: BoxFit.fill,
                      height: screenSize.height < screenSize.width
                          ? screenSize.height * 0.2
                          : screenSize.height * 0.1,
                      width: screenSize.height > screenSize.width
                          ? screenSize.width * 0.6
                          : screenSize.width * 0.3,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.1),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    // Column(
                    TextSpan(
                      text: "Student \n",
                      style: TextStyle(
                        fontSize: screenSize.height * 0.05,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'FontMain2',
                      ),
                    ),

                    TextSpan(
                        text: "Feedback \n",
                        style: TextStyle(
                            fontSize: screenSize.height * 0.05,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'FontMain1')),
                    TextSpan(
                        text: "System",
                        style: TextStyle(
                            fontSize: screenSize.height * 0.05,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'FontMain3')),
                  ]),
                ),
              ),
            ),
            const Spacer(),
            const Divider(
              thickness: 3,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.02),
              child: Text(
                "divyanshpatidar85",
                style: TextStyle(
                    fontSize: screenSize.width * 0.03,
                    color: Colors.blueAccent,
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
