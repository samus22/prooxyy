import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Variable {
  String id;
  String name;
  String type;
  dynamic value;

  Variable({
    required this.id,
    required this.name,
    required this.type,
    required this.value
  });

  
  Variable copyWith({
    String? id,
    String? name,
    String? type,
    String? value,
  }) {
    return Variable(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'value': value,
    };
  }

  factory Variable.fromMap(Map<String, dynamic> map, String id) {
    return Variable(
      id: id,
      name: map['name'],
      type: map['type'],
      value: map['value'],
    );
  }

  factory Variable.fromMap2(DocumentSnapshot document) {
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    print('data: $map');
    return Variable(
      id: document.id,
      name: map['name'],
      type: map['type'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Variable.fromJson(String source, String id) =>
      Variable.fromMap(json.decode(source), id);

  @override
  String toString() {
    return 'SiteSetting(id: $id, name: $name, type: $type, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Variable &&
        other.id == id &&
        other.name == name &&
        other.type == type &&
        other.value == value;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        type.hashCode ^
        value.hashCode;
  }
}