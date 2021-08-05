import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:prooxyy_events/models/user.dart';
import 'package:http/http.dart' as http;

class AllUsersRepo with ChangeNotifier {
  final String authToken;
  final String userId;

  AllUsersRepo({required this.authToken, required this.userId});
  final String url = '';
  final String urlUnique = '';
  List<UserData> _items = [];

  UserData _user = UserData(
    blocked: false,
    id: '',
    nomPrenom: '',
    firstName: '',
    lastName: '',
    email: '',
    password: '',
    whatsappNumber: '',
    instagramLink: '',
    facebookLink: '',
    numTel: '',
    profileUrl: '',
    listeBooking: [],
    listeDevis: [],
    listeFavoris: [],
    serverId: '',
  );

  List<UserData> get items => [..._items];

  UserData get user => UserData(
        blocked: _user.blocked,
        id: _user.id,
        nomPrenom: _user.nomPrenom,
        firstName: '',
        lastName: '',
        email: '',
        password: '',
        whatsappNumber: '',
        instagramLink: '',
        facebookLink: '',
        numTel: _user.numTel,
        profileUrl: _user.profileUrl,
        listeBooking: _user.listeBooking,
        listeDevis: _user.listeDevis,
        listeFavoris: _user.listeFavoris,
        serverId: _user.serverId,
      );

  Future<void> addAUser(
    String nomPrenom,
    String profileUrl,
    String numTel,
    bool blocked,
    List<String> listeFavoris,
    List<String> listeDevis,
    List<String> listeBooking,
    String serverId,
  ) async {
    var u = UserData(
      blocked: blocked,
      id: DateTime.now().toString(),
      nomPrenom: nomPrenom,
      firstName: '',
      lastName: '',
      email: '',
      password: '',
      whatsappNumber: '',
      instagramLink: '',
      facebookLink: '',
      numTel: numTel,
      profileUrl: profileUrl,
      listeFavoris: listeFavoris,
      serverId: serverId,
    );
    try {
      // final response = await http.post(
      //   Uri.https(url, ''),
      //   body: u.toJson(),
      // );
      // String id = json.decode(response.body)['name'];
      // u = u.copyWith(id: id);
      _user = u;
      _items.add(u);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateAUser({
    String? id,
    String? nomPrenom,
    String? profileUrl,
    String? numTel,
    bool? blocked,
    List<String>? listeFavoris,
    List<String>? listeDevis,
    List<String>? listeBooking,
  }) async {
    final user = _user.copyWith(
      blocked: blocked,
      id: id,
      listeFavoris: listeFavoris,
      nomPrenom: nomPrenom,
      numTel: numTel,
      profileUrl: profileUrl,
    );
    try {
      // await http.patch(
      //   Uri.https(url, ''),
      // );
      _user = user;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addUser(
    String nomPrenom,
    String profileUrl,
    String numTel,
    bool blocked,
    String serverId,
    List<String> listeFavoris,
    List<Map<String, String>> listeDevis,
    List<Map<String, String>> listeBooking,
  ) async {
    var u = UserData(
      blocked: blocked,
      id: DateTime.now().toString(),
      nomPrenom: nomPrenom,
      firstName: '',
      lastName: '',
      email: '',
      password: '',
      whatsappNumber: '',
      instagramLink: '',
      facebookLink: '',
      numTel: numTel,
      profileUrl: profileUrl,
      listeFavoris: listeFavoris,
      serverId: serverId,
    );
    try {
      // final response = await http.post(
      //   Uri.https(url, ''),
      //   body: u.toJson(),
      // );
      // String id = json.decode(response.body)['name'];
      // u = u.copyWith(id: id);
      _items.add(u);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> initUser() async {
    List<UserData> list = [];
    try {
      final response = await http.get(Uri.https(url, ''));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((id, map) {
        list.add(UserData.fromMap(map, id));
      });
      _items = [...list];
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUser({
    String? id,
    String? nomPrenom,
    String? profileUrl,
    String? numTel,
    bool? blocked,
    List<String>? listeFavoris,
    List<Map<String, String>>? listeDevis,
    List<Map<String, String>>? listeBooking,
  }) async {
    int index = _items.indexWhere((element) => element.id == id);
    var u = _items[index];
    u = u.copyWith(
      blocked: blocked,
      id: id,
      listeFavoris: listeFavoris,
      nomPrenom: nomPrenom,
      numTel: numTel,
      profileUrl: profileUrl,
    );
    try {
      // await http.patch(
      //   Uri.https(url, ''),
      //   body: u.toJson(),
      // );
      _items[index] = u;
      if (u.id == user.id) {
        _user = _user.copyWith(
          blocked: u.blocked,
          nomPrenom: u.nomPrenom,
          numTel: u.numTel,
          profileUrl: u.profileUrl,
        );
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteUser(String id) async {
    final index = _items.indexWhere((element) => element.id == id);
    var cat = _items[index];
    _items.removeAt(index);
    notifyListeners();
    try {
      // await http.delete(
      //   Uri.https(url, ''),
      //   body: cat.toJson(),
      // );
    } catch (e) {
      _items.insert(index, cat);
      notifyListeners();
      print(e);
    }
  }

  UserData getUserById(String id) =>
      _items.firstWhere((element) => element.id == id);
}
