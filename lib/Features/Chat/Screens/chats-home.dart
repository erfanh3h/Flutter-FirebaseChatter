import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Configs/app-session.dart';
import '../../../Core/Configs/routes.dart';
import '../../../Core/Widgets/input-box.dart';
import '../../../Core/Widgets/loading-widget.dart';
import '../../../Core/Widgets/submit-button.dart';
import '../Providers/chats-home.dart';

class ChatsHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatsHomeProvider>(
      create: (_) => ChatsHomeProvider(),
      child: ChatTile(),
    );
  }
}

class ChatTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatsHomeProvider>(
      builder: (ctx, provider, _) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  AppSession.auth.signOut().then(
                        (value) => Navigator.of(context)
                            .pushReplacementNamed(Routes.home),
                      );
                },
              )
            ],
            centerTitle: true,
            title: Text('گفت و گو'),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: provider.isLoading
                ? Center(
                    child: LoadingWidget(),
                  )
                : LayoutBuilder(
                    builder: (ctx, cons) => SizedBox(
                      height: cons.maxHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GlobalInputBox(
                            ctrl: provider.targetNameCtrl,
                            icon: Icons.lock,
                            label: 'ایمیل شخص موردنظر',
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          SubmitButton(
                            title: 'شروع صحبت',
                            icon: Icons.play_arrow_rounded,
                            function: () => provider.startChat(context),
                            color: Theme.of(context).primaryColor,
                            fontColor: Colors.white70,
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
