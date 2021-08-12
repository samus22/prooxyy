import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/models/asset.dart';
import 'package:prooxyy_events/services/asset.dart';

class TeamGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AssetService.instance.getAll(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingIndicator(
                  indicatorType: Indicator.ballPulse,
                  colors: const [Colors.orange, Colors.amber, Colors.yellow],
                  strokeWidth: 2,
                  pathBackgroundColor: Colors.black
            );
          }

          List<Asset> assets = snapshot.data!.docs.map((doc) => Asset.fromMap2(doc)).toList();

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
            ),
            itemCount: assets.length,
            shrinkWrap: true,
            itemBuilder: (ctx, index) => Container(
              height: 320,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: Image.asset(
                      assets[index].media,
                      fit: BoxFit.cover,
                    ),
                  ),
                  vBox20(),
                  Text(
                    assets[index].name,
                    style: TextStyle(
                      fontFamily: 'Stay Classy',
                      fontSize: 40.0,
                      color: Theme.of(context).accentColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 100,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Text(
                      assets[index].description,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 13.0,
                        // overflow: TextOverflow.clip,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
