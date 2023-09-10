import 'package:flutter/material.dart';
import 'package:studentfeedbackform/resourcses.dart/firestore_methods.dart';
import 'package:studentfeedbackform/screen/addfaculty.dart';
import 'package:studentfeedbackform/widget/alertdialog.dart';

class CourseFacUi extends StatelessWidget {
  final String name;
  final String id;
  final String uid;

  const CourseFacUi(
      {super.key, required this.name, required this.id, required this.uid});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => AddFacultyState(courseidd: uid))));
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenSize.height * 0.4,
                  child: Text(
                    'Course: $name',
                    maxLines: 4,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: screenSize.height * 0.04,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'FontMain1'),
                    softWrap: true,
                  ),
                ),
                Text(
                  'Course Code $id',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: screenSize.height * 0.03,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'FontMain3'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // InkWell(
                //   child: const Text('Delete'),
                //   onTap: () async {
                // String s =
                //     await FireStoreMethods().deleteFacultyByCourseId(uid);
                // alterDiallog(context, s);
                //   },
                // ),
                TextButton(
                    onPressed: () async {
                      String s =
                          await FireStoreMethods().deleteFacultyByCourseId(uid);
                      alterDiallog(context, s);
                    },
                    child: Text('Delete Course'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
