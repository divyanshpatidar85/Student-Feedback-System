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
        width: screenSize.width,
        color: Colors.white,
        child: Image.asset('asset/image/flash.png'),
      ),
    );
  }
}
