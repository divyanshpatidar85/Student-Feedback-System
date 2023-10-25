import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //know Free Code champ
  // Future<UserDetails> getUserDetails() async {
  //   // User currentUser = _auth.currentUser!;
  //   // DocumentSnapshot snap=await _firestore.collection('user').doc()

  // }

  // Signing Up User
  Future<String> signUpuser({
    required String username,
    required String enrollno,
    required String email,
    required String password,
    required String sem,
    required String usertype,
  }) async {
    String res = "Fill the the details";
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          (sem != 'sem' || usertype == 'Faculty' || usertype == 'Admin')) {
        UserCredential cd = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cd.user!.email);
        await _firestore.collection('users').doc(cd.user!.uid).set({
          'uid': cd.user!.uid,
          'username': username,
          'email': email,
          'sem': sem,
          'usertype': usertype,
          'enrollnum': enrollno
        });
        res = "success";
      }
    } catch (err) {
      return err.toString();
    }
    print('result is : ${res}');
    return res;
  }

  Future<String> loginMethod({
    required String email,
    required String password,
    required String usertype,
  }) async {
    Completer<String> completer = Completer<String>();

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        completer.complete("Please fill all the fields.");
        return completer.future; // Return early
      }
    } catch (error) {
      completer.complete(error.toString());
      return completer.future; // Return early
    }

    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot;
      usertype != 'Faculty'
          ? userSnapshot =
              await _firestore.collection('users').doc(user.uid).get()
          : userSnapshot =
              await _firestore.collection('FacultyAdmin').doc(user.uid).get();
      print('faculty is here : $userSnapshot ');
      if (userSnapshot.exists) {
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;
        print('above user');
        if (userData != null) {
          String userType = userData['usertype'] ?? '';

          print('UserType: $userType, Selected UserType: $usertype');
          Timer(Duration(seconds: 2), () {
            print('${usertype == userType}');
            if (userType == usertype) {
              completer.complete("success");
            } else {
              _auth.signOut();
              completer.complete("No data is found.");
            }
          });
        } else {
          _auth.signOut();
        }
      } else {
        _auth.signOut();
      }
    } else {
      _auth.signOut();
      completer.complete("User not found.");
    }

    return completer.future;
  }

  //admin faculty sign up
  Future<String> FacultyAdminSignUp({
    required String username,
    required String email,
    required String password,
    required String fcode,
  }) async {
    String res = "Fill in the details";
    String usertype = 'Faculty';

    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          (usertype == 'Faculty') &&
          fcode.isNotEmpty) {
        // Check if the provided fcode matches a predefined value
        if (fcode == fcode) {
          // Check if the faculty user already exists with the provided email
          final QuerySnapshot existingUsers = await _firestore
              .collection('FacultyAdmin')
              .where('fcode', isEqualTo: fcode)
              .get();

          if (existingUsers.docs.isEmpty) {
            // If no matching documents found, create a new user
            UserCredential cd = await _auth.createUserWithEmailAndPassword(
                email: email, password: password);
            print(cd.user!.email);
            await _firestore.collection('FacultyAdmin').doc(cd.user!.uid).set({
              'uid': cd.user!.uid,
              'username': username,
              'email': email,
              'usertype': usertype,
              'fcode': fcode
            });
            res = "Success";
          } else {
            // User with the same email already exists, forcefully overwrite
            final existingUser = existingUsers.docs.first;
            await _firestore.collection('FacultyAdmin').doc(existingUser.id).set(
                {
                  'uid': existingUser.id,
                  'username': username,
                  'email': email,
                  'usertype': usertype,
                  'fcode': fcode
                },
                SetOptions(
                    merge:
                        true)); // Use merge: true to overwrite the existing document
            res = "User with this email already existed and has been updated";
          }
        } else {
          // Provided fcode does not match the predefined value
          res = "Invalid fcode";
        }
      }
    } catch (err) {
      return err.toString();
    }

    print('Result is: ${res}');
    return res;
  }

  //deleting faculty admin
  Future<String> deleteFacultyAdmin(
      String facultyId, String uid, String em) async {
    String res = "some error occured";
    try {
      QuerySnapshot querySnapshottt = await FirebaseFirestore.instance
          .collection('FacultyAdmin')
          .where('fcode', isEqualTo: facultyId)
          .get();

      // await FirebaseAuth.instance.currentUser!.delete();
      // _auth().deleteUser(email, password);
      await FirebaseAuth.instance.fetchSignInMethodsForEmail(em);

      // FirebaseAuth _auth=FirebaseAuth.instance;
      // User? user= await _auth.;
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
      if (querySnapshottt.size > 0) {
        for (QueryDocumentSnapshot docSnapshot in querySnapshottt.docs) {
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
}
