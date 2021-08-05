import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/models/category.dart';
import 'package:prooxyy_events/pages/category.dart';
import 'package:prooxyy_events/pages/portfolio.dart';
import 'package:prooxyy_events/services/category.dart';
import 'package:prooxyy_events/widgets/app_button.dart';
import 'package:provider/provider.dart';

class CategoryBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final list =
        Provider.of<CategoriesRepo>(context, listen: false).items.sublist(0, 3);

    CategoryService _categories = CategoryService.instance;

    return StreamBuilder<QuerySnapshot>(
        stream: _categories.getAllAsSnapshot().asStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          List<Category> categories =
              snapshot.data!.docs.map((e) => Category.fromMap2(e)).toList();
          List<Category> subList = categories.sublist(
              0, categories.length >= 3 ? 3 : categories.length);

          List<InkWell> blocks = subList
              .map((category) => InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        CategoryPage.routeName,
                        arguments: category.id,
                      );
                    },
                    child: Container(
                      height: (width - 50) / 3,
                      child: Stack(
                        children: [
                          Container(
                            height: (width - 50) / 3,
                            width: (width - 50) / 3,
                            child: Image.asset(
                              category.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: ((width - 50) / 6) - 80,
                            left: ((width - 50) / 6) - 140,
                            child: Container(
                              height: 80,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                border: Border.all(
                                  width: 5.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              child: Text(
                                category.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Stay Classy',
                                  fontSize: 30.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList();

          return Container(
            height: 500,
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        crossAxisSpacing: 20.0,
                      ),
                      children: blocks
                      // [
                      //   InkWell(
                      //     onTap: () {
                      //       Navigator.of(context).pushNamed(
                      //         CategoryPage.routeName,
                      //         arguments: list[0].id,
                      //       );
                      //     },
                      //     child: Container(
                      //       height: (width - 50) / 3,
                      //       child: Stack(
                      //         children: [
                      //           Container(
                      //             height: (width - 50) / 3,
                      //             width: (width - 50) / 3,
                      //             child: Image.asset(
                      //               list[0].imageUrl,
                      //               fit: BoxFit.cover,
                      //             ),
                      //           ),
                      //           Positioned(
                      //             top: ((width - 50) / 6) - 80,
                      //             left: ((width - 50) / 6) - 140,
                      //             child: Container(
                      //               height: 80,
                      //               width: 200,
                      //               decoration: BoxDecoration(
                      //                 color: Colors.black.withOpacity(0.5),
                      //                 border: Border.all(
                      //                   width: 5.0,
                      //                   color: Theme.of(context).primaryColor,
                      //                 ),
                      //               ),
                      //               child: Text(
                      //                 list[0].name,
                      //                 textAlign: TextAlign.center,
                      //                 style: TextStyle(
                      //                   fontFamily: 'Stay Classy',
                      //                   fontSize: 30.0,
                      //                   color: Colors.white,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),

                      //   InkWell(
                      //     onTap: () {
                      //       Navigator.of(context).pushNamed(
                      //         CategoryPage.routeName,
                      //         arguments: categories[1].id, // list[1].id,
                      //       );
                      //     },
                      //     child: Container(
                      //       height: (width - 50) / 3,
                      //       child: Stack(
                      //         children: [
                      //           Container(
                      //             height: (width - 50) / 3,
                      //             width: (width - 50) / 3,
                      //             child: Image.asset(
                      //               categories[1].imageUrl, // list[1].imageUrl,
                      //               fit: BoxFit.cover,
                      //             ),
                      //           ),
                      //           Positioned(
                      //             top: ((width - 50) / 6) - 80,
                      //             left: ((width - 50) / 6) - 120,
                      //             child: Container(
                      //               height: 80,
                      //               width: 200,
                      //               decoration: BoxDecoration(
                      //                 color: Colors.black.withOpacity(0.5),
                      //                 border: Border.all(
                      //                   width: 5.0,
                      //                   color: Theme.of(context).primaryColor,
                      //                 ),
                      //               ),
                      //               child: Text(
                      //                 categories[1].name, // list[1].name,
                      //                 textAlign: TextAlign.center,
                      //                 style: TextStyle(
                      //                   fontFamily: 'Stay Classy',
                      //                   fontSize: 30.0,
                      //                   color: Colors.white,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      //   InkWell(
                      //     onTap: () {
                      //       Navigator.of(context).pushNamed(
                      //         CategoryPage.routeName,
                      //         arguments: categories[2].id // list[2].id,
                      //       );
                      //     },
                      //     child: Container(
                      //       height: (width - 50) / 3,
                      //       child: Stack(
                      //         children: [
                      //           Container(
                      //             height: (width - 50) / 3,
                      //             width: (width - 50) / 3,
                      //             child: Image.asset(
                      //               categories[2].imageUrl, // list[2].imageUrl,
                      //               fit: BoxFit.cover,
                      //             ),
                      //           ),
                      //           Positioned(
                      //             top: ((width - 50) / 6) - 80,
                      //             left: ((width - 50) / 6) - 120,
                      //             child: Container(
                      //               height: 80,
                      //               width: 200,
                      //               decoration: BoxDecoration(
                      //                 color: Colors.black.withOpacity(0.5),
                      //                 border: Border.all(
                      //                   width: 5.0,
                      //                   color: Theme.of(context).primaryColor,
                      //                 ),
                      //               ),
                      //               child: Text(
                      //                 categories[2].name, // list[2].name,
                      //                 textAlign: TextAlign.center,
                      //                 style: TextStyle(
                      //                   fontFamily: 'Stay Classy',
                      //                   fontSize: 30.0,
                      //                   color: Colors.white,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ],
                      ),
                ),
                vBox20(),
                AppButton(
                  text: 'Voir Plus',
                  color: Theme.of(context).accentColor,
                  handler: () {
                    Navigator.of(context).pushNamed(PortfolioPage.routeName);
                  },
                ),
              ],
            ),
          );
        });
  }
}
