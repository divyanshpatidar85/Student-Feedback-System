import 'package:flutter/material.dart';
import 'package:studentfeedbackform/UI/ReviewScreen.dart';
import 'package:studentfeedbackform/userviewscreen/facultyuserview.dart';

class CourseScreenUIuser extends StatelessWidget {
  final String name;
  final String id;
  final String uid;

  const CourseScreenUIuser(
      {super.key, required this.name, required this.id, required this.uid});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserFacultyState(
                      courseidd: uid,
                    )));
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenSize.width * 0.97,
                  height: screenSize.height * 0.3,
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'asset/image/courses.jpeg',
                          width: screenSize.width,
                          height: screenSize.height * 0.3,
                          fit: BoxFit.fill,
                          // fit: BoxFit.fitWidth,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.,
                  children: [
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: screenSize.width * 0.6911,
                          child: Text(
                            'Course: $name',
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
                        onPressed: () {
                          print('$name');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReviewScreen(
                                        courseid: uid,
                                        iscourse: true,
                                        facultyid: '',
                                        coursename: name,
                                      )));
                        },
                        child: const Text(
                          "Rate Course",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ],
            ),

            // InkWell(
            //     onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => ReviewScreen(
            //               courseid: uid,
            //               iscourse: true,
            //               facultyid: '',
            //             )));
            //     },
            //     child: const Icon(Icons.rate_review))
          ],
        ),
      ),
    );
  }
}
