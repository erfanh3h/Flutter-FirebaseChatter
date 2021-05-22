import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function function;
  final Color color;
  final Color fontColor;

  const SubmitButton({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.function,
    this.color = Colors.transparent,
    this.fontColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: fontColor,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 5),
            Icon(
              icon,
              color: fontColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
