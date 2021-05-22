import 'package:flutter/material.dart';

class SendChatWidget extends StatelessWidget {
  final TextEditingController ctrl;
  const SendChatWidget({
    Key key,
    @required this.ctrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: ctrl,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        hintText: 'بنویسید . . .',
        hintTextDirection: TextDirection.rtl,
        border: InputBorder.none,
      ),
      textAlign: TextAlign.right,
      style: TextStyle(
        fontSize: 20,
        color: Theme.of(context).primaryColor,
      ),
      textDirection: TextDirection.rtl,
    );
  }
}
