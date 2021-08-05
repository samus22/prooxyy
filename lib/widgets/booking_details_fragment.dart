import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/models/booking.dart';
import 'package:prooxyy_events/services/all_bookings.dart';
import 'package:prooxyy_events/services/all_users.dart';
import 'package:prooxyy_events/services/category.dart';
import 'package:prooxyy_events/widgets/booking_form.dart';
import 'package:prooxyy_events/widgets/booking_list_fragment.dart';
// import 'package:prooxyy_events/widgets/booking_fragment2.dart';
import 'package:provider/provider.dart';

// import 'app_button.dart';

class BookingFragment extends StatefulWidget {
  @override
  _BookingFragmentState createState() => _BookingFragmentState();
}

class _BookingFragmentState extends State<BookingFragment> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _categorieFN = TextEditingController();
  FocusNode _themeFN = FocusNode();
  FocusNode _villeFN = FocusNode();
  FocusNode _budgetFN = FocusNode();
  FocusNode _phoneFN = FocusNode();
  bool _didChange = false;
  String idE = '';
  Booking booking = Booking(
    id: '',
    name: '',
    category: '',
    categoryId: '',
    theme: '',
    town: '',
    budget: 0,
    phoneNumber: '',
    user: '',
    done: false,
    status: Status.PENDING,
    public: true,
    targetCapacity: 0,
  );
  List<String> _items = [];

  @override
  void didChangeDependencies() {
    if (!_didChange) {
      String u = Provider.of<AllUsersRepo>(context, listen: false).userId;
      if (booking.user == '') booking = booking.copyWith(user: u);
      _items = Provider.of<CategoriesRepo>(context, listen: false)
          .items
          .map((e) => e.name)
          .toList();
      if (idE != '') {
        booking = Provider.of<AllBookingRepo>(context, listen: false)
            .getBookingById(idE);
        _categorieFN.text = booking.category;
        _didChange = true;
      }
      super.didChangeDependencies();
    }
  }

  void _validator(String id) {
    setState(() {
      idE = id;
      _didChange = false;
    });
    booking =
        Provider.of<AllBookingRepo>(context, listen: false).getBookingById(id);
    _categorieFN.text = booking.category;
  }

  void _submitPart() {
    bool validated = false;
    validated = _formKey.currentState!.validate();
    if (!validated) return;
    _formKey.currentState!.save();
    final u =
        Provider.of<AllUsersRepo>(context, listen: false).user.listeBooking;
    Provider.of<AllBookingRepo>(context, listen: false)
        .patchBookingUnique(
      id: booking.id,
      name: booking.name,
      category: booking.category,
      theme: booking.theme,
      town: booking.town,
      budget: booking.budget,
      phoneNumber: booking.phoneNumber,
      targetCapacity: booking.targetCapacity,
      user: booking.user,
      done: booking.done,
      status: booking.status,
      public: booking.public,
      mediaUrl: booking.mediaUrl,
    )
        .then((value) {
      if (value) {
        // var index = u.indexWhere((element) => element['id'] == booking.id);
        // u[index] = {
        //   'title': booking.category,
        //   'theme': booking.theme,
        //   'id': booking.id,
        // };
        // Provider.of<AllUsersRepo>(context, listen: false).updateAUser(
        //   listeBooking: u,
        // );
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
    final u =
        Provider.of<AllUsersRepo>(context, listen: false).user.listeBooking;
    // var index = u.indexWhere((element) => element['id'] == booking.id);
    // Provider.of<AllBookingRepo>(context, listen: false)
    //     .deleteBooking(booking.id)
    //     .then(
    //   (value) {
    //     if (value) {
    //       u.removeAt(index);
    //       Provider.of<AllUsersRepo>(context, listen: false).updateAUser(
    //         listeBooking: u,
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
    print(booking);
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
                    child: BookingListFragment(_validator),
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
                        ? BookingForm(
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
                                  'MODIFIER UN BOOKING',
                                  style: TextStyle(
                                    letterSpacing: 3.0,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                vBox20(),
                                TextFormField(
                                  initialValue: booking.name,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value.toString().length == 0)
                                      return 'Ce champ doit être remplit';
                                    if (value.toString().length < 3)
                                      return 'Trop Court';
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.star),
                                    errorMaxLines: 2,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    hintText:
                                        'Noms de l\'évènement (ex. Alex & Sophia)',
                                  ),
                                  onSaved: (value) {
                                    booking = booking.copyWith(
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
                                  initialValue: booking.phoneNumber,
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
                                    booking = booking.copyWith(
                                        phoneNumber: value.toString());
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
                                        booking = booking.copyWith(
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
                                          booking = booking.copyWith(
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
                                  initialValue: booking.theme,
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
                                        'Thème: Ex. Princesse / Rose-Blanc',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    booking = booking.copyWith(
                                        theme: value.toString());
                                  },
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(_villeFN);
                                  },
                                ),
                                vBox20(),
                                TextFormField(
                                  initialValue: booking.town,
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
                                    booking = booking.copyWith(
                                        town: value.toString());
                                  },
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(_budgetFN);
                                  },
                                ),
                                vBox20(),
                                TextFormField(
                                  initialValue:
                                      booking.budget.toStringAsFixed(0),
                                  focusNode: _budgetFN,
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
                                    prefixIcon:
                                        Icon(Icons.monetization_on_outlined),
                                    errorMaxLines: 2,
                                    hintText: 'Votre Budget (en FCFA)',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    booking = booking.copyWith(
                                        budget: double.parse(value.toString()));
                                  },
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  },
                                ),
                                vBox20(),
                                ListTile(
                                  leading: Icon(Icons.public),
                                  title: Text(
                                    'Visibilité du Booking',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'En acceptant de rendre votre booking publique, vous pourrez bénéficier de bla bla bla bala bla bla bala bla bla bala',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  trailing: Switch(
                                    activeColor: Theme.of(context).primaryColor,
                                    value: booking.public,
                                    onChanged: (val) {
                                      setState(() {
                                        booking =
                                            booking.copyWith(publique: val);
                                      });
                                    },
                                  ),
                                ),
                                vBox20(),
                                ListTile(
                                  leading: Icon(Icons.work),
                                  title: Text(
                                    'Etat de la demande',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Vous pouvez rejeter une demande ici',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            booking = booking.copyWith(
                                              status: Status.PENDING,
                                              done: false,
                                            );
                                          });
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 100,
                                          color: booking.status ==
                                                  Status.PENDING
                                              ? Theme.of(context).primaryColor
                                              : Colors.white,
                                          child: Center(
                                            child: Text(
                                              'EN COURS',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: booking.status ==
                                                        Status.PENDING
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                        .primaryColor,
                                                letterSpacing: 1.2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      hBox20(),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            booking = booking.copyWith(
                                              status: Status.REJECTED,
                                              done: true,
                                            );
                                          });
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 100,
                                          color: booking.status ==
                                                  Status.REJECTED
                                              ? Theme.of(context).primaryColor
                                              : Colors.white,
                                          child: Center(
                                            child: Text(
                                              'REJETER',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: booking.status ==
                                                        Status.REJECTED
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                        .primaryColor,
                                                letterSpacing: 1.2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      hBox20(),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            booking = booking.copyWith(
                                              status: Status.DONE,
                                              done: true,
                                            );
                                          });
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 100,
                                          color: booking.status == Status.DONE
                                              ? Theme.of(context).primaryColor
                                              : Colors.white,
                                          child: Center(
                                            child: Text(
                                              'Traitée'.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: booking.status ==
                                                        Status.DONE
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                        .primaryColor,
                                                letterSpacing: 1.2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                vBox20(),
                                ListTile(
                                  leading: Icon(Icons.public),
                                  title: Text(
                                    'Terminé ?',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Vous confirmez ici que vous avez terminé de traiter la requete de ${booking.name}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  trailing: Switch(
                                    activeColor: Theme.of(context).primaryColor,
                                    value: booking.done,
                                    onChanged: (val) {
                                      setState(() {
                                        booking = booking.copyWith(done: val);
                                      });
                                    },
                                  ),
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
