import 'package:flutter/material.dart';

import 'package:studentfeedbackform/resourcses.dart/auth_method.dart';
import 'package:studentfeedbackform/screen/addcourse.dart';
import 'package:studentfeedbackform/screen/feedscreen.dart';
import 'package:studentfeedbackform/wideget.dart';
import 'package:studentfeedbackform/widget/alertdialog.dart';
import 'package:studentfeedbackform/widget/textfiled.dart';

class SignUpScreen extends StatefulWidget {
  final Function(String) updateBl;
  const SignUpScreen({super.key, required this.updateBl});

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  bool indicator = true;
  String selectedSem = 'sem';
  String selectedusertype = 'Student';
  List<String> userTypes = ['Student', 'Admin']; // Default value
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
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController enrollcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Sign Up Screen',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: screenSize.width * 0.05),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 132, 181, 220),
        ),
        body: Center(
          child: SizedBox(
            width: screenSize.width * 0.5,
            height: screenSize.height * 0.5,
            child: Column(
              children: [
                DropdownButton<String>(
                  value: selectedusertype,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      selectedusertype = newValue;

                      setState(() {});
                    }
                  },
                  items:
                      userTypes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                selectedusertype == 'Student'
                    ? DropdownButton<String>(
                        value: selectedSem,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedSem = newValue;
                            });
                          }
                        },
                        items:
                            sem.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    : const SizedBox(),
                TextFieldInput(
                    decoation: InputDecoration(),
                    fontFamily: 'FontMain3',
                    textEditingController: usernamecontroller,
                    hintText: 'Username',
                    textInputType: TextInputType.text),
                const SizedBox(
                  height: 6,
                ),
                selectedusertype == 'Student'
                    ? TextFieldInput(
                        decoation: InputDecoration(),
                        fontFamily: 'FontMain3',
                        textEditingController: enrollcontroller,
                        hintText: 'Enroll number',
                        textInputType: TextInputType.text)
                    : const SizedBox(),
                const SizedBox(
                  height: 6,
                ),
                TextFieldInput(
                  decoation: InputDecoration(),
                  fontFamily: 'FontMain3',
                  textEditingController: emailcontroller,
                  hintText: 'Email',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 6,
                ),
                TextFieldInput(
                    decoation: InputDecoration(),
                    fontFamily: 'FontMain3',
                    textEditingController: passwordcontroller,
                    hintText: 'Password',
                    textInputType: TextInputType.text,
                    isPass: true),
                const SizedBox(
                  height: 6,
                ),
                ElevatedButton(
                    onPressed: () async {
                      indicator = false;
                      setState(() {});
                      String s = await AuthMethods().signUpuser(
                          username: usernamecontroller.text,
                          email: emailcontroller.text,
                          password: passwordcontroller.text,
                          sem: selectedSem,
                          usertype: selectedusertype,
                          enrollno: enrollcontroller.text);
                      if (s != 'success') {
                        indicator = true;
                        setState(() {});
                        // ignore: use_build_context_synchronously
                        alterDiallog(context, s);
                      } else if (s == 'success') {
                        indicator = true;
                        setState(() {});
                        // ignore: use_build_context_synchronously
                        if (selectedusertype == 'Student') {
                          // ignore: unused_label
                          updatebl:
                          widget.updateBl('Student');
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => MainFeedScreen(
                                sem: selectedSem,
                              ),
                            ),
                          );
                        } else if (selectedusertype == 'Admin') {
                          widget.updateBl('Admin');
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const TimePasss(),
                          ));
                        }
                      }
                    },
                    child: indicator
                        ? const Text("Register")
                        : const CircularProgressIndicator())
              ],
            ),
          ),
        ));
  }
}
