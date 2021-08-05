import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prooxyy_events/models/asset.dart';

class AssetService {

  AssetService._();
  static AssetService get instance => AssetService._();

  CollectionReference _c =
      FirebaseFirestore.instance.collection('assets');

  Future<void> add(Asset theme) async {
    return _c
        .add(theme.toMap())
        .then((value) => print("Asset added"))
        .catchError((error) => print("Failed to add asset: $error"));
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
  Future<void> update(String id, Asset entity) {
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