import 'package:flutter/material.dart';
// import 'package:prooxyy_events/helpers/helpers.dart';
// import 'package:prooxyy_events/pages/details_categorie.dart';
// import 'package:prooxyy_events/repositories/categories.dart';
// import 'package:provider/provider.dart';

class CatalogGrid extends StatelessWidget {
  final List<String> images;
  CatalogGrid(this.images);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
      ),
      itemCount: images.length,
      shrinkWrap: true,
      itemBuilder: (ctx, index) => InkWell(
        onTap: () {
          // Navigator.of(context).pushNamed(
          //   DetailCategoriesPage.routName,
          //   arguments: services[index].id,
          // );
        },
        child: Container(
          height: 320,
          width: double.infinity,
          child: Image.asset(
            images[index],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
