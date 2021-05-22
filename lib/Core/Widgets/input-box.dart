import 'package:flutter/material.dart';

class GlobalInputBox extends StatelessWidget {
  final TextEditingController ctrl;
  final IconData icon;
  final String label;
  final TextInputType inputType;
  final bool isSecure;

  const GlobalInputBox({
    Key key,
    @required this.ctrl,
    @required this.icon,
    @required this.label,
    this.inputType = TextInputType.text,
    this.isSecure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          obscureText: isSecure,
          controller: ctrl,
          decoration: InputDecoration(
            labelText: label,
            suffixIcon: Icon(icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
          ),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
          keyboardType: inputType,
        ),
      ),
    );
  }
}
