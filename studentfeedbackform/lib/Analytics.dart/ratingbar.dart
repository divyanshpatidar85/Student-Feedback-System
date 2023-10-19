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
  List<int> ratingsCountList = List<int>.filled(6, 0);
  List<int> ratingsCountList1 = List<int>.filled(6, 0);
  List<int> ratingsCountList2 = List<int>.filled(6, 0);
  List<int> ratingsCountList3 = List<int>.filled(6, 0);
  // Initialize list with zeros

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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<void>(
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
            iscourse
                ? Text('Relevance of Content',
                    style: TextStyle(
                        fontFamily: 'FontMain1',
                        fontSize: MediaQuery.of(context).size.height * 0.02))
                : Text('Knowledge and Expertise',
                    style: TextStyle(
                        fontFamily: 'FontMain1',
                        fontSize: MediaQuery.of(context).size.height * 0.02)),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<void>(
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
            iscourse
                ? Text('Relevance of Content',
                    style: TextStyle(
                        fontFamily: 'FontMain1',
                        fontSize: MediaQuery.of(context).size.height * 0.02))
                : Text('Breadth and Depth of Coverage',
                    style: TextStyle(
                        fontFamily: 'FontMain1',
                        fontSize: MediaQuery.of(context).size.height * 0.02)),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<void>(
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
            iscourse
                ? Text('Clarity and Organization of Material',
                    style: TextStyle(
                        fontFamily: 'FontMain1',
                        fontSize: MediaQuery.of(context).size.height * 0.02))
                : Text('Accessibility and Approachability',
                    style: TextStyle(
                        fontFamily: 'FontMain1',
                        fontSize: MediaQuery.of(context).size.height * 0.02)),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<void>(
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
            iscourse
                ? Text('Engagement and Interactive Elements',
                    style: TextStyle(
                        fontFamily: 'FontMain1',
                        fontSize: MediaQuery.of(context).size.height * 0.02))
                : Text('Engagement and Student Involvement',
                    style: TextStyle(
                        fontFamily: 'FontMain1',
                        fontSize: MediaQuery.of(context).size.height * 0.02)),
            const SizedBox(
              height: 20,
            ),
          ],
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
