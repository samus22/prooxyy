import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/pages/dashboard.dart';
import 'package:prooxyy_events/widgets/text_button.dart';

import 'app_button.dart';

class NumVerificationForm extends StatefulWidget {
  final Function validator;
  final Function previous;

  NumVerificationForm({
    required this.previous,
    required this.validator,
  });

  @override
  _NumVerificationFormState createState() => _NumVerificationFormState();
}

class _NumVerificationFormState extends State<NumVerificationForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  bool _length = false;

  void _submitPart() {
    bool validated = false;
    validated = _formKey.currentState!.validate();
    if (!validated) return;
    _formKey.currentState!.save();
    widget.validator();
    Navigator.of(context).pushNamed(Dashboard.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          PinCodeTextField(
            appContext: context,
            obscureText: true,
            obscuringCharacter: '*',
            blinkWhenObscuring: true,
            animationType: AnimationType.fade,
            keyboardType: TextInputType.phone,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.underline,
              fieldHeight: 50,
              fieldWidth: 40,
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Colors.grey,
              selectedColor: Theme.of(context).primaryColor,
            ),
            cursorColor: Colors.black,
            animationDuration: Duration(milliseconds: 300),
            onChanged: (value) {
              if (value.toString().length == 6) {
                setState(() {
                  _length = true;
                });
              } else {
                setState(() {
                  _length = false;
                });
              }
            },
            length: 6,
          ),
          vBox80(),
          AppButton(
            text: 'Envoyer',
            color: Theme.of(context).primaryColor,
            handler: _length ? _submitPart : null,
          ),
          const SizedBox(
            height: 40.0,
          ),
          Text(
            'Vous n\'avez pas recu de SMS ?',
            style: TextStyle(
              // fontSize: 20.0,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          vBox20(),
          AppTextButton(
            text: 'Renvoyer',
            color: Theme.of(context).accentColor,
            handler: widget.previous,
          ),
        ],
      ),
    );
  }
}
