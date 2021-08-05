import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/models/category.dart';
import 'package:prooxyy_events/services/category.dart';
// import 'package:prooxyy_events/repositories/all_users.dart';
// import 'package:prooxyy_events/repositories/categories.dart';
import 'package:prooxyy_events/widgets/category_list_fragment.dart';
// import 'package:prooxyy_events/widgets/categorie_fragment2.dart';
import 'package:provider/provider.dart';

import 'app_button.dart';

// import 'app_button.dart';

class CategoryDetailsFragment extends StatefulWidget {
  @override
  _CategoryDetailsFragmentState createState() => _CategoryDetailsFragmentState();
}

class _CategoryDetailsFragmentState extends State<CategoryDetailsFragment> {
  GlobalKey<FormState> _formKey = GlobalKey();
  FocusNode _nameFN = FocusNode();
  FocusNode _descriptionFN = FocusNode();
  TextEditingController nameC = TextEditingController();
  TextEditingController descC = TextEditingController();
  bool _didChange = false;
  String idE = '';

  Category categorie = Category(
    id: '',
    description: '',
    imageUrl: 'assets/images/out_event.jpg',
    name: '',
  );

  @override
  void didChangeDependencies() {
    if (!_didChange) {
      if (idE != '') {
        categorie = Provider.of<CategoriesRepo>(context).getCategorieById(idE);
        _didChange = true;
      }
    }
    super.didChangeDependencies();
  }

  void _validator(String id) {
    setState(() {
      idE = id;
      _didChange = false;
    });
    try {
      categorie = Provider.of<CategoriesRepo>(context, listen: false)
          .getCategorieById(id);
    } catch (e) {
      print('There was an error');
    }
  }

  void _submitPart() {
    bool validated = false;
    validated = _formKey.currentState!.validate();
    if (!validated) return;
    _formKey.currentState!.save();
    Provider.of<CategoriesRepo>(context, listen: false)
        .patchCategorie(
      id: categorie.id,
      description: categorie.description,
      imageUrl: categorie.imageUrl,
      name: categorie.name,
    )
        .then((value) {
      if (value) {
        _reload();
      }
    });
  }

  void _addPart() {
    bool validated = false;
    validated = _formKey.currentState!.validate();
    if (!validated) return;
    _formKey.currentState!.save();
    Provider.of<CategoriesRepo>(context, listen: false)
        .addCategory(
      description: categorie.description,
      imageUrl: categorie.imageUrl,
      name: categorie.name,
    )
        .then((value) {
      if (value) {
        _reload();
      }
    });
  }

  void _reload() {
    setState(() {
      idE = '';
      _didChange = false;
    });
  }

  void _delete() {
    Provider.of<CategoriesRepo>(context, listen: false)
        .deleteCategorie(categorie.id)
        .then(
      (value) {
        if (value) {
          _reload();
        }
      },
    );
  }

  @override
  void dispose() {
    _nameFN.dispose();
    _descriptionFN.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    descC.text = categorie.description;
    nameC.text = categorie.name;

    
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
                                  categorie = Category(
                                    id: '',
                                    description: '',
                                    imageUrl: 'assets/images/out_event.jpg',
                                    name: '',
                                  );
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
                    child: CategoryListFragment(_validator),
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
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (idE != '_')
                            Container(
                              height: 60,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(),
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: _delete,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.delete,
                                              color:
                                                  Theme.of(context).accentColor,
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
                          if (idE != '_') Divider(),
                          Form(
                            key: _formKey,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Text(
                                  idE == '_'
                                      ? 'créer une catégorie'.toUpperCase()
                                      : 'MODIFIER une catégorie'.toUpperCase(),
                                  style: TextStyle(
                                    letterSpacing: 3.0,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                vBox20(),
                                TextFormField(
                                  controller: nameC,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value.toString().length == 0)
                                      return 'Ce champ doit être remplit';
                                    if (value.toString().length < 3)
                                      return 'Trop Court';
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.info_outline),
                                    errorMaxLines: 2,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    hintText: 'Nom de la Catégorie',
                                  ),
                                  onSaved: (value) {
                                    categorie = categorie.copyWith(
                                        name: value.toString());
                                    // _nomPrenom = value.toString();
                                  },
                                ),
                                vBox20(),
                                TextFormField(
                                  controller: descC,
                                  focusNode: _descriptionFN,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value.toString().length == 0)
                                      return 'Ce champ doit être remplit';
                                  },
                                  maxLines: 10,
                                  decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.description_outlined),
                                    hintText: 'Description de la Catégorie',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    categorie = categorie.copyWith(
                                      description: value.toString(),
                                    );
                                    // _phone = value.toString();
                                  },
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  },
                                ),
                                vBox20(),
                                if (idE == '_')
                                  AppButton(
                                    text: 'Envoyer',
                                    color: Theme.of(context).primaryColor,
                                    handler: _addPart,
                                  ),
                              ],
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
