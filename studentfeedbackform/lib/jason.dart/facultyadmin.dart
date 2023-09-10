import 'package:cloud_firestore/cloud_firestore.dart';

class FacultyAdmin {
  final String fid;
  final String facultyname;
  const FacultyAdmin({required this.fid, required this.facultyname});
  Map<String, dynamic> toJson() => {"facultyname": facultyname, "fid": fid};

  static FacultyAdmin fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return FacultyAdmin(
      facultyname: snapshot['facultyname'],
      fid: snapshot['Fid'],
    );
  }
}
