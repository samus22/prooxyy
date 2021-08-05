import 'package:flutter/material.dart';

class HeaderLine extends StatelessWidget {
  final String header;

  HeaderLine({required this.header});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width * 0.86,
      child: Stack(
        children: [
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width * 0.86,
          ),
          Positioned(
            top: 49,
            left: 0,
            child: Container(
              height: 2.0,
              width: MediaQuery.of(context).size.width * 0.86,
              color: Colors.grey,
            ),
          ),
          Positioned(
            top: 0,
            left: (MediaQuery.of(context).size.width * 0.43) - 300,
            child: Container(
              height: 100,
              width: 600,
              color: Colors.grey[50],
              child: Center(
                child: Text(
                  header,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
