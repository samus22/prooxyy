import 'package:flutter/material.dart';

class ImageBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 450,
          width: double.infinity,
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            height: 300,
            width: 300,
            child: Image.asset(
              'assets/images/serve.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 350,
          child: Container(
            height: 300,
            width: 700,
            child: Image.asset(
              'assets/images/funerailles.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 400,
          child: Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
                border: Border.all(
              width: 10.0,
              color: Colors.white,
            )),
            child: Image.asset(
              'assets/images/mar_out.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 30,
          child: Container(
            height: 300,
            width: 450,
            decoration: BoxDecoration(
                border: Border.all(
              width: 10.0,
              color: Colors.white,
            )),
            child: Image.asset(
              'assets/images/birth.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
