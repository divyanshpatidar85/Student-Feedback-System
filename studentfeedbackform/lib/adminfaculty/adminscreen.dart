import 'package:flutter/material.dart';

import 'package:studentfeedbackform/widget/alertdialog.dart';
import 'package:studentfeedbackform/widget/textfiled.dart';
import 'package:studentfeedbackform/resourcses.dart/auth_method.dart';

class AdminFacultyRegistration extends StatefulWidget {
  // final Function(String) updateBl;
  const AdminFacultyRegistration({
    super.key,
  });

  @override
  State<AdminFacultyRegistration> createState() =>
      AdminFacultyRegistrationState();
}

class AdminFacultyRegistrationState extends State<AdminFacultyRegistration> {
  bool indicator = true;

  @override
  Widget build(BuildContext context) {
    TextEditingController usernamecontroller = TextEditingController();
    TextEditingController facultycodecontroller = TextEditingController();
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Faculty Registration ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 132, 181, 220),
        ),
        body: Center(
          child: SizedBox(
            width: screenSize.width * 0.5,
            height: screenSize.height * 0.5,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  TextFieldInput(
                    textEditingController: usernamecontroller,
                    hintText: 'Faculty UserName',
                    textInputType: TextInputType.text,
                    decoation: InputDecoration(),
                    fontFamily: 'FontMain3',
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFieldInput(
                    textEditingController: facultycodecontroller,
                    hintText: 'Faculty code',
                    textInputType: TextInputType.text,
                    decoation: InputDecoration(),
                    fontFamily: 'FontMain3',
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFieldInput(
                    textEditingController: emailcontroller,
                    hintText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    decoation: const InputDecoration(),
                    // hintStyle: TextStyle(fontFamily: 'FontMain3')),
                    fontFamily: 'FontMain3',
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFieldInput(
                    textEditingController: passwordcontroller,
                    hintText: 'Password',
                    textInputType: TextInputType.text,
                    isPass: true,
                    decoation: const InputDecoration(),
                    fontFamily: 'FontMain3',
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        indicator = false;
                        setState(() {});
                        String s = await AuthMethods().FacultyAdminSignUp(
                            username: usernamecontroller.text,
                            email: emailcontroller.text,
                            password: passwordcontroller.text,
                            fcode: facultycodecontroller.text);
                        if (s != 'success') {
                          indicator = true;
                          setState(() {});
                          // ignore: use_build_context_synchronously
                          alterDiallog(context, s);
                        } else if (s == 'success') {
                          passwordcontroller.text = "";
                          emailcontroller.text = "";
                          usernamecontroller.text = "";
                          facultycodecontroller.text = "";
                          indicator = true;
                          setState(() {});
                          alterDiallog(context, s);
                        }
                      },
                      child: indicator
                          ? const Text("Register")
                          : const CircularProgressIndicator())
                ],
              ),
            ),
          ),
        ));
  }
}
