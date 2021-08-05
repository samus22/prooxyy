import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/models/user.dart';
import 'package:prooxyy_events/services/all_users.dart';
// import 'package:prooxyy_events/widgets/app_button.dart';
import 'package:prooxyy_events/widgets/appbar.dart';
import 'package:prooxyy_events/widgets/comment_bloc.dart';
import 'package:prooxyy_events/widgets/footer.dart';
import 'package:prooxyy_events/widgets/num_details_form.dart';
import 'package:prooxyy_events/widgets/num_verification_form.dart';
import 'package:prooxyy_events/widgets/social_handle.dart';
import 'package:prooxyy_events/widgets/sign_up_form.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/sign-up';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int _index = 0;
  UserData u = UserData(
    id: '',
    nomPrenom: '',
    firstName: '',
    lastName: '',
    email: '',
    password: '',
    whatsappNumber: '',
    facebookLink: '',
    instagramLink: '',
    profileUrl: '',
    numTel: '',
    blocked: false,
    listeBooking: [],
    listeDevis: [],
    listeFavoris: [],
    serverId: 'test',
  );
  List<String> _text = [
    'Pour finaliser votre inscription, veuillez remplir votre numéro de téléphone. Un SMS vous sera envoyé',
    'Veuillez entrer le code qui vous a été envoyé par SMS',
  ];

  void _next() {
    setState(() {
      _index = (_index + 1) % 2;
    });
  }

  void _previous() {
    setState(() {
      _index = (_index - 1) % 2;
    });
  }

  void _val1(String phone) {
    u = u.copyWith(numTel: phone);
    _next();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          WebAppBar(5),
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 100,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Image.asset(
                      'assets/images/other.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 100,
                    width: MediaQuery.of(context).size.width / 2,
                    color: Colors.black.withOpacity(0.67),
                  ),
                  // Positioned(
                  //   top: 220,
                  //   left: (MediaQuery.of(context).size.width / 4) - 200,
                  //   child: Container(
                  //     height: 60,
                  //     width: 420,
                  //     child: RotationTransition(
                  //       turns: AlwaysStoppedAnimation(349 / 360),
                  //       child: Container(
                  //         height: 60,
                  //         width: 420,
                  //         color: Theme.of(context).accentColor.withOpacity(0.5),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                    top: 200,
                    left: (MediaQuery.of(context).size.width / 4) -
                        ((200 * 2.407079646017699) / 2),
                    child: Container(
                      height: 200,
                      width: 200 * 2.407079646017699,
                      color: Colors.black.withOpacity(0.4),
                      child: Center(
                        child: Container(
                          height: 200 * 0.8,
                          width: 200 * 2.407079646017699 * 0.8,
                          color: Colors.black.withOpacity(0.6),
                          child: Center(
                            child: Container(
                              height: 200 * 0.7,
                              width: 200 * 2.407079646017699 * 7,
                              child: Image.asset(
                                'assets/images/logo_prox3.jpg',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40.0,
                    left: 40.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      width: (MediaQuery.of(context).size.width / 2) - 100,
                      child: Text(
                        'L\'Amour de tout ce qui est bien fait. Rejoignez aujourd\'hui la grande famille de professionnels Prooxyy Events. ',
                        style: TextStyle(
                          fontFamily: 'Dancing',
                          fontSize: 40.0,
                          // overflow: TextOverflow.clip,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    headerText(
                      'Bienvenue',
                      size: 70.0,
                    ),
                    Divider(),
                    vBox20(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100.0),
                      child: Text(
                        'VERIFICATION',
                        style: TextStyle(
                          fontSize: 20.0,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    vBox20(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100.0),
                      child: Text(
                        _text[_index],
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    vBox60(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            (MediaQuery.of(context).size.width / 2) * 0.2,
                      ),
                      child: _index == 0
                          ? SignUpForm(reload: () {})
                          // NumDetailForm(
                          //     validator: _val1,
                          //   )
                          : NumVerificationForm(
                              previous: _previous,
                              validator: () {
                                u = u.copyWith(
                                  id: DateTime.now().toString(),
                                  nomPrenom: 'Nelino Josias',
                                  profileUrl: 'assets/images/pp.png',
                                );
                                Provider.of<AllUsersRepo>(context,
                                        listen: false)
                                    .addAUser(
                                  u.nomPrenom,
                                  u.profileUrl,
                                  u.numTel,
                                  u.blocked,
                                  u.listeFavoris,
                                  u.listeDevis,
                                  u.listeBooking,
                                  u.serverId,
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          vBox80(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.07,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                headerText('Ils disent aussi de nous. . .', size: 50.0),
                vBox80(),
                CommentBloc(),
              ],
            ),
          ),
          vBox80(),
          SocialHandle(),
          vBox60(),
          WebFooter(handler: () {}),
        ],
      ),
    );
  }
}
