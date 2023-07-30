// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'vocabulary.dart';

class Topic extends Equatable {
  String? id;
  String title;
  String email;
  int initAt; // millisecondsSinceEpoch
  bool isPublic;
  List<Vocabulary> vocabularys;
  Topic({
    this.id,
    this.title = "",
    this.email = "",
    this.initAt = 0,
    this.isPublic = false,
    this.vocabularys = const <Vocabulary>[],
  }) {
    if (initAt == 0) {
      initAt = DateTime.now().millisecondsSinceEpoch;
    }
    vocabularys = List.from(vocabularys);
  }

  Topic copyWith({
    String? id,
    String? title,
    String? email,
    bool? isPublic,
    List<Vocabulary>? vocabularys,
  }) {
    return Topic(
      id: id ?? this.id,
      title: title ?? this.title,
      email: email ?? this.email,
      isPublic: isPublic ?? this.isPublic,
      vocabularys: vocabularys ?? this.vocabularys,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'email': email,
      'initAt': initAt,
      'isPublic': isPublic,
      'vocabularys': vocabularys.map((x) => x.toMap()).toList(),
    };
  }

  factory Topic.fromMap(
      {required String id, required Map<String, dynamic> map}) {
    List<Vocabulary> listV = [];
    List<dynamic> mapV = map['vocabularys'] as List<dynamic>;
    for (var value in mapV) {
      Vocabulary v = Vocabulary.fromMap(value as Map<String, dynamic>);
      listV.add(v);
    }

    return Topic(
        id: id,
        title: map['title'] ?? "",
        email: map['email'] ?? "",
        isPublic: map['isPublic'] ?? false,
        vocabularys: listV);
  }

  factory Topic.fromMap2(Map<String, dynamic> map) {
    List<Vocabulary> listV = [];
    if (map['vocabularys'] != null) {
      List<dynamic> mapV = jsonDecode(map['vocabularys']) as List<dynamic>;
      for (var value in mapV) {
        Vocabulary v = Vocabulary.fromMap(value as Map<String, dynamic>);
        listV.add(v);
      }
    }

    return Topic(
        id: map['id'],
        title: map['title'] ?? "",
        email: map['email'] ?? "",
        initAt: map['initAt'] ?? 0,
        isPublic: map['isPublic'] ?? false,
        vocabularys: listV);
  }

  String toJson() => json.encode(toMap());

  factory Topic.fromJson(String source) =>
      Topic.fromMap2(json.decode(source) as Map<String, dynamic>);

  String initAtString() {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(initAt);
    String res = "${date.day}/${date.month}/${date.year}";
    return res;
  }

  @override
  String toString() {
    return 'Topic(id: $id, title: $title, email: $email, isPublic: $isPublic,vocabularys: $vocabularys)';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, email, isPublic, vocabularys];
}
