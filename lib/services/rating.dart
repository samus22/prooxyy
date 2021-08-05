import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:prooxyy_events/models/rating.dart';
import 'package:http/http.dart' as http;
import 'package:prooxyy_events/services/dao.dart';

class RatingService with ChangeNotifier implements Dao<Rating> {
  final String authToken;
  final String userId;

  RatingService({required this.authToken, required this.userId});
  final String url = 'c.com';
  List<Rating> _items = [
    Rating(
        id: 'co1',
        booking: 'b1',
        // categorie: 'Anniversaire',
        rater: 'Jones',
        ratedBy: 'Toto',
        comment:
            'Taccusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren',
        avatar: 'assets/images/pp.png',
        value: 3.74,
        ratedOn: DateTime.now(),
        category: '',
        // userName: 'Alex & Sofia',
        // theme: 'Mariage Féerique'),
    )
  ];

  List<Rating> get items => [..._items];

  Future<bool> addNote({
    required String id,
    required String booking,
    required String avatar,
    required String ratedBy,
    required String rater,
    required double value,
    required String comment,
    required DateTime ratedOn,
  }) async {
    var cat = Rating(
      id: id,
      category: '',
      booking: booking,
      avatar: avatar,
      rater: rater,
      value: value,
      comment: comment,
      ratedBy: ratedBy,
      ratedOn: ratedOn
    );
    try {
      // final response = await http.post(
      //   Uri.https(url, ''),
      //   body: cat.toJson(),
      // );
      // cat = cat.copyWith(
      //   id: json.decode(response.body)['name'],
      // );
      _items.add(cat);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> patchNote({
    String? id,
    String? booking,
    double? value,
    String? comment,
    DateTime? ratedOn,
  }) async {
    var cat = _items.firstWhere((element) => element.id == id);
    final index = _items.indexWhere((element) => element.id == id);
    cat = cat.copyWith(
      id: id,
      booking: booking,
      value: value,
      comment: comment,
      ratedOn: ratedOn
    );
    try {
      // await http.patch(
      //   Uri.https(url, ''),
      //   body: cat.toJson(),
      // );
      _items[index] = cat;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteNote(String id) async {
    final index = _items.indexWhere((element) => element.id == id);
    var cat = _items[index];
    _items.removeAt(index);
    notifyListeners();
    try {
      // await http.delete(
      //   Uri.https(url, ''),
      //   body: cat.toJson(),
      // );
      return true;
    } catch (e) {
      _items.insert(index, cat);
      notifyListeners();
      print(e);
      return false;
    }
  }

  Future<bool> initNote() async {
    List<Rating> list = [];
    try {
      final response = await http.get(Uri.https(url, ''));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((id, map) {
        list.add(Rating.fromMap(map, id));
      });
      _items = [...list];
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Rating getNoteById(String id) =>
      _items.firstWhere((element) => element.id == id);

  Rating getNoteByBookingId(String id) =>
      _items.firstWhere((element) => element.booking == id);

  List<Rating> getNoteByUserId(String id) {
    List<Rating> list = [];
    _items.forEach((element) {
      if (element.ratedBy == id) list.add(element);
    });
    return list;
  }

  @override
  // TODO: implement COLLECTION
  String get COLLECTION => throw UnimplementedError();

  @override
  Future<void> add(Rating entity) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future update(String id, Rating entity) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<QuerySnapshot<Object?>> getAllAsSnapshot() {
    // TODO: implement getAllAsSnapshot
    throw UnimplementedError();
  }

  @override
  Future<DocumentSnapshot<Object?>> getAsSnapshot(String id) {
    // TODO: implement getAsSnapshot
    throw UnimplementedError();
  }
}

class RatingService2 {

  RatingService2._();
  static RatingService2 get instance => RatingService2._();

  CollectionReference _c =
      FirebaseFirestore.instance.collection('rating');

  Future<void> add(Rating rating) async {
    return _c
        .add(rating.toMap())
        .then((value) => print("Rating Added"))
        .catchError((error) => print("Failed to add rating: $error"));
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
  Future<void> update(String id, Rating entity) {
    Map<String, dynamic> userDataMap = entity.toMap();
    String id = entity.id;
    userDataMap.remove('id');
    return _c.doc(id).update(userDataMap);
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

  Future<QuerySnapshot> getByUser(String userId) {
    return _c.where("userId", isEqualTo: userId).get();
  }

}