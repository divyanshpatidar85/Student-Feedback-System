import 'package:flutter/material.dart';
import 'package:studentfeedbackform/model_for_user_provider/userproviderFireStore.dart';

class UserProvider with ChangeNotifier {
  UserDetails? _user;
  UserDetails get getUser => _user!;
  Future<void> refreshUser() async {}
}
