import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/pages/dashboard.dart';
import 'package:prooxyy_events/pages/signup.dart';
import 'package:prooxyy_events/services/user.dart';
import 'package:prooxyy_events/widgets/app_button.dart';
import 'package:prooxyy_events/widgets/appbar.dart';
import 'package:prooxyy_events/widgets/comment_bloc.dart';
import 'package:prooxyy_events/widgets/footer.dart';
import 'package:prooxyy_events/widgets/social_handle.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/sign-in';
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            WebAppBar(7),
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height - 100,
                      width: MediaQuery.of(context).size.width / 2,
                      child: Image.asset(
                        'assets/images/team.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height - 100,
                      width: MediaQuery.of(context).size.width / 2,
                      color: Colors.black.withOpacity(0.67),
                    ),
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
                        'Inscription / Connexion',
                        size: 70.0,
                      ),
                      vBox20(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100.0),
                        child: Text(
                          'L\'évènement d\'une vie commence ici. Inscrivez vous gratuitement dès maintenant et recevez gratuitement un devis pour votre évènement',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      vBox60(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.toString().length == 0)
                              return 'Ce champ doit être remplit';
                          },
                          decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            prefixIcon: Icon(Icons.mail),
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onChanged: (value) {
                            _email = value.toString();
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        ),
                      ),
                      vBox20(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100.0),
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.toString().length == 0)
                              return 'Ce champ doit être remplit';
                          },
                          decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            prefixIcon: Icon(Icons.vpn_key_rounded),
                            hintText: 'Mot de passe',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onChanged: (value) {
                            _password = value.toString();
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        ),
                      ),
                      vBox60(),
                      AppButton(
                        text: 'Connecter',
                        color: Theme.of(context).primaryColor,
                        handler: () {
                          UserService2.instance
                              .signIn(_email, _password)
                              .then((value) {
                            Navigator.of(context)
                                .pushNamed(Dashboard.routeName);
                          }).onError((error, stackTrace) {
                            print('Error occured $error');
                          });
                        },
                      ),
                      vBox80(),
                      Container(
                        height: 0.5,
                        width: 300,
                        color: Colors.grey,
                      ),
                      vBox60(),
                      Text(
                        'CONTINUER AVEC . . .',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          fontSize: 22.0,
                        ),
                      ),
                      vBox60(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(SignUpPage.routeName);
                        },
                        child: Container(
                          height: 60,
                          width: 400,
                          child: Image.asset(
                            'assets/images/google.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(SignUpPage.routeName);
                        },
                        child: Container(
                          height: 60,
                          width: 400,
                          child: Image.asset(
                            'assets/images/fb_login.png',
                            fit: BoxFit.contain,
                          ),
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
                  headerText(
                    'Ils disent aussi de nous. . .',
                    size: 50.0,
                  ),
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
      ),
    );
  }
}
