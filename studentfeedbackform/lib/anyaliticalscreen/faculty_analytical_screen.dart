import 'dart:async';

import 'package:flutter/material.dart';
import 'package:studentfeedbackform/Analytics.dart/ratingbar.dart';

class AnalyticalFacultyState extends StatefulWidget {
  final String fname;
  final String fid;
  final String cid;
  const AnalyticalFacultyState({
    super.key,
    required this.fname,
    required this.fid,
    required this.cid,
  });

  @override
  State<AnalyticalFacultyState> createState() =>
      _AnalyticalFacultyStateState(fid: fid, cid: cid);
}

class _AnalyticalFacultyStateState extends State<AnalyticalFacultyState> {
  final String fid;
  final String cid;
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
        cid: widget.cid,
        fid: widget.fid, // Adjust this as needed
        rating: index,
      ).getRatingCountt();
    }

    // print('Ram Ram ${widget.uid}'); // Check if widget.uid has a value

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
      rating_val = rating_val / i;
      setState(() {});
      print("Rating id  :${rating_val / i}");
    });
  }

  _AnalyticalFacultyStateState({required this.fid, required this.cid});
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenSize.height * 0.35,
                child: Text(
                  'Faculty Name: ${widget.fname}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: screenSize.height * 0.03,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FontMain1'),
                  softWrap: true,
                ),
              ),
              Text(
                'Faculty Code: ${widget.fid}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: screenSize.height * 0.02,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'FontMain1'),
              ),
              Text(
                'Rating: ${rating_val}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: screenSize.height * 0.02,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'FontMain3'),
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                child: const Text(
                  'Analytic',
                  style: TextStyle(fontFamily: 'FontMain3'),
                ),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RatingBarState(
                                AnaCUid: cid,
                                AnaFid: fid,
                                iscourse: false,
                              )));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
