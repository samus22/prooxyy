import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prooxyy_events/models/booking.dart';
import 'package:prooxyy_events/models/category.dart';
// import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/pages/category.dart';
import 'package:prooxyy_events/services/category.dart';
import 'package:provider/provider.dart';

class CategoryGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final services = Provider.of<CategoriesRepo>(context, listen: false).items;

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

          List<Category> categories = snapshot.data!.docs.map((e) => Category.fromMap2(e)).toList();
          print('Category grid : $categories');
          
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 3 / 2,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
            ),
            itemCount: categories.length,
            shrinkWrap: true,
            itemBuilder: (ctx, index) => InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  CategoryPage.routeName,
                  arguments: categories[index].id, // services[index].id,
                );
              },
              child: Stack(
                children: [
                  Container(
                    height: 320,
                    width: double.infinity,
                    child: Image.asset(
                      categories[index].imageUrl, // services[index].imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 320,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.6),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: Container(
                      // height: 80,
                      width: 220,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        border: Border.all(
                          width: 3.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        categories[index].name, // services[index].name,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
