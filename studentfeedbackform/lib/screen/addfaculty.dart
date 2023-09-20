import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentfeedbackform/UI/SpecialfacultyUI.dart';
import 'package:studentfeedbackform/resourcses.dart/firestore_methods.dart';
import 'package:studentfeedbackform/widget/alertdialog.dart';
// import 'package:studentfeedbackform/resourcses.dart/firestore_methods.dart';
import 'package:studentfeedbackform/widget/textfiled.dart';

// ignore: non_constant_identifier_names
TextEditingController FacultyNameController = TextEditingController();
// ignore: non_constant_identifier_names
TextEditingController FacultyIdController = TextEditingController();

class AddFacultyState extends StatefulWidget {
  final String courseidd;

  const AddFacultyState({super.key, required this.courseidd});

  @override
  // ignore: no_logic_in_create_state
  State<AddFacultyState> createState() => _AddFacultyStateState(courseidd);
}

class _AddFacultyStateState extends State<AddFacultyState> {
  final String courseid;
  _AddFacultyStateState(this.courseid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Faculty'),
          backgroundColor: const Color.fromARGB(255, 184, 174, 202),
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

                return FacUi(
                  fname: fName,
                  fid: fId,
                  cid: courseid,
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(
              Icons.add,
              semanticLabel: "Add Courses",
            ),
            onPressed: () {
              showSimpleDialog(context, courseid);
            }));
    // ;
  }
}

showSimpleDialog(BuildContext context, String id) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              'Add Faculty ',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              TextFieldInput(
                  textEditingController: FacultyNameController,
                  hintText: "Faculty Name",
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 5,
              ),
              TextFieldInput(
                  textEditingController: FacultyIdController,
                  hintText: "Faculty ID",
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                  onPressed: () async {
                    String s = await FireStoreMethods().addFaulty(
                        FacultyNameController.text,
                        FacultyIdController.text,
                        id);
                    FacultyNameController.text = "";
                    FacultyIdController.text = "";
                    if (s.isNotEmpty) Navigator.pop(context);
                    alterDiallog(context, s);
                  },
                  child: const Text('Add')),
            ]));
      });
}
