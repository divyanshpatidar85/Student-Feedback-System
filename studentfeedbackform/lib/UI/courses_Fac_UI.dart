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
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        width: screenSize.width * 0.95,
                        height: screenSize.height * 0.26,
                        child: Image.asset(
                          'asset/image/courses.jpeg',
                          width: screenSize.width,
                          height: screenSize.height * 0.26,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: screenSize.width * 0.95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment:CrossAxisAlignment.end/,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: screenSize.height * 0.3,
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
                                  fontFamily: 'FontMain1'),
                            ),
                          ],
                        ),
                        TextButton(
                            onPressed: () async {
                              String s = await FireStoreMethods()
                                  .deleteFacultyByCourseId(uid);
                              alterDiallog(context, s);
                            },
                            // child: const Text('Delete '))
                            child: Text(
                              'Delete',
                              style: TextStyle(fontFamily: 'FontMain3'),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
