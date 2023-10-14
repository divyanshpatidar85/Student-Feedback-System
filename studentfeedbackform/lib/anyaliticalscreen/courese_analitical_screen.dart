import 'dart:async';

import 'package:flutter/material.dart';
import 'package:studentfeedbackform/Analytics.dart/faclty_analtyical_view_for_user.dart';
import 'package:studentfeedbackform/Analytics.dart/ratingbar.dart';

class AnalyticalCourseScreen extends StatefulWidget {
  final String name;
  final String id;
  final String uid;
  // final String acid;
  // final String auid;
  const AnalyticalCourseScreen(
      {super.key, required this.name, required this.id, required this.uid});

  @override
  State<AnalyticalCourseScreen> createState() => _AnalyticalCourseScreenState();
}

class _AnalyticalCourseScreenState extends State<AnalyticalCourseScreen> {
  late int i = 0;
  double rating_val = 0;
  late List<int> ratingsCountList;
  late List<Future<int>> ratingCountFutures;

  @override
  void initState() {
    print('Helli ');
    super.initState();
    ratingsCountList = List<int>.filled(6, 0); // Initialize with zeros
    ratingCountFutures = List<Future<int>>.filled(6, Future.value(0));

    for (int index = 0; index < 6; index++) {
      ratingCountFutures[index] = RatingCountScreen(
        cid: widget.uid,
        fid: '', // Adjust this as needed
        rating: index,
      ).getRatingCountt();
    }

    print('Ram Ram ${widget.uid}'); // Check if widget.uid has a value

    Future.wait(ratingCountFutures).then((counts) {
      // Check if counts contains valid data
      setState(() {
        ratingsCountList = counts;
        print('course  $counts');
        for (int j = 0; j < counts.length; j++) {
          i = i + counts[j];
          rating_val = rating_val + (counts[j] * j);
        }
      });
    });
    Timer(Duration(seconds: 1), () {
      print("i is :$i");
      rating_val = rating_val;
      setState(() {});
      // print("Rating id  :${rating_val / i}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FacultyDetailsOnAnalyticalScreen(
                      courseidd: widget.uid,
                    )));
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenSize.width * 0.97,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
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
                  ),
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: screenSize.width * 0.8,
                          child: Text(
                            'Course: ${widget.name}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenSize.height * 0.04,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'FontMain1',
                            ),
                            softWrap: true,
                          ),
                        ),
                        Text(
                          'Course Code ${widget.id}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenSize.height * 0.03,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'FontMain1',
                          ),
                        ),
                        Text(
                          'Rating is ${rating_val / i}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenSize.height * 0.03,
                            fontFamily: 'FontMain1',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RatingBarState(
                                  AnaCUid: widget.uid,
                                  AnaFid: '',
                                  iscourse: true,
                                ),
                              ));
                        },
                        child: const Text(
                          'Analytic',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'FontMain3'),
                        ))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
