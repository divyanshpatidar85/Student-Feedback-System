import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:studentfeedbackform/Analytics.dart/analytics.dart';
// import 'package:studentfeedbackform/Analytics.dart/customratingbar.dart';
import 'package:studentfeedbackform/resourcses.dart/firestore_methods.dart';
import 'package:studentfeedbackform/widget/alertdialog.dart';

// ignore: must_be_immutable
class ReviewScreen extends StatelessWidget {
  final bool iscourse;
  final String courseid;
  final String facultyid;
  String? coursename;
  ReviewScreen(
      {super.key,
      required this.facultyid,
      required this.iscourse,
      required this.courseid,
      this.coursename});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback Screen'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
          child: StarRating(
        facultyid: facultyid,
        iscoursee: iscourse,
        courseid: courseid,
        coursename: coursename,
      )),
    );
  }
}

// ignore: must_be_immutable
class StarRating extends StatefulWidget {
  final String courseid;
  final bool iscoursee;
  final String facultyid;
  String? coursename;
  StarRating(
      {super.key,
      required this.facultyid,
      required this.iscoursee,
      required this.courseid,
      bool? iscourse,
      this.coursename});
  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _StarRatingState createState() => _StarRatingState(
      courseidd: courseid,
      iscourse: iscoursee,
      facultyIDd: facultyid,
      coursename: coursename);
}

class _StarRatingState extends State<StarRating> {
  int _rating = 0, _rating1 = 0, _rating2 = 0, _rating3 = 0;
  final String courseidd;
  final bool iscourse;
  final String facultyIDd;
  String? coursename;
  _StarRatingState(
      {required this.facultyIDd,
      required this.courseidd,
      required this.iscourse,
      this.coursename});
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Yor are rating : $coursename',
                style: TextStyle(
                    fontFamily: 'FontMain1',
                    fontSize: MediaQuery.of(context).size.width * 0.05),
              ),
            ],
          ),
          const Center(
              child: Text("Ready to rate based on",
                  softWrap: true, style: TextStyle(fontFamily: 'FontMain1'))),
          const SizedBox(
            height: 10,
          ),
          Center(
              child: iscourse
                  ? const Text(
                      'Relevance of Content',
                      softWrap: true,
                      style: TextStyle(fontFamily: 'FontMain1'),
                    )
                  : const Text(
                      'Knowledge and Expertise',
                      softWrap: true,
                      style: TextStyle(fontFamily: 'FontMain1'),
                    )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.blue,
                ),
                onPressed: () {
                  AnalyticDisplay(sem: 'i');
                  setState(() {
                    _rating = index + 1;
                  });
                },
              );
            }),
          ),
          Center(
              child: iscourse
                  ? const Text(
                      'Breadth and Depth of Coverage',
                      softWrap: true,
                      style: TextStyle(fontFamily: 'FontMain1'),
                    )
                  : const Text(
                      'Teaching Methods and Clarity',
                      softWrap: true,
                      style: TextStyle(fontFamily: 'FontMain1'),
                    )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _rating1 ? Icons.star : Icons.star_border,
                  color: Colors.blue,
                ),
                onPressed: () {
                  AnalyticDisplay(sem: 'i');
                  setState(() {
                    _rating1 = index + 1;
                  });
                },
              );
            }),
          ),
          Center(
              child: iscourse
                  ? const Text(
                      'Clarity and Organization of Material',
                      softWrap: true,
                      style: TextStyle(fontFamily: 'FontMain1'),
                    )
                  : const Text(
                      'Accessibility and Approachability',
                      softWrap: true,
                      style: TextStyle(fontFamily: 'FontMain1'),
                    )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _rating2 ? Icons.star : Icons.star_border,
                  color: Colors.blue,
                ),
                onPressed: () {
                  AnalyticDisplay(sem: 'i');
                  setState(() {
                    _rating2 = index + 1;
                  });
                },
              );
            }),
          ),
          Center(
              child: iscourse
                  ? const Text(
                      'Engagement and Interactive Elements',
                      softWrap: true,
                      style: TextStyle(fontFamily: 'FontMain1'),
                    )
                  : const Text(
                      'Engagement and Student Involvement',
                      softWrap: true,
                      style: TextStyle(fontFamily: 'FontMain1'),
                    )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _rating3 ? Icons.star : Icons.star_border,
                  color: Colors.blue,
                ),
                onPressed: () {
                  AnalyticDisplay(sem: 'i');
                  setState(() {
                    _rating3 = index + 1;
                  });
                },
              );
            }),
          ),
          ElevatedButton(
            onPressed: () async {
              // print('icalled $iscourse  $facultyIDd');
              final FirebaseAuth auth = FirebaseAuth.instance;
              User currentUser = auth.currentUser!;
              String s = "";
              iscourse
                  ? (s = await FireStoreMethods().addCourseReview(
                      reviewCourseId: courseidd,
                      reviewerId: currentUser.uid,
                      courseRating: _rating,
                      courseRating1: _rating1,
                      courseRating2: _rating2,
                      courseRating3: _rating3))
                  : (s = await FireStoreMethods().addFacultyReview(
                      reviewCourseId: courseidd,
                      reviewerId: currentUser.uid,
                      courseRating: _rating,
                      facultyID: facultyIDd,
                      courseRating1: _rating1,
                      courseRating2: _rating2,
                      courseRating3: _rating3));
              // ignore: use_build_context_synchronously
              alterDiallog(context, s);

              // print('icalled ');
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}
