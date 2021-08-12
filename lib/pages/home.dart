import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/widgets/appbar.dart';
import 'package:prooxyy_events/widgets/catalog_page_form.dart';
import 'package:prooxyy_events/widgets/category_bloc.dart';
import 'package:prooxyy_events/widgets/comment_bloc.dart';
import 'package:prooxyy_events/widgets/footer.dart';
import 'package:prooxyy_events/widgets/image_bloc.dart';
import 'package:prooxyy_events/widgets/slider.dart';
import 'package:prooxyy_events/widgets/social_handle.dart';

class Home extends StatelessWidget {
  static const routeName = '/';
  void handler() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          WebAppBar(0),
          WebSlider(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.07,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'DE LA PLACE DANS VOS COEURS POUR',
                      style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'l\'iNoubLiaBle',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'Stay Classy',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80.0,
                ),
                // CatalogPageForm(),
                // vBox80(),
                ImageBloc(),
                vBox80(),
                headerText('Un aperçu de notre travail', size: 50.0),
                vBox80(),
                CategoryBloc(),
                vBox80(),
                headerText('Ils disent aussi de nous. . .', size: 50.0),
                vBox80(),
                CommentBloc(),
                vBox80(),
                SocialHandle(),
                vBox60(),
              ],
            ),
          ),
          WebFooter(
            handler: handler,
          ),
        ],
      ),
    ));
  }
}
