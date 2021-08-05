import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
// import 'package:prooxyy_events/models/user.dart';
// import 'package:prooxyy_events/repositories/all_users.dart';
import 'package:prooxyy_events/widgets/favorites_list_fragment.dart';
// import 'package:prooxyy_events/widgets/Favoris_fragment2.dart';
// import 'package:provider/provider.dart';

// import 'app_button.dart';

class FavoritesDetailsFragment extends StatefulWidget {
  @override
  _FavoritesDetailsFragmentState createState() => _FavoritesDetailsFragmentState();
}

class _FavoritesDetailsFragmentState extends State<FavoritesDetailsFragment> {
  bool _didChange = false;

  @override
  void didChangeDependencies() {
    if (!_didChange) {
      _didChange = true;
    }
    super.didChangeDependencies();
  }

  void _reload() {
    setState(() {
      _didChange = false;
    });
  }

  Widget build(BuildContext context) {
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
                              onPressed: _reload,
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
                    child: FavoritesListFragment(),
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
                child: Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
