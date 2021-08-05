import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';

class TrustedBloc extends StatelessWidget {
  Widget buildTiles(
      {required String name,
      required int number,
      required String asset,
      required Color color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          number.toString(),
          style: TextStyle(
            letterSpacing: 1.5,
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
          ),
          textAlign: TextAlign.center,
        ),
        vBox20(),
        Container(
          height: 100,
          width: 100,
          child: Image.asset(
            asset,
            fit: BoxFit.contain,
          ),
        ),
        vBox20(),
        Text(
          name,
          style: TextStyle(
            letterSpacing: 1.5,
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildTiles(
          name: 'EVENEMENTS ORGANISES',
          number: 35,
          asset: 'assets/images/did.png',
          color: Theme.of(context).primaryColor,
        ),
        buildTiles(
          name: 'PARTICULIERS',
          number: 27,
          asset: 'assets/images/people.png',
          color: Theme.of(context).primaryColor,
        ),
        buildTiles(
          name: 'ORGANISATIONS',
          number: 35 - 27,
          asset: 'assets/images/ent.png',
          color: Theme.of(context).primaryColor,
        ),
        buildTiles(
          name: 'LOCALITES',
          number: 07,
          asset: 'assets/images/state.png',
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
