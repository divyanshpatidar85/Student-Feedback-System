import 'package:cloud_firestore/cloud_firestore.dart';

class AddCourse {
  final String couresename;
  final String courseid;
  final String uid;
  final String sem;
  const AddCourse(
      {required this.uid,
      required this.couresename,
      required this.courseid,
      required this.sem});
  Map<String, dynamic> toJson() =>
      {"coursename": couresename, "couresid": courseid, "uid": uid, "sem": sem};

  static AddCourse fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return AddCourse(
        couresename: snapshot['coursename'],
        courseid: snapshot['couresid'],
        uid: snapshot['uid'],
        sem: snapshot['sem']);
  }
}
