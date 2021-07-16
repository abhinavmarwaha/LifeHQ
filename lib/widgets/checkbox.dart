import 'package:flutter/material.dart';

class CheckBox extends StatelessWidget {
  const CheckBox({
    Key key,
    @required this.checked,
  }) : super(key: key);

  final bool checked;

  @override
  Widget build(BuildContext context) {
    return checked
        ? Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.white,
              width: 1,
            )),
            child: Center(
              child: Text(
                "✓",
                style: TextStyle(fontSize: 7),
              ),
            ),
          )
        : Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.white,
              width: 1,
            )),
          );
  }
}
