import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentfeedbackform/jason.dart/couresereview.dart';
import 'package:studentfeedbackform/jason.dart/course.dart';
import 'package:studentfeedbackform/jason.dart/faculty.dart';
import 'package:studentfeedbackform/jason.dart/facultyreview.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addCourse(
      String coureseName, String courseId, String sem) async {
    String res = "Some error occurred";
    try {
      String uid = const Uuid().v1();
      AddCourse cou = AddCourse(
          couresename: coureseName, courseid: courseId, uid: uid, sem: sem);
      String lowercaseCourseId = courseId.toLowerCase();

// Check if a course with the provided courseId already exists
      QuerySnapshot snapshot = await _firestore
          .collection('courses')
          .where('lowercase_courseid', isEqualTo: lowercaseCourseId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return res = 'A course with the same courseId already exists.';
      } else {
        // Create a map to store both the original courseId and the lowercase version
        Map<String, dynamic> courseData = cou.toJson();
        courseData['lowercase_courseid'] = lowercaseCourseId;

        await _firestore.collection('courses').doc(uid).set(courseData);
        res = 'Course inserted successfully.';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> addFaulty(String FName, String FId, String cid) async {
    String res = "Some error occurred";
    try {
      String uid = const Uuid().v1();
      AddFaculty cou = AddFaculty(fid: FId, couresid: cid, facultyname: FName);
      String lowercasefId = FId.toLowerCase();

// Check if a course with the provided courseId already exists
      QuerySnapshot snapshot = await _firestore
          .collection('faculty')
          .where('lowercase_courseid', isEqualTo: lowercasefId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return res = 'A Faculty with the same fcode already exists.';
      } else {
        // Create a map to store both the original courseId and the lowercase version
        Map<String, dynamic> Fac = cou.toJson();
        Fac['lowercase_courseid'] = lowercasefId;

        await _firestore.collection('faculty').doc(uid).set(Fac);
        res = 'Faculty inserted successfully.';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> deleteFacultyMember(String facultyId) async {
    String res = "some error occured";
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('faculty')
          .where('fid', isEqualTo: facultyId)
          .get();
      QuerySnapshot querySnapshott = await FirebaseFirestore.instance
          .collection('FcaultyReview')
          .where('fid', isEqualTo: facultyId)
          .get();
      //
      print('Fid is :${facultyId}');
      if (querySnapshott.size > 0) {
        for (QueryDocumentSnapshot docSnapshot in querySnapshott.docs) {
          print("i am andar");
          await docSnapshot.reference.delete();
        }
      }

      if (querySnapshot.size > 0) {
        // Since faculty ID should be unique, we can delete the first (and only) document found
        await querySnapshot.docs[0].reference.delete();

        return res = 'Faculty member with ID $facultyId deleted successfully';
      } else {
        return res = 'No faculty member found with ID $facultyId';
      }
      // res = 'Faculty member deleted successfully';
    } catch (error) {
      res = 'Error deleting faculty member';
    }
    return res;
  }

  deleteFacultyByCourseId(String uId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('faculty')
          .where('couresid', isEqualTo: uId)
          .get();

      await _firestore.collection('courses').doc(uId).delete();

      // Loop through the documents and delete each one
      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        await document.reference.delete();
      }
      //courese review is deleting logic
      QuerySnapshot querySnapshott = await FirebaseFirestore.instance
          .collection('CourseReview')
          .where('couresid', isEqualTo: uId)
          .get();
      //
      // print('Fid is :${facultyId}');
      if (querySnapshott.size > 0) {
        for (QueryDocumentSnapshot docSnapshot in querySnapshott.docs) {
          print("i am andar");
          await docSnapshot.reference.delete();
        }
      }

      if (querySnapshot.size == 0) {}
    } catch (error) {
      print('Error deleting faculty members: $error');
    }
  }

//adding course rating
  Future<String> addCourseReview(
      {required String reviewCourseId,
      required String reviewerId,
      required int courseRating}) async {
    String res = "Some error occurred";
    try {
      int rating = 0;
      String uid = const Uuid().v1();
      AddCourseReview cou = AddCourseReview(
        uid: reviewerId,
        rating: courseRating,
        courseid: reviewCourseId,
      );

      // String lowercasefId = FId.toLowerCase();

// Check if a course with the provided courseId already exists
      QuerySnapshot snapshot = await _firestore
          .collection('CourseReview')
          .where('uid', isEqualTo: reviewerId)
          .where('couresid', isEqualTo: reviewCourseId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        DocumentSnapshot document = snapshot.docs[0]; //

        Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

        rating = data!['rating'];

        return res = 'You Already rated is course \n rating is $rating';
      } else {
        // Create a map to store both the original courseId and the lowercase version
        Map<String, dynamic> reviewCourseData = cou.toJson();
        await _firestore
            .collection('CourseReview')
            .doc(uid)
            .set(reviewCourseData);
        return res = 'successfully.';
      }
    } catch (err) {
      res = err.toString();
      print('$res');
    }
    return res;
  }

  //add factulty review
  //adding course rating
  Future<String> addFacultyReview(
      {required String reviewCourseId,
      required String reviewerId,
      required int courseRating,
      required String facultyID}) async {
    String res = "Some error occurred";
    try {
      int rating = 0;
      // facultyID = facultyID.toLowerCase();
      String uid = const Uuid().v1();
      AddFacultyReview cou = AddFacultyReview(
          uid: reviewerId,
          rating: courseRating,
          courseid: reviewCourseId,
          fid: facultyID);

      // String lowercasefId = FId.toLowerCase();

// Check if a course with the provided courseId already exists
      QuerySnapshot snapshot = await _firestore
          .collection('FcaultyReview')
          .where('uid', isEqualTo: reviewerId)
          .where('couresid', isEqualTo: reviewCourseId)
          .where('fid', isEqualTo: facultyID)
          .get();

      if (snapshot.docs.isNotEmpty) {
        DocumentSnapshot document = snapshot.docs[0]; //

        Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

        rating = data!['rating'];
        // print('Rating: $rat/ing');

        return res = 'You Already rated this faculty \n rating is $rating';
      } else {
        // Create a map to store both the original courseId and the lowercase version
        Map<String, dynamic> reviewfacultyData = cou.toJson();
        await _firestore
            .collection('FcaultyReview')
            .doc(uid)
            .set(reviewfacultyData);
        res = 'successfully.';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
