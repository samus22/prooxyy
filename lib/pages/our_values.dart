import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/widgets/appbar.dart';
import 'package:prooxyy_events/widgets/footer.dart';
import 'package:prooxyy_events/widgets/header_line.dart';
import 'package:prooxyy_events/widgets/our_values_grid.dart';
import 'package:prooxyy_events/widgets/social_handle.dart';
import 'package:prooxyy_events/widgets/sub_slide.dart';
import 'package:prooxyy_events/widgets/team_grid.dart';

class OurValuesPage extends StatelessWidget {
  static const routeName = '/nos-valeurs';
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
          WebAppBar(5),
          SubSlide(
            image: 'assets/images/first.png',
            text: 'Nos valeurs',
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.07,
              vertical: 20.0,
            ),
            child: Column(
              children: [
                vBox20(),
                HeaderLine(header: 'NOS VALEURS'),
                vBox60(),
                OurValuesGrid(),
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
