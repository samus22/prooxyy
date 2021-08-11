import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/models/catalog.dart';
import 'package:prooxyy_events/models/category.dart';
import 'package:prooxyy_events/services/catalog.dart';
import 'package:prooxyy_events/services/category.dart';
import 'package:prooxyy_events/widgets/app_button.dart';
import 'package:prooxyy_events/widgets/catalog_list_fragment.dart';
import 'package:prooxyy_events/widgets/image_uploader.dart';

class CatalogPageForm extends StatefulWidget {
  final String? catalogEntryId;

  CatalogPageForm({this.catalogEntryId});
  @override
  _CatalogPageFormState createState() => _CatalogPageFormState();
}

class _CatalogPageFormState extends State<CatalogPageForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  FocusNode _nameFN = FocusNode();
  FocusNode _themeFN = FocusNode();
  FocusNode _descriptionFN = FocusNode();
  TextEditingController _categoryFN = TextEditingController();

  Catalog catalogEntry = new Catalog(
    name: '',
    theme: '',
    category: '',
    categoryId: '',
    description: '',
    media: [],
  );

  void _submit() {
    if (widget.catalogEntryId == null) {
      CatalogService.instance
          .add(catalogEntry)
          .then((value) => print('Catalog entry added'))
          .catchError((error) => print('Error when adding new entry $error'));
    } else {
      catalogEntry.id = widget.catalogEntryId!;
      CatalogService.instance
          .update(widget.catalogEntryId!, catalogEntry)
          .then((value) => print('Catalog entry ${widget.catalogEntryId}'))
          .catchError((error) => print('Error when updating entry $error'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: ListView(
      shrinkWrap: true,
      children: [
        TextFormField(
          focusNode: _nameFN,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.ac_unit),
            errorMaxLines: 2,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: "Nom de l'evènement",
          ),
          onChanged: (value) {
            catalogEntry.name = value;
          },
        ),
        vBox20(),
        TextFormField(
          focusNode: _themeFN,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.tag_rounded),
            errorMaxLines: 2,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: "Thème de l'évenement",
          ),
          onChanged: (value) {
            catalogEntry.theme = value;
          },
        ),
        vBox20(),
        TextFormField(
          focusNode: _descriptionFN,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.calendar_today),
            errorMaxLines: 2,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: "Descrivez l'evènement",
          ),
          onChanged: (value) {
            catalogEntry.description = value;
          },
        ),
        vBox20(),
        Stack(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              controller: _categoryFN,
              decoration: InputDecoration(
                  errorMaxLines: 2,
                  prefixIcon: Icon(Icons.tag),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: "Sélectionnez la catégorie"),
            ),
            Positioned(
                right: 20.0,
                top: 8.0,
                child: FutureBuilder(
                    future: CategoryService.instance.getAll(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(
                          value: null,
                          semanticsLabel: 'Linear progress indicator',
                        );
                      }

                      List<Category> categories = snapshot.data!.docs
                          .map((doc) => Category.fromMap2(doc))
                          .toList();

                      return PopupMenuButton<Category>(
                        icon: Icon(Icons.keyboard_arrow_down),
                        iconSize: 20.0,
                        itemBuilder: (ctx) {
                          return categories.map((category) {
                            return PopupMenuItem(
                                value: category,
                                child: Text('Catégorie : ${category.name}'));
                          }).toList();
                        },
                        onSelected: (newValue) {
                          catalogEntry.category = newValue.name;
                          catalogEntry.categoryId = newValue.id;
                          setState(() {
                            _categoryFN.text = newValue.name;
                          });
                        },
                      );
                    }))
          ],
        ),
        vBox20(),
        ImageUploader(onFileAdded: (List<String> media) {
          print('These are the media saved $media');
          catalogEntry.media = media;
        }),
        vBox20(),
        AppButton(
            text: 'Sauvegarder',
            color: Theme.of(context).primaryColor,
            handler: _submit)
      ],
    ));
  }
}
