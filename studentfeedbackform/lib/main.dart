import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentfeedbackform/Splash%20Screen/flashscreen.dart';

import 'package:studentfeedbackform/screen/addcourse.dart';
import 'package:studentfeedbackform/screen/bottomappbar.dart';

import 'package:studentfeedbackform/screen/loginscreen.dart';
import 'package:studentfeedbackform/wideget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCpdn9Oz98wgUorAg0YW6bqNxz-5Ph9rSo",
            appId: "1:783609536062:web:79123eeddb4682f9627b6f",
            messagingSenderId: "783609536062",
            storageBucket: "student-feedback-cb818.appspot.com",
            projectId: "student-feedback-cb818"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // static bool bl = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const FlashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
  void updateBl(String value) {
    _MyHomePageState state = _MyHomePageState();
    state.updateBl(value);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String bl = 'Student';
  @override
  void initState() {
    // updateBl('');
    super.initState();
    loadBl();
    // Load the value of bl from SharedPreferences
  }

  Future<void> loadBl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bl = prefs.getString('bl') ??
          ''; // Load the value from storage or use false if not found
    });
  }

  Future<void> updateBl(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('bl', value); // Save the value to SharedPreferences
    setState(() {
      bl = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            if (bl == "") {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Fetching Your Account Details'),
                    CircularProgressIndicator(),
                  ],
                ),
              );
            } else if (bl == 'Faculty') {
              return const AddCouseScreen();
            } else if (bl == 'Admin') {
              print('heelo ');
              return const TimePasss();
            } else if (bl == 'Student') {
              return const BottomAppBarr();
            }
          } else if (snapshot.hasError) {
            Text('${snapshot.error}');
          }
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.pinkAccent,
            ),
          );
        }
        return LoginScreen(
          updateBl: updateBl,
        );
      },
    )
        // body: AdminFacultyRegistration()
        );
  }
}
