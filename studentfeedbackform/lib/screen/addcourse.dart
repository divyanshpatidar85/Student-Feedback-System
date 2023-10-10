import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:studentfeedbackform/anyaliticalscreen/courese_analitical_screen.dart';
import 'package:studentfeedbackform/resourcses.dart/firestore_methods.dart';
import 'package:studentfeedbackform/screen/FacultyAddUiBothPArtOFUIAndRAting/addcourseui.dart';
import 'package:studentfeedbackform/widget/alertdialog.dart';
import 'package:studentfeedbackform/widget/textfiled.dart';

TextEditingController CousreseNameController = TextEditingController();
TextEditingController CousreseIdController = TextEditingController();

class AddCouseScreen extends StatefulWidget {
  const AddCouseScreen({super.key});

  @override
  State<AddCouseScreen> createState() => _AddCouseScreenState();
}

class _AddCouseScreenState extends State<AddCouseScreen> {
  int _page = 0;
  String selectedSem = 'sem'; // Default value
  List<String> sem = [
    'sem',
    'i',
    'ii',
    'iii',
    'iv',
    'v',
    'vi',
    'vii',
    'viii',
  ];
  void setsem(String seme) {
    selectedSem = seme;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    late PageController pageControll = PageController();
    // ignore: unused_element
    @override
    void initState() {
      super.initState();
      pageControll = PageController();
    }

    // ignore: unused_element
    @override
    void dispose() {
      super.dispose();
      pageControll.dispose();
    }

    void navigationTapped(int page) {
      pageControll.jumpToPage(page);
    }

    void onPageChanged(int page) {
      setState(() {
        _page = page;
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Course',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 132, 181, 220),
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: onPageChanged,
          controller: pageControll,
          children: [
            const FacultyAddCourseUi(),
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('courses').snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: Colors.red,
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var courseData = snapshot.data!.docs[index].data();
                    var courseName = courseData['coursename'] ?? 'No Name';
                    var courseId = courseData['couresid'] ?? 'No ID';
                    var courseUId = courseData['uid'] ?? 'No ID';

                    return AnalyticalCourseScreen(
                      name: courseName,
                      id: courseId,
                      uid: courseUId,
                    );
                  },
                );
              },
            ),
          ],
        ),
        // body: StreamBuilder(
        //   stream: FirebaseFirestore.instance.collection('courses').snapshots(),
        //   builder: (context,
        //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const CircularProgressIndicator(
        //         color: Colors.red,
        //       );
        //     }

        //     return ListView.builder(
        //       itemCount: snapshot.data!.docs.length,
        //       itemBuilder: (context, index) {
        //         var courseData = snapshot.data!.docs[index].data();
        //         var courseName = courseData['coursename'] ?? 'No Name';
        //         var courseId = courseData['couresid'] ?? 'No ID';
        //         var courseUId = courseData['uid'] ?? 'No ID';

        //         return CourseFacUi(
        //           name: courseName,
        //           id: courseId,
        //           uid: courseUId,
        //         );
        //       },
        //     );
        //   },
        // ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: _page == 0 ? Colors.black : Colors.black12,
              ),
              label: 'Home',
              tooltip: 'Home',
              // backgroundColor: Colors.yellow,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.analytics,
                color: _page == 1 ? Colors.black : Colors.black12,
              ),
              label: 'Analytic',
              tooltip: 'Analytic',
              // backgroundColor: Colors.yellow,
            ),
          ],
          onTap: navigationTapped,
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(
              Icons.add,
              semanticLabel: "Add Courses",
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ShowDialogClasss(selectedSem, sem: sem)));
              // ShowDialogClasss(selectedSem, sem: sem);
              // showSimpleDialog;
              print('sem is : ${selectedSem}');
            }));
    // ;
  }
}

// ignore: must_be_immutable
class ShowDialogClasss extends StatefulWidget {
  String selectedSem;
  final List<String> sem;
  ShowDialogClasss(this.selectedSem, {super.key, required this.sem});

  @override
  State<ShowDialogClasss> createState() => _ShowDialogClasssState();
}

class _ShowDialogClasssState extends State<ShowDialogClasss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Add Course',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            // fontFamily: 'FontMain'
          ),
        ),
        centerTitle: true,
      ),
      body: AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'ADD COURSES ',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            TextFieldInput(
              textEditingController: CousreseNameController,
              hintText: "Course Name",
              textInputType: TextInputType.text,
              fontFamily: 'FontMain3',
              decoation: InputDecoration(),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFieldInput(
                textEditingController: CousreseIdController,
                decoation: InputDecoration(),
                fontFamily: 'FontMain3',
                hintText: "Course ID",
                textInputType: TextInputType.text),
            const SizedBox(
              height: 5,
            ),
            DropdownButton<String>(
              value: widget.selectedSem,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  widget.selectedSem = newValue;
                  // setsem(selectedSem);
                  setState(() {});
                }
              },
              items: widget.sem.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
                onPressed: () async {
                  String s = "some error occured";
                  print('sem is $widget.selectedSem');
                  if (CousreseNameController.text.isNotEmpty &&
                      CousreseIdController.text.isNotEmpty &&
                      widget.selectedSem != 'sem') {
                    s = await FireStoreMethods().addCourse(
                        CousreseNameController.text,
                        CousreseIdController.text,
                        widget.selectedSem);
                    CousreseNameController.text = "";
                    CousreseIdController.text = "";
                  } else {
                    alterDiallog(context, 'Fill all the field');
                  }
                  if (s.isNotEmpty && s == 'Course inserted successfully.')
                    Navigator.pop(context);
                  alterDiallog(context, s);
                },
                child: const Text('Add')),
          ])),
    );
  }
}
// showSimpleDialog(BuildContext context, String selectedSem, var sem, setsem()) {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return
//       });
// }
