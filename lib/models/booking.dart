import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prooxyy_events/helpers/helpers.dart';

class Booking {
  final String id;
  final String name;
  final String categoryId;
  final String category;
  final String theme;
  final String town;
  final double budget;
  final String phoneNumber;
  final int targetCapacity;
  final String user;
  final bool done;
  final Status status;
  final bool public;
  List<String> mediaUrl = [];

  Booking({
    required this.id,
    required this.name,
    required this.category,
    required this.categoryId,
    required this.theme,
    required this.town,
    required this.budget,
    required this.phoneNumber,
    required this.user,
    required this.done,
    required this.status,
    required this.public,
    required this.targetCapacity,
    this.mediaUrl = const [],
  });

  Booking copyWith({
    String? id,
    String? name,
    String? category,
    String? categoryId,
    String? theme,
    String? town,
    double? budget,
    String? phoneNumber,
    int? targetCapacity,
    String? user,
    bool? done,
    Status? status,
    bool? publique,
    List<String>? mediaUrl,
  }) {
    return Booking(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      theme: theme ?? this.theme,
      town: town ?? this.town,
      budget: budget ?? this.budget,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      user: user ?? this.user,
      done: done ?? this.done,
      status: status ?? this.status,
      public: publique ?? this.public,
      targetCapacity: targetCapacity ?? this.targetCapacity,
      mediaUrl: mediaUrl ?? this.mediaUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'categoryId': categoryId,
      'theme': theme,
      'town': town,
      'budget': budget,
      'phoneNumber': phoneNumber,
      'user': user,
      'done': done,
      'status': status.toString().split('.').last,
      'public': public,
      'targetCapacity': targetCapacity,
      'mediaUrl': mediaUrl,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      categoryId: map['categoryId'],
      theme: map['theme'],
      town: map['town'],
      budget: map['budget'],
      phoneNumber: map['phoneNumber'],
      user: map['user'],
      done: map['done'],
      status: getStatus(map['status']),
      public: map['public'],
      targetCapacity: map['nombreDePlace'],
      mediaUrl: map['mediaUrl'],
    );
  }

  factory Booking.fromMap2(DocumentSnapshot document) {
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    print('data: $map');
    List<dynamic> mediaUrls = map['mediaUrl'];
    return Booking(
      id: document.id,
      name: map['name'],
      category: map['category'],
      categoryId: map['categoryId'],
      theme: map['theme'],
      town: map['town'],
      budget: map['budget'],
      phoneNumber: map['phoneNumber'],
      user: map['user'],
      done: map['done'],
      status: getStatus(map['status']),
      public: map['public'],
      targetCapacity: map['nombreDePlace'],
      mediaUrl: mediaUrls.cast<String>(),
    );
  }

  // factory Booking.fromMap(Map<String, dynamic> map, String id) {
  //   return Booking(
  //     id: id,
  //     nomPrenom: map['nomPrenom'],
  //     categorie: map['categorie'],
  //     theme: map['theme'],
  //     ville: map['ville'],
  //     budget: map['budget'],
  //     phone: map['phone'],
  //     user: map['user'],
  //     done: map['done'],
  //     status: getStatus(map['status']),
  //     publique: map['publique'],
  //     nombreDePlace: map['nombreDePlace'],
  //     mediaUrl: map['mediaUrl'],
  //   );
  // }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source, String id) =>
      Booking.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Booking(id: $id, firstName: $name, category: $category, theme: $theme, town: $town, budget: $budget, phoneNumber: $phoneNumber, user: $user, done: $done, status: $status, public: $public, targetCapacity: $targetCapacity, mediaUrl: $mediaUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Booking &&
        other.id == id &&
        other.name == name &&
        other.category == category &&
        other.theme == theme &&
        other.town == town &&
        other.budget == budget &&
        other.phoneNumber == phoneNumber &&
        other.user == user &&
        other.targetCapacity == targetCapacity &&
        other.done == done &&
        other.status == status &&
        other.mediaUrl == mediaUrl &&
        other.public == public;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        category.hashCode ^
        theme.hashCode ^
        town.hashCode ^
        budget.hashCode ^
        phoneNumber.hashCode ^
        targetCapacity.hashCode ^
        user.hashCode ^
        done.hashCode ^
        status.hashCode ^
        mediaUrl.hashCode ^
        public.hashCode;
  }
}
