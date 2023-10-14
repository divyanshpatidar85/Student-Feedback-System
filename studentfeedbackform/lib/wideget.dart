import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:studentfeedbackform/adminfaculty/adminscreen.dart';
import 'package:studentfeedbackform/adminfaculty/adminui.dart';
import 'package:studentfeedbackform/main.dart';

class TimePasss extends StatelessWidget {
  const TimePasss({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   'Admin Window ',
        //   style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.05),
        // ),
        title: ListTile(
          title: const Center(
            child: Text(
              'Admin Window ',
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
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(
                            title: 'hello',
                          )));
            },
            child: const Icon(Icons.logout),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 132, 181, 220),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('FacultyAdmin').snapshots(),
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
              var fName = courseData['username'] ?? 'No Name';
              var fcode = courseData['fcode'] ?? 'No ID';
              var ucode = courseData['uid'] ?? 'No ID';
              var email = courseData['email'] ?? 'No ID';
              // var courseUId = courseData['uid'] ?? 'No ID';

              return AdminFacUi(
                  name: fName, fcode: fcode, uid: ucode, em: email);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AdminFacultyRegistration()));
        },
        child: const Icon(
          Icons.add,
          semanticLabel: "Add Courses",
        ),
      ),
    );
  }
}
