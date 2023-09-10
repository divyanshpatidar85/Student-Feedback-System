import 'package:flutter/material.dart';

import 'package:studentfeedbackform/userviewscreen/userviewcourse.dart';

class MainFeedScreen extends StatefulWidget {
  final String sem;
  MainFeedScreen({Key? key, required this.sem}) : super(key: key);

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  // final FirebaseAuth auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // late String sem; // No need for Future<String> since sem is always available

  @override
  void initState() {
    super.initState();
    // fetchSemValue();
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 184, 174, 202),
          title: const Text(
            "Course Details ",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: UserScreenView(sem: widget.sem),
      );
    } catch (err) {
      return Scaffold();
    }
  }
}
