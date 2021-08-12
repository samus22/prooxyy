import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:prooxyy_events/models/category.dart';
import 'package:prooxyy_events/services/category.dart';
import 'package:provider/provider.dart';

class CategoryListFragment extends StatefulWidget {
  final Function load;
  CategoryListFragment(this.load);

  @override
  _CategoryListFragmentState createState() => _CategoryListFragmentState();
}

class _CategoryListFragmentState extends State<CategoryListFragment> {
  List<Category> _list = [];
  bool _didChange = false;
  bool _multiSelection = true;
  List<int> _selection = [];
  bool _init = false;

  @override
  void didChangeDependencies() {
    if (!_didChange) {
      _list = Provider.of<CategoriesRepo>(context).items;
      _didChange = true;
    }
    super.didChangeDependencies();
  }

  Widget _buildTile() {
    _list = Provider.of<CategoriesRepo>(context).items;

    StreamSubscription c = CategoryService.instance.getAllAsSnapshot().asStream().listen((event) {
      print('updated data ${event.docs}');
    });

    return StreamBuilder<QuerySnapshot>(
        stream: CategoryService.instance.getAllAsSnapshot().asStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting && !_init) {
            return Text("Loading");
          }

          _init = true;

          List<Category> categories =
              snapshot.data!.docs.map((e) => Category.fromMap2(e)).toList();
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (ctx, index) => ListView(
              shrinkWrap: true,
              children: [
                _multiSelection ?
                CheckboxListTile(
                  onChanged: (value) {
                    if (value != null) {
                      print('index $index');
                      setState(() {
                        value ? _selection.add(index) : _selection.remove(index);
                        print('new selection $_selection $value');
                      });
                    }
                  },
                  value: this._selection.contains(index),
                  secondary: CircleAvatar(
                    backgroundColor: Colors.amber,
                    radius: 20.0,
                    backgroundImage: AssetImage(
                      categories[index].imageUrl, // _list[index].imageUrl,
                    ),
                  ),
                  title: Text(
                    categories[index].name, // _list[index].name,
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    categories[index].description, // _list[index].description,
                    style: TextStyle(
                      // overflow: TextOverflow.ellipsis,
                      letterSpacing: 1.2,
                    ),
                    maxLines: 2,
                  )
                )
                :
                ListTile(
                  onTap: () {
                    widget.load(categories[index].id); // widget.load(_list[index].id);
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.amber,
                    radius: 20.0,
                    backgroundImage: AssetImage(
                      categories[index].imageUrl, // _list[index].imageUrl,
                    ),
                  ),
                  title: Text(
                    categories[index].name, // _list[index].name,
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    categories[index].description, // _list[index].description,
                    style: TextStyle(
                      // overflow: TextOverflow.ellipsis,
                      letterSpacing: 1.2,
                    ),
                    maxLines: 2,
                  ),
                ),
                Divider(),
              ],
            ),
            itemCount: categories.length,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print('categories $_selection');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        // shrinkWrap: true,
        children: [
          Text(
            'Liste des Categories',
            style: TextStyle(
              letterSpacing: 3.0,
              fontFamily: 'Stay Classy',
              fontSize: 30.0,
            ),
            textAlign: TextAlign.start,
          ),
          _buildTile(),
        ],
      ),
    );
  }
}
