import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentfeedbackform/UI/courses_Fac_UI.dart';

class FacultyAddCourseUi extends StatefulWidget {
  const FacultyAddCourseUi({super.key});

  @override
  State<FacultyAddCourseUi> createState() => _FacultyAddCourseUiState();
}

class _FacultyAddCourseUiState extends State<FacultyAddCourseUi> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('courses').snapshots(),
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

            return CourseFacUi(
              name: courseName,
              id: courseId,
              uid: courseUId,
            );
          },
        );
      },
    );
  }
}
