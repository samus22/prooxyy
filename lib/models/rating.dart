import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Rating {
  final String id;
  final double value; // This rating is done on 5
  final String avatar;
  final String ratedBy;
  final String rater;
  final String comment;
  final DateTime ratedOn;
  final String category;
  final String booking; // Id of booking

  Rating({
    required this.id,
    required this.value,
    required this.comment,
    required this.avatar,
    required this.ratedBy,
    required this.rater,
    required this.ratedOn,
    required this.booking,
    required this.category
  });

  Rating copyWith({
    String? id,
    double? value,
    String? avatar,
    String? ratedBy,
    String? rater,
    String? comment,
    DateTime? ratedOn,
    String? booking,
    String? category
  }) {
    return Rating(
      id: id ?? this.id,
      value: value ?? this.value,
      avatar: avatar ?? this.avatar,
      ratedBy: avatar ?? this.ratedBy,
      rater: rater ?? this.rater,
      comment: comment ?? this.comment,
      ratedOn: ratedOn ?? this.ratedOn,
      booking: booking ?? this.booking,
      category: category ?? this.category
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
      'avatar': avatar,
      'ratedBy': ratedBy,
      'rater': rater,
      'comment': comment,
      'ratedOn': ratedOn,
      'booking': booking,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map, String id) {
    return Rating(
      id: map['id'],
      value: map['value'],
      avatar: map['avatar'],
      ratedBy: map['ratedBy'],
      rater: map['rater'],
      comment: map['comment'],
      ratedOn: map['ratedOn'],
      booking: map['booking'],
      category: map['category']
    );
  }

  factory Rating.fromMap2(DocumentSnapshot document) {
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    print('data: $map');
    return Rating(
      id: document.id,
      value: map['value'],
      avatar: map['avatar'],
      ratedBy: map['ratedBy'],
      rater: map['rater'],
      comment: map['comment'],
      ratedOn: map['ratedOn'],
      booking: map['booking'],
      category: map['category']
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source, String id) =>
      Rating.fromMap(json.decode(source), id);

  @override
  String toString() {
    return 'Rating(id: $id, value: $value, avatar: $avatar, ratedBy: $ratedBy, comment: $comment, ratedOn: $ratedOn, booking: $booking)';
  }

  @override
  bool operator == (Object other) {
    if (identical(this, other)) return true;

    return other is Rating &&
        other.id == id &&
        other.value == value &&
        other.avatar == avatar &&
        other.ratedBy == ratedBy &&
        other.comment == comment &&
        other.ratedOn == ratedOn &&
        other.booking == booking;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        value.hashCode ^
        comment.hashCode ^
        ratedOn.hashCode ^
        booking.hashCode;
  }  
}