import 'package:flutter/material.dart';
import 'package:flutter_instagram/models/users.dart';
import 'package:flutter_instagram/resources/auth_methods.dart';
import 'package:provider/provider.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authmethods = AuthMethods();

  User? get getUser => _user;

  Future<void> refreshUser() async {
    User user = await _authmethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
