import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../Core/Configs/app-session.dart';
import '../../../Core/Configs/routes.dart';

class RegistrationProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  register(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      await AppSession.auth.createUserWithEmailAndPassword(
        email: emailCtrl.text,
        password: passCtrl.text,
      );
      Navigator.pop(context);
      Navigator.of(context).pushReplacementNamed(Routes.chatsHome);
    } catch (e) {
      if (e.toString().contains('email-already-in-use')) {
        Fluttertoast.showToast(msg: 'ایمیل وارد شده تکراری است');
      } else {
        Fluttertoast.showToast(msg: 'مشکلی در ساخت حساب بوجود آمده است');
      }
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  @override
  void reassemble() {}
}
