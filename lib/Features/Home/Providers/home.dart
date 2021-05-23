import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../Core/Configs/app-session.dart';
import '../../../Core/Configs/routes.dart';

class HomeProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

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
  }

  @override
  void reassemble() {}
}
