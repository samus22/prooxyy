import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:prooxyy_events/models/booking.dart';
// import 'package:prooxyy_events/models/booking.dart';
// import 'package:prooxyy_events/repositories/all_bookings.dart';
import 'package:prooxyy_events/services/all_users.dart';
import 'package:prooxyy_events/services/booking.dart';
import 'package:prooxyy_events/services/user.dart';
import 'package:provider/provider.dart';
// import 'package:prooxyy_events/helpers/helpers.dart';

class BookingListFragment extends StatefulWidget {
  final Function load;
  BookingListFragment(this.load);
  @override
  _BookingListFragmentState createState() => _BookingListFragmentState();
}

class _BookingListFragmentState extends State<BookingListFragment> {
  bool _didChange = false;
  List<Map<String, String>> _list = [];
  User? user = UserService2.instance.currentUser();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didChange) {
      // _list = Provider.of<AllUsersRepo>(context).user.listeBooking;
      _didChange = false;
    }
  }

  Widget _buildTile() {
    BookingService _bookingService = BookingService.instance;
    Stream<QuerySnapshot> stream = BookingService.instance.stre();
    stream.listen((result) {
      result.docChanges.forEach((res) {
        print('changes $res ${DateTime.now()}');
        if (res.type == DocumentChangeType.added) {
          print("added");
          print(res.doc.data());
        } else if (res.type == DocumentChangeType.modified) {
          print("modified");
          print(res.doc.data());
        } else if (res.type == DocumentChangeType.removed) {
          print("removed");
          print(res.doc.data());
        }
      });
    });

    if (user != null) {
      return StreamBuilder(
          stream: stream, // BookingService.instance.getByUser(user?.uid ?? '').asStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingIndicator(
                  indicatorType: Indicator.ballPulse,

                  /// Required, The loading type of the widget
                  colors: const [Colors.orange, Colors.amber, Colors.yellow],

                  /// Optional, The color collections
                  strokeWidth: 2,

                  /// Optional, Background of the widget
                  pathBackgroundColor: Colors.black

                  /// Optional, the stroke backgroundColor
                  );
            }

            List<Booking> bookings =
                snapshot.data!.docs.map((e) => Booking.fromMap2(e)).toList();

            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (ctx, index) => ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    onTap: () {
                      widget.load(bookings[index]
                          .id); // widget.load(_list[index]['id']);
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 20.0,
                      // backgroundImage: AssetImage(_list[index]['']),
                    ),
                    title: Text(
                      bookings[index].name, // _list[index]['title']!,
                      style: TextStyle(
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    subtitle: Text(
                      bookings[index].theme, // _list[index]['theme']!,
                      style: TextStyle(
                        // overflow: TextOverflow.ellipsis,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Divider(),
                ],
              ),
              itemCount: bookings.length,
            );
          });
    } else {
      return SizedBox(
          height: 25,
          width: 5,
          child: LoadingIndicator(
              indicatorType: Indicator.ballPulse,

              /// Required, The loading type of the widget
              colors: const [Colors.orange, Colors.amber, Colors.yellow],

              /// Optional, The color collections
              strokeWidth: 2,

              /// Optional, Background of the widget
              pathBackgroundColor: Colors.black

              /// Optional, the stroke backgroundColor
              ));
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
            'Liste des Booking',
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
