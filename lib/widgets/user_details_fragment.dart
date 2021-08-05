import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/models/user.dart';
import 'package:prooxyy_events/services/all_users.dart';
import 'package:prooxyy_events/widgets/user_list_fragment.dart';
// import 'package:prooxyy_events/widgets/Utilisateur_fragment2.dart';
import 'package:provider/provider.dart';

// import 'app_button.dart';

class UserDetailsFragment extends StatefulWidget {
  @override
  _UserDetailsFragmentState createState() => _UserDetailsFragmentState();
}

class _UserDetailsFragmentState extends State<UserDetailsFragment> {
  bool _didChange = false;
  String idE = '';
  UserData user = UserData(
    id: '',
    firstName: '',
    lastName: '',
    email: '',
    password: '',
    whatsappNumber: '',
    facebookLink: '',
    instagramLink: '',
    nomPrenom: '',
    blocked: false,
    numTel: '',
    profileUrl: '',
    serverId: '',
  );

  @override
  void didChangeDependencies() {
    if (!_didChange) {
      UserData u = Provider.of<AllUsersRepo>(context, listen: false).user;
      user = u;
      _didChange = true;
    }
    super.didChangeDependencies();
  }

  void _reload() {
    setState(() {
      idE = '';
      _didChange = false;
    });
  }

  void _submitPart() {
    Provider.of<AllUsersRepo>(context, listen: false)
        .updateUser(
      blocked: user.blocked,
      id: user.id,
    )
        .then((value) {
      _reload();
    });
  }

  void _load(String id) {
    setState(() {
      idE = id;
      _didChange = false;
    });
    user = Provider.of<AllUsersRepo>(context, listen: false).getUserById(id);
  }

  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: Colors.black12,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Row(
                          children: [
                            TextButton(
                              onPressed: _reload,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.refresh,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  hBox20(),
                                  Text(
                                    'ACTUALISER',
                                    style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 40.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height - 300,
                      minHeight: 300,
                    ),
                    child: UserListFragment(_load),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom: 20.0,
                ),
                child: idE == ''
                    ? null
                    : ListView(
                        children: [
                          Container(
                            height: 60,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: _submitPart,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.save,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                          hBox20(),
                                          Text(
                                            'ENREGISTRER',
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Text(
                                  'Mon Profil',
                                  style: TextStyle(
                                    letterSpacing: 3.0,
                                    fontFamily: 'Stay Classy',
                                    fontSize: 30.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 70,
                                      backgroundImage: AssetImage(
                                        user.profileUrl,
                                      ),
                                    ),
                                  ],
                                ),
                                vBox20(),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    user.blocked
                                        ? 'COMPTE DéSACTIVé'.toUpperCase()
                                        : 'COMPTE ACTIF'.toUpperCase(),
                                    style: TextStyle(
                                      color: user.blocked
                                          ? Colors.red
                                          : Colors.green,
                                      letterSpacing: 2.0,
                                      fontSize: 18.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(
                                  height: 40.0,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    'Nom et prénom'.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 2.0,
                                      fontSize: 14.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    user.nomPrenom,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(
                                  height: 40.0,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    'Numéro de téléphone'.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 2.0,
                                      fontSize: 14.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    user.numTel,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                vBox20(),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                              'ACTIVITé DU PROFIL'.toUpperCase(),
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          vBox20(),
                          ListTile(
                            leading: Text(
                              'Nombre de booking'.toUpperCase(),
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text(
                              user.listeBooking.length.toStringAsFixed(0),
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            leading: Text(
                              'Nombre de dévis demandé'.toUpperCase(),
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text(
                              user.listeDevis.length.toStringAsFixed(0),
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            leading: Text(
                              'évènements favoris'.toUpperCase(),
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text(
                              user.listeFavoris.length.toStringAsFixed(0),
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          Divider(),
                          vBox20(),
                          ListTile(
                            leading: Icon(Icons.public),
                            title: Text(
                              'Bloquer cet utilisateur',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            subtitle: Text(
                              'En bloquant cet utilisateur, il pourra toujours visiter Prooxy Events mais ne pourra pas booker, ni demander un devis',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                            trailing: Switch(
                              activeColor: Theme.of(context).primaryColor,
                              value: user.blocked,
                              onChanged: (val) {
                                setState(() {
                                  user = user.copyWith(blocked: val);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
