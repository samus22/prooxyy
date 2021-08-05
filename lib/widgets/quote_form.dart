import 'package:flutter/material.dart';

// -- Helpers
import 'package:prooxyy_events/helpers/helpers.dart';

// -- Models
import 'package:prooxyy_events/models/quote.dart';

// -- Pages
import 'package:prooxyy_events/pages/request_sent.dart';

// -- Services
import 'package:prooxyy_events/services/quote.dart';
import 'package:prooxyy_events/services/all_users.dart';
import 'package:prooxyy_events/services/category.dart';

// -- Widgets
import 'package:prooxyy_events/widgets/app_button.dart';
import 'package:provider/provider.dart';

class QuoteForm extends StatefulWidget {
  final bool dash;
  final Function reload;

  QuoteForm({
    this.dash = false,
    required this.reload,
  });
  @override
  _QuoteFormState createState() => _QuoteFormState();
}

class _QuoteFormState extends State<QuoteForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _categorieFN = TextEditingController();
  FocusNode _themeFN = FocusNode();
  FocusNode _villeFN = FocusNode();
  FocusNode _nombreDePlaceFN = FocusNode();
  FocusNode _phoneFN = FocusNode();
  bool _didChange = false;
  Quote booking = Quote(
    id: DateTime.now().toString(),
    theme: '',
    category: '',
    town: '',
    phoneNumber: '',
    name: '',
    done: false,
    status: Status.PENDING,
    intendedPlaces: 0,
    quoteDocUrl: '', avatar: '',
  );
  List<String> _items = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didChange) {
      String u = Provider.of<AllUsersRepo>(context, listen: false).userId;

      // if (booking.name == '') booking = booking.copyWith(user: u);

      _items = Provider.of<CategoriesRepo>(context, listen: false)
          .items
          .map((e) => e.name)
          .toList();

      _categorieFN.text = 'Catégorie :';
      _didChange = true;

    }
  }

  void _submitPart() {
    bool validated = false;
    validated = _formKey.currentState!.validate();
    if (!validated) return;
    _formKey.currentState!.save();
    // final u = Provider.of<AllUsersRepo>(context, listen: false).name.listeDevis;
    // Provider.of<QuoteService>(context, listen: false)
    //     .addDevisUnique(
    //   id: booking.id,
    //   // nomPrenom: booking.nomPrenom,
    //   category: booking.category,
    //   theme: booking.theme,
    //   town: booking.town,
    //   phoneNumber: booking.phoneNumber,
    //   intendedPlaces: booking.intendedPlaces,
    //   name: booking.name,
    //   done: booking.done,
    //   status: booking.status,
    //   quoteDocUrl: booking.quoteDocUrl,
    // )
    //     .then((value) {
    //   if (value != '') {
    //     u.add({
    //       'title': booking.category,
    //       'theme': booking.theme,
    //       'id': value,
    //     });
    //     Provider.of<AllUsersRepo>(context, listen: false).updateAUser(
    //       listeDevis: u,
    //     );
    //     if (!widget.dash) {
    //       Navigator.of(context).pushNamed(RequestSentPage.routeName);
    //     } else {
    //       widget.reload();
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    _categorieFN.dispose();
    _themeFN.dispose();
    _villeFN.dispose();
    _phoneFN.dispose();
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
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value.toString().length == 0)
                return 'Ce champ doit être remplit';
              if (value.toString().length < 3) return 'Trop Court';
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person_outline),
              errorMaxLines: 2,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: 'Nom et Prénom',
            ),
            onSaved: (value) {
              booking = booking.copyWith(name: value.toString());
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_phoneFN);
            },
          ),
          vBox20(),
          TextFormField(
            focusNode: _phoneFN,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value.toString().length == 0)
                return 'Ce champ doit être remplit';
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone),
              hintText: 'Numéro de téléphone',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onSaved: (value) {
              booking = booking.copyWith(phoneNumber: value.toString());
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_themeFN);
            },
          ),
          vBox20(),
          Stack(
            children: [
              TextFormField(
                enabled: false,
                textInputAction: TextInputAction.next,
                controller: _categorieFN,
                validator: (value) {
                  if (value.toString().length == 0)
                    return 'Ce champ doit être remplit';
                  if (value.toString().length < 2) return 'Trop Court';
                },
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.category),
                  errorMaxLines: 2,
                  hintText: 'Catégorie : Ex. Marriage',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onSaved: (value) {
                  booking = booking.copyWith(category: value.toString());
                },
              ),
              Positioned(
                right: 20.0,
                top: 8.0,
                child: PopupMenuButton(
                  // value: _dropD,
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 20.0,

                  itemBuilder: (ctx) {
                    return _items.map((items) {
                      return PopupMenuItem(
                          value: items, child: Text('Catégorie : $items'));
                    }).toList();
                  },
                  onSelected: (newValue) {
                    booking = booking.copyWith(category: newValue.toString());
                    setState(() {
                      _categorieFN.text = newValue.toString();
                    });
                  },
                ),
              ),
            ],
          ),
          vBox20(),
          TextFormField(
            focusNode: _themeFN,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value.toString().length == 0)
                return 'Ce champ doit être remplit';
              if (value.toString().length < 2) return 'Trop Court';
            },
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.bubble_chart),
              errorMaxLines: 2,
              hintText: 'Thème: Ex. Pricesse / Rose-Blanc',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onSaved: (value) {
              booking = booking.copyWith(theme: value.toString());
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_villeFN);
            },
          ),
          vBox20(),
          TextFormField(
            focusNode: _villeFN,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value.toString().length == 0)
                return 'Ce champ doit être remplit';
              if (value.toString().length < 2) return 'Trop Court';
            },
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.map_outlined),
              errorMaxLines: 2,
              hintText: 'Ville, Adresse de l\'évènement',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onSaved: (value) {
              booking = booking.copyWith(town: value.toString());
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_nombreDePlaceFN);
            },
          ),
          vBox20(),
          TextFormField(
            focusNode: _nombreDePlaceFN,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value.toString().length == 0)
                return 'Ce champ doit être remplit';
              if (value.toString().length < 2) return 'Trop Court';
            },
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.group_outlined),
              errorMaxLines: 2,
              hintText: 'Nombre de Places',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onSaved: (value) {
              booking =
                  booking.copyWith(nombreDePlace: int.parse(value.toString()));
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(FocusNode());
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
