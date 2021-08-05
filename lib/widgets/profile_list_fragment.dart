import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/models/user.dart';
// import 'package:prooxyy_events/models/booking.dart';
// import 'package:prooxyy_events/repositories/all_bookings.dart';
// import 'package:prooxyy_events/helpers/helpers.dart';

class ProfileListFragment extends StatelessWidget {
  final UserData user;
  ProfileListFragment(this.user);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        // shrinkWrap: true,
        children: [
          Text(
            'Mon Profil',
            style: TextStyle(
              letterSpacing: 3.0,
              fontFamily: 'Stay Classy',
              fontSize: 30.0,
            ),
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage(
                  user.profileUrl,
                ),
              ),
            ],
          ),
          vBox20(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              user.blocked
                  ? 'COMPTE DéSACTIVé'.toUpperCase()
                  : 'COMPTE ACTIF'.toUpperCase(),
              style: TextStyle(
                color: user.blocked ? Colors.red : Colors.green,
                letterSpacing: 2.0,
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Nom et prénom'.toUpperCase(),
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              '${user.firstName} ${user.lastName}',
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Numéro de téléphone'.toUpperCase(),
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              user.numTel,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          vBox60(),
        ],
      ),
    );
  }
}
