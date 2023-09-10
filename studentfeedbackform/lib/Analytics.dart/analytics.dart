import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentfeedbackform/anyaliticalscreen/courese_analitical_screen.dart';

class AnalyticDisplay extends StatefulWidget {
  final String sem;
  const AnalyticDisplay({super.key, required this.sem});

  @override
  State<AnalyticDisplay> createState() => _AnalyticDisplayState();
}

class _AnalyticDisplayState extends State<AnalyticDisplay> {
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   setState(() {});
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Analytical Screen",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 184, 174, 202),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('courses')
            .where('sem', isEqualTo: widget.sem)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Colors.red,
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var courseData = snapshot.data!.docs[index].data();
              var courseName = courseData['coursename'] ?? 'No Name';
              var courseId = courseData['couresid'] ?? 'No ID';
              var courseUId = courseData['uid'] ?? 'No ID';

              return AnalyticalCourseScreen(
                name: courseName,
                id: courseId,
                uid: courseUId,
              );
            },
          );
        },
      ),
    );
  }
}
