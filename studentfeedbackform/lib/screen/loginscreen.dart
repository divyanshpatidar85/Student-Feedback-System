import 'dart:async';

import 'package:flutter/material.dart';

import 'package:studentfeedbackform/resourcses.dart/auth_method.dart';
import 'package:studentfeedbackform/screen/addcourse.dart';
import 'package:studentfeedbackform/screen/bottomappbar.dart';
import 'package:studentfeedbackform/screen/signupscreen.dart';
import 'package:studentfeedbackform/wideget.dart';
import 'package:studentfeedbackform/widget/alertdialog.dart';
import 'package:studentfeedbackform/widget/textfiled.dart';
// import 'package:studentfeedbackform/dimesion/dimension.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  Function(String)? updateBl;
  LoginScreen({
    super.key,
    this.updateBl,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState(updateBl!);
}

class _LoginScreenState extends State<LoginScreen> {
  final Function(String) updateBll;
  bool indicator = false;
  static int count = 0;
  TextEditingController emailcontoller = TextEditingController();
  TextEditingController passwordcontoller = TextEditingController();
  String selectedUserType = 'Student'; // Default value
  List<String> userTypes = ['Student', 'Admin', 'Faculty'];
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

  _LoginScreenState(this.updateBll);
  @override
  void initState() {
    super.initState();
    // count == 0 ? widget.updateBl!('') : null;
    // count = count + 1;
    // widget.updateBl!('Student');
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // String? email, password;

    return Scaffold(
      body: Container(
        height: screenSize.height,
        color: Colors.white,
        child: Center(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02), // Shadow color
                      spreadRadius: 10, // Spread radius
                      blurRadius: 100, // Blur radius
                      offset: const Offset(
                          0, 3), // Offset in the X and Y directions
                    ),
                  ],
                ),
                // height: screenSize.height * 0.5,
                width: screenSize.width * .52,
                child: Scrollbar(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage('asset/image/login.webp'),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.01,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.black87,
                            ),
                          ),
                          child: DropdownButton<String>(
                            value: selectedUserType,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  selectedUserType = newValue;
                                });
                              }
                            },
                            items: userTypes
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.01,
                        ),
                        TextFieldInput(
                          decoation: InputDecoration(),
                          fontFamily: 'FontMain3',
                          hintText: 'Email',
                          textEditingController: emailcontoller,
                          isPass: false,
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: screenSize.height * 0.01,
                        ),
                        TextFieldInput(
                            decoation: InputDecoration(),
                            fontFamily: 'FontMain3',
                            hintText: 'Password',
                            textEditingController: passwordcontoller,
                            isPass: true,
                            textInputType: TextInputType.text),
                        SizedBox(
                          height: screenSize.height * 0.01,
                        ),
                        selectedUserType == 'Student'
                            ? DropdownButton<String>(
                                value: selectedSem,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    selectedSem = newValue;

                                    setState(() {});
                                  }
                                },
                                items: sem.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )
                            : SizedBox(),
                        ElevatedButton(
                          onPressed: () async {
                            String s = "false";
                            indicator = true;
                            setState(() {});
                            if (selectedUserType == 'Student' &&
                                selectedSem == 'sem') {
                              indicator = false;
                              setState(() {});
                              alterDiallog(context, 'Fill Sem value');
                            } else {
                              s = await AuthMethods().loginMethod(
                                  email: emailcontoller.text,
                                  password: passwordcontoller.text,
                                  usertype: selectedUserType);
                            }
                            print('s isssss   ==>${s}');
                            if (s != 'success') {
                              indicator = false;
                              setState(() {});
                              alterDiallog(context, s);
                            } else if (s == 'success') {
                              await Timer(const Duration(seconds: 3), () {
                                print("s is ${s}   ===> ${selectedUserType}");

                                if (selectedUserType == 'Stude') {
                                } else if (selectedUserType == 'Admin') {
                                  widget.updateBl!('Admin');

                                  selectedUserType = 'Admin';

                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => const TimePasss(),
                                  ));
                                } else if (selectedUserType == 'Faculty') {
                                  widget.updateBl!('Faculty');
                                  selectedUserType = 'Faculty';
                                  print(selectedUserType);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AddCouseScreen()));
                                }
                                if (selectedUserType == 'Student' &&
                                    selectedSem != 'sem') {
                                  print('i am student ');
                                  widget.updateBl!('Student');
                                  selectedUserType = 'Student';
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BottomAppBarr()));
                                }
                              });
                            } else {
                              print('error occcured');
                            }
                          },
                          child: indicator
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Login ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              widget.updateBl!('Student');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen(
                                            updateBl: updateBll,
                                          )));
                            },
                            child: SizedBox(
                              width: screenSize.width,
                              child: Center(
                                child: RichText(
                                    text: const TextSpan(children: [
                                  TextSpan(
                                      text: "Don't have anaccount  ",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.black)),
                                  TextSpan(
                                      text: "Sign Up ",
                                      style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue)),
                                ])),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
