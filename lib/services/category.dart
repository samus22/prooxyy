import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:prooxyy_events/models/category.dart';
import 'package:http/http.dart' as http;

/// Class which contains methods used to interact with Firestore Database
class CategoriesRepo with foundation.ChangeNotifier {
  final String authToken;
  final String userId;

  CategoriesRepo({required this.authToken, required this.userId});
  final String url = 'c.com';
  
  List<Category> _items = [
    Category(
      id: 'c1',
      description:
          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor inviduntut labore et dolore magna aliquyam erat, sed Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy ut labore et dolore',
      imageUrl: 'assets/images/mar_out.jpg',
      name: 'Mariages',
    ),
    Category(
      id: 'c2',
      description:
          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor inviduntut labore et dolore magna aliquyam erat, sed Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy ut labore et dolore',
      imageUrl: 'assets/images/birth.jpg',
      name: 'Anniversaires',
    ),
    Category(
      id: 'c3',
      description:
          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor inviduntut labore et dolore magna aliquyam erat, sed Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy ut labore et dolore',
      imageUrl: 'assets/images/event_entreprise.jpg',
      name: 'Entreprises',
    ),
    Category(
      id: 'c4',
      description:
          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor inviduntut labore et dolore magna aliquyam erat, sed Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy ut labore et dolore',
      imageUrl: 'assets/images/wine.jpg',
      name: 'Soirées Caritatives',
    ),
    Category(
      id: 'c5',
      description:
          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor inviduntut labore et dolore magna aliquyam erat, sed Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy ut labore et dolore',
      imageUrl: 'assets/images/funerailles.jpg',
      name: 'Obsèques & Funérailles',
    ),
    Category(
      id: 'c6',
      description:
          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor inviduntut labore et dolore magna aliquyam erat, sed Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy ut labore et dolore',
      imageUrl: 'assets/images/out_event.jpg',
      name: 'Spectacles',
    ),
    Category(
      id: 'c7',
      description:
          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor inviduntut labore et dolore magna aliquyam erat, sed Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy ut labore et dolore',
      imageUrl: 'assets/images/valentine.jpg',
      name: 'Spécial Saint Valentin',
    ),
  ];

  List<Category> get items => [..._items];

  Future<bool> addCategory({
    required name,
    required imageUrl,
    required description,
  }) async {
    var cat = Category(
      id: DateTime.now().toString(),
      name: name,
      description: description,
      imageUrl: imageUrl,
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

  Future<bool> patchCategorie({
    required String id,
    String? name,
    String? description,
    String? imageUrl,
  }) async {
    var cat = _items.firstWhere((element) => element.id == id);
    final index = _items.indexWhere((element) => element.id == id);
    cat = cat.copyWith(
      name: name,
      id: id,
      description: description,
      imageUrl: imageUrl,
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

  Future<bool> deleteCategorie(String id) async {
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

  Future<bool> initCategorie() async {
    List<Category> list = [];
    try {
      final response = await http.get(Uri.https(url, ''));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((id, map) {
        list.add(Category.fromMap(map, id));
      });
      _items = [...list];
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Category getCategorieById(String id) =>
      _items.firstWhere((element) => element.id == id);

  Category getCategorieByName(String name) =>
      _items.firstWhere((element) => element.name == name);
}



/// Repository for interacting with the database regarding the Booking model
class CategoryService {

  CategoryService._();
  static CategoryService get instance => CategoryService._();

  CollectionReference _c =
      FirebaseFirestore.instance.collection('category');

  Future<void> add(Category category) async {
    return _c
        .add(category.toMap())
        .then((value) => print("Category Added"))
        .catchError((error) => print("Failed to add category: $error"));
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
  Future<void> update(String id, Category entity) {
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

}
