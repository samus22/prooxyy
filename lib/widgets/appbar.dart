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
import 'package:prooxyy_events/services/all_users.dart';
import 'package:prooxyy_events/services/user.dart';
import 'package:prooxyy_events/widgets/roulette_game.dart';
import 'package:provider/provider.dart';

class WebAppBar extends StatefulWidget {
  final int index;
  final bool logged;

  WebAppBar([this.index = 0, this.logged = false]);
  @override
  _WebAppBarState createState() => _WebAppBarState();
}

class _WebAppBarState extends State<WebAppBar> {
  var index = 0;
  bool _didChange = false;
  bool _logged = false;

  @override
  void initState() {
    super.initState();
    index = widget.index;
  }

  void _setIndex(int i) {
    if (i == index) return;
    if (i > 7) return;
    if (i < 0) return;
    setState(() {
      index = i;
    });
  }

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
    print('This is the index $index');
    return Container(
      width: double.infinity,
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3.0,
            spreadRadius: 3.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(Home.routeName);
              _setIndex(0);
            },
            child: Text(
              'ACCUEIL',
              style: TextStyle(
                color:
                    index == 0 ? Theme.of(context).primaryColor : Colors.black,
                fontWeight: FontWeight.bold,
                // fontSize: 17.0,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ServicesPage.routeName);
              _setIndex(1);
            },
            child: Text(
              'NOS SERVICES',
              style: TextStyle(
                color:
                    index == 1 ? Theme.of(context).primaryColor : Colors.black,
                fontWeight: FontWeight.bold,
                // fontSize: 17.0,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(PortfolioPage.routeName);
              _setIndex(2);
            },
            child: Text(
              'CATALOGUE',
              style: TextStyle(
                color:
                    index == 2 ? Theme.of(context).primaryColor : Colors.black,
                fontWeight: FontWeight.bold,
                // fontSize: 17.0,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(BookingPage.routeName);
              _setIndex(3);
            },
            child: Text(
              'BOOKER',
              style: TextStyle(
                color:
                    index == 3 ? Theme.of(context).primaryColor : Colors.black,
                fontWeight: FontWeight.bold,
                // fontSize: 17.0,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(Home.routeName);
              _setIndex(0);
            },
            child: Container(
              height: 80,
              width: 200,
              child: Image.asset(
                'assets/images/logo_prox3.jpg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AboutUsPage.routeName);
              _setIndex(4);
            },
            child: Text(
              'QUI SOMMES NOUS',
              style: TextStyle(
                color:
                    index == 4 ? Theme.of(context).primaryColor : Colors.black,
                fontWeight: FontWeight.bold,
                // fontSize: 16.0,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(OurValuesPage.routeName);
              _setIndex(5);
            },
            child: Text(
              'NOS VALEURS',
              style: TextStyle(
                color:
                    index == 5 ? Theme.of(context).primaryColor : Colors.black,
                fontWeight: FontWeight.bold,
                // fontSize: 17.0,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(RouletteGame.routeName);
              _setIndex(6);
            },
            child: Text(
              'TOMBOLA',
              style: TextStyle(
                color:
                    index == 6 ? Theme.of(context).primaryColor : Colors.black,
                fontWeight: FontWeight.bold,
                // fontSize: 17.0,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (UserService2.instance.isLogged()) {
                Navigator.of(context).pushNamed(Dashboard.routeName);
              } else {
                Navigator.of(context).pushNamed(LoginPage.routeName);
              }
              _setIndex(7);
            },
            child: Text(
              UserService2.instance.isLogged() ? 'MON COMPTE' : 'CONNEXION',
              style: TextStyle(
                color:
                    index == 7 ? Theme.of(context).primaryColor : Colors.black,
                fontWeight: FontWeight.bold,
                // fontSize: 17.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
