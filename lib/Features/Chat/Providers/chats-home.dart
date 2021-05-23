import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../Core/Configs/app-session.dart';
import '../../../Core/Configs/routes.dart';

class ChatsHomeProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  TextEditingController targetNameCtrl = TextEditingController();

  var box;

  ChatsHomeProvider() {
    Hive.openBox('currentTargetUser').then((value) => box = value);
  }

  startChat(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (AppSession.auth.currentUser.email == targetNameCtrl.text) {
      Fluttertoast.showToast(msg: 'امکان گفت و گو با خودتان وجود ندارد!');
      return;
    }
    isLoading = true;
    notifyListeners();
    try {
      var userExists =
          await AppSession.auth.fetchSignInMethodsForEmail(targetNameCtrl.text);
      if (userExists.length > 0) {
        isLoading = false;
        notifyListeners();
        await box.add(targetNameCtrl.text);
        Navigator.of(context)
            .pushReplacementNamed(Routes.chat, arguments: targetNameCtrl.text);
      } else
        Fluttertoast.showToast(msg: 'این کاربر یافت نشد!');
    } catch (e) {
      Fluttertoast.showToast(msg: 'ایمیل شخص را بدرستی وارد کنید!');
    }
    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    try {
      box.close();
    } catch (e) {}
    super.dispose();
  }

  @override
  void reassemble() {}
}
