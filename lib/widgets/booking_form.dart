import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/models/booking.dart';
import 'package:prooxyy_events/models/category.dart';
import 'package:prooxyy_events/pages/request_sent.dart';
import 'package:prooxyy_events/services/all_bookings.dart';
import 'package:prooxyy_events/services/all_users.dart';
import 'package:prooxyy_events/services/booking.dart';
import 'package:prooxyy_events/services/category.dart';
import 'package:prooxyy_events/services/user.dart';
import 'package:prooxyy_events/widgets/app_button.dart';
import 'package:provider/provider.dart';

class BookingForm extends StatefulWidget {
  final bool dash;
  final Function reload;

  BookingForm({
    this.dash = false,
    required this.reload,
  });
  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _categorieFN = TextEditingController();
  FocusNode _themeFN = FocusNode();
  FocusNode _villeFN = FocusNode();
  FocusNode _budgetFN = FocusNode();
  FocusNode _phoneFN = FocusNode();
  bool _didChange = false;
  User? user = UserService2.instance.currentUser();

  Booking booking = Booking(
    id: DateTime.now().toString(),
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
  List<Category> _categories = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didChange) {
      String u = Provider.of<AllUsersRepo>(context, listen: false).userId;
      if (user != null && booking.user == '') booking = booking.copyWith(user: user!.uid);
      _items = Provider.of<CategoriesRepo>(context, listen: false)
          .items
          .map((e) => e.name)
          .toList();

      CategoryService.instance.getAll().then((value) {
        _categories = value.docs.map((e) => Category.fromMap2(e)).toList();
      });
      _categorieFN.text = 'Catégorie :';
      _didChange = true;
    }
  }

  void _submitPart() {
    bool validated = false;
    validated = _formKey.currentState!.validate();
    if (!validated) return;
    _formKey.currentState!.save();

    BookingService bookingService = BookingService.instance;
    bookingService.add(booking)
      .then((value) => {
        if (!widget.dash) {
          Navigator.of(context).pushNamed(RequestSentPage.routeName)
        } else {
          widget.reload()
        }
      })
      .onError((error, stackTrace) => {});

    final u =
        Provider.of<AllUsersRepo>(context, listen: false).user.listeBooking;
    Provider.of<AllBookingRepo>(context, listen: false)
        .addBookingUnique(
      id: booking.id,
      name: booking.name,
      category: booking.category,
      categoryId: booking.categoryId,
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
      if (value != '') {
        // u.add({
        //   'title': booking.category,
        //   'theme': booking.theme,
        //   'id': value,
        // });
        Provider.of<AllUsersRepo>(context, listen: false).updateAUser(
          listeBooking: u,
        );
        if (!widget.dash) {
          Navigator.of(context).pushNamed(RequestSentPage.routeName);
        } else {
          widget.reload();
        }
      }
    });
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
    print('Logged in user: $user');

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
              prefixIcon: Icon(Icons.star),
              errorMaxLines: 2,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: 'Noms de l\'évènement (ex. Alex & Sophia)',
            ),
            onSaved: (value) {
              booking = booking.copyWith(name: value.toString());
              // _nomPrenom = value.toString();
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
              // _phone = value.toString();
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
                    return _categories.map((category) {
                      return PopupMenuItem(
                          value: category, child: Text('Catégorie : ${category.name}'));
                    }).toList();
                  },
                  onSelected: (newValue) {
                    Category sCategory = newValue as Category;
                    booking = booking.copyWith(category: sCategory.name, categoryId: sCategory.id);
                    setState(() {
                      _categorieFN.text = newValue.name;
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
              FocusScope.of(context).requestFocus(_budgetFN);
            },
          ),
          vBox20(),
          TextFormField(
            focusNode: _budgetFN,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value.toString().length == 0)
                return 'Ce champ doit être remplit';
              if (value.toString().length < 2) return 'Trop Court';
            },
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.monetization_on_outlined),
              errorMaxLines: 2,
              hintText: 'Votre Budget (en FCFA)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onSaved: (value) {
              booking = booking.copyWith(budget: double.parse(value.toString()));
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(FocusNode());
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
                  booking = booking.copyWith(publique: val);
                });
              },
            ),
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
