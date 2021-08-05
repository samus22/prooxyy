import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:prooxyy_events/models/user.dart';
// import 'package:prooxyy_events/models/Utilisateur.dart';
// import 'package:prooxyy_events/repositories/all_Utilisateurs.dart';
import 'package:prooxyy_events/services/all_users.dart';
import 'package:prooxyy_events/services/user.dart';
import 'package:provider/provider.dart';
// import 'package:prooxyy_events/helpers/helpers.dart';

class UserListFragment extends StatefulWidget {
  final Function load;
  UserListFragment(this.load);
  @override
  _UserListFragmentState createState() => _UserListFragmentState();
}

class _UserListFragmentState extends State<UserListFragment> {
  bool _didChange = false;
  List<UserData> _list = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didChange) {
      _list = Provider.of<AllUsersRepo>(context).items;
      _didChange = false;
    }
  }

  Widget _buildTile() {

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
            title: Text(
              _list[index].nomPrenom,
              style: TextStyle(
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            subtitle: Text(
              _list[index].numTel,
              style: TextStyle(
                // overflow: TextOverflow.ellipsis,
                letterSpacing: 1.2,
              ),
            ),
            trailing: Text(
              _list[index].blocked ? 'BLOQUÉ'.toUpperCase() : 'ACTIF',
              style: TextStyle(
                // overflow: TextOverflow.ellipsis,
                color: _list[index].blocked ? Colors.red : Colors.green,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Divider(),
        ],
      ),
      itemCount: _list.length,
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
            'Liste des Utilisateurs',
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
