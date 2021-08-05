import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:prooxyy_events/models/quote.dart';
// import 'package:prooxyy_events/models/Devis.dart';
// import 'package:prooxyy_events/repositories/all_Deviss.dart';
import 'package:prooxyy_events/services/all_users.dart';
import 'package:prooxyy_events/services/quote.dart';
import 'package:prooxyy_events/services/user.dart';
import 'package:provider/provider.dart';
// import 'package:prooxyy_events/helpers/helpers.dart';

class QuoteListFragment extends StatefulWidget {
  final Function load;
  QuoteListFragment(this.load);
  @override
  _QuoteListFragmentState createState() => _QuoteListFragmentState();
}

class _QuoteListFragmentState extends State<QuoteListFragment> {
  bool _didChange = false;
  List<Map<String, String>> _list = [];
  User? user = UserService2.instance.currentUser();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didChange) {
      // _list = Provider.of<AllUsersRepo>(context).user.listeDevis;
      _didChange = false;
    }
  }

  Widget _buildTile() {

    return StreamBuilder(
      stream: QuoteService2.instance.getByUser("userId").asStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

        if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          List<Quote> quotes =
              snapshot.data!.docs.map((e) => Quote.fromMap2(e)).toList();

        return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (ctx, index) => ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            onTap: () {
              widget.load(quotes[index].id); // widget.load(_list[index]['id']);
            },
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              radius: 20.0,
              // backgroundImage: AssetImage(_list[index]['']),
            ),
            title: Text(
              quotes[index].name, // _list[index]['title']!,
              style: TextStyle(
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            subtitle: Text(
              quotes[index].theme, // _list[index]['theme']!,
              style: TextStyle(
                // overflow: TextOverflow.ellipsis,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Divider(),
        ],
      ),
      itemCount: quotes.length,
    );
  
      }
    );
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        // shrinkWrap: true,
        children: [
          Text(
            'Liste des Devis',
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
