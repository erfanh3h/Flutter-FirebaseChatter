import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Configs/routes.dart';
import '../../../Core/Widgets/loading-widget.dart';
import '../Providers/chat.dart';
import '../Widgets/send-chat-box.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatProvider>(
      create: (_) => ChatProvider(ModalRoute.of(context).settings.arguments),
      child: ChatTile(),
    );
  }
}

class ChatTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (ctx, provider, _) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () async {
                  try {
                    provider.box2.deleteAt(0);
                    Navigator.pushReplacementNamed(context, Routes.chatsHome);
                  } catch (e) {}
                },
              )
            ],
            centerTitle: true,
            title: Text(provider.targetUsername),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            child: provider.isLoading
                ? Center(
                    child: LoadingWidget(),
                  )
                : LayoutBuilder(
                    builder: (ctx, cons) => SizedBox(
                      height: cons.maxHeight,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          Expanded(child: provider.streamWidget),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                TextButton(
                                  onPressed: () => provider.sendChat(
                                    provider.chatCtrl.text,
                                  ),
                                  child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Icon(
                                        Icons.send_rounded,
                                        color: Theme.of(context).primaryColor,
                                      )),
                                ),
                                Expanded(
                                  child: SendChatWidget(
                                    ctrl: provider.chatCtrl,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
