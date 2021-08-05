import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/models/user.dart';
import 'package:prooxyy_events/services/all_users.dart';
import 'package:prooxyy_events/services/user.dart';
import 'package:prooxyy_events/widgets/profile_list_fragment.dart';
// import 'package:prooxyy_events/widgets/Profile_fragment2.dart';
import 'package:provider/provider.dart';

// import 'app_button.dart';

class ProfileDetailsFragment extends StatefulWidget {
  @override
  _ProfileDetailsFragmentState createState() => _ProfileDetailsFragmentState();
}

class _ProfileDetailsFragmentState extends State<ProfileDetailsFragment> {
  bool _didChange = false;
  User? currentUser = UserService2.instance.currentUser();
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
      // UserData u = Provider.of<AllUsersRepo>(context, listen: false).user;
      UserService2.instance
          .getUserData(UserService2.instance.currentUser()!.uid)
          .then((value) {
        user = value!;
      }).catchError((error) {
        print('Unable to retrieve user data $error');
      });
      // user = u;
      _didChange = true;
    }
    super.didChangeDependencies();
  }

  void _reload() {
    setState(() {
      _didChange = false;
    });
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserService2.instance.getUserData(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<UserData?> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          UserData? userData = snapshot.data;

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
                                            color:
                                                Theme.of(context).accentColor,
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
                          child: ProfileListFragment(userData!),
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
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Container(
                            height: 60,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 40.0,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'ACTIVITé DU PROFIL'.toUpperCase(),
                            style: TextStyle(
                              letterSpacing: 3.0,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          vBox80(),
                          ListTile(
                            leading: Text(
                              'Nombre de booking'.toUpperCase(),
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text(
                              userData.listeBooking.length.toStringAsFixed(0),
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
                              userData.listeDevis.length.toStringAsFixed(0),
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
                              userData.listeFavoris.length.toStringAsFixed(0),
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
