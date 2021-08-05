import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prooxyy_events/models/catalog.dart';

class CatalogService {

  CatalogService._();
  static CatalogService get instance => CatalogService._();

  CollectionReference _c =
      FirebaseFirestore.instance.collection('catalog');

  Future<void> add(Catalog theme) async {
    return _c
        .add(theme.toMap())
        .then((value) => print("Catalog added"))
        .catchError((error) => print("Failed to add catalog: $error"));
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
  Future<void> update(String id, Catalog entity) {
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