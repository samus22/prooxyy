import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prooxyy_events/helpers/helpers.dart';

class Quote {
  final String id;
  final String name;
  final String avatar;
  final String category;
  final String theme;
  final String town;
  final int intendedPlaces;
  final String phoneNumber;
  final bool done;
  final Status status;
  final String quoteDocUrl;

  Quote({
    required this.id,
    required this.name,
    required this.avatar,
    required this.category,
    required this.theme,
    required this.town,
    required this.intendedPlaces,
    required this.phoneNumber,
    required this.done,
    required this.status,
    required this.quoteDocUrl,
  });

  Quote copyWith({
    String? id,
    String? theme,
    String? avatar,
    String? category,
    String? town,
    int? nombreDePlace,
    String? phoneNumber,
    String? name,
    bool? done,
    Status? status,
    String? quoteDocUrl,
  }) {
    return Quote(
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      category: category ?? this.category,
      theme: theme ?? this.theme,
      town: town ?? this.town,
      intendedPlaces: nombreDePlace ?? this.intendedPlaces,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      done: done ?? this.done,
      status: status ?? this.status,
      quoteDocUrl: quoteDocUrl ?? this.quoteDocUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': name,
      'category': category,
      'theme': theme,
      'town': town,
      'nombreDePlace': intendedPlaces,
      'phoneNumber': phoneNumber,
      'done': done,
      'status': status.toString(),
      'quoteDocUrl': quoteDocUrl,
    };
  }

  factory Quote.fromMap(Map<String, dynamic> map, String id) {
    return Quote(
      id: id,
      avatar: map['avatar'],
      category: map['category'],
      theme: map['theme'],
      town: map['town'],
      intendedPlaces: map['nombreDePlace'],
      phoneNumber: map['phoneNumber'],
      name: map['name'],
      done: map['done'],
      status: getStatus(map['status']),
      quoteDocUrl: map['quoteDocUrl'],
    );
  }

  factory Quote.fromMap2(DocumentSnapshot document) {
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    print('data: $map');
    return Quote(
      id: document.id,
      avatar: map['avatar'],
      category: map['category'],
      theme: map['theme'],
      town: map['town'],
      intendedPlaces: map['nombreDePlace'],
      phoneNumber: map['phoneNumber'],
      name: map['name'],
      done: map['done'],
      status: getStatus(map['status']),
      quoteDocUrl: map['quoteDocUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Quote.fromJson(String source, String id) =>
      Quote.fromMap(json.decode(source), id);

  @override
  String toString() {
    return 'Quote(id: $id, category: $category, theme: $theme, town: $town, intendedPlaces: $intendedPlaces, phoneNumber: $phoneNumber, user: $name, done: $done, status: $status, quoteDocUrl: $quoteDocUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Quote &&
        other.id == id &&
        // other.nomPrenom == nomPrenom &&
        // other.categorie == categorie &&
        other.theme == theme &&
        other.town == town &&
        other.intendedPlaces == intendedPlaces &&
        other.phoneNumber == phoneNumber &&
        other.name == name &&
        other.done == done &&
        other.status == status &&
        other.quoteDocUrl == quoteDocUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        // nomPrenom.hashCode ^
        // categorie.hashCode ^
        theme.hashCode ^
        town.hashCode ^
        intendedPlaces.hashCode ^
        phoneNumber.hashCode ^
        name.hashCode ^
        done.hashCode ^
        status.hashCode ^
        quoteDocUrl.hashCode;
  }
}
