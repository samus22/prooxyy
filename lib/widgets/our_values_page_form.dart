import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/models/variable.dart';
import 'package:prooxyy_events/services/variable.dart';

import 'app_button.dart';

class OurValuesPageForm extends StatefulWidget {
  final String? contentId;
  OurValuesPageForm({this.contentId});

  @override
  _OurValuesPageFormState createState() => _OurValuesPageFormState();
}

class _OurValuesPageFormState extends State<OurValuesPageForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  FocusNode _content = FocusNode();

  Variable content = new Variable(name: 'our_values', type: 'text', value: '');

  void submit() {
    if (widget.contentId == null) {
      VariableService.instance
          .add(content)
          .then((value) => print('Variable saved'))
          .catchError((error) {
        print('Unable to save variable: $content');
      });
    } else {
      content.id = widget.contentId!;
      VariableService.instance
          .update(widget.contentId!, content)
          .then((value) => print('Variable saved'))
          .catchError((error) {
        print('Unable to save variable: $content');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            TextFormField(
                focusNode: _content,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.edit),
                  errorMaxLines: 2,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Précisez vos valeurs ici',
                ),
                onChanged: (value) {
                  content.value = value;
                }),
            vBox80(),
            AppButton(
              text: 'Envoyer',
              color: Theme.of(context).primaryColor,
              handler: submit,
            ),
          ],
        ));
  }
}
