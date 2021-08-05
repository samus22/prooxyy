import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function handler;

  AppTextButton(
      {required this.text, required this.color, required this.handler});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        handler();
      },
      child: Container(
        height: 60.0,
        width: 200.0,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Stay Classy',
            fontSize: 35.0,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
