import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prooxyy_events/models/variable.dart';

class VariableService {

  VariableService._();
  static VariableService get instance => VariableService._();

  CollectionReference _c =
      FirebaseFirestore.instance.collection('variables');

  Future<void> add(Variable setting) async {
    return _c
        .add(setting.toMap())
        .then((value) => print("Setting added"))
        .catchError((error) => print("Failed to add setting: $error"));
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
  Future<void> update(String id, Variable entity) {
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