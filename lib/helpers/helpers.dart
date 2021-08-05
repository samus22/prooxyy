import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

Widget vBox20() {
  return SizedBox(
    height: 20,
  );
}

Widget vBox80() {
  return SizedBox(
    height: 80,
  );
}

Widget vBox60() {
  return SizedBox(
    height: 60,
  );
}

Widget hBox20() {
  return SizedBox(
    width: 20,
  );
}

Widget hBox60() {
  return SizedBox(
    width: 60,
  );
}

Widget hBox80() {
  return SizedBox(
    width: 80,
  );
}

Widget headerText(String text, {double size = 20.0}) => Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontFamily: 'Stay Classy',
        letterSpacing: 3.0,
      ),
    );

Widget headerTextAlt(String text, {double size = 20.0}) => Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: size,
        letterSpacing: 3.0,
        fontWeight: FontWeight.bold,
      ),
    );

enum Status { DONE, PENDING, REJECTED }

Status getStatus(String s) {
  if (s == 'DONE') return Status.DONE;
  if (s == 'PENDING')
    return Status.PENDING;
  else
    return Status.REJECTED;
}

List<Map<String, dynamic>> team = [
  {
    'name': 'Conseillers',
    'description':
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor inviduntut labore et dolore magna aliquyam erat, sed Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy ut labore et dolore',
    'media': 'assets/images/team.jpg',
  },
  {
    'name': 'Décorateurs Modernes',
    'description':
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor inviduntut labore et dolore magna aliquyam erat, sed Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy ut labore et dolore',
    'media': 'assets/images/deco_moderne.jpg',
  },
  {
    'name': 'Décorateurs Traditionels',
    'description':
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor inviduntut labore et dolore magna aliquyam erat, sed Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy ut labore et dolore',
    'media': 'assets/images/deco_mixte.jpg',
  },
  {
    'name': 'Salles de Fêtes',
    'description':
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor inviduntut labore et dolore magna aliquyam erat, sed Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy ut labore et dolore',
    'media': 'assets/images/salle.jpg',
  },
  {
    'name': 'Traiteurs Repas',
    'description':
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor inviduntut labore et dolore magna aliquyam erat, sed Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy ut labore et dolore',
    'media': 'assets/images/traiteur.jpg',
  },
  {
    'name': 'Traiteurs Désserts',
    'description':
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor inviduntut labore et dolore magna aliquyam erat, sed Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy ut labore et dolore',
    'media': 'assets/images/traiteur2.jpg',
  },
  {
    'name': 'Photographes',
    'description':
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor inviduntut labore et dolore magna aliquyam erat, sed Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy ut labore et dolore',
    'media': 'assets/images/photographes.jpg',
  },
  {
    'name': 'Maquilleurs Pro',
    'description':
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor inviduntut labore et dolore magna aliquyam erat, sed Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy ut labore et dolore',
    'media': 'assets/images/makeup.jpg',
  },
  {
    'name': 'Graphistes',
    'description':
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor inviduntut labore et dolore magna aliquyam erat, sed Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy ut labore et dolore',
    'media': 'assets/images/graphistes.jpg',
  },
  {
    'name': 'Figurant(e) & Protocol',
    'description':
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor inviduntut labore et dolore magna aliquyam erat, sed Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy ut labore et dolore',
    'media': 'assets/images/hotesse.jpeg',
  },
  {
    'name': 'Animateurs & DJ',
    'description':
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor inviduntut labore et dolore magna aliquyam erat, sed Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy ut labore et dolore',
    'media': 'assets/images/dj.png',
  },
];

/// Method which launches a select file dialog and uploads the file to Firestore Storage
/// 
void selectFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    PlatformFile file = result.files.first;

    try {
      await FirebaseStorage.instance
            .ref('uploads/${DateTime.now().millisecondsSinceEpoch}.${file.extension}')
            .putData(file.bytes!);
      } on FirebaseException catch (e) {
        print('Error $e');
      }
  } else {
    print('User canceled picker');
  }
}