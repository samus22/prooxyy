import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/widgets/appbar.dart';
import 'package:prooxyy_events/widgets/footer.dart';
import 'package:prooxyy_events/widgets/header_line.dart';
import 'package:prooxyy_events/widgets/social_handle.dart';
import 'package:prooxyy_events/widgets/sub_slide.dart';
import 'package:prooxyy_events/widgets/team_grid.dart';

class AboutUsPage extends StatelessWidget {
  static const routeName = '/qui-sommes-nous';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.messenger_outline_sharp,
          color: Colors.white,
        ),
      ),
      body: ListView(
        children: [
          WebAppBar(3),
          SubSlide(
            image: 'assets/images/first.png',
            text: 'Qui sommes nous ?',
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.07,
              vertical: 20.0,
            ),
            child: Column(
              children: [
                vBox20(),
                HeaderLine(header: 'QUI SOMMES NOUS'),
                vBox60(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                vBox80(),
                headerText(
                  'Nous mettons à votre disposition . . .',
                  size: 60.0,
                ),
                vBox80(),
                TeamGrid(),
              ],
            ),
          ),
          vBox60(),
          SocialHandle(),
          vBox60(),
          WebFooter(handler: () {}),
        ],
      ),
    );
  }
}
