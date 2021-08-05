import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/models/rating.dart';
import 'package:prooxyy_events/services/all_bookings.dart';
import 'package:prooxyy_events/services/all_users.dart';
import 'package:prooxyy_events/services/rating.dart';
// import 'package:prooxyy_events/repositories/all_users.dart';
// import 'package:prooxyy_events/repositories/Notes.dart';
import 'package:prooxyy_events/widgets/rating_list_fragment.dart';
// import 'package:prooxyy_events/widgets/Note_fragment2.dart';
import 'package:provider/provider.dart';

import 'app_button.dart';

// import 'app_button.dart';

class RatingDetailsFragment extends StatefulWidget {
  @override
  _RatingDetailsFragmentState createState() => _RatingDetailsFragmentState();
}

class _RatingDetailsFragmentState extends State<RatingDetailsFragment> {
  GlobalKey<FormState> _formKey = GlobalKey();
  double noteNumber = 1.0;
  List<bool> _hover = [true, false, false, false, false];
  List<bool> _noted = [true, false, false, false, false];
  TextEditingController descC = TextEditingController();
  bool _didChange = false;
  bool _none = false;
  String idE = '';
  Rating rating = Rating(
    id: '',
    value: 1.0,
    avatar: '',
    ratedBy: '',
    rater: '',
    ratedOn: DateTime.now(),
    booking: '',
    comment: '',
    category: ''
  );

  @override
  void didChangeDependencies() {
    if (!_didChange) {
      if (idE != '') {
        rating = Provider.of<RatingService>(context).getNoteByBookingId(idE);
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
      rating =
          Provider.of<RatingService>(context, listen: false).getNoteByBookingId(id);
      setState(() {
        _none = false;
      });
    } catch (e) {
      setState(() {
        _none = true;
      });
      print('There was an error');
    }
  }

  void _submitPart() {
    bool validated = false;
    validated = _formKey.currentState!.validate();
    if (!validated) return;
    _formKey.currentState!.save();
    Provider.of<RatingService>(context, listen: false)
        .patchNote(
      id: rating.id,
      booking: rating.booking,
      value: rating.value,
      comment: rating.comment,
      ratedOn: rating.ratedOn
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
    final u = Provider.of<AllUsersRepo>(context, listen: false).user;
    final bok =
        Provider.of<AllBookingRepo>(context, listen: false).getBookingById(idE);
    Provider.of<RatingService>(context, listen: false)
        .addNote(
      id: DateTime.now().toString(),
      // bookingId: bok.id,
      // category: bok.category,
      booking: bok.id,
      comment: rating.comment,
      avatar: u.profileUrl,
      value: rating.value,
      ratedOn: DateTime.now(),
      ratedBy: u.nomPrenom,
      rater: 'Jones'
      // userId: u.id,
      // userName: u.nomPrenom,
      // theme: bok.theme,
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
    Provider.of<RatingService>(context, listen: false).deleteNote(rating.id).then(
      (value) {
        if (value) {
          _reload();
        }
      },
    );
  }

  void _selected(int i) {
    setState(() {
      for (int a = 0; a <= i; a++) {
        _noted[a] = true;
      }
      for (int a = i + 1; a <= 4; a++) {
        _noted[a] = false;
      }
      noteNumber = i * 1.0;
      rating = rating.copyWith(value: noteNumber);
    });
  }

  @override
  void dispose() {
    descC.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    descC.text = rating.comment;
    noteNumber = rating.value;
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
                    child: RatingListFragment(_validator),
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
                          if (!_none)
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
                          if (!_none) Divider(),
                          Form(
                            key: _formKey,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Text(
                                  _none
                                      ? 'doner un avis'.toUpperCase()
                                      : 'MODIFIER mon avis'.toUpperCase(),
                                  style: TextStyle(
                                    letterSpacing: 3.0,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                vBox20(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'NOTE',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            _selected(0);
                                          },
                                          child: Icon(
                                            _noted[0]
                                                ? Icons.star
                                                : Icons.star_border_outlined,
                                            color: _noted[0] || _hover[0]
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey,
                                          ),
                                        ),
                                        hBox20(),
                                        InkWell(
                                          onTap: () {
                                            _selected(1);
                                          },
                                          child: Icon(
                                            _noted[1]
                                                ? Icons.star
                                                : Icons.star_border_outlined,
                                            color: _noted[1] || _hover[1]
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey,
                                          ),
                                        ),
                                        hBox20(),
                                        InkWell(
                                          onTap: () {
                                            _selected(2);
                                          },
                                          child: Icon(
                                            _noted[2]
                                                ? Icons.star
                                                : Icons.star_border_outlined,
                                            color: _noted[2] || _hover[2]
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey,
                                          ),
                                        ),
                                        hBox20(),
                                        InkWell(
                                          onTap: () {
                                            _selected(3);
                                          },
                                          child: Icon(
                                            _noted[3]
                                                ? Icons.star
                                                : Icons.star_border_outlined,
                                            color: _noted[3] || _hover[3]
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey,
                                          ),
                                        ),
                                        hBox20(),
                                        InkWell(
                                          onTap: () {
                                            _selected(4);
                                          },
                                          child: Icon(
                                            _noted[4]
                                                ? Icons.star
                                                : Icons.star_border_outlined,
                                            color: _noted[4] || _hover[4]
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                vBox20(),
                                TextFormField(
                                  controller: descC,
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
                                    rating = rating.copyWith(
                                      comment: value.toString(),
                                    );
                                    // _phone = value.toString();
                                  },
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  },
                                ),
                                vBox20(),
                                if (_none)
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
