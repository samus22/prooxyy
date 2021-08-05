import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/widgets/appbar.dart';
import 'package:prooxyy_events/widgets/category_grid.dart';
import 'package:prooxyy_events/widgets/footer.dart';
import 'package:prooxyy_events/widgets/header_line.dart';
import 'package:prooxyy_events/widgets/social_handle.dart';
import 'package:prooxyy_events/widgets/sub_slide.dart';
import 'package:prooxyy_events/widgets/trusted_bloc.dart';

class PortfolioPage extends StatelessWidget {
  static const routeName = '/catalogue';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            WebAppBar(2),
            SubSlide(
              image: 'assets/images/first.png',
              text: 'Catalogue',
            ),
            vBox20(),
            HeaderLine(header: 'CATALOGUE'),
            vBox60(),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.07,
              ),
              child: Column(
                children: [
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
                  TrustedBloc(),
                  vBox80(),
                  headerText(
                    'Evènements par Catégorie',
                    size: 60.0,
                  ),
                  vBox80(),
                  CategoryGrid(),
                ],
              ),
            ),
            vBox60(),
            SocialHandle(),
            vBox80(),
            WebFooter(handler: () {}),
          ],
        ),
      ),
    );
  }
}
