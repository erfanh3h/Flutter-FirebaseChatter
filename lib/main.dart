
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterchat/Features/Chat/Models/chat.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'Core/Configs/app-session.dart';
import 'Core/Configs/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var path = await getApplicationDocumentsDirectory();
  Hive..init(path.path)..registerAdapter(ChatModelAdapter());
  // var box = await Hive.openBox('testBox');
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppSession()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'hekayat',
          primaryColor: Color(0XFF3568A2),
        ),
        initialRoute: Routes.home,
        routes: Routes().appRoutes,
      ),
    );
  }
}
