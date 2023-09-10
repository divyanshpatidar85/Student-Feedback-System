import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentfeedbackform/UI/facultyUserView.dart';

class UserFacultyState extends StatefulWidget {
  final String courseidd;

  const UserFacultyState({super.key, required this.courseidd});

  @override
  State<UserFacultyState> createState() => _UserFacultyStateState(courseidd);
}

class _UserFacultyStateState extends State<UserFacultyState> {
  final String courseid;
  _UserFacultyStateState(this.courseid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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

              return UserFacUi(fname: fName, fid: fId, cid: courseid);
            },
          );
        },
      ),
    );
    // ;
  }
}
