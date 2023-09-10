import 'package:cloud_firestore/cloud_firestore.dart';

class AddFacultyReview {
  final int rating;
  final String courseid;
  final String uid;
  final String fid;
  const AddFacultyReview(
      {required this.uid,
      required this.rating,
      required this.courseid,
      required this.fid});
  Map<String, dynamic> toJson() =>
      {"rating": rating, "couresid": courseid, "uid": uid, "fid": fid};

  static AddFacultyReview fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return AddFacultyReview(
      rating: snapshot['rating'],
      courseid: snapshot['couresid'],
      uid: snapshot['uid'],
      fid: snapshot['fid'],
    );
  }
}
