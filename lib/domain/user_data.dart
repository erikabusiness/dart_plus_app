import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  String? userEmail;
  String? userName;

  void updateUser(String email, String name) {
    userEmail = email;
    userName = name;
    notifyListeners();
  }
}
