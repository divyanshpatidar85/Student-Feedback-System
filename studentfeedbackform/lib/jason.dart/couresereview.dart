import 'package:cloud_firestore/cloud_firestore.dart';

class AddCourseReview {
  final int rating;
  final String courseid;
  final String uid;
  const AddCourseReview(
      {required this.uid, required this.rating, required this.courseid});
  Map<String, dynamic> toJson() =>
      {"rating": rating, "couresid": courseid, "uid": uid};

  static AddCourseReview fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return AddCourseReview(
        rating: snapshot['rating'],
        courseid: snapshot['couresid'],
        uid: snapshot['uid']);
  }
}
