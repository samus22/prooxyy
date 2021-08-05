import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
// import 'package:x_icon/x_icon.dart';

class SocialHandle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'ECRIVEZ NOUS SUR',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        hBox20(),
        ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 40,
              width: 40,
              child: Image.asset(
                'assets/images/instagram.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        hBox20(),
        ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 45,
              width: 45,
              child: Image.asset(
                'assets/images/facebook.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        hBox20(),
        ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 40,
              width: 40,
              child: Image.asset(
                'assets/images/whatsapp.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        hBox20(),
        ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 40,
              width: 40,
              child: Image.asset(
                'assets/images/mail.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        hBox20(),
        ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 40,
              width: 40,
              child: Image.asset(
                'assets/images/call.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
