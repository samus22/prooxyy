import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/models/category.dart';
import 'package:prooxyy_events/pages/booking.dart';
import 'package:prooxyy_events/services/category.dart';
import 'package:prooxyy_events/widgets/app_button.dart';
import 'package:prooxyy_events/widgets/appbar.dart';
import 'package:prooxyy_events/widgets/category_presenter_grid.dart';
import 'package:prooxyy_events/widgets/footer.dart';
import 'package:prooxyy_events/widgets/header_line.dart';
import 'package:prooxyy_events/widgets/social_handle.dart';
import 'package:prooxyy_events/widgets/sub_slide.dart';
import 'package:prooxyy_events/widgets/text_button.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  static const routeName = '/details-categorie';
  @override
  Widget build(BuildContext context) {
    // TODO: Get Data from out where in the form of A CATEGORY object
    final args = ModalRoute.of(context)!.settings.arguments;
    String s = '';
    if (args != null) s = args.toString();
    // final category = Provider.of<CategoriesRepo>(context).getCategorieById(s);

    return FutureBuilder(
        future: CategoryService.instance.getAsSnapshot(s),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          Category category = Category.fromMap2(snapshot.data!);
          return Scaffold(
            body: ListView(
              children: [
                WebAppBar(2),
                SubSlide(
                  image: 'assets/images/first.png',
                  text: category.name,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.07,
                  ),
                  child: Column(
                    children: [
                      vBox20(),
                      HeaderLine(
                        header: 'Category > ${category.name}'.toUpperCase(),
                      ),
                      vBox60(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Text(
                          category.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      vBox80(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AppTextButton(
                            text: 'Obtenir un dévis',
                            color: Theme.of(context).primaryColor,
                            handler: () {
                              Navigator.of(context)
                                  .pushNamed(BookingPage.routeName);
                            },
                          ),
                          // AppButton(
                          //   text: 'Booker',
                          //   color: Theme.of(context).primaryColor,
                          //   handler: () {
                          //     Navigator.of(context)
                          //         .pushNamed(BookingPage.routeName);
                          //   },
                          // ),
                        ],
                      ),
                      vBox60(),
                      CategoryPresenterGrid(
                        categoryId: category.id,
                      ),
                    ],
                  ),
                ),
                vBox60(),
                SocialHandle(),
                vBox60(),
                WebFooter(handler: () {}),
              ],
            ),
          );
        });
  }
}
