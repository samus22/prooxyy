import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/models/user.dart';
import 'package:prooxyy_events/pages/home.dart';
import 'package:prooxyy_events/pages/login.dart';
import 'package:prooxyy_events/services/all_users.dart';
import 'package:prooxyy_events/services/user.dart';
import 'package:prooxyy_events/widgets/appbar.dart';
import 'package:prooxyy_events/widgets/booking_details_fragment.dart';
import 'package:prooxyy_events/widgets/catalog_details_fragment.dart';
import 'package:prooxyy_events/widgets/category_details_fragment.dart';
import 'package:prooxyy_events/widgets/quote_details_fragment.dart';
import 'package:prooxyy_events/widgets/favorites_fragment.dart';
import 'package:prooxyy_events/widgets/rating_details_fragment.dart';
import 'package:prooxyy_events/widgets/profile_details_fragment.dart';
import 'package:prooxyy_events/widgets/rounded_button.dart';
import 'package:prooxyy_events/widgets/user_details_fragment.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  static const routeName = '/dashboard';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _index = 0;
  String _asset = '';
  bool _didChange = false;
  User? user = UserService2.instance.currentUser();

  String searchText = '';

  static const List<String> _titles = [
    'Booking',
    'Catalogue',
    'Catégories',
    'Dévis',
    'Avis',
    'Mon Profil',
    'Favoris',
    'Utilisateurs',
    'Déconnexion',
  ];

  @override
  void didChangeDependencies() {
    if (!_didChange) {
      _asset =
          Provider.of<AllUsersRepo>(context, listen: false).user.profileUrl;
    }
    super.didChangeDependencies();
  }

  void _setIndex(int index) {
    setState(() {
      _index = index;
    });
  }

  Widget _buildTile(
      {required String name,
      required int index,
      required IconData icon,
      required Function handler}) {
    // -- Verify if user is logged
    if (!UserService2.instance.isLogged()) {
      Navigator.of(context).pushNamed(LoginPage.routeName);
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      decoration: BoxDecoration(
        color: index == _index ? Theme.of(context).primaryColor : null,
        boxShadow: [
          if (index == _index)
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0,
              spreadRadius: 3.0,
              offset: Offset(0, 2),
            ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: index == _index ? Colors.white : Colors.black,
        ),
        title: Text(
          name,
          style: TextStyle(
            color: index == _index ? Colors.white : Colors.black,
            letterSpacing: 1.0,
          ),
        ),
        onTap: () => handler(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserService2.instance.getUserData(user!.uid),
        builder: (BuildContext context, AsyncSnapshot<UserData?> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingIndicator(
              indicatorType: Indicator.ballPulse,
              colors: const [Colors.orange, Colors.amber, Colors.yellow],
              strokeWidth: 2,
            );
          }

          UserData? userData = snapshot.data;
          if (userData != null) {
            return Scaffold(
              body: Column(
                children: [
                  WebAppBar(
                    5,
                    true,
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 104,
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height - 104,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4.0,
                                spreadRadius: 4.0,
                                offset: Offset(3, 0),
                              ),
                            ],
                          ),
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              vBox20(),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _index = 4;
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(
                                    userData.profileUrl == ''
                                        ? 'assets/images/mar4.png'
                                        : userData.profileUrl,
                                  ),
                                ),
                              ),
                              vBox20(),
                              Text(
                                '${userData.firstName} ${userData.lastName}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              vBox20(),
                              Divider(),
                              _buildTile(
                                name: _titles[0],
                                index: 0,
                                icon: Icons.book,
                                handler: () {
                                  _setIndex(0);
                                },
                              ),
                              _buildTile(
                                name: _titles[1],
                                index: 1,
                                icon: Icons.account_tree_rounded,
                                handler: () {
                                  _setIndex(1);
                                },
                              ),
                              _buildTile(
                                name: _titles[2],
                                index: 2,
                                icon: Icons.category,
                                handler: () {
                                  _setIndex(2);
                                },
                              ),
                              _buildTile(
                                name: _titles[3],
                                index: 3,
                                icon: Icons.attach_money, // Icons.price_check
                                handler: () {
                                  _setIndex(3);
                                },
                              ),
                              _buildTile(
                                name: _titles[4],
                                index: 4,
                                icon: Icons.rate_review_outlined,
                                handler: () {
                                  _setIndex(4);
                                },
                              ),
                              _buildTile(
                                name: _titles[5],
                                index: 5,
                                icon: Icons.person,
                                handler: () {
                                  _setIndex(5);
                                },
                              ),
                              _buildTile(
                                name: _titles[6],
                                index: 6,
                                icon: Icons.star,
                                handler: () {
                                  _setIndex(6);
                                },
                              ),
                              _buildTile(
                                name: _titles[7],
                                index: 7,
                                icon: Icons.people_alt_rounded,
                                handler: () {
                                  _setIndex(7);
                                },
                              ),
                              _buildTile(
                                name: _titles[8],
                                index: 8,
                                icon: Icons.power_settings_new,
                                handler: () {
                                  UserService2.instance.signOut();
                                  Navigator.of(context)
                                      .pushNamed(Home.routeName);
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height,
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    headerTextAlt(
                                      _titles[_index],
                                    ),
                                    Container(
                                      width: 500,
                                      child: Row(
                                        children: [
                                          _index != 5
                                              ? Expanded(
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      focusColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      hintText:
                                                          'Tapez votre recherche ici',
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50.0),
                                                      ),
                                                    ),
                                                    onChanged: (value) {
                                                      searchText = value;
                                                    },
                                                  ),
                                                )
                                              : Container(),
                                          hBox20(),
                                          AppRoundedButton(
                                            handler: () {
                                              switch (_index) {
                                                case 0:
                                                  print(
                                                      'First case $searchText');
                                                  break;
                                                case 1:
                                                  print(
                                                      'Second case $searchText');
                                                  break;
                                                case 2:
                                                  print(
                                                      'Third case $searchText');
                                                  break;
                                                case 3:
                                                  print(
                                                      'Fourth case $searchText');
                                                  break;
                                                case 4:
                                                  print(
                                                      'Fifth case $searchText');
                                                  break;
                                                case 5:
                                                  print(
                                                      'Sixth case $searchText');
                                                  break;
                                                case 6:
                                                  print(
                                                      'Seventh case $searchText');
                                                  break;
                                                case 7:
                                                  print(
                                                      'Eighth case $searchText');
                                                  break;
                                                default:
                                                  break;
                                              }
                                            },
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 30.0,
                                            icon: Icons.search,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              if (_index == 0) BookingFragment(),
                              if (_index == 1) CatalogFragment(),
                              if (_index == 2) CategoryDetailsFragment(),
                              if (_index == 3) QuoteDetailsFragment(),
                              if (_index == 4) RatingDetailsFragment(),
                              if (_index == 5) ProfileDetailsFragment(),
                              if (_index == 6) FavoritesDetailsFragment(),
                              if (_index == 7) UserDetailsFragment(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Text('Impossible d\'obtenir les informations utilisateur');
          }
        });
  }
}
