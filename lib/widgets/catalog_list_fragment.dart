import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:prooxyy_events/models/booking.dart';
import 'package:prooxyy_events/services/all_bookings.dart';
import 'package:prooxyy_events/services/booking.dart';
import 'package:prooxyy_events/services/category.dart';
// import 'package:prooxyy_events/models/booking.dart';
// import 'package:prooxyy_events/repositories/all_bookings.dart';
// import 'package:prooxyy_events/repositories/all_users.dart';
import 'package:provider/provider.dart';
// import 'package:prooxyy_events/helpers/helpers.dart';

class CatalogListFragment extends StatefulWidget {
  final Function load;
  CatalogListFragment(this.load);
  @override
  _CatalogListFragmentState createState() => _CatalogListFragmentState();
}

class _CatalogListFragmentState extends State<CatalogListFragment> {
  bool _didChange = false;
  List<Booking> _list = [];

  @override
  void didChangeDependencies() {
    if (!_didChange) {
      _list = Provider.of<AllBookingRepo>(context).catalogueItems;
      _didChange = false;
    }
    super.didChangeDependencies();
  }

  Widget _buildTile() {

    return StreamBuilder<QuerySnapshot>(
        stream: BookingService.instance.getAllAsSnapshot().asStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
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
                    widget.load(bookings[index].id); // widget.load(_list[index].id);
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.amber,
                    radius: 20.0,
                    // backgroundImage: AssetImage(_list[index]['']),
                  ),
                  title: Text(
                    bookings[index].id, // _list[index].category,
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    bookings[index].theme, // [index].theme,
                    style: TextStyle(
                      // overflow: TextOverflow.ellipsis,
                      letterSpacing: 1.2,
                    ),
                  ),  
                ),
                Divider(),
              ],
            ),
            itemCount: _list.length,
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
            'Eléments du Catalogue',
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
