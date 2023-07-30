// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';

class Vocabulary extends Equatable {
  String id;
  String terms;
  String spelling;
  String define;
  String example;
  int color;
  int textColor;
  Vocabulary(
      {this.id = "",
      this.terms = "",
      this.spelling = "",
      this.define = "",
      this.example = "",
      this.color = 0xFFffffff,
      this.textColor = 0xFF000000}) {
    if (id == "") {
      id = "${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(1000)}";
    }
  }

  Vocabulary copyWith({
    String? id,
    String? terms,
    String? spelling,
    String? define,
    String? example,
    int? color,
    int? textColor,
  }) {
    return Vocabulary(
      id: id ?? this.id,
      terms: terms ?? this.terms,
      spelling: spelling ?? this.spelling,
      define: define ?? this.define,
      example: example ?? this.example,
      color: color ?? this.color,
      textColor: textColor ?? this.textColor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'terms': terms,
      'spelling': spelling,
      'define': define,
      'example': example,
      'color': color,
      'textColor': textColor,
    };
  }

  factory Vocabulary.fromMap(Map<String, dynamic> map) {
    return Vocabulary(
      id: map['id'] ?? "",
      terms: map['terms'] ?? "",
      spelling: map['spelling'] ?? "",
      define: map['define'] ?? "",
      example: map['example'] ?? "",
      color: map['color'] ?? 0xFFffffff,
      textColor: map['textColor'] ?? 0xFF000000,
    );
  }
  @override
  String toString() {
    return 'Vocabulary(id: $id, terms: $terms, spelling: $spelling, define: $define, example: $example, color: $color, textColor: $textColor)';
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, terms, spelling, define, example, color, textColor];

  String toJson() => json.encode(toMap());

  factory Vocabulary.fromJson(String source) =>
      Vocabulary.fromMap(json.decode(source) as Map<String, dynamic>);
}
