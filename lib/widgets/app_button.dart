import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function? handler;

  AppButton({required this.text, required this.color, required this.handler});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        handler!();
      },
      child: Container(
        height: 60.0,
        width: 200.0,
        color: color,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Stay Classy',
            fontSize: 35.0,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
