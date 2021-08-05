import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/pages/booking.dart';
import 'package:prooxyy_events/widgets/app_button.dart';
import 'package:prooxyy_events/widgets/text_button.dart';

class ServiceTile extends StatelessWidget {
  final int isZero;
  final String image;
  final String description;
  final String title;
  final bool isLast;

  ServiceTile({
    required this.isZero,
    required this.description,
    required this.image,
    required this.title,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.86;
    print(title == 'Spécial Saint Valentin');
    return Container(
      height: 400,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isZero == 0)
            Container(
              height: width * 0.275 * 0.7239,
              width: width * 0.275,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          if (isZero == 1)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerText(title, size: 60.0),
                vBox20(),
                Container(
                  width: width * 0.54,
                  child: Text(
                    description,
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AppTextButton(
                        text: 'Obtenir un dévis',
                        color: isLast
                            ? Theme.of(context).accentColor
                            : Theme.of(context).primaryColor,
                        handler: () {
                          Navigator.of(context)
                              .pushNamed(BookingPage.routeName);
                        },
                      ),
                      hBox80(),
                      AppButton(
                        text: 'Booker',
                        color: isLast
                            ? Theme.of(context).accentColor
                            : Theme.of(context).primaryColor,
                        handler: () {
                          Navigator.of(context)
                              .pushNamed(BookingPage.routeName);
                        },
                      ),
                    ],
                  ),
                ),
                vBox60(),
              ],
            ),
          const SizedBox(
            width: 40,
          ),
          if (isZero == 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerText(title, size: 60.0),
                vBox20(),
                Container(
                  width: width * 0.54,
                  child: Text(
                    description,
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AppTextButton(
                        text: 'Obtenir un dévis',
                        color: title == 'Spécial Saint Valentin'
                            ? Theme.of(context).accentColor
                            : Theme.of(context).primaryColor,
                        handler: () {},
                      ),
                      hBox80(),
                      AppButton(
                        text: 'Booker',
                        color: title == 'Spécial Saint Valentin'
                            ? Theme.of(context).accentColor
                            : Theme.of(context).primaryColor,
                        handler: () {},
                      ),
                    ],
                  ),
                ),
                vBox60(),
              ],
            ),
          if (isZero == 1)
            Container(
              height: width * 0.275 * 0.7239,
              width: width * 0.275,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }
}
