import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final Function _presentDatePicker;
  final String text;

  AdaptiveFlatButton(this.text, this._presentDatePicker);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: _presentDatePicker,
            child: Text(
              text,
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ))
        : FlatButton(
            onPressed: _presentDatePicker,
            child: Text(
              text,
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ));
  }
}
