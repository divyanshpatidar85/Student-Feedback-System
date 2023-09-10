// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class RatingCountScreen extends StatelessWidget {
//   final String cid;
//   final String fid;
//   final int rating;
//   const RatingCountScreen(
//       {super.key, required this.cid, required this.fid, required this.rating});

//   Future<int> getRatingCountt() async {
//     final QuerySnapshot snapshot = (fid.isEmpty
//         ? FirebaseFirestore.instance
//             .collection('CourseReview') // Replace with your collection name
//             .where('rating', isEqualTo: rating)
//             .where('couresid', isEqualTo: cid)
//             .get()
//         : FirebaseFirestore.instance
//             .collection('FcaultyReview') // Replace with your collection name
//             .where('rating', isEqualTo: rating)
//             .where('couresid', isEqualTo: cid)
//             .where('fid', isEqualTo: fid)
//             .get()) as QuerySnapshot<Object?>;

//     return snapshot.size;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<int>(
//       future: getRatingCountt(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           return Center(
//             child: Text('Count of ratings with value 3: ${snapshot.data}'),
//           );
//         }
//       },
//     );
//   }
// }
