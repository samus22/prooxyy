import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/models/page_block.dart';
import 'package:prooxyy_events/models/catalog.dart';
import 'package:prooxyy_events/models/category.dart';
import 'package:prooxyy_events/services/page_block.dart';
import 'package:prooxyy_events/services/catalog.dart';
import 'package:prooxyy_events/services/category.dart';
import 'package:prooxyy_events/widgets/app_button.dart';
import 'package:prooxyy_events/widgets/catalog_list_fragment.dart';
import 'package:prooxyy_events/widgets/image_uploader.dart';

class AssetPageForm extends StatefulWidget {
  final String? assetId;

  AssetPageForm({this.assetId});
  @override
  _AssetPageFormState createState() => _AssetPageFormState();
}

class _AssetPageFormState extends State<AssetPageForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  FocusNode _nameFN = FocusNode();
  FocusNode _descriptionFN = FocusNode();
  TextEditingController _categoryFN = TextEditingController();

  PageBlock asset = new PageBlock(
    id: '',
    name: '',
    description: '',
    media: '',
  );

  void _submit() {
    if (widget.assetId == null) {
      PageBlockService.instance
          .add(asset)
          .then((value) => print('Asset added'))
          .catchError((error) => print('Error when adding new entry $error'));
    } else {
      asset.id = widget.assetId!;
      PageBlockService.instance
          .update(widget.assetId!, asset)
          .then((value) => print('Catalog entry ${widget.assetId}'))
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
            hintText: "Nom de l'atout que vous possédez",
          ),
          onChanged: (value) {
            asset.name = value;
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
            hintText: "Description de l'atout",
          ),
          onChanged: (value) {
            asset.description = value;
          },
        ),
        vBox20(),
        ImageUploader(onFileAdded: (List<String> media) {
          print('These are the media saved $media');
          // asset.media = media;
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
