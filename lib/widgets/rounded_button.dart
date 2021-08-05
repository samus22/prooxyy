import 'package:flutter/material.dart';

class AppRoundedButton extends StatelessWidget {
  final Function handler;
  final IconData icon;
  final Color color;
  final double size;

  const AppRoundedButton({
    required this.handler,
    required this.color,
    required this.size,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        handler();
      },
      child: Container(
        height: size + 20,
        width: size + 20,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 2.0,
              offset: Offset(0, 2),
              color: Colors.black12,
              spreadRadius: 2.0,
            ),
          ],
        ),
        padding: const EdgeInsets.all(5.0),
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
    );
  }
}
