import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String id;
  final String serverId;
  final String nomPrenom;
  final String profileUrl;
  final String numTel;
  final bool blocked;

  final String firstName;
  final String lastName;

  // -- User credentials
  final String email;
  // final String username;
  final String password;

  final String whatsappNumber;
  final String instagramLink;
  final String facebookLink;

  List<String> listeFavoris = [];
  List<String> listeDevis = [];
  List<String> listeBooking = [];

  UserData({
    required this.id,
    required this.nomPrenom,
    required this.profileUrl,
    required this.firstName,
    required this.lastName,
    required this.whatsappNumber,
    required this.instagramLink,
    required this.facebookLink,
    required this.email,
    required this.password,
    required this.numTel,
    required this.blocked,
    required this.serverId,
    this.listeBooking = const [],
    this.listeDevis = const [],
    this.listeFavoris = const [],
  });

  UserData copyWith({
    String? id,
    String? nomPrenom,
    String? firstName,
    String? lastName,
    String? profileUrl,
    String? numTel,
    String? whatsappNumber,
    String? facebookLink,
    String? instagramLink,
    String? email,
    String? password,
    bool? blocked,
    String? serverId,
    List<String>? listeFavoris,
    List<String>? listeDevis,
    List<String>? listeBooking,
  }) {
    return UserData(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      nomPrenom: nomPrenom ?? this.nomPrenom,
      profileUrl: profileUrl ?? this.profileUrl,
      email: email ?? this.email,
      password: password ?? this.password,
      numTel: numTel ?? this.numTel,
      blocked: blocked ?? this.blocked,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      facebookLink: facebookLink ?? this.facebookLink,
      instagramLink: instagramLink ?? this.instagramLink,
      listeBooking: listeBooking ?? this.listeBooking,
      listeDevis: listeDevis ?? this.listeDevis,
      listeFavoris: listeFavoris ?? this.listeFavoris,
      serverId: serverId ?? this.serverId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'nomPrenom': nomPrenom,
      'profileUrl': profileUrl,
      'numTel': numTel,
      'blocked': blocked,
      'listeBooking': listeBooking,
      'listeDevis': listeDevis,
      'listeFavoris': listeFavoris,
      'serverId': serverId,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map, String id) {
    return UserData(
      id: id,
      nomPrenom: map['nomPrenom'],
      profileUrl: map['profileUrl'],
      numTel: map['numTel'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      whatsappNumber: map['whatsappNumber'],
      facebookLink: map['facebookLink'],
      instagramLink: map['instagramLink'],
      email: map['email'],
      password: map['password'],
      blocked: map['blocked'],
      listeBooking: map['listeBooking'],
      listeDevis: map['listeDevis'],
      listeFavoris: map['listeFavoris'],
      serverId: map['serverId'],
    );
  }

  factory UserData.fromMap2(DocumentSnapshot document) {
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    print('data: $map');
    List<dynamic> bookings = map['listeBooking'] as List<dynamic>;
    List<dynamic> quotes = map['listeDevis'] as List<dynamic>;
    List<dynamic> favorites = map['listeFavoris'] as List<dynamic>;
    return UserData(
      id: document.id,
      nomPrenom: map['nomPrenom'],
      profileUrl: map['profileUrl'],
      numTel: map['numTel'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      whatsappNumber: map['whatsappNumber'],
      facebookLink: map['facebookLink'],
      instagramLink: map['instagramLink'],
      email: map['email'],
      password: map['password'],
      blocked: map['blocked'],
      listeBooking: bookings.length > 0 ? bookings.cast<String>() : [],
      listeDevis: quotes.length > 0 ? quotes.cast<String>() : [],
      listeFavoris: favorites.length > 0 ? favorites.cast<String>() : [],
      serverId: map['serverId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source, String id) =>
      UserData.fromMap(json.decode(source), id);

  @override
  String toString() =>
      'User(id: $id, serverId: $serverId, nomPrenom: $nomPrenom, profileUrl: $profileUrl, numTel: $numTel, blocked: $blocked, listeBooking: $listeBooking, listeDevis: $listeDevis, listeFavoris: $listeFavoris)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.id == id &&
        other.nomPrenom == nomPrenom &&
        other.numTel == numTel &&
        other.blocked == blocked &&
        other.listeBooking == listeBooking &&
        other.listeDevis == listeDevis &&
        other.listeFavoris == listeFavoris &&
        other.serverId == serverId &&
        other.profileUrl == profileUrl;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      nomPrenom.hashCode ^
      profileUrl.hashCode ^
      numTel.hashCode ^
      blocked.hashCode ^
      listeBooking.hashCode ^
      listeDevis.hashCode ^
      serverId.hashCode ^
      listeFavoris.hashCode;
}
