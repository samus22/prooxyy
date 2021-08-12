import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PageBlock {
  String id;
  String name;
  String description;
  String media;

  PageBlock({
    required this.id,
    required this.name,
    required this.description,
    required this.media,
  });

  PageBlock copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
  }) {
    return PageBlock(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      media: imageUrl ?? this.media,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': media,
    };
  }

  factory PageBlock.fromMap(Map<String, dynamic> map, String id) {
    return PageBlock(
      id: id,
      name: map['name'],
      description: map['description'],
      media: map['imageUrl'],
    );
  }

  factory PageBlock.fromMap2(DocumentSnapshot document) {
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    print('data: $map');
    return PageBlock(
      id: document.id,
      name: map['name'],
      description: map['description'],
      media: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PageBlock.fromJson(String source, String id) =>
      PageBlock.fromMap(json.decode(source), id);

  @override
  String toString() {
    return 'Asset(id: $id, name: $name, description: $description, imageUrl: $media)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PageBlock &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.media == media;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ description.hashCode ^ media.hashCode;
  }
}
