import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Asset {
  String id;
  String name;
  String description;
  String imageUrl;

  Asset({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  
  Asset copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
  }) {
    return Asset(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory Asset.fromMap(Map<String, dynamic> map, String id) {
    return Asset(
      id: id,
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }

  factory Asset.fromMap2(DocumentSnapshot document) {
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    print('data: $map');
    return Asset(
      id: document.id,
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Asset.fromJson(String source, String id) =>
      Asset.fromMap(json.decode(source), id);

  @override
  String toString() {
    return 'Asset(id: $id, name: $name, description: $description, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Asset &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        imageUrl.hashCode;
  }
}