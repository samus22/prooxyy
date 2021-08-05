import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:prooxyy_events/models/theme.dart';
import 'package:http/http.dart' as http;

class ThemesRepo with ChangeNotifier {
  final String authToken;
  final String userId;

  ThemesRepo({required this.authToken, required this.userId});
  final String url = 'c.com';
  List<Theme> _items = [];

  List<Theme> get items => [..._items];

  Future<void> addCategory({
    required name,
    required imageUrl,
    required description,
  }) async {
    var cat = Theme(
      id: DateTime.now().toString(),
      name: name,
      description: description,
      imageUrl: imageUrl,
    );
    try {
      final response = await http.post(
        Uri.https(url, ''),
        body: cat.toJson(),
      );
      cat = cat.copyWith(
        id: json.decode(response.body)['name'],
      );
      _items.add(cat);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> patchTheme({
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
      await http.patch(
        Uri.https(url, ''),
        body: cat.toJson(),
      );
      _items[index] = cat;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteTheme(String id) async {
    final index = _items.indexWhere((element) => element.id == id);
    var cat = _items[index];
    _items.removeAt(index);
    notifyListeners();
    try {
      await http.delete(
        Uri.https(url, ''),
        body: cat.toJson(),
      );
    } catch (e) {
      _items.insert(index, cat);
      notifyListeners();
      print(e);
    }
  }

  Future<void> initTheme() async {
    List<Theme> list = [];
    try {
      final response = await http.get(Uri.https(url, ''));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((id, map) {
        list.add(Theme.fromMap(map, id));
      });
      _items = [...list];
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Theme getThemeById(String id) =>
      _items.firstWhere((element) => element.id == id);
}
