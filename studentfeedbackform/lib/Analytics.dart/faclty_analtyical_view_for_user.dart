import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:studentfeedbackform/anyaliticalscreen/faculty_analytical_screen.dart';

class FacultyDetailsOnAnalyticalScreen extends StatefulWidget {
  final String courseidd;

  const FacultyDetailsOnAnalyticalScreen({super.key, required this.courseidd});

  @override
  State<FacultyDetailsOnAnalyticalScreen> createState() =>
      _FacultyDetailsOnAnalyticalScreenState(courseidd);
}

class _FacultyDetailsOnAnalyticalScreenState
    extends State<FacultyDetailsOnAnalyticalScreen> {
  final String courseid;
  _FacultyDetailsOnAnalyticalScreenState(this.courseid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 184, 174, 202),
        title: const Text(
          'Faculty Details',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('faculty')
            .where('couresid', isEqualTo: courseid)
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
              var fData = snapshot.data!.docs[index].data();
              var fName = fData['facultyname'] ?? 'No Name';
              var fId = fData['fid'] ?? 'No ID';

              // print('${lol}');
              return AnalyticalFacultyState(
                  fname: fName, fid: fId, cid: courseid);
            },
          );
        },
      ),
    );
    // ;
  }
}
