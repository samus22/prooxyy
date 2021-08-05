import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:prooxyy_events/models/booking.dart';
import 'package:prooxyy_events/models/rating.dart';
// import 'package:prooxyy_events/models/note.dart';
import 'package:prooxyy_events/services/all_bookings.dart';
import 'package:prooxyy_events/services/rating.dart';
import 'package:prooxyy_events/services/user.dart';
// import 'package:prooxyy_events/models/Note.dart';
// import 'package:prooxyy_events/repositories/all_Notes.dart';
// import 'package:prooxyy_events/repositories/all_users.dart';
// import 'package:prooxyy_events/repositories/notes.dart';
import 'package:provider/provider.dart';
// import 'package:prooxyy_events/helpers/helpers.dart';

class RatingListFragment extends StatefulWidget {
  final Function load;
  RatingListFragment(this.load);
  @override
  _RatingListFragmentState createState() => _RatingListFragmentState();
}

class _RatingListFragmentState extends State<RatingListFragment> {
  bool _didChange = false;
  List<Booking> _list = [];
  User? user = UserService2.instance.currentUser();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didChange) {
      _list = Provider.of<AllBookingRepo>(context).catalogueItems;
      _didChange = false;
    }
  }

  Widget _buildTile() {
    return StreamBuilder(
        stream: RatingService2.instance.getByUser("userId").asStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          List<Rating> ratings =
              snapshot.data!.docs.map((e) => Rating.fromMap2(e)).toList();
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (ctx, index) => ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  onTap: () {
                    widget.load(_list[index].id);
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.amber,
                    radius: 20.0,
                    // backgroundImage: AssetImage(_list[index]['']),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ratings[index].ratedBy,
                        style: TextStyle(
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      Icon(
                        Icons.star,
                        color: Theme.of(context).primaryColor,
                        size: 20.0,
                      ),
                      Icon(
                        ratings[index].value > 1.49
                            ? Icons.star
                            : Icons.star_border,
                        color: Theme.of(context).primaryColor,
                        size: 20.0,
                      ),
                      Icon(
                        ratings[index].value > 2.49
                            ? Icons.star
                            : Icons.star_border,
                        color: Theme.of(context).primaryColor,
                        size: 20.0,
                      ),
                      Icon(
                        ratings[index].value > 3.49
                            ? Icons.star
                            : Icons.star_border,
                        color: Theme.of(context).primaryColor,
                        size: 20.0,
                      ),
                      Icon(
                        ratings[index].value > 4.49
                            ? Icons.star
                            : Icons.star_border,
                        color: Theme.of(context).primaryColor,
                        size: 20.0,
                      ),
                    ],
                  ),
                  subtitle: Text(
                    ratings[index].comment,
                    style: TextStyle(
                      // overflow: TextOverflow.ellipsis,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                Divider(),
              ],
            ),
            itemCount: ratings.length,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        // shrinkWrap: true,
        children: [
          Text(
            'Liste des Avis',
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
