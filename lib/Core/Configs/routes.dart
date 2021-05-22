import 'package:flutter/material.dart';
import 'package:flutterchat/Features/Chat/Screens/chats-home.dart';

import '../../Features/Auth/Screens/login.dart';
import '../../Features/Auth/Screens/registration.dart';
import '../../Features/Chat/Screens/chat.dart';
import '../../Features/Home/Screens/home.dart';

class Routes {
  static const home = '/';
  static const signIn = '/signIn';
  static const signUp = '/signUp';

  static const chatsHome = '/chatsHome';
  static const chat = '/chat';
  

  final Map<String, Widget Function(BuildContext)> appRoutes = {
    home: (ctx) => HomeScreen(),
    signIn: (ctx) => LoginScreen(),
    signUp: (ctx) => RegistrationScreen(),
    chatsHome: (ctx) => ChatsHomeScreen(),
    chat: (ctx) => ChatScreen(),

  };
}
