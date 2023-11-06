// import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentfeedbackform/Analytics.dart/customratingbar.dart';

// ignore: must_be_immutable
class RatingBarState extends StatefulWidget {
  String AnaCUid, AnaFid;
  bool iscourse;
  var rating0, rating1, rating2, rating3;

  RatingBarState({
    Key? key,
    required this.iscourse,
    required this.AnaCUid,
    required this.AnaFid,
    required this.rating0,
    required this.rating1,
    required this.rating2,
    required this.rating3,
  }) : super(key: key);

  @override
  State<RatingBarState> createState() => _RatingBarStateState(
        AnaCUid: AnaCUid,
        AnaFid: AnaFid,
        iscourse: iscourse,
        rating1: rating0,
        rating2: rating1,
        rating3: rating2,
        rating4: rating3,
      );
}

class _RatingBarStateState extends State<RatingBarState> {
  String AnaCUid, AnaFid;
  bool iscourse;
  List<int> ratingsCountList = List<int>.filled(6, 0);
  List<int> ratingsCountList1 = List<int>.filled(6, 0);
  List<int> ratingsCountList2 = List<int>.filled(6, 0);
  List<int> ratingsCountList3 = List<int>.filled(6, 0);

  var rating1, rating2, rating3, rating4;

  // var ;
  // Initialize list with zeros

  _RatingBarStateState({
    required this.AnaCUid,
    required this.AnaFid,
    required this.iscourse,
    required this.rating1,
    required this.rating2,
    required this.rating3,
    required this.rating4,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 132, 181, 220),
        title: Text("Analytical Rating"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: kIsWeb && MediaQuery.of(context).size.width > 375
                      ? MediaQuery.of(context).size.height * 0.6
                      : null,
                  child: FutureBuilder<void>(
                    future: fetchRatings(0),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return CustomRatingBar(ratingsCountList);
                      }
                    },
                  ),
                ),
                iscourse
                    ? Column(
                        children: [
                          Text('Overall Course Experience',
                              style: TextStyle(
                                  fontFamily: 'FontMain1',
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02)),
                          Text('Rating: (${(rating1).toStringAsFixed(2)})',
                              style: TextStyle(
                                  fontFamily: 'FontMain1',
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02))
                        ],
                      )
                    : Column(
                        children: [
                          Text('Teaching Method',
                              style: TextStyle(
                                  fontFamily: 'FontMain1',
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02)),
                          Text('Rating: (${(rating1).toStringAsFixed(2)})',
                              style: TextStyle(
                                  fontFamily: 'FontMain1',
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02))
                        ],
                      ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: kIsWeb && MediaQuery.of(context).size.width > 375
                      ? MediaQuery.of(context).size.height * 0.6
                      : null,
                  child: FutureBuilder<void>(
                    future: fetchRatings(1),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return CustomRatingBar(ratingsCountList1);
                      }
                    },
                  ),
                ),
                iscourse
                    ? Column(
                        children: [
                          Text('Course Content',
                              style: TextStyle(
                                  fontFamily: 'FontMain1',
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02)),
                          Text('Rating: (${(rating2).toStringAsFixed(2)})',
                              style: TextStyle(
                                  fontFamily: 'FontMain1',
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02))
                        ],
                      )
                    : Column(
                        children: [
                          Text('Clarity and Communication',
                              style: TextStyle(
                                  fontFamily: 'FontMain1',
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02)),
                          Text('Rating: (${(rating2).toStringAsFixed(2)})',
                              style: TextStyle(
                                  fontFamily: 'FontMain1',
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02))
                        ],
                      ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: kIsWeb && MediaQuery.of(context).size.width > 375
                      ? MediaQuery.of(context).size.height * 0.6
                      : null,
                  child: FutureBuilder<void>(
                    future: fetchRatings(2),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return CustomRatingBar(ratingsCountList2);
                      }
                    },
                  ),
                ),
                iscourse
                    ? Column(
                        children: [
                          Text('Course Goal and Outcome',
                              style: TextStyle(
                                  fontFamily: 'FontMain1',
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02)),
                          Text('Rating: (${(rating3).toStringAsFixed(2)})',
                              style: TextStyle(
                                  fontFamily: 'FontMain1',
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02))
                        ],
                      )
                    : Column(
                        children: [
                          Text('Availability and Responsiveness',
                              style: TextStyle(
                                  fontFamily: 'FontMain1',
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02)),
                          Text('Rating: (${(rating3).toStringAsFixed(2)})',
                              style: TextStyle(
                                  fontFamily: 'FontMain1',
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02))
                        ],
                      ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: kIsWeb && MediaQuery.of(context).size.width > 375
                      ? MediaQuery.of(context).size.height * 0.6
                      : null,
                  child: FutureBuilder<void>(
                    future: fetchRatings(3),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return CustomRatingBar(ratingsCountList3);
                      }
                    },
                  ),
                ),
                iscourse
                    ? Column(
                        children: [
                          Text('Course Structure and Organiation',
                              style: TextStyle(
                                  fontFamily: 'FontMain1',
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02)),
                          Text('Rating: (${(rating3).toStringAsFixed(2)})',
                              style: TextStyle(
                                  fontFamily: 'FontMain1',
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02))
                        ],
                      )
                    : Column(
                        children: [
                          Text('Knowledge and Expertise',
                              style: TextStyle(
                                  fontFamily: 'FontMain1',
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02)),
                          Text('Rating: (${(rating4).toStringAsFixed(2)})',
                              style: TextStyle(
                                  fontFamily: 'FontMain1',
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02))
                        ],
                      ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fetchRatings(int i) async {
    final futures = List<Future<void>>.generate(6, (index) {
      return RatingCountScreen(
        cid: AnaCUid,
        fid: AnaFid,
        rating: index,
      ).getRatingCountt(i).then((count) {
        if (i == 0) {
          ratingsCountList[index] = count;
        } else if (i == 1) {
          ratingsCountList1[index] = count;
        } else if (i == 2) {
          ratingsCountList2[index] = count;
        } else {
          ratingsCountList3[index] = count;
        }
      });
    });

    await Future.wait(futures);
  }
}

class RatingCountScreen {
  final String cid;
  final String fid;
  final int rating;

  RatingCountScreen({
    required this.cid,
    required this.fid,
    required this.rating,
  });

  Future<int> getRatingCountt(int i) async {
    try {
      final QuerySnapshot snapshot = await (fid.isEmpty
          ? FirebaseFirestore.instance
              .collection('CourseReview') // Replace with your collection name
              .where('rating$i', isEqualTo: rating)
              .where('couresid', isEqualTo: cid)
              .get()
          : FirebaseFirestore.instance
              .collection('FcaultyReview') // Replace with your collection name
              .where('rating$i', isEqualTo: rating)
              .where('couresid', isEqualTo: cid)
              .where('fid', isEqualTo: fid)
              .get());
      return snapshot.size;
    } catch (error) {
      print("Error fetching rating count: $error");
      return 0; // Return 0 on error
    }
  }
}
