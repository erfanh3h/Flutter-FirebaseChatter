import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../Core/Configs/app-session.dart';
import '../../../Core/Widgets/loading-widget.dart';
import '../Models/chat.dart';
import '../Widgets/chat-box.dart';

class ChatProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  bool isSendingChat = false;

  TextEditingController chatCtrl = TextEditingController();
  final String targetUsername;
  final fireStore = FirebaseFirestore.instance;

  List<String> onGoingChats = [];

  var box; //chats database box
  var box2; //currentTargetUser database box

  List<ChatModel> _chats = [];
  List<ChatModel> get chats => _chats;

  emptyChats({bool deleteDB = true}) async {
    _chats = [];
    if (deleteDB) await box.deleteAll(box.keys);
  }

  setChats(var datas) async {
    for (var data in datas) {
      final ChatModel chat = ChatModel.fromJson(data.data(), data.id);
      chats.add(chat);
      await box.add(chat);
    }
    notifyListeners();
  }

  Widget streamWidget = Container();

  var connectionSubscription;
  static ConnectivityResult connectivityResult;

  ChatProvider(this.targetUsername) {
    box2 = Hive.openBox('currentTargetUser');
    Hive.openBox('currentChats').then((value) async {
      box = value;
      connectivityResult = await Connectivity().checkConnectivity();
      for (var chat in box.values) _chats.add(chat);
      notifyListeners();
      connectionSubscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        connectivityResult = result;
        switch (result) {
          case ConnectivityResult.none:
            break;
          default:
            for (var chat in onGoingChats) {
              print('object');
              sendChat(chat, resetCtrl: false);
            }
            onGoingChats = [];
            notifyListeners();
        }
        print(result.toString());
        connectivityResult = result;
      });
      streamWidget = StreamBuilder<QuerySnapshot>(
        builder: (ctx, snapshot) {
          if (connectivityResult == ConnectivityResult.none) {
          } else if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: LoadingWidget());
          else if (snapshot.hasData) {
            emptyChats();
            setChats(snapshot.data.docs);
          }
          return ChatsBoxWidget();
        },
        stream: fireStore.collection('messages').orderBy('date').where(
          'users',
          arrayContainsAny: [
            //users feild in databse use for flag of two user talks
            targetUsername.toString(),
            AppSession.auth.currentUser.email.toString(),
          ],
        ).snapshots(),
      );
    });
  }

  //chat field because maybe message in queue most be send
  sendChat(String chat, {bool resetCtrl = true}) async {
    if (resetCtrl) chatCtrl.text = ''; // reset value of chat ctrl
    if (connectivityResult == ConnectivityResult.none) {
      onGoingChats.add(chat);
      notifyListeners();
      return;
    }
    // isSendingChat = true;
    // notifyListeners();
    try {
      await fireStore.collection('messages').add({
        'receiverEmail': targetUsername,
        'senderEmail': AppSession.auth.currentUser.email,
        'date': DateTime.now().millisecondsSinceEpoch,
        'text': chat,
        'users': [targetUsername, AppSession.auth.currentUser.email],
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'مشکلی درارسال پیام بوجود آمده است');
      print(e);
    }
    // isSendingChat = false;
    // notifyListeners();
  }

  @override
  void dispose() {
    connectionSubscription.cancel();
    try {
      box.close();
    } catch (e) {}
    try {
      box2.close();
    } catch (e) {}
    super.dispose();
  }

  @override
  void reassemble() {}
}
