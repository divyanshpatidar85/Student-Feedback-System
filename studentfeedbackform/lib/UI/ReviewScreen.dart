import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:studentfeedbackform/Analytics.dart/analytics.dart';
// import 'package:studentfeedbackform/Analytics.dart/customratingbar.dart';
import 'package:studentfeedbackform/resourcses.dart/firestore_methods.dart';
import 'package:studentfeedbackform/widget/alertdialog.dart';

class ReviewScreen extends StatelessWidget {
  final bool iscourse;
  final String courseid;
  final String facultyid;
  const ReviewScreen({
    super.key,
    required this.facultyid,
    required this.iscourse,
    required this.courseid,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback Screen'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.withOpacity(0.2),
      ),
      body: Center(
          child: StarRating(
        facultyid: facultyid,
        iscoursee: iscourse,
        courseid: courseid,
      )),
    );
  }
}

class StarRating extends StatefulWidget {
  final String courseid;
  final bool iscoursee;
  final String facultyid;
  const StarRating(
      {super.key,
      required this.facultyid,
      required this.iscoursee,
      required this.courseid,
      bool? iscourse});
  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _StarRatingState createState() => _StarRatingState(
      courseidd: courseid, iscourse: iscoursee, facultyIDd: facultyid);
}

class _StarRatingState extends State<StarRating> {
  int _rating = 0;
  final String courseidd;
  final bool iscourse;
  final String facultyIDd;
  _StarRatingState(
      {required this.facultyIDd,
      required this.courseidd,
      required this.iscourse});
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
                    courseRating: _rating))
                : (s = await FireStoreMethods().addFacultyReview(
                    reviewCourseId: courseidd,
                    reviewerId: currentUser.uid,
                    courseRating: _rating,
                    facultyID: facultyIDd));
            alterDiallog(context, s);

            // print('icalled ');
          },
          child: const Text('Submit'),
        )
      ],
    );
  }
}
