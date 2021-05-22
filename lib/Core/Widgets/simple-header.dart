import 'package:flutter/material.dart';

class SimpleHeader extends StatelessWidget {
  final String title;
  const SimpleHeader({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 45.0,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
