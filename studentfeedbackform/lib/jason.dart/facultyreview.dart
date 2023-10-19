import 'package:cloud_firestore/cloud_firestore.dart';

class AddFacultyReview {
  final int rating0;
  final int rating1;
  final int rating2;
  final int rating3;
  final String courseid;
  final String uid;
  final String fid;
  const AddFacultyReview({
    required this.uid,
    required this.rating0,
    required this.courseid,
    required this.fid,
    required this.rating1,
    required this.rating2,
    required this.rating3,
  });
  Map<String, dynamic> toJson() => {
        "rating0": rating0,
        "rating1": rating1,
        "rating2": rating2,
        "rating3": rating3,
        "couresid": courseid,
        "uid": uid,
        "fid": fid
      };

  static AddFacultyReview fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return AddFacultyReview(
      rating0: snapshot['rating'],
      rating1: snapshot['rating1'],
      rating2: snapshot['rating2'],
      rating3: snapshot['rating3'],
      courseid: snapshot['couresid'],
      uid: snapshot['uid'],
      fid: snapshot['fid'],
    );
  }
}
