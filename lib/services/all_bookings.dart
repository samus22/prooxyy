import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// Helpers
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/models/booking.dart';

// Firebase
import 'package:cloud_firestore/cloud_firestore.dart'; 

import 'package:http/http.dart' as http;

/// Presents all booking repository
class AllBookingRepo with ChangeNotifier {
  final String authToken;
  final String userId;

  AllBookingRepo({required this.authToken, required this.userId});

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final String url = '';
  List<Booking> _items = [
    Booking(
      id: 'b1',
      name: 'Emily & Jason',
      category: 'Mariage',
      categoryId: 'Mariage',
      theme: 'UN MARIAGE FEERIQUE',
      town: 'Yaoundé',
      budget: 5000000,
      phoneNumber: '+237691812939',
      user: 'u1',
      done: true,
      status: Status.DONE,
      public: true,
      targetCapacity: 200,
      mediaUrl: ['assets/images/mar2.jpg'],
    ),
    Booking(
      id: 'b1',
      name: 'Rachel & Alex',
      category: 'Mariage',
      categoryId: 'Mariage',
      theme: 'NATURE ET PLEIN AIR',
      town: 'Yaoundé',
      budget: 5000000,
      phoneNumber: '+237691812939',
      user: 'u3',
      done: true,
      status: Status.DONE,
      public: true,
      targetCapacity: 200,
      mediaUrl: ['assets/images/mar3.jpg'],
    ),
    Booking(
      id: 'b1',
      name: 'Megan & Patrick',
      category: 'Mariage',
      categoryId: 'Mariage',
      theme: 'AMOUR & ROME ANTIQUE',
      town: 'Yaoundé',
      budget: 5000000,
      phoneNumber: '+237691812939',
      user: 'u2',
      done: true,
      status: Status.DONE,
      public: true,
      targetCapacity: 200,
      mediaUrl: ['assets/images/mar4.jpg'],
    ),
    Booking(
      id: 'b1',
      name: 'Hannah & Chris',
      category: 'Mariage',
      categoryId: 'Mariage',
      theme: 'LES ANNEES 50, NOIR & BLANC',
      town: 'Yaoundé',
      budget: 5000000,
      phoneNumber: '+237691812939',
      user: 'u1',
      done: true,
      status: Status.DONE,
      public: true,
      targetCapacity: 200,
      mediaUrl: ['assets/images/mar1.jpg'],
    ),
  ];

  List<Booking> _itemsUnique = [];

  List<Booking> _catalogueItems = [];

  List<Booking> get items => [..._items];

  List<Booking> get itemsUnique => [..._itemsUnique];

  List<Booking> get catalogueItems => [..._catalogueItems];

  Future<String> addBookingUnique({
    required String id,
    required String name,
    required String category,
    required String categoryId,
    required String theme,
    required String town,
    required double budget,
    required String phoneNumber,
    required int targetCapacity,
    required String user,
    required bool done,
    required Status status,
    required bool public,
    required List<String> mediaUrl,
  }) async {
    var booking = Booking(
      id: id,
      name: name,
      category: category,
      categoryId: categoryId,
      theme: theme,
      town: town,
      budget: budget,
      phoneNumber: phoneNumber,
      user: user,
      done: done,
      status: status,
      public: public,
      targetCapacity: targetCapacity,
      mediaUrl: mediaUrl,
    );
    String idE = '';
    try {
      // final response = await http.post(
      //   Uri.https(url, ''),
      //   body: booking.toJson(),
      // );
      // booking = booking.copyWith(id: json.decode(response.body)['name']);
      // idE = json.decode(response.body)['name']
      _items.add(booking);
      _itemsUnique.add(booking);
      final index =
          _catalogueItems.indexWhere((element) => element.id == booking.id);
      if (index < 0 && booking.done == true && booking.status == Status.DONE) {
        _catalogueItems.add(booking);
      }
      notifyListeners();
      idE = id;
      return idE;
    } catch (e) {
      print(e);
      return idE;
    }
  }

