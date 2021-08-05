import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prooxyy_events/widgets/app_button.dart';
import 'package:prooxyy_events/widgets/roulette_game.dart';

class WebSlider extends StatefulWidget {
  @override
  _WebSliderState createState() => _WebSliderState();
}

class _WebSliderState extends State<WebSlider> {
  int _count = 10;
  int _index = 0;
  List<String> _assets = [
    'assets/images/second.png',
    'assets/images/wine.jpg',
    'assets/images/stand.jpg',
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      --_count;
      if (_count < 0) {
        setState(() {
          _count = 10;
          _index = (_index + 1) % 3;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 500,
          width: double.infinity,
          child: Image.asset(
            _assets[_index],
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 200,
          left: 20.0,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _index = 0;
                  });
                },
                child: Container(
                  height: 15.0,
                  width: 15.0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: _index == 0
                        ? null
                        : Border.all(width: 1.0, color: Colors.white),
                    color: _index == 0 ? Colors.white : Colors.transparent,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _index = 1;
                  });
                },
                child: Container(
                  height: 15.0,
                  width: 15.0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: _index == 1
                        ? null
                        : Border.all(width: 1.0, color: Colors.white),
                    color: _index == 1 ? Colors.white : Colors.transparent,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _index = 2;
                  });
                },
                child: Container(
                  height: 15.0,
                  width: 15.0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: _index == 2
                        ? null
                        : Border.all(width: 1.0, color: Colors.white),
                    color: _index == 2 ? Colors.white : Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 50,
          left: (MediaQuery.of(context).size.width / 2) - 200,
          child: Container(
            width: 400,
            height: 400,
            child: Image.asset(
              'assets/images/wheel.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          left: (MediaQuery.of(context).size.width / 2) - 100,
          bottom: 40.0,
          child: AppButton(
            text: 'Jouer Tombola',
            color: Theme.of(context).accentColor.withOpacity(0.5),
            handler: () {
              Navigator.of(context).pushNamed(RouletteGame.routeName);
            },
          ),
        ),
      ],
    );
  }
}
