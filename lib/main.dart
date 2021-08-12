import 'package:flutter/material.dart';

// -- Pages
import 'package:prooxyy_events/pages/about_us.dart';
import 'package:prooxyy_events/pages/booking.dart';
import 'package:prooxyy_events/pages/catalog.dart';
import 'package:prooxyy_events/pages/dashboard.dart';
import 'package:prooxyy_events/pages/category.dart';
import 'package:prooxyy_events/pages/home.dart';
import 'package:prooxyy_events/pages/login.dart';
import 'package:prooxyy_events/pages/our_values.dart';
import 'package:prooxyy_events/pages/portfolio.dart';
import 'package:prooxyy_events/pages/request_sent.dart';
import 'package:prooxyy_events/pages/service.dart';
import 'package:prooxyy_events/pages/signin.dart';
import 'package:prooxyy_events/pages/signup.dart';

// -- Services
import 'package:prooxyy_events/services/all_bookings.dart';
import 'package:prooxyy_events/services/quote.dart';
import 'package:prooxyy_events/services/all_users.dart';
import 'package:prooxyy_events/services/category.dart';
import 'package:prooxyy_events/services/comment.dart';
import 'package:prooxyy_events/services/themes.dart';
import 'package:prooxyy_events/widgets/roulette_game.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: CategoriesRepo(
            authToken: 'authToken',
            userId: 'userId',
          ),
        ),
        ChangeNotifierProvider.value(
          value: AllUsersRepo(
            authToken: 'authToken',
            userId: 'userId',
          ),
        ),
        ChangeNotifierProvider.value(
          value: AllBookingRepo(
            authToken: 'authToken',
            userId: 'userId',
          ),
        ),
        ChangeNotifierProvider.value(
          value: CommentService(
            authToken: 'authToken',
            userId: 'userId',
          ),
        ),
        ChangeNotifierProvider.value(
          value: QuoteService(
            authToken: 'authToken',
            userId: 'userId',
          ),
        ),
        ChangeNotifierProvider.value(
          value: ThemesRepo(
            authToken: 'authToken',
            userId: 'userId',
          ),
        ),
      ],
      child: MaterialApp(
        title: 'PROOXYY Events',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(233, 208, 35, 1),
          accentColor: Color.fromRGBO(255, 40, 0, 1),
          errorColor: Color.fromRGBO(255, 40, 0, 1),
          focusColor: Color.fromRGBO(233, 208, 35, 1),
          fontFamily: 'Segoe',
        ),
        home: Home(),
        routes: {
          ServicesPage.routeName: (ctx) => ServicesPage(),
          LoginPage.routeName: (ctx) => LoginPage(),
          SignInPage.routeName: (ctx) => SignInPage(),
          PortfolioPage.routeName: (ctx) => PortfolioPage(),
          AboutUsPage.routeName: (ctx) => AboutUsPage(),
          OurValuesPage.routeName: (ctx) => OurValuesPage(),
          BookingPage.routeName: (ctx) => BookingPage(),
          CategoryPage.routeName: (ctx) => CategoryPage(),
          RouletteGame.routeName: (ctx) => RouletteGame(),
          SignUpPage.routeName: (ctx) => SignUpPage(),
          Dashboard.routeName: (ctx) => Dashboard(),
          RequestSentPage.routeName: (ctx) => RequestSentPage(),
          CatalogPage.routeName: (ctx) => CatalogPage(),
        },
      ),
    );
  }
}
