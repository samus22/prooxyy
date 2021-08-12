import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
// import 'package:prooxyy_events/widgets/app_button.dart';
import 'package:prooxyy_events/widgets/appbar.dart';
import 'package:prooxyy_events/widgets/booking_form.dart';
import 'package:prooxyy_events/widgets/quote_form.dart';
import 'package:prooxyy_events/widgets/footer.dart';
import 'package:prooxyy_events/widgets/header_line.dart';
import 'package:prooxyy_events/widgets/social_handle.dart';
import 'package:prooxyy_events/widgets/sub_slide.dart';
import 'package:prooxyy_events/widgets/text_button.dart';

class BookingPage extends StatefulWidget {
  static const routeName = '/booking';
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int _fragment = 0;
  // int _alt = 1;
  List<String> _texts = [
    'Booker',
    'Demander un dévis',
  ];
  List<String> _altText = [
    'Démander un avis plustôt',
    'Booker plustôt',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          WebAppBar(3),
          SubSlide(
            image: 'assets/images/first.png',
            text: 'Obtenir un devis',
          ),
          vBox20(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.07,
            ),
            child: Column(
              children: [
                HeaderLine(header: 'OBTENIR UN DEVIS'),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'C\'EST ICI QUE COMMENCE VOTRE',
                      style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Journée',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'Stay Classy',
                      ),
                    ),
                  ],
                ),
                vBox60(),
                Text(
                  _texts[_fragment],
                  style: TextStyle(
                    fontFamily: 'Stay Classy',
                    fontSize: 80.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                Divider(),
                vBox20(),
                AppTextButton(
                  text: _altText[_fragment],
                  color: Theme.of(context).accentColor,
                  handler: () {
                    setState(() {
                      _fragment = (_fragment + 1) % 2;
                    });
                  },
                ),
                vBox60(),
                Text(
                  'Veuillez remplir les information ci-dessous',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                vBox20(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 200.0),
                  child: _fragment == 0
                      ? BookingForm(
                          reload: () {},
                        )
                      : QuoteForm(
                          reload: () {},
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
