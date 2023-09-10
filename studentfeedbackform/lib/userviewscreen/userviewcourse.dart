import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:studentfeedbackform/UI/userviewscreenCourse.dart';

class UserScreenView extends StatefulWidget {
  final String sem;
  const UserScreenView({super.key, required this.sem});

  @override
  State<UserScreenView> createState() => _UserScreenViewState();
}

class _UserScreenViewState extends State<UserScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

              return CourseScreenUIuser(
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
