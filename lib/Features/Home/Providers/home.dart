import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../Core/Configs/app-session.dart';
import '../../../Core/Configs/routes.dart';

class HomeProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  // final _auth = FirebaseAuth.instance;

  autoLogin(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    var currentTargetUser = '';
    try {
      var box = await Hive.openBox('currentTargetUser');
      currentTargetUser = box.getAt(0);
      box.close();
    } catch (e) {}
    if (AppSession.auth.currentUser == null) {
    } else if (currentTargetUser != '') {
      Navigator.of(context)
          .pushReplacementNamed(Routes.chat, arguments: currentTargetUser);
      return;
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.chatsHome);
      return;
    }
    isLoading = false;
    notifyListeners();
    // try {
    //   await _auth.signInWithEmailAndPassword(
    //     email: emailCtrl.text,
    //     password: passCtrl.text,
    //   );
    //   Navigator.of(context).pushReplacementNamed(Routes.chat, arguments: _auth);
    // } catch (e) {
    //   if (e.toString().contains('user-not-found')) {
    //     Fluttertoast.showToast(msg: 'ایمیل وارد شده نامعتبراست');
    //   } else if (e.toString().contains('wrong-password')) {
    //     Fluttertoast.showToast(msg: 'رمزواردشده صحیح نمی باشد');
    //   } else if (e.toString().contains('user-disabled')) {
    //     Fluttertoast.showToast(msg: 'حساب شما به حالت تعلیق درآمده است');
    //   } else {
    //     Fluttertoast.showToast(msg: 'مشکلی در ورود به حساب بوجود آمده است');
    //   }
    //   print(e);
    // }
    // isLoading = false;
    // notifyListeners();
  }

  @override
  void reassemble() {}
}
