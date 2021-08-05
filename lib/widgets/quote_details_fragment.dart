import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/models/quote.dart';

// -- Services
import 'package:prooxyy_events/services/quote.dart';
import 'package:prooxyy_events/services/all_users.dart';
import 'package:prooxyy_events/services/category.dart';

// -- Widgets
import 'package:prooxyy_events/widgets/quote_form.dart';
import 'package:prooxyy_events/widgets/quote_list_fragment.dart';
// import 'package:prooxyy_events/widgets/devis_fragment2.dart';
import 'package:provider/provider.dart';

// import 'app_button.dart';

class QuoteDetailsFragment extends StatefulWidget {
  @override
  _QuoteDetailsFragmentState createState() => _QuoteDetailsFragmentState();
}

class _QuoteDetailsFragmentState extends State<QuoteDetailsFragment> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _categorieFN = TextEditingController();
  FocusNode _themeFN = FocusNode();
  FocusNode _villeFN = FocusNode();
  FocusNode _phoneFN = FocusNode();
  FocusNode _placeFN = FocusNode();
  bool _didChange = false;
  String idE = '';
  Quote quote = Quote(
    id: '',
    // nomPrenom: '',
    category: '',
    theme: '',
    town: '',
    phoneNumber: '',
    name: '',
    done: false,
    status: Status.PENDING,
    intendedPlaces: 0,
    quoteDocUrl: '',
    avatar: '',
  );
  List<String> _items = [];

  @override
  void didChangeDependencies() {
    if (!_didChange) {
      // String u = Provider.of<AllUsersRepo>(context, listen: false).userId;
      // if (quote.name == '') quote = quote.copyWith(user: u);
      _items = Provider.of<CategoriesRepo>(context, listen: false)
          .items
          .map((e) => e.name)
          .toList();
      if (idE != '') {
        // quote =
        //     Provider.of<QuoteService>(context, listen: false).getDevisById(idE);
        // _categorieFN.text = quote.category;
        // _didChange = true;
      }
      super.didChangeDependencies();
    }
  }

  void _validator(String id) {
    setState(() {
      idE = id;
      _didChange = false;
    });
    // quote = Provider.of<QuoteService>(context, listen: false).getDevisById(id);
    // _categorieFN.text = quote.category;
  }

  void _submitPart() {
    bool validated = false;
    validated = _formKey.currentState!.validate();
    if (!validated) return;
    _formKey.currentState!.save();
    final u = Provider.of<AllUsersRepo>(context, listen: false).user.listeDevis;
    // Provider.of<QuoteService>(context, listen: false)
    //     .patchDevis(
    //   id: quote.id,
    //   // nomPrenom: devis.nomPrenom,
    //   // categorie: devis.categorie,
    //   category: quote.category,
    //   theme: quote.theme,
    //   town: quote.town,
    //   phone: quote.phoneNumber,
    //   intendedPlaces: quote.intendedPlaces,
    //   name: quote.name,
    //   done: quote.done,
    //   status: quote.status,
    //   quoteDocUrl: quote.quoteDocUrl,
    // )
    //     .then((value) {
    //   if (value) {
    //     var index = u.indexWhere((element) => element['id'] == quote.id);
    //     u[index] = {
    //       'title': quote.category,
    //       'theme': quote.theme,
    //       'id': quote.id,
    //     };
    //     Provider.of<AllUsersRepo>(context, listen: false).updateAUser(
    //       listeDevis: u,
    //     );
    //     _reload();
    //   }
    // });
  }

  void _reload() {
    setState(() {
      idE = '';
      _didChange = false;
    });
  }

  void _delete() {
    // final u = Provider.of<AllUsersRepo>(context, listen: false).user.listeDevis;
    // var index = u.indexWhere((element) => element['id'] == quote.id);
    // Provider.of<QuoteService>(context, listen: false)
    //     .delete(quote.id)
    //     .then(
    //   (value) {
    //     if (value) {
    //       u.removeAt(index);
    //       Provider.of<AllUsersRepo>(context, listen: false).updateAUser(
    //         listeDevis: u,
    //       );
    //       _reload();
    //     }
    //   },
    // );
  }

  @override
  void dispose() {
    _themeFN.dispose();
    _villeFN.dispose();
    _phoneFN.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    print(quote);
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
                              onPressed: () {
                                setState(() {
                                  idE = '';
                                  _didChange = false;
                                });
                              },
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
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  idE = '_';
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  hBox20(),
                                  Text(
                                    'AJOUTER',
                                    style: TextStyle(
                                      color: Theme.of(context).accentColor,
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
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height - 300,
                      minHeight: 300,
                    ),
                    child: QuoteListFragment(_validator),
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
                    : idE == '_'
                        ? QuoteForm(
                            dash: true,
                            reload: _reload,
                          )
                        : Form(
                            key: _formKey,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Container(
                                  height: 60,
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          TextButton(
                                            onPressed: _delete,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Icon(
                                                  Icons.delete,
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                ),
                                                hBox20(),
                                                Text(
                                                  'SUPPRIMER',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 40.0,
                                          ),
                                          TextButton(
                                            onPressed: _submitPart,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Icon(
                                                  Icons.save,
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                ),
                                                hBox20(),
                                                Text(
                                                  'ENREGISTRER',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .accentColor,
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
                                Text(
                                  'MODIFIER UN DéVIS'.toUpperCase(),
                                  style: TextStyle(
                                    letterSpacing: 3.0,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                vBox20(),
                                TextFormField(
                                  initialValue: quote.name,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value.toString().length == 0)
                                      return 'Ce champ doit être remplit';
                                    if (value.toString().length < 3)
                                      return 'Trop Court';
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person_outline),
                                    errorMaxLines: 2,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    hintText: 'Noms et Prénoms',
                                  ),
                                  onSaved: (value) {
                                    quote = quote.copyWith(
                                        name: value.toString());
                                    // _nomPrenom = value.toString();
                                  },
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(_phoneFN);
                                  },
                                ),
                                vBox20(),
                                TextFormField(
                                  initialValue: quote.phoneNumber,
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
                                    quote =
                                        quote.copyWith(phoneNumber: value.toString());
                                    // _phone = value.toString();
                                  },
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(_themeFN);
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
                                        if (value.toString().length < 2)
                                          return 'Trop Court';
                                      },
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.category),
                                        errorMaxLines: 2,
                                        hintText: 'Catégorie : Ex. Marriage',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      onSaved: (value) {
                                        quote = quote.copyWith(
                                            category: value.toString());
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
                                                value: items,
                                                child:
                                                    Text('Catégorie : $items'));
                                          }).toList();
                                        },
                                        onSelected: (newValue) {
                                          quote = quote.copyWith(
                                              category: newValue.toString());
                                          setState(() {
                                            _categorieFN.text =
                                                newValue.toString();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                vBox20(),
                                TextFormField(
                                  initialValue: quote.theme,
                                  focusNode: _themeFN,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value.toString().length == 0)
                                      return 'Ce champ doit être remplit';
                                    if (value.toString().length < 2)
                                      return 'Trop Court';
                                  },
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.bubble_chart),
                                    errorMaxLines: 2,
                                    hintText:
                                        'Thème: Ex. Pricesse / Rose-Blanc',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    quote =
                                        quote.copyWith(theme: value.toString());
                                  },
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(_villeFN);
                                  },
                                ),
                                vBox20(),
                                TextFormField(
                                  initialValue: quote.town,
                                  focusNode: _villeFN,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value.toString().length == 0)
                                      return 'Ce champ doit être remplit';
                                    if (value.toString().length < 2)
                                      return 'Trop Court';
                                  },
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.map_outlined),
                                    errorMaxLines: 2,
                                    hintText: 'Ville, Adresse de l\'évènement',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    quote =
                                        quote.copyWith(town: value.toString());
                                  },
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(_placeFN);
                                  },
                                ),
                                vBox20(),
                                TextFormField(
                                  initialValue:
                                      quote.intendedPlaces.toStringAsFixed(0),
                                  focusNode: _placeFN,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (int.tryParse(value.toString()) == null)
                                      return 'Sans espace ni virgule';
                                    if (value.toString().length == 0)
                                      return 'Ce champ doit être remplit';
                                    if (value.toString().length < 2)
                                      return 'Trop Court';
                                  },
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.map_outlined),
                                    errorMaxLines: 2,
                                    hintText:
                                        'Nombre de place (sans espace ni virgule)',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    quote = quote.copyWith(
                                        nombreDePlace:
                                            int.tryParse(value.toString()) ??
                                                0);
                                  },
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  },
                                ),
                                vBox20(),
                              ],
                            ),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
