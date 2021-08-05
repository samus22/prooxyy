import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/models/quote.dart';
import 'package:http/http.dart' as http;
import 'package:prooxyy_events/services/dao.dart';

class QuoteService with ChangeNotifier implements Dao<Quote> {
  final String authToken;
  final String userId;

  QuoteService({required this.authToken, required this.userId});
  
  final String url = '';
  
  List<Quote> _items = [
    Quote(
      id: 'b1',
      // nomPrenom: 'Emily & Jason',
      category: 'Mariage',
      theme: 'UN MARIAGE FEERIQUE',
      town: 'Yaoundé',
      phoneNumber: '+237691812939',
      name: 'u1',
      done: true,
      status: Status.DONE,
      intendedPlaces: 200,
      quoteDocUrl: '', avatar: '',
    ),
    Quote(
      id: 'b1',
      // nomPrenom: 'Rachel & Alex',
      category: 'Mariage',
      theme: 'NATURE ET PLEIN AIR',
      town: 'Yaoundé',
      phoneNumber: '+237691812939',
      name: 'u3',
      done: true,
      status: Status.DONE,
      intendedPlaces: 200,
      quoteDocUrl: '', avatar: '',
    ),
    Quote(
      id: 'b1',
      // nomPrenom: 'Megan & Patrick',
      category: 'Mariage',
      theme: 'AMOUR & ROME ANTIQUE',
      town: 'Yaoundé',
      phoneNumber: '+237691812939',
      name: 'u2',
      done: true,
      status: Status.DONE,
      intendedPlaces: 200,
      quoteDocUrl: '', avatar: '',
    ),
    Quote(
      id: 'b1',
      // nomPrenom: 'Hannah & Chris',
      category: 'Mariage',
      theme: 'LES ANNEES 50, NOIR & BLANC',
      town: 'Yaoundé',
      phoneNumber: '+237691812939',
      name: 'u1',
      done: true,
      status: Status.DONE,
      intendedPlaces: 200,
      quoteDocUrl: '', avatar: '',
    ),
  ];

  List<Quote> _itemsUnique = [];

  List<Quote> get items => [..._items];

  List<Quote> get itemsUnique => [..._itemsUnique];

  Future<String> addQuoteUnique({
    required String id,
    required String avatar,
    required String category,
    required String theme,
    required String town,
    required String phoneNumber,
    required int nombreDePlace,
    required String name,
    required bool done,
    required Status status,
    required String devisDocUrl,
  }) async {
    var devis = Quote(
      id: id,
      category: category,
      theme: theme,
      town: town,
      phoneNumber: phoneNumber,
      name: name,
      done: done,
      quoteDocUrl: devisDocUrl,
      status: status,
      intendedPlaces: nombreDePlace,
      avatar: '',
    );
    String idE = '';
    try {
      // final response = await http.post(
      //   Uri.https(url, ''),
      //   body: devis.toJson(),
      // );
      // devis = devis.copyWith(id: json.decode(response.body)['name']);
      _items.add(devis);
      _itemsUnique.add(devis);
      notifyListeners();
      idE = id;
      return idE;
    } catch (e) {
      print(e);
      return idE;
    }
  }