  Future<bool> initABooking(String id) async {
    Booking b = Booking(
      budget: 0.0,
      category: '',
      categoryId: '',
      done: false,
      id: '',
      name: '',
      targetCapacity: 0,
      phoneNumber: '',
      public: true,
      status: Status.PENDING,
      theme: '',
      user: '',
      town: '',
      mediaUrl: [],
    );
    try {
      final response = await http.get(Uri.https(url, ''));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((key, value) {
        b = Booking.fromMap(value);
      });
      _itemsUnique.add(b);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteBookingUnique(String id) async {
    final index = _itemsUnique.indexWhere((element) => element.id == id);
    try {
      // await http.delete(
      //   Uri.https(url, ''),
      //   body: cat.toJson(),
      // );
      _items.removeAt(index);
      _itemsUnique.removeAt(index);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> patchBookingUnique({
    String? id,
    String? name,
    String? category,
    String? theme,
    String? town,
    double? budget,
    String? phoneNumber,
    int? targetCapacity,
    String? user,
    bool? done,
    Status? status,
    bool? public,
    List<String>? mediaUrl,
  }) async {
    final index = _itemsUnique.indexWhere((element) => element.id == id);
    var book = _itemsUnique[index];
    book = book.copyWith(
      budget: budget,
      category: category,
      done: done,
      id: id,
      mediaUrl: mediaUrl,
      name: name,
      targetCapacity: targetCapacity,
      phoneNumber: phoneNumber,
      publique: public,
      status: status,
      theme: theme,
      user: user,
      town: town
    );
    try {
      // await http.patch(
      //   Uri.https(url, ''),
      //   body: book.toJson(),
      // );
      _itemsUnique[index] = book;
      final index2 =
          _catalogueItems.indexWhere((element) => element.id == book.id);
      if (index2 >= 0) {
        _catalogueItems[index2] = book;
        if (book.status != Status.DONE || !book.done)
          _catalogueItems.removeAt(index);
        print('Catalogue Update');
      }
      final index3 = _items.indexWhere((element) => element.id == book.id);
      if (index3 >= 0 && _items[index3].id == book.id) {
        _items[index3] = book;
      }
      if (book.done == true && book.status == Status.DONE && index2 < 0) {
        _catalogueItems.add(book);
      }
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Booking getUniqueBookingById(String id) =>
      _itemsUnique.firstWhere((element) => element.id == id);

  Future<bool> addBooking({
    required String id,
    required String name,
    required String category,
    required String categoryId,
    required String theme,
    required String ville,
    required double budget,
    required String phoneNumber,
    required int targetCapacity,
    required String user,
    required bool done,
    required Status status,
    required bool public,
    required List<String> mediaUrl,
  }) async {
    var booking = Booking(
      id: id,
      name: name,
      category: category,
      categoryId: categoryId,
      theme: theme,
      town: ville,
      budget: budget,
      phoneNumber: phoneNumber,
      user: user,
      done: done,
      status: status,
      public: public,
      targetCapacity: targetCapacity,
      mediaUrl: mediaUrl,
    );
    try {
      // final response = await http.post(
      //   Uri.https(url, ''),
      //   body: booking.toJson(),
      // );
      // booking = booking.copyWith(id: json.decode(response.body)['name']);
      _items.add(booking);
      final index2 =
          _catalogueItems.indexWhere((element) => element.id == booking.id);
      if (index2 >= 0 && _catalogueItems[index2].id == booking.id) {
        _catalogueItems[index2] = booking;
      }
      if (booking.done == true && booking.status == Status.DONE && index2 < 0) {
        _catalogueItems.add(booking);
      }
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> initBooking(String id) async {
    List<Booking> list = [];
    try {
      final response = await http.get(Uri.https(url, ''));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((key, value) {
        list.add(Booking.fromMap(value));
      });
      _items = [...list];
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteBooking(String id) async {
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

  Future<bool> patchBooking({
    required String id,
    String? name,
    String? category,
    String? theme,
    String? town,
    double? budget,
    String? phoneNumber,
    int? targetCapacity,
    String? user,
    bool? done,
    Status? status,
    bool? public,
    List<String>? mediaUrl,
  }) async {
    final index = _items.indexWhere((element) => element.id == id);
    var book = _items[index];
    book = book.copyWith(
      budget: budget,
      category: category,
      done: done,
      id: id,
      mediaUrl: mediaUrl,
      name: name,
      targetCapacity: targetCapacity,
      phoneNumber: phoneNumber,
      publique: public,
      status: status,
      theme: theme,
      user: user,
      town: town
    );
    try {
      // await http.patch(
      //   Uri.https(url, ''),
      //   body: book.toJson(),
      // );
      _items[index] = book;
      final index2 =
          _catalogueItems.indexWhere((element) => element.id == book.id);
      if (index2 >= 0 && _catalogueItems[index2].id == book.id) {
        _catalogueItems[index2] = book;
      }
      final index3 =
          _itemsUnique.indexWhere((element) => element.id == book.id);
      if (index3 >= 0 && _itemsUnique[index3].id == book.id) {
        _itemsUnique[index3] = book;
      }
      if (book.done == true && book.status == Status.DONE && index2 < 0) {
        _catalogueItems.add(book);
      }
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Booking getBookingById(String id) =>
      _items.firstWhere((element) => element.id == id);

  List<Booking> getBookingByCategoryName(String name) {
    final List<Booking> list = [];
    _items.forEach((element) {
      if (element.category == name) list.add(element);
    });
    return list;
  }

  Future<bool> addCatalogueItem({
    required String id,
    required String name,
    required String category,
    required String categoryId,
    required String theme,
    required String town,
    required double budget,
    required String phoneNumber,
    required int targetCapacity,
    required String user,
    required bool done,
    required Status status,
    required bool public,
    required List<String> mediaUrl,
  }) async {
    var booking = Booking(
      id: id,
      name: name,
      category: category,
      categoryId: categoryId,
      theme: theme,
      town: town,
      budget: budget,
      phoneNumber: phoneNumber,
      user: user,
      done: done,
      status: status,
      public: public,
      targetCapacity: targetCapacity,
      mediaUrl: mediaUrl,
    );
    try {
      // final response = await http.post(
      //   Uri.https(url, ''),
      //   body: booking.toJson(),
      // );
      // booking = booking.copyWith(id: json.decode(response.body)['name']);
      _catalogueItems.add(booking);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> initCatalogueItems(String id) async {
    List<Booking> list = [];
    try {
      final response = await http.get(Uri.https(url, ''));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((key, value) {
        list.add(Booking.fromMap(value));
      });
      _catalogueItems = [...list];
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteCatalogueItem(String id) async {
    final index = _catalogueItems.indexWhere((element) => element.id == id);
    var cat = _catalogueItems[index];
    _catalogueItems.removeAt(index);
    notifyListeners();
    try {
      // await http.delete(
      //   Uri.https(url, ''),
      //   body: cat.toJson(),
      // );
      return true;
    } catch (e) {
      _catalogueItems.insert(index, cat);
      notifyListeners();
      print(e);
      return false;
    }
  }

  Future<bool> patchCatalogueItem({
    required String id,
    String? name,
    String? category,
    String? theme,
    String? town,
    double? budget,
    String? phoneNumber,
    int? targetCapacity,
    String? user,
    bool? done,
    Status? status,
    bool? public,
    List<String>? mediaUrl,
  }) async {
    final index = _catalogueItems.indexWhere((element) => element.id == id);
    var book = _catalogueItems[index];
    book = book.copyWith(
      budget: budget,
      category: category,
      done: done,
      id: id,
      mediaUrl: mediaUrl,
      name: name,
      targetCapacity: targetCapacity,
      phoneNumber: phoneNumber,
      publique: public,
      status: status,
      theme: theme,
      user: user,
      town: town,
    );
    try {
      // await http.patch(
      //   Uri.https(url, ''),
      //   body: book.toJson(),
      // );
      _catalogueItems[index] = book;
      final index2 = _items.indexWhere((element) => element.id == book.id);
      if (index2 >= 0 && _items[index2].id == book.id) {
        _items[index2] = book;
      }
      final index3 =
          _itemsUnique.indexWhere((element) => element.id == book.id);
      if (index3 >= 0 && _itemsUnique[index3].id == book.id) {
        _itemsUnique[index3] = book;
      }
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Booking getCatalogueItemsById(String id) =>
      _catalogueItems.firstWhere((element) => element.id == id);

  List<Booking> getCatalogueItemsByCategoryName(String name) {
    final List<Booking> list = [];
    _catalogueItems.forEach((element) {
      if (element.category == name) list.add(element);
    });
    return list;
  }

  List<Booking> getVisibleCatalogueItemsByCategoryName(String name) {
    final List<Booking> list = [];
    _catalogueItems.forEach((element) {
      if (element.category == name &&
          element.done == true &&
          element.status == Status.DONE) list.add(element);
    });
    return list;
  }
}
