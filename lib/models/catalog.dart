import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Catalog {
  String id;
  String name;
  String theme;
  String description;
  String category;
  String categoryId;
  List<String> media;

  Catalog({
    required this.id,
    required this.name,
    required this.theme,
    required this.category,
    required this.categoryId,
    required this.description,
    required this.media
  });

  
  Catalog copyWith({
    String? id,
    String? name,
    String? theme,
    String? description,
    String? category,
    String? categoryId,
    List<String>? media,
  }) {
    return Catalog(
      id: id ?? this.id,
      name: name ?? this.name,
      theme: theme ?? this.theme,
      description: description ?? this.description,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      media: media ?? this.media,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'theme': theme,
      'description': description,
      'category': category,
      'categoryId': categoryId,
      'media': media,
    };
  }

  factory Catalog.fromMap(Map<String, dynamic> map, String id) {
    return Catalog(
      id: id,
      name: map['name'],
      theme: map['theme'],
      description: map['description'],
      category: map['category'],
      categoryId: map['categoryId'],
      media: map['media'],
    );
  }

  factory Catalog.fromMap2(DocumentSnapshot document) {
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    print('data: $map');
    return Catalog(
      id: document.id,
      name: map['name'],
      theme: map['theme'],
      description: map['description'],
      category: map['category'],
      categoryId: map['categoryId'],
      media: map['media'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Catalog.fromJson(String source, String id) =>
      Catalog.fromMap(json.decode(source), id);

  @override
  String toString() {
    return 'Catalog(id: $id, name: $name, theme: $theme, description: $description, category: $category, categoryId: $categoryId, media: $media)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Catalog &&
        other.id == id &&
        other.name == name &&
        other.theme == theme &&
        other.category == category &&
        other.categoryId == categoryId &&
        other.description == description &&
        other.media == media;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        theme.hashCode ^
        description.hashCode ^
        category.hashCode ^
        categoryId.hashCode ^
        media.hashCode;
  }
}