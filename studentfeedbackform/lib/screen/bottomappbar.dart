import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studentfeedbackform/Analytics.dart/analytics.dart';
import 'package:studentfeedbackform/screen/feedscreen.dart';

class BottomAppBarr extends StatefulWidget {
  const BottomAppBarr({Key? key}) : super(key: key);

  @override
  State<BottomAppBarr> createState() => _BottomAppBarrState();
}

class _BottomAppBarrState extends State<BottomAppBarr> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? sem; // Use nullable String for initial value
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int _page = 0;
  late PageController pageControll;

  @override
  void initState() {
    super.initState();
    fetchSemValue();
    pageControll = PageController();
  }

  Future<void> fetchSemValue() async {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userSnapshot =
            await _firestore.collection('users').doc(currentUser.uid).get();
        if (userSnapshot.exists) {
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;
          setState(() {
            sem = userData['sem'] as String;
          });
        } else {
          print("User document not found.");
          // Handle this scenario if needed
        }
      } else {
        print("No authenticated user.");
        // Handle this scenario if needed
      }
    } catch (e) {
      print("Error fetching sem: $e");
      // Handle this error if needed
    }
  }

  @override
  void dispose() {
    super.dispose();
    pageControll.dispose();
  }

  void navigationTapped(int page) {
    pageControll.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return sem != null
        ? Scaffold(
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageControll,
              onPageChanged: onPageChanged,
              children: [
                MainFeedScreen(
                  sem: sem!,
                ),
                AnalyticDisplay(
                  sem: sem!,
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_outlined,
                      color: _page == 0 ? Colors.black : Colors.black12,
                    ),
                    label: 'Home',
                    backgroundColor: Colors.blueAccent),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.analytics,
                      color: _page == 1 ? Colors.black : Colors.black12,
                    ),
                    label: 'Analytic',
                    backgroundColor: Colors.blueAccent),
              ],
              onTap: navigationTapped,
            ),
          )
        : Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
  }
}
