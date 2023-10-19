import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studentfeedbackform/main.dart';

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
          backgroundColor: const Color.fromARGB(255, 132, 181, 220),
          // title: Text(
          //   "Course Details ",
          //   style: TextStyle(
          //       fontSize: MediaQuery.of(context).size.height * 0.05,
          //       fontWeight: FontWeight.bold),
          // ),
          title: ListTile(
            title: const Center(
              child: Text(
                'Course Details',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  // fontFamily: 'FontMain'
                ),
              ),
            ),
            trailing: GestureDetector(
              onTap: () async {
                FirebaseAuth auth = FirebaseAuth.instance;
                await auth.signOut();
                MyHomePage app = MyHomePage(
                  title: 'heelo',
                );
                app.updateBl('');
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage(
                              title: 'Course Details ',
                            )));
              },
              child: const Icon(Icons.logout),
            ),
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
