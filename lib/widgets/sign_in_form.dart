import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/models/booking.dart';
import 'package:prooxyy_events/pages/request_sent.dart';
import 'package:prooxyy_events/services/all_bookings.dart';
import 'package:prooxyy_events/services/all_users.dart';
import 'package:prooxyy_events/services/booking.dart';
import 'package:prooxyy_events/services/category.dart';
import 'package:prooxyy_events/services/user.dart';
import 'package:prooxyy_events/widgets/app_button.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  final bool dash;
  final Function reload;

  SignInForm({
    this.dash = false,
    required this.reload,
  });
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  FocusNode _emailFN = FocusNode();
  FocusNode _passwordFN = FocusNode();
  bool _didChange = false;

  Map<String, dynamic> userDetails = {
    'email': '',
    'password': ''
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didChange) {
      _didChange = true;
    }
  }

  void _submitPart() {
    bool validated = false;
    validated = _formKey.currentState!.validate();
    if (!validated) return;
    _formKey.currentState!.save();

    // Sign in on plateform
    UserService2.instance.signIn(userDetails['email'], userDetails['password']);

  }

  @override
  void dispose() {
    _emailFN.dispose();
    _passwordFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (_user) FocusScope.of(context).requestFocus(_villeFN);
    

    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value.toString().length == 0)
                return 'Ce champ doit être remplit';
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.mail),
              hintText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onSaved: (value) {
              userDetails['email'] = value;
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_emailFN);
            },
          ),
          vBox20(),
          TextFormField(
            focusNode: _passwordFN,
            obscureText: true,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value.toString().length == 0)
                return 'Ce champ doit être remplit';
              if (value.toString().length < 2) return 'Trop Court';
            },
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              errorMaxLines: 2,
              hintText: 'Mot de passe',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onSaved: (value) {
              userDetails['password'] = value;
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_passwordFN);
            },
          ),
          vBox20(),
          AppButton(
            text: 'Envoyer',
            color: Theme.of(context).primaryColor,
            handler: _submitPart,
          ),
        ],
      ),
    );
  }
}
