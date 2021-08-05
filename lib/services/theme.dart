import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prooxyy_events/models/theme.dart';

import 'dao.dart';

class ThemeService {

  ThemeService._();
  static ThemeService get instance => ThemeService._();

  CollectionReference _c =
      FirebaseFirestore.instance.collection('theme');

  Future<void> add(Theme theme) async {
    return _c
        .add(theme.toMap())
        .then((value) => print("Theme added"))
        .catchError((error) => print("Failed to add theme: $error"));
  }

  Future<DocumentSnapshot> getAsSnapShot(String documentId) async {
    return _c.doc(documentId).get();
  }

  Future<QuerySnapshot> getAllAsSnapshot() async {
    return _c.get(); 
  }

  @override
  Future<void> delete(String id) {
    return _c.doc(id).delete();
  }

  @override
  Future<void> update(String id, Theme entity) {
    return _c.doc(id).update(entity.toMap());
  }

  String get COLLECTION => throw UnimplementedError();

  DocumentReference get(String id) {
    return _c.doc(id);
  }

  Future<QuerySnapshot> getAll() {
    return _c.get();
  }

  Future<DocumentSnapshot> getAsSnapshot(String id) {
    return _c.doc(id).get();
  }

}