  Future<bool> initAQuote(String id) async {
    var b = Quote(
      category: '',
      done: false,
      id: '',
      avatar: '',
      intendedPlaces: 0,
      phoneNumber: '',
      status: Status.PENDING,
      theme: '',
      name: '',
      town: '',
      quoteDocUrl: '',
    );
    try {
      final response = await http.get(Uri.https(url, ''));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((key, value) {
        b = Quote.fromMap(value, key);
      });
      _items.add(b);
      _itemsUnique.add(b);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteQuoteUnique(String id) async {
    final index = _itemsUnique.indexWhere((element) => element.id == id);
    var cat = _itemsUnique[index];
    _items.removeAt(index);
    _itemsUnique.removeAt(index);
    notifyListeners();
    try {
      // await http.delete(
      //   Uri.https(url, ''),
      //   body: cat.toJson(),
      // );
      return true;
    } catch (e) {
      _items.insert(index, cat);
      _itemsUnique.insert(index, cat);
      notifyListeners();
      print(e);
      return false;
    }
  }

  Future<bool> patchQuoteUnique({
    String? id,
    String? name,
    String? category,
    String? theme,
    String? town,
    String? phoneNumber,
    int? nombreDePlace,
    String? user,
    bool? done,
    Status? status,
    String? devisDocUrl,
  }) async {
    final index = _itemsUnique.indexWhere((element) => element.id == id);
    var book = _itemsUnique[index];
    book = book.copyWith(
      category: category,
      done: done,
      id: id,
      quoteDocUrl: devisDocUrl,
      nombreDePlace: nombreDePlace,
      phoneNumber: phoneNumber,
      status: status,
      theme: theme,
      name: name,
      town: town
    );
    try {
      // await http.patch(
      //   Uri.https(url, ''),
      //   body: book.toJson(),
      // );
      _items[index] = book;
      _itemsUnique[index] = book;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Quote getUniqueQuoteById(String id) =>
      _itemsUnique.firstWhere((element) => element.id == id);

  Future<bool> addQuote({
    required String id,
    required String nomPrenom,
    required String category,
    required String theme,
    required String town,
    required String phoneNumber,
    required int nombreDePlace,
    required String name,
    required bool done,
    required Status status,
    required String quoteDocUrl,
  }) async {
    var devis = Quote(
      id: id,
      category: category,
      theme: theme,
      town: town,
      phoneNumber: phoneNumber,
      name: name,
      done: done,
      quoteDocUrl: quoteDocUrl,
      status: status,
      intendedPlaces: nombreDePlace,
      avatar: '',
    );
    try {
      // final response = await http.post(
      //   Uri.https(url, ''),
      //   body: devis.toJson(),
      // );
      // devis = devis.copyWith(id: json.decode(response.body)['name']);
      _items.add(devis);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> initQuote(String id) async {
    List<Quote> list = [];
    try {
      final response = await http.get(Uri.https(url, ''));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((key, value) {
        list.add(Quote.fromMap(value, key));
      });
      _items = [...list];
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteQuote(String id) async {
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

  Future<bool> patchQuote({
    String? id,
    String? avatar,
    String? category,
    String? theme,
    String? town,
    String? phoneNumber,
    int? nombreDePlace,
    String? name,
    bool? done,
    Status? status,
    String? devisDocUrl,
  }) async {
    final index = _items.indexWhere((element) => element.id == id);
    var book = _items[index];
    book = book.copyWith(
      category: category,
      done: done,
      id: id,
      quoteDocUrl: devisDocUrl,
      avatar: avatar,
      nombreDePlace: nombreDePlace,
      phoneNumber: phoneNumber,
      status: status,
      theme: theme,
      name: name,
      town: town,
    );
    try {
      // await http.patch(
      //   Uri.https(url, ''),
      //   body: book.toJson(),
      // );
      _items[index] = book;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Quote getQuoteById(String id) =>
      _items.firstWhere((element) => element.id == id);

  @override
  // TODO: implement COLLECTION
  String get COLLECTION => throw UnimplementedError();

  @override
  Future<void> add(Quote entity) {
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
  Future update(String id, Quote entity) {
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

class QuoteService2 {

  QuoteService2._();
  static QuoteService2 get instance => QuoteService2._();

  CollectionReference _c =
      FirebaseFirestore.instance.collection('category');

  Future<void> add(Quote quote) async {
    return _c
        .add(quote.toMap())
        .then((value) => print("Quote Added"))
        .catchError((error) => print("Failed to add quote: $error"));
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
  Future<void> update(String id, Quote entity) {
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

  Future<QuerySnapshot> getByUser(String userId) {
    return _c.where("user", isEqualTo: userId).get();
  }

  Future<DocumentSnapshot> getAsSnapshot(String id) {
    return _c.doc(id).get();
  }

}