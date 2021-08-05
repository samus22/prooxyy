import 'package:flutter/cupertino.dart';
import 'package:prooxyy_events/helpers/helpers.dart';

// -- Model
import 'package:prooxyy_events/models/booking.dart';

// -- Firestore database
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prooxyy_events/services/dao.dart';


/// Repository for interacting with the database regarding the Booking model
class BookingService with ChangeNotifier implements Dao<Booking> {

  BookingService._();
  static BookingService get instance => BookingService._();

  CollectionReference _c =
      FirebaseFirestore.instance.collection('bookings');

  @override
  Future<void> add(Booking booking) async {
    print('Added booking $booking ${booking.status} ');
    return _c
        .add(booking.toMap())
        .then((value) => print("Booking Added"))
        .catchError((error) => print("Failed to add booking: $error"));
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
  Future<void> update(String id, Booking entity) {
    Map<String, dynamic> userDataMap = entity.toMap();
    String id = entity.id;
    userDataMap.remove('id');
    return _c.doc(id).update(userDataMap);
  }

  @override
  // TODO: implement COLLECTION
  String get COLLECTION => throw UnimplementedError();

  @override
  DocumentReference get(String id) {
    return _c.doc(id);
  }

  @override
  Future<QuerySnapshot> getAll() {
    return _c.get();
  }

  Stream<QuerySnapshot> stre() {
    return _c.snapshots();
  }

  Future<DocumentSnapshot> getAsSnapshot(String id) {
    return _c.doc(id).get();
  }

  Future<QuerySnapshot> getByCategory(String categoryId) {
    return _c.where("categoryId", isEqualTo: categoryId).get();
  }

  Future<QuerySnapshot> getByCategoryAndStatus(String categoryId, Status status) {
    return _c.where("categoryId", isEqualTo: categoryId).where('status', isEqualTo: status.toString().split('.').last).get();
  }

  Future<QuerySnapshot> getByUser(String userId) {
    return _c.where("userId", isEqualTo: userId).get();
  }

  Future<QuerySnapshot> getByFavorites(List<String> favoriteBookings) {
    return _c.where("id", arrayContainsAny: favoriteBookings).get();
  }

  // Future<int> getCount() {
  //   return _c.snapshots().length;
  // }

  // Future<int> getCountByTown() {}

  // Future<int> getCountByEnterprise() {}

  // Future<int> getCountByTown() {
  //   _c.
  // }

}
