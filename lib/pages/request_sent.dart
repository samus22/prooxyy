import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/widgets/appbar.dart';
import 'package:prooxyy_events/widgets/footer.dart';
import 'package:prooxyy_events/widgets/social_handle.dart';
import 'package:prooxyy_events/widgets/sub_slide.dart';

class RequestSentPage extends StatelessWidget {
  static const routeName = '/sent';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          WebAppBar(3),
          SubSlide(
            image: 'assets/images/first.png',
            text: 'Demande Envoyée',
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.07,
              vertical: 20.0,
            ),
            child: Column(
              children: [
                vBox60(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    'Votre demande a été bien prise en compte!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                vBox20(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1,
                  ),
                  child: Image.asset(
                    'assets/images/im.png',
                    fit: BoxFit.contain,
                  ),
                ),
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
