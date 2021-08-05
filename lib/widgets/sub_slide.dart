import 'package:flutter/material.dart';

class SubSlide extends StatelessWidget {
  final String text, image;

  SubSlide({required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 150 - 20,
          left: (MediaQuery.of(context).size.width / 2) - 150,
          child: RotationTransition(
            turns: AlwaysStoppedAnimation(349 / 360),
            child: Container(
              height: 80,
              width: 350,
              color: Theme.of(context).accentColor.withOpacity(0.5),
            ),
          ),
        ),
        Positioned(
          top: 150 - 75,
          left: (MediaQuery.of(context).size.width / 2) - 100,
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Stay Classy',
              fontSize: 80.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
