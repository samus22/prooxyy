import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';

import 'app_button.dart';

class NumDetailForm extends StatefulWidget {
  final Function validator;

  NumDetailForm({required this.validator});
  @override
  _NumDetailFormState createState() => _NumDetailFormState();
}

class _NumDetailFormState extends State<NumDetailForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _phone = '';
  // bool _user = false;

  void _submitPart() {
    bool validated = false;
    validated = _formKey.currentState!.validate();
    if (!validated) return;
    _formKey.currentState!.save();
    widget.validator(_phone.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value.toString().length == 0)
                return 'Ce champ doit être remplit';
            },
            decoration: InputDecoration(
              focusColor: Theme.of(context).primaryColor,
              prefixIcon: Icon(Icons.phone),
              hintText: 'Numéro de téléphone',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onSaved: (value) {
              _phone = value.toString();
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
          vBox80(),
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
