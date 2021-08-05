import 'package:flutter/material.dart';

// -- Pages
import 'package:prooxyy_events/pages/about_us.dart';
import 'package:prooxyy_events/pages/booking.dart';
import 'package:prooxyy_events/pages/dashboard.dart';
import 'package:prooxyy_events/pages/home.dart';
import 'package:prooxyy_events/pages/login.dart';
import 'package:prooxyy_events/pages/our_values.dart';
import 'package:prooxyy_events/pages/portfolio.dart';
import 'package:prooxyy_events/pages/service.dart';

// -- Services
import 'package:prooxyy_events/services/all_users.dart';

// -- Widgets
import 'package:prooxyy_events/widgets/app_button.dart';
import 'package:prooxyy_events/widgets/roulette_game.dart';
import 'package:provider/provider.dart';

class WebFooter extends StatefulWidget {
  final Function handler;
  final bool logged;

  WebFooter({required this.handler, this.logged = false});

  @override
  _WebFooterState createState() => _WebFooterState();
}

class _WebFooterState extends State<WebFooter> {
  bool _logged = false;
  bool _didChange = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didChange) {
      final u = Provider.of<AllUsersRepo>(context).user.id;
      if (u != '') _logged = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -2),
            blurRadius: 3.0,
            spreadRadius: 3.0,
          ),
        ],
        color: Colors.grey[50],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(Home.routeName);
                  },
                  child: Text(
                    'ACCUEIL',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      // fontSize: 17.0,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(ServicesPage.routeName);
                  },
                  child: Text(
                    'NOS SERVICES',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      // fontSize: 17.0,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(OurValuesPage.routeName);
                  },
                  child: Text(
                    'NOS VALEURS',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      // fontSize: 17.0,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(AboutUsPage.routeName);
                  },
                  child: Text(
                    'NOUS CONTACTER',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      // fontSize: 17.0,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(PortfolioPage.routeName);
                  },
                  child: Text(
                    'CATALOGUE',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      // fontSize: 17.0,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(BookingPage.routeName);
                  },
                  child: Text(
                    'DEMANDE DE DEVIS',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      // fontSize: 17.0,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouletteGame.routeName);
                  },
                  child: Text(
                    'TOMBOLA',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      // fontSize: 17.0,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: () {
                    if (_logged) {
                      Navigator.of(context).pushNamed(Dashboard.routeName);
                    } else {
                      Navigator.of(context).pushNamed(LoginPage.routeName);
                    }
                  },
                  child: Text(
                    _logged ? 'MON COMPTE' : 'CONNEXION',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      // fontSize: 17.0,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(Home.routeName);
              },
              child: Container(
                height: 100.0,
                width: 350.0,
                child: Image.asset(
                  'assets/images/logo_prox3.jpg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                AppButton(
                  text: 'Booker',
                  color: Theme.of(context).primaryColor,
                  handler: () {
                    Navigator.of(context).pushNamed(BookingPage.routeName);
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  '©2021 Prooxyy Events',
                  style: TextStyle(
                    fontSize: 14.0,
                    letterSpacing: 1.2,
                  ),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
