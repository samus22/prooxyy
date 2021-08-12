import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/widgets/app_button.dart';
import 'package:prooxyy_events/widgets/appbar.dart';
import 'package:prooxyy_events/widgets/footer.dart';
import 'package:prooxyy_events/widgets/roulette_score.dart';
import 'package:prooxyy_events/widgets/social_handle.dart';

class RouletteGame extends StatefulWidget {
  static const routeName = '/tombola';
  @override
  _RouletteGameState createState() => _RouletteGameState();
}

class _RouletteGameState extends State<RouletteGame> {
  final StreamController _dividerController = StreamController<int>();

  final _wheelNotifier = StreamController<double>();

  @override
  void dispose() {
    super.dispose();
    _dividerController.close();
    _wheelNotifier.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          WebAppBar(6),
          vBox60(),
          Container(
            width: double.infinity,
            child: Center(
              child: Text(
                'Tombola',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 80.0,
                  fontFamily: 'Stay Classy',
                  letterSpacing: 3.0,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
          vBox60(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 340.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          vBox80(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinningWheel(
                  Image.asset('assets/images/wheel.png'),
                  width: 310,
                  height: 310,
                  initialSpinAngle: _generateRandomAngle(),
                  spinResistance: 0.6,
                  canInteractWhileSpinning: false,
                  dividers: 12,
                  onUpdate: _dividerController.add,
                  onEnd: _dividerController.add,
                  secondaryImage: Image.asset('assets/images/r_pick.png'),
                  secondaryImageHeight: 110,
                  secondaryImageWidth: 110,
                  shouldStartOrStop: _wheelNotifier.stream,
                ),
                SizedBox(height: 30),
                StreamBuilder(
                  stream: _dividerController.stream,
                  builder: (context, snapshot) => snapshot.hasData
                      ? RouletteScore(int.parse(snapshot.data!.toString()))
                      : Container(),
                ),
                SizedBox(height: 30),
                AppButton(
                  text: 'Jouer',
                  color: Theme.of(context).accentColor,
                  handler: () =>
                      _wheelNotifier.sink.add(_generateRandomVelocity()),
                ),
              ],
            ),
          ),
          vBox60(),
          SocialHandle(),
          vBox80(),
          WebFooter(handler: () {}),
        ],
      ),
    );
  }

  double _generateRandomVelocity() => (Random().nextDouble() * 10000) + 10000;

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}
