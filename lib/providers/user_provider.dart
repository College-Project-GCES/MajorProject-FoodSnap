import 'package:flutter/material.dart';

class User {
  final String name;
  final String email;
  final String photoUrl;

  User({required this.name, required this.email, required this.photoUrl});
}

class UserProvider extends ChangeNotifier {
  User? user;

  void setUserWithEmail(String name, String email) {
    user = User(name: name, email: email, photoUrl: '');
    notifyListeners();
  }

  void setUserWithGoogle(String name, String email, String photoUrl) {
    user = User(name: name, email: email, photoUrl: photoUrl);
    notifyListeners();
  }
}
