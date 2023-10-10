import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentfeedbackform/Analytics.dart/customratingbar.dart';

class RatingBarState extends StatefulWidget {
  String AnaCUid, AnaFid;
  bool iscourse;

  RatingBarState({
    Key? key,
    required this.iscourse,
    required this.AnaCUid,
    required this.AnaFid,
  }) : super(key: key);

  @override
  State<RatingBarState> createState() => _RatingBarStateState(
        AnaCUid: AnaCUid,
        AnaFid: AnaFid,
        iscourse: iscourse,
      );
}

class _RatingBarStateState extends State<RatingBarState> {
  String AnaCUid, AnaFid;
  bool iscourse;
  List<int> ratingsCountList =
      List<int>.filled(6, 0); // Initialize list with zeros

  _RatingBarStateState({
    required this.AnaCUid,
    required this.AnaFid,
    required this.iscourse,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 132, 181, 220),
        title: Text("Analytical Rating"),
      ),
      body: FutureBuilder<void>(
        future: fetchRatings(),
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
    );
  }

  Future<void> fetchRatings() async {
    final futures = List<Future<void>>.generate(6, (index) {
      return RatingCountScreen(
        cid: AnaCUid,
        fid: AnaFid,
        rating: index,
      ).getRatingCountt().then((count) {
        ratingsCountList[index] = count;
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

  Future<int> getRatingCountt() async {
    try {
      final QuerySnapshot snapshot = await (fid.isEmpty
          ? FirebaseFirestore.instance
              .collection('CourseReview') // Replace with your collection name
              .where('rating', isEqualTo: rating)
              .where('couresid', isEqualTo: cid)
              .get()
          : FirebaseFirestore.instance
              .collection('FcaultyReview') // Replace with your collection name
              .where('rating', isEqualTo: rating)
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
