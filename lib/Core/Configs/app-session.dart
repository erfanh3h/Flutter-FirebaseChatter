import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppSession extends ChangeNotifier with ReassembleHandler {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseAuth get auth {
    return _auth;
  }

  static set setAuth(FirebaseAuth value) {
    _auth = value;
  }

  @override
  void reassemble() {}
}
