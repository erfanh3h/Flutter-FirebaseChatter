import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../Core/Configs/app-session.dart';
import '../../../Core/Configs/routes.dart';

class LoginProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  login(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      await AppSession.auth.signInWithEmailAndPassword(
        email: emailCtrl.text,
        password: passCtrl.text,
      );
      Navigator.pop(context);
      Navigator.of(context).pushReplacementNamed(Routes.chatsHome);
    } catch (e) {
      if (e.toString().contains('user-not-found')) {
        Fluttertoast.showToast(msg: 'ایمیل وارد شده نامعتبراست');
      } else if (e.toString().contains('wrong-password')) {
        Fluttertoast.showToast(msg: 'رمزواردشده صحیح نمی باشد');
      } else if (e.toString().contains('user-disabled')) {
        Fluttertoast.showToast(msg: 'حساب شما به حالت تعلیق درآمده است');
      } else {
        Fluttertoast.showToast(msg: 'مشکلی در ورود به حساب بوجود آمده است');
      }
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  @override
  void reassemble() {}
}
