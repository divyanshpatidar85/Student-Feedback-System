import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:studentfeedbackform/main.dart';

import 'package:studentfeedbackform/userviewscreen/userviewcourse.dart';

class MainFeedScreen extends StatefulWidget {
  final String sem;
  MainFeedScreen({Key? key, required this.sem}) : super(key: key);

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  // final FirebaseAuth auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // late String sem; // No need for Future<String> since sem is always available
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (kIsWeb) {
    //     // Check if the app is running on the web
    //     _scaffoldKey.currentState?.openDrawer();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.width * 0.1,
          backgroundColor: const Color.fromARGB(255, 132, 181, 220),
          // title: Text(
          //   "Course Details ",
          //   style: TextStyle(
          //       fontSize: MediaQuery.of(context).size.height * 0.05,
          //       fontWeight: FontWeight.bold),
          // ),
          title: ListTile(
            title: Center(
              child: Text(
                'Course Details',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.07,
                  fontWeight: FontWeight.bold,
                  // fontFamily: 'FontMain'
                ),
              ),
            ),
            // leading: Builder(builder: (BuildContext context) {
            //   return GestureDetector(
            //     child: Text('heelo'),
            //     onTap: () {
            //       Scaffold.of(context).openDrawer();
            //     },
            //   );
            // }),
            trailing: GestureDetector(
              onTap: () async {
                FirebaseAuth auth = FirebaseAuth.instance;
                await auth.signOut();
                MyHomePage app = MyHomePage(
                  title: 'heelo',
                );
                app.updateBl('');
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage(
                              title: 'Course Details ',
                            )));
              },
              child: const Icon(Icons.logout),
            ),
          ),
          centerTitle: true,
        ),
        body: UserScreenView(sem: widget.sem),
        drawer: Drawer(
            child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(128, 132, 181, 220),
                ),
                child: Image.asset('asset/image/hi.jpeg')),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('uid',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: Colors.red,
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var courseData = snapshot.data!.docs[index].data();
                    var courseName = courseData['email'] ?? 'No Name';
                    print('heelo ');
                    // var courseId = courseData['couresid'] ?? 'No ID';
                    // var courseUId = courseData['uid'] ?? 'No ID';
                    return Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Center(
                                child: Text(
                                  'Email : $courseName',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02),
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Center(
                                child: Text(
                                  'UserName : ${courseData['username']}',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02),
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Center(
                                child: Text(
                                  'Enrollment no. : ${courseData['enrollnum']}',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02),
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Center(
                                child: Text(
                                  'Semester : ${courseData['sem']}',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02),
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Status : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                    ),
                                    Text(
                                      'Active',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                    // setState(() {});
                    // return null;
                  },
                );
              },
            ),
          ],
        )),
      );
    } catch (err) {
      return Scaffold();
    }
  }
}
