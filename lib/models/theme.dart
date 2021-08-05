import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Theme {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  Theme({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  Theme copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
  }) {
    return Theme(
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

  factory Theme.fromMap(Map<String, dynamic> map, String id) {
    return Theme(
      id: id,
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }

  factory Theme.fromMap2(DocumentSnapshot document) {
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    print('data: $map');
    return Theme(
      id: document.id,
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Theme.fromJson(String source, String id) =>
      Theme.fromMap(json.decode(source), id);

  @override
  String toString() {
    return 'Theme(id: $id, name: $name, description: $description, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Theme &&
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
