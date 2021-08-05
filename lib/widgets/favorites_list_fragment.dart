import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:prooxyy_events/models/booking.dart';
import 'package:prooxyy_events/models/user.dart';
import 'package:prooxyy_events/services/all_bookings.dart';
import 'package:prooxyy_events/services/all_users.dart';
import 'package:prooxyy_events/services/booking.dart';
import 'package:prooxyy_events/services/user.dart';
// import 'package:prooxyy_events/models/booking.dart';
// import 'package:prooxyy_events/repositories/all_bookings.dart';
// import 'package:prooxyy_events/repositories/all_users.dart';
import 'package:provider/provider.dart';
// import 'package:prooxyy_events/helpers/helpers.dart';

class FavoritesListFragment extends StatefulWidget {
  @override
  _FavoritesListFragmentState createState() => _FavoritesListFragmentState();
}

class _FavoritesListFragmentState extends State<FavoritesListFragment> {
  bool _didChange = false;
  List<Booking> _list = [];
  List<String> fav = [];

  User? user = UserService2.instance.currentUser();
  UserData? userData;

  @override
  void didChangeDependencies() {
    if (!_didChange) {
      fav = Provider.of<AllUsersRepo>(context, listen: false).user.listeFavoris;
      _list = Provider.of<AllBookingRepo>(context).catalogueItems;
      _didChange = false;
    }
    if (user != null) {
      UserService2.instance.getUserData(user!.uid).then((value) {
        userData = value;
      });
    }
    super.didChangeDependencies();
  }

  Widget _buildTile() {
    print(fav);
    print('User data: $userData');
    if (user != null) {
      return FutureBuilder(
          future: UserService2.instance.getUserData(user!.uid),
          builder: (BuildContext context, AsyncSnapshot<UserData?> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            UserData? userData = snapshot.data;
            if (userData != null && userData.listeFavoris.length > 0) {
              return StreamBuilder(
                  stream: BookingService.instance
                      .getByFavorites(userData.listeFavoris)
                      .asStream(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }

                    List<Booking> favoriteBookings = snapshot.data!.docs
                        .map((e) => Booking.fromMap2(e))
                        .toList();

                    return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) => ListView(
                        shrinkWrap: true,
                        children: [
                          ListTile(
                              onTap: () {
                                if (fav.contains(favoriteBookings[index].id)) {
                                  setState(() {
                                    fav.remove(favoriteBookings[index].id);
                                  });
                                } else {
                                  setState(() {
                                    fav.add(favoriteBookings[index].id);
                                  });
                                }
                                Provider.of<AllUsersRepo>(context,
                                        listen: false)
                                    .updateAUser(listeFavoris: fav);
                              },
                              leading: CircleAvatar(
                                backgroundColor: Colors.amber,
                                radius: 20.0,
                                // backgroundImage: AssetImage(_list[index]['']),
                              ),
                              title: Text(
                                favoriteBookings[index].category,
                                style: TextStyle(
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                              subtitle: Text(
                                favoriteBookings[index].theme,
                                style: TextStyle(
                                  // overflow: TextOverflow.ellipsis,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              trailing: Icon(
                                fav.contains(favoriteBookings[index].id)
                                    ? Icons.favorite
                                    : Icons.favorite_outlined,
                                color: Theme.of(context).accentColor,
                              )),
                          Divider(),
                        ],
                      ),
                      itemCount: _list.length,
                    );
                  });
            } else {
              return Text('Nothing');
            }
          });
    } else {
      return Text('Loading');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        // shrinkWrap: true,
        children: [
          Text(
            'Eléments Favoris',
            style: TextStyle(
              letterSpacing: 3.0,
              fontFamily: 'Stay Classy',
              fontSize: 30.0,
            ),
            textAlign: TextAlign.start,
          ),
          _buildTile(),
        ],
      ),
    );
  }
}
