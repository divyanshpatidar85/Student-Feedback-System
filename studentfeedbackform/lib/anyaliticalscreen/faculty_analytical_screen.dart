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
  int i = 0, i1 = 0, i2 = 0, i3 = 0, i4 = 0;
  // ignore: non_constant_identifier_names
  double rating_val = 0,
      // ignore: non_constant_identifier_names
      rating_val1 = 0,
      // ignore: non_constant_identifier_names
      rating_val2 = 0,
      // ignore: non_constant_identifier_names
      rating_val3 = 0,
      // ignore: non_constant_identifier_names
      rating_val4 = 0;
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
        i1 = i1 + counts[j];
        rating_val = rating_val + (counts[j] * j);
        rating_val1 = (rating_val1 + (counts[j] * j));
      }
    });
    Future.wait(ratingCountFutures2).then((counts) {
      // Check if counts contains valid data

      ratingsCountList2 = counts;
      print('course  $counts');
      for (int j = 0; j < counts.length; j++) {
        i = i + counts[j];
        i2 = i2 + counts[j];
        rating_val = rating_val + (counts[j] * j);
        rating_val2 = (rating_val2 + (counts[j] * j));
      }
    });
    Future.wait(ratingCountFutures1).then((counts) {
      // Check if counts contains valid data

      ratingsCountList1 = counts;
      print('course  $counts');
      for (int j = 0; j < counts.length; j++) {
        i = i + counts[j];
        i3 = i3 + counts[j];
        rating_val = rating_val + (counts[j] * j);
        rating_val3 = (rating_val3 + (counts[j] * j));
      }
    });
    Future.wait(ratingCountFutures).then((counts) {
      // Check if counts contains valid data
      setState(() {
        ratingsCountList = counts;
        print('course  $counts');
        for (int j = 0; j < counts.length; j++) {
          i = i + counts[j];
          i4 = i4 + counts[j];
          rating_val = rating_val + (counts[j] * j);
          rating_val4 = (rating_val4 + (counts[j] * j));
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
                width: screenSize.width * 0.6,
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
                'Rating: ${(rating_val).toStringAsFixed(2)}',
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
                                rating0: rating_val1 / i1,
                                rating1: rating_val2 / i2,
                                rating2: rating_val3 / i3,
                                rating3: rating_val4 / i4,
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
