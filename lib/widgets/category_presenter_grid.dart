import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/models/booking.dart';
import 'package:prooxyy_events/models/category.dart';
import 'package:prooxyy_events/pages/catalog.dart';
import 'package:prooxyy_events/services/all_bookings.dart';
import 'package:prooxyy_events/services/booking.dart';
import 'package:prooxyy_events/services/category.dart';
// import 'package:prooxyy_events/repositories/categories.dart';
import 'package:provider/provider.dart';

class CategoryPresenterGrid extends StatelessWidget {
  final String categoryId;

  CategoryPresenterGrid({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    // final list = Provider.of<AllBookingRepo>(context)
    //     .getCatalogueItemsByCategoryName(name);
    // final cat = Provider.of<CategoriesRepo>(context, listen: false)
    //     .getCategorieByName(name);
    // print(list);

    // CategoryService _categories = CategoryService.instance;
    // BookingService _bookings = BookingService.instance;
    
    // Category? category;
    // _categories.get(name).get().then((DocumentSnapshot doc) => {
    //   category = Category.fromMap2(doc)
    // });

    // String categoryId = category?.id ?? "";

    return StreamBuilder<QuerySnapshot>(
        stream: BookingService.instance.getByCategoryAndStatus(categoryId, Status.DONE).asStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          List<Booking> bookings =
              snapshot.data!.docs.map((e) => Booking.fromMap2(e)).toList();
          print('Bookings in the presenter grid: $bookings');

          return bookings.length < 1 // list.length < 1
              ? Container()
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 100.0,
                  ),
                  itemCount: bookings.length, // list.length,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) => InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        CatalogPage.routeName,
                        arguments: bookings[index].id, // list[index].id,
                      );
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 400,
                            child: Image.asset(
                              'assets/images/mar3.jpg',
                              // bookings[index].mediaUrl.length < 1 // [index].mediaUrl.length < 1
                              //     ? cat.imageUrl
                              //     : bookings[index].mediaUrl[0], // list[index].mediaUrl[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                          vBox20(),
                          Text(
                            bookings[index].name, // list[index].name,
                            style: TextStyle(
                              fontFamily: 'Dancing',
                              fontSize: 60.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          vBox20(),
                          Container(
                            height: 100,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: Text(
                              bookings[index].theme.toUpperCase(), // list[index].theme.toUpperCase(),
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 20.0,
                                // overflow: TextOverflow.clip,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        });
  }
}
