import 'package:cloud_firestore/cloud_firestore.dart';

class AddCourseReview {
  final int rating;
  final int rating1;
  final int rating2;
  final int rating3;
  final String courseid;
  final String uid;
  const AddCourseReview(
      {required this.uid,
      required this.rating,
      required this.courseid,
      required this.rating1,
      required this.rating2,
      required this.rating3});
  Map<String, dynamic> toJson() => {
        "rating0": rating,
        "couresid": courseid,
        "uid": uid,
        "rating1": rating1,
        "rating2": rating2,
        "rating3": rating
      };

  static AddCourseReview fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return AddCourseReview(
        rating: snapshot['rating0'],
        courseid: snapshot['couresid'],
        uid: snapshot['uid'],
        rating1: snapshot['rating1'],
        rating2: snapshot['rating2'],
        rating3: snapshot['rating3']);
  }
}
