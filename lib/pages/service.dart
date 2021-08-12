import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

// -- Helpers
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/models/page_block.dart';
import 'package:prooxyy_events/services/page_block.dart';

// -- Services
import 'package:prooxyy_events/services/category.dart';

// -- Widgets
import 'package:prooxyy_events/widgets/appbar.dart';
import 'package:prooxyy_events/widgets/footer.dart';
import 'package:prooxyy_events/widgets/header_line.dart';
import 'package:prooxyy_events/widgets/service_tile.dart';
import 'package:prooxyy_events/widgets/social_handle.dart';
import 'package:provider/provider.dart';

class ServicesPage extends StatelessWidget {
  static const routeName = '/service-page';
  @override
  Widget build(BuildContext context) {
    bool zero = true;
    final items = Provider.of<CategoriesRepo>(context, listen: false).items;
    final List<Map<String, dynamic>> services = [];
    items.forEach((element) {
      services.add({
        'cat': element,
        'zero': zero ? 0 : 1,
        'last': false,
      });
      zero = !zero;
    });
    services[items.length - 1]['last'] = false;

    return FutureBuilder(
      future: PageBlockService.instance.getAll(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot
    ) {

      if (snapshot.hasError) {
        return Text('Error produced');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return LoadingIndicator(
              indicatorType: Indicator.ballPulse,
              colors: const [Colors.orange, Colors.amber, Colors.yellow],
              strokeWidth: 2,
              pathBackgroundColor: Colors.black
        );
      }

      List<PageBlock> assets = snapshot.data!.docs.map((document) => PageBlock.fromMap2(document)).toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            WebAppBar(1),
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/first.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 150 - 20,
                  left: (MediaQuery.of(context).size.width / 2) - 150,
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(349 / 360),
                    child: Container(
                      height: 80,
                      width: 350,
                      color: Theme.of(context).accentColor.withOpacity(0.5),
                    ),
                  ),
                ),
                Positioned(
                  top: 150 - 75,
                  left: (MediaQuery.of(context).size.width / 2) - 100,
                  child: Text(
                    'Nos Services',
                    style: TextStyle(
                      fontFamily: 'Stay Classy',
                      fontSize: 80.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            vBox20(),
            HeaderLine(header: 'NOS SERVICES'),
            vBox80(),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.07,
              ),
              child: Column(
                children: [
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
                  vBox60(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'DE LA PLACE DANS VOS PENSEES POUR',
                        style: TextStyle(
                          fontSize: 20.0,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(349 / 360),
                        child: Text(
                          'l\'irremplacable',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontFamily: 'Dancing',
                          ),
                        ),
                      ),
                    ],
                  ),
                  vBox80(),
                  ...services.asMap().entries
                      .map(
                        (e) => Column(
                          children: [
                            ServiceTile(
                              isZero: e.key % 2, // e['zero'],
                              description: e.value['cat'].description!,
                              image: e.value['cat'].imageUrl!,
                              title: e.value['cat'].name!,
                              isLast: services.length - 1 == e.key, // e['last'],
                            ),
                            if (services.length - 1 == e.key /* !e['last'] */) Divider(),
                            if (services.length - 1 == e.key /* !e['last'] */) vBox60(),
                          ],
                        ),
                      )
                      .toList(),
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
    });
  }
}
