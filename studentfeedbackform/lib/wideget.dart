import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:studentfeedbackform/adminfaculty/adminscreen.dart';
import 'package:studentfeedbackform/adminfaculty/adminui.dart';
import 'package:studentfeedbackform/main.dart';
import 'package:studentfeedbackform/updatestudentsem.dart';

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
              MyHomePage app = MyHomePage(title: '');
              app.updateBl('');
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
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                height: 200, // Adjust the height to your preference
                child: Wrap(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Add teacher'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AdminFacultyRegistration()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.update),
                      title: Text('Update Semester of student'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UpdateSemValue()));
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Container(
      //     width: 500,
      //     child: Row(
      //       children: [
      //         GestureDetector(
      //           child: Icon(
      //             Icons.add,
      //             semanticLabel: "Add Courses",
      //           ),
      //           onTap: () {
      //             updateDocuments('i', 'ii');
      //             Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) =>
      //                         const AdminFacultyRegistration()));
      //           },
      //         ),
      //         Icon(
      //           Icons.update,
      //           // semanticLabel: "Add Courses",
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

Future<String> updateDocuments(String i, String updatedSem) async {
  String b = 'Some error occured';
  FirebaseFirestore.instance
      .collection('users')
      .where('sem', isEqualTo: i)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      // This is where you can update the fields of the document
      // For example, if you want to increment a 'count' field by 1:
      // int currentCount = doc['count'];
      String newCount = updatedSem;

      // Create a map with the updated field
      Map<String, dynamic> updatedData = {'sem': newCount};

      // Update the document
      doc.reference.update(updatedData).then((_) {
        b = 'Document updated successfully';
        print('ho gaya update');
      }).catchError((error) {
        b = 'Error updating document: $error';
      });
    });
  });
  await Future.delayed(Duration(seconds: 2));
  return b;
}

// Call the function with your desired value of 'i'
// int i = 3; // Replace this with your desired value


