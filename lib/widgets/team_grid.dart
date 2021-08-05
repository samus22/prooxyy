import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';

class TeamGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
      ),
      itemCount: team.length,
      shrinkWrap: true,
      itemBuilder: (ctx, index) => Container(
        height: 320,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              child: Image.asset(
                team[index]['media'],
                fit: BoxFit.cover,
              ),
            ),
            vBox20(),
            Text(
              team[index]['name'],
              style: TextStyle(
                fontFamily: 'Stay Classy',
                fontSize: 40.0,
                color: Theme.of(context).accentColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              height: 100,
              margin: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Text(
                team[index]['description'],
                maxLines: 3,
                style: TextStyle(
                  fontSize: 13.0,
                  // overflow: TextOverflow.clip,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
