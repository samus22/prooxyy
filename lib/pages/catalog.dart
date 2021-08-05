import 'package:flutter/material.dart';

// -- Helpers
import 'package:prooxyy_events/helpers/helpers.dart';

// -- Models
import 'package:prooxyy_events/models/booking.dart';

// -- Services
import 'package:prooxyy_events/services/all_bookings.dart';
import 'package:prooxyy_events/services/all_users.dart';
import 'package:prooxyy_events/services/category.dart';

// -- Widgets
import 'package:prooxyy_events/widgets/appbar.dart';
import 'package:prooxyy_events/widgets/catalog_grid.dart';
import 'package:prooxyy_events/widgets/comment_bloc.dart';
import 'package:prooxyy_events/widgets/footer.dart';
import 'package:prooxyy_events/widgets/header_line.dart';
import 'package:prooxyy_events/widgets/social_handle.dart';
import 'package:prooxyy_events/widgets/sub_slide.dart';
import 'package:provider/provider.dart';

class CatalogPage extends StatefulWidget {
  static const routeName = '/element-catalogue';

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  Widget build(BuildContext context) {
    String id = '';
    id = ModalRoute.of(context)!.settings.arguments.toString();
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
    if (id.isNotEmpty) {
      booking = Provider.of<AllBookingRepo>(context, listen: false)
          .getCatalogueItemsById(id);
    }
    var imageUrl = Provider.of<CategoriesRepo>(context, listen: false)
        .getCategorieByName(booking.category);
    var fav =
        Provider.of<AllUsersRepo>(context, listen: false).user.listeFavoris;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (fav.contains(booking.id)) {
            setState(() {
              fav.remove(booking.id);
            });
          } else {
            setState(() {
              fav.add(booking.id);
            });
          }
          Provider.of<AllUsersRepo>(context).updateAUser(listeFavoris: fav);
        },
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(
          Icons.favorite_border,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WebAppBar(2),
            SubSlide(
              image: 'assets/images/first.png',
              text: 'Catalogue',
            ),
            vBox20(),
            HeaderLine(
                header: 'CATALOGUE > ${booking.category.toUpperCase()}'),
            vBox60(),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.07,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      imageUrl.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  vBox80(),
                  headerText(
                    booking.name,
                    size: 100.0,
                  ),
                  vBox20(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100.0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 100.0,
                          backgroundImage: AssetImage(imageUrl.imageUrl),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'catégorie'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.grey,
                                letterSpacing: 2.0,
                                fontSize: 14.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              booking.category,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'thème'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.grey,
                                letterSpacing: 2.0,
                                fontSize: 14.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              booking.theme,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'ville'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.grey,
                                letterSpacing: 2.0,
                                fontSize: 14.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              booking.town,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'nombre de place'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.grey,
                                letterSpacing: 2.0,
                                fontSize: 14.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              booking.targetCapacity.toStringAsFixed(0),
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'budget'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.grey,
                                letterSpacing: 2.0,
                                fontSize: 14.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              booking.budget.toStringAsFixed(0) + ' FCFA',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            if (fav.contains(booking.id))
                              Text(
                                'Favoris'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.grey,
                                  letterSpacing: 2.0,
                                  fontSize: 14.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            if (fav.contains(booking.id))
                              const SizedBox(
                                height: 20.0,
                              ),
                            if (fav.contains(booking.id))
                              Icon(
                                Icons.favorite,
                                color: Theme.of(context).accentColor,
                                size: 20.0,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  vBox80(),
                  CatalogGrid(booking.mediaUrl),
                  headerText('Ils disent aussi de nous. . .', size: 50.0),
                  vBox80(),
                  CommentBloc(),
                ],
              ),
            ),
            vBox60(),
            SocialHandle(),
            vBox80(),
            WebFooter(handler: () {}),
          ],
        ),
      ),
    );
  }
}
