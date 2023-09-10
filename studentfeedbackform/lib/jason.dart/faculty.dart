import 'package:cloud_firestore/cloud_firestore.dart';

class AddFaculty {
  final String couresid;
  final String fid;
  final String facultyname;
  const AddFaculty(
      {required this.fid, required this.couresid, required this.facultyname});
  Map<String, dynamic> toJson() =>
      {"couresid": couresid, "facultyname": facultyname, "fid": fid};

  static AddFaculty fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return AddFaculty(
      couresid: snapshot['couresid'],
      facultyname: snapshot['facultyname'],
      fid: snapshot['Fid'],
    );
  }
}
