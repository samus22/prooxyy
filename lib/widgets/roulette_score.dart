import 'package:flutter/material.dart';

class RouletteScore extends StatelessWidget {
  final int selected;

  final Map<int, String> labels = {
    1: '10\$',
    2: 'ZERO',
    3: '2\$',
    4: '50\$',
    5: '1\$',
    6: '5\$',
    7: '20\$',
    8: 'JACKPOT',
    9: '15',
    10: '100\$',
    11: '1\$',
    12: '5\$',
  };

  RouletteScore(this.selected);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${labels[selected]}',
      style: TextStyle(
        fontFamily: 'Stay Classy',
        fontSize: 60.0,
      ),
    );
  }
}
