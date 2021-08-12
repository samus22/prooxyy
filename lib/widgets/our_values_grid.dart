import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:prooxyy_events/helpers/helpers.dart';

class ValueBox {
  final IconData icon;
  final String title;
  final String subTitle;

  ValueBox({required this.icon, required this.title, required this.subTitle});
}

class OurValuesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ValueBox> valueBoxes = [
      ValueBox(
        icon: Icons.home_outlined,
        title: 'Confiance',
        subTitle: 'Honnêteté - Responsabilité - Respect - Layauté - Fiabilité'
      ),
      ValueBox(
        icon: Icons.work_outline,
        title: 'Professionalisme',
        subTitle: 'Compétence - Expertise - Pragmatisme - Efficacité'
      ),
      ValueBox(
        icon: Icons.location_on_outlined,
        title: 'Proximité',
        subTitle: 'Empathie - Disponibilité - Sociabilité - Solidarité'
      ),
      ValueBox(
        icon: Icons.lightbulb_outline,
        title: 'Innovation',
        subTitle: 'Créativité - Ouverture d\'esprit - Curiosité'
      ),
      ValueBox(
        icon: Icons.favorite,
        title: 'Passion',
        subTitle: 'Motivation - Engagement - Dépassement - Audace'
      ),
      ValueBox(
        icon: TablerIcons.gift,
        title: 'HAVE FUN !',
        subTitle: ''
      ),
    ];

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
      ),
      itemCount: valueBoxes.length,
      shrinkWrap: true,
      itemBuilder: (ctx, index) => Container(
        height: 320,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 100,
              child: Icon(
                valueBoxes[index].icon,
                size: 80,
              ),
            ),
            vBox20(),
            Text(
              valueBoxes[index].title,
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
                valueBoxes[index].subTitle,
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
