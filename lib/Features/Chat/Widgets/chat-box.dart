import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Configs/app-session.dart';
import '../Providers/chat.dart';
import 'ongoing-chat-box.dart';

class ChatsBoxWidget extends StatelessWidget {
  // final List<ChatModel> chats;
  const ChatsBoxWidget({
    Key key,
    // @required this.chats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder:(ctx,provider,_)=> Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: LayoutBuilder(
          builder: (ctx, cons) => ListView(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, ind) => Container(
                  child: Align(
                    alignment: AppSession.auth.currentUser.email ==
                            provider.chats[ind].senderEmail
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: cons.maxWidth * 3 / 4),
                        child: Column(
                          crossAxisAlignment:
                              AppSession.auth.currentUser.email ==
                                      provider.chats[ind].senderEmail
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                          children: [
                            AppSession.auth.currentUser.email !=
                                    provider.chats[ind].senderEmail
                                ? ind > 0 &&
                                        provider.chats[ind].senderEmail ==
                                            provider.chats[ind - 1].senderEmail
                                    ? Container()
                                    : Text(
                                        provider.chats[ind].senderEmail,
                                        textAlign: provider.chats[ind].senderEmail ==
                                                AppSession
                                                    .auth.currentUser.email
                                            ? TextAlign.right
                                            : TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black.withOpacity(.75),
                                        ),
                                      )
                                : Container(),
                            SizedBox(height: 5),
                            Material(
                              color: AppSession.auth.currentUser.email ==
                                      provider.chats[ind].senderEmail
                                  ? Theme.of(context).primaryColor
                                  : Colors.white.withOpacity(.9),
                              elevation: 3,
                              shadowColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 15,
                                ),
                                child: Text(
                                  provider.chats[ind].text,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppSession.auth.currentUser.email ==
                                            provider.chats[ind].senderEmail
                                        ? Colors.white.withOpacity(.9)
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (ctx, ind) => SizedBox(
                    height: ind < provider.chats.length &&
                            provider.chats[ind].senderEmail == provider.chats[ind + 1].senderEmail
                        ? 5
                        : 20),
                itemCount: provider.chats.length,
              ),
              SizedBox(height: 20),
              OngoingChatBox(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
