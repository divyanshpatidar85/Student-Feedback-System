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
  late List<int> ratingsCountList1;
  late List<int> ratingsCountList2;
  late List<int> ratingsCountList3;
  late List<Future<int>> ratingCountFutures;
  late List<Future<int>> ratingCountFutures1;
  late List<Future<int>> ratingCountFutures2;
  late List<Future<int>> ratingCountFutures3;
  @override
  void initState() {
    print('Helli ');
    super.initState();
    ratingsCountList = List<int>.filled(6, 0);
    ratingsCountList1 = List<int>.filled(6, 0);
    ratingsCountList2 = List<int>.filled(6, 0);
    ratingsCountList3 = List<int>.filled(6, 0);
    // Initialize with zeros
    ratingCountFutures = List<Future<int>>.filled(6, Future.value(0));
    ratingCountFutures1 = List<Future<int>>.filled(6, Future.value(0));
    ratingCountFutures2 = List<Future<int>>.filled(6, Future.value(0));
    ratingCountFutures3 = List<Future<int>>.filled(6, Future.value(0));
    for (int index = 0; index < 6; index++) {
      ratingCountFutures[index] = RatingCountScreen(
        cid: widget.cid,
        fid: widget.fid, // Adjust this as needed
        rating: index,
      ).getRatingCountt(0);
    }
    for (int index = 0; index < 6; index++) {
      ratingCountFutures1[index] = RatingCountScreen(
        cid: widget.cid,
        fid: widget.fid, // Adjust this as needed
        rating: index,
      ).getRatingCountt(1);
    }
    for (int index = 0; index < 6; index++) {
      ratingCountFutures2[index] = RatingCountScreen(
        cid: widget.cid,
        fid: widget.fid, // Adjust this as needed
        rating: index,
      ).getRatingCountt(2);
    }
    for (int index = 0; index < 6; index++) {
      ratingCountFutures3[index] = RatingCountScreen(
        cid: widget.cid,
        fid: widget.fid, // Adjust this as needed
        rating: index,
      ).getRatingCountt(3);
    }

    // print('Ram Ram ${widget.uid}'); // Check if widget.uid has a value
    Future.wait(ratingCountFutures3).then((counts) {
      // Check if counts contains valid data

      ratingsCountList3 = counts;
      print('course  $counts');
      for (int j = 0; j < counts.length; j++) {
        i = i + counts[j];
        rating_val = rating_val + (counts[j] * j);
      }
    });
    Future.wait(ratingCountFutures2).then((counts) {
      // Check if counts contains valid data

      ratingsCountList2 = counts;
      print('course  $counts');
      for (int j = 0; j < counts.length; j++) {
        i = i + counts[j];
        rating_val = rating_val + (counts[j] * j);
      }
    });
    Future.wait(ratingCountFutures1).then((counts) {
      // Check if counts contains valid data

      ratingsCountList1 = counts;
      print('course  $counts');
      for (int j = 0; j < counts.length; j++) {
        i = i + counts[j];
        rating_val = rating_val + (counts[j] * j);
      }
    });
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
                    fontFamily: 'FontMain1'),
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
