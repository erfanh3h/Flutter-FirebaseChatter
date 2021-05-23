import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/chat.dart';

class OngoingChatBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (ctx, provider, _) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: LayoutBuilder(
          builder: (ctx, cons) => ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (ctx, ind) => Container(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: cons.maxWidth * 3 / 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.report,
                          color: Colors.red[300],
                        ),
                        SizedBox(width: 10),
                        Material(
                          color: Theme.of(context).primaryColor,
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
                              provider.onGoingChats[ind],
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white.withOpacity(.9),
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
            separatorBuilder: (ctx, ind) => SizedBox(height: 5),
            itemCount: provider.onGoingChats.length,
          ),
        ),
      ),
    );
  }
}